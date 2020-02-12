# Web REPL/console


# Note: 127.0.0.1 allows connections only from localhost. To listen on external
# ports, use 0.0.0.0.
web_repl <- function(host = "127.0.0.1", port = 7000) {
  library(httpuv)

  app <- list(
    call = function(req) {
      page(req)
    },
    onWSOpen = function(ws) {
      ws$onMessage(function(binary, message) {
        on_message(ws, binary, message)
      })
    }
  )

  page <- function(req) {
    wsUrl = paste(sep='',
      '"',
      "ws://",
      ifelse(is.null(req$HTTP_HOST), req$SERVER_NAME, req$HTTP_HOST),
      '"')

    list(
      status = 200L,
      headers = list(
        'Content-Type' = 'text/html'
      ),
      body = sprintf('
<html>
<head>
<style type="text/css">
body {
  font-size: 14px;
}
pre {
  margin: 0
}
.user-input {
  color: blue;
  margin-top: 4px;
}
.user-input textarea {
  color: blue;
  vertical-align: top;
  font-family: Courier;
  font-size: 14px;
  margin: 0;
  border: 0;
  padding: 0;
  outline: none;
  height: 5em;
}
#overlay{
  position: absolute;
  background: #bbb;
  opacity: 0.6;
  visibility: hidden;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
  z-index: 1;
}
</style>
<script>
var ws = new WebSocket("ws://localhost:%s");
ws.onmessage = function(msg) {
  var msgDiv = document.createElement("pre");
  msgDiv.innerHTML = msg.data.replace(/&/g, "&amp;").replace(/\\</g, "&lt;");
  document.getElementById("output").appendChild(msgDiv);
  document.documentElement.scrollIntoView({behavior: "smooth", block: "end"});
};
ws.onclose = function() {
  document.getElementById("overlay").style.visibility = "visible";
};
function sendInput() {
  var input = document.getElementById("input");
  // Append the text
  var msgDiv = document.createElement("pre");
  msgDiv.setAttribute("class", "user-input");
  msgDiv.innerHTML = "&gt; " + input.value.replace(/&/g, "&amp;").replace(/\\</g, "&lt;");
  document.getElementById("output").appendChild(msgDiv);
  if (input.value == "") {
    // Don\'t try to eval empty line
    return;
  }
  ws.send(input.value);
  input.value = "";
}
</script>
</head>
<body>
<div id="overlay"></div>
<div id="output">
<pre>%s
</pre>
</div>
<pre class="user-input">&gt; <textarea rows=1 cols=100 id="input" autofocus></textarea>
</pre>
<script>
document.getElementById("input").addEventListener("keydown", function(event) {
  if (event.key === "Enter") {
    if (event.shiftKey) {
      // Don\'t send if Shift is down. Only increase number of rows.
      input.rows = input.rows + 1;
    } else {
      sendInput();
      event.preventDefault();
    }
  }
});
</script>
</body>
</html>
', port, R.version.string
      )
    )
  }

  on_message <- function(ws, binary, message) {
    result_txt <- capture.output({
      tryCatch(
        {
          expr <- parse(text = message)
          result <- withVisible(eval(expr, envir = .GlobalEnv))
          if (result$visible == TRUE) {
            print(result$value)
          }
        },
        error = function(e) {
          cat("Error: ", e$message)
        }
      )
    })
    result_txt <- paste(result_txt, collapse = "\n")

    ws$send(result_txt)
  }

  startServer(host, port, app)
}

web_repl()
