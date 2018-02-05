window.addEventListener("load", function() {
  var model = new KerasJS.Model({
    filepath: "https://s3.amazonaws.com/javierluraschi/tensorflow-deployment-rstudio-conf/examples/kerasjs-mnist.bin",
    gpu: true
  });
  
  var root = document.getElementsByClassName("mnist-digits")[0];
  
  var canvas = document.createElement("div");
  canvas.id = "canvas";
  root.appendChild(canvas);
  
  var digits = document.createElement("div");
  digits.className = "digits";
  root.appendChild(digits);
  
  for (var idx = 0; idx < 10; idx++) {
    var digit = document.createElement("div");
    digit.id = "digit" + idx;
    digit.innerText = idx;
    digits.appendChild(digit);
  }
  
  var pixels = new Pixels();
  document.getElementById("canvas").appendChild(pixels.getElement());
  pixels.init(null, 28, 28, 200, 200, [
    [0.0,0.5,0.8,0.5,0.0],
    [0.5,1.0,1.0,1.0,0.5],
    [0.8,1.0,1.0,1.0,0.8],
    [0.5,1.0,1.0,1.0,0.5],
    [0.0,0.5,0.8,0.5,0.0]
  ], {
    fill: { color: "#555555" },
    grid: { color: "#DDDDDD" }
  });

  slideshow.on('showSlide', function (slide) {
    pixels.onMouseDown(function() {
      slideshow.pause();
      for(idx = 0; idx < 10; idx++) {
        document.getElementById("digit" + idx).style.width = 20 + "px";
      }
    });
    
    pixels.onMouseUp(function() {
      window.setTimeout(function () {
        slideshow.resume();
      }, 1000);
    });
  });

  pixels.onChange(function(pixels) {
    var flat = [];
    for(var i = 0; i < pixels.length; i++) {
      flat = flat.concat(pixels[i]);
    }
  
    model
      .predict({
        input: new Float32Array(flat)
      })
      .then(function(outputData) {
        for(idx = 0; idx < 10; idx++) {
          document.getElementById("digit" + idx).style.width = (20 + 280 * outputData.output[idx]) + "px";
        }
      });
  });
});
