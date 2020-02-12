# WebSocket server that reverses input text

library(httpuv)
ws_reverser <- startServer("0.0.0.0", 4000,
  list(
    onWSOpen = function(ws) {
      ws$onMessage(function(binary, message) {
        reversed <- paste(rev(strsplit(message, "")[[1]]), collapse = "")
        ws$send(reversed)
      })
    }
  )
)


# To stop the server:
# ws_reverser$stop()
