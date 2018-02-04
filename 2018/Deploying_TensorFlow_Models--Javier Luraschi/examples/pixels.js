function Pixels() {
  var canvas = document.createElement("canvas");
  context = canvas.getContext("2d");
  
  var params;
  var deltaX;
  var deltaY;
  var gridX;
  var gridY;
  var width;
  var height;
  var brush;
  
  var mouseIsDown = false;
  var onChangeCallback;
  var onMouseDownCallback;
  var onMouseUpCallback;
  
  var pixels;
  
  var defaultParams = function(p) {
    if (!p) p = {};
    if (!p.fill) p.fill = {};
    if (!p.fill.color) p.fill.color = "#555555";
    if (!p.grid) p.grid = {};
    if (!p.grid.color) p.grid.color = "#DDDDDD";
    
    return p;
  };
  
  this.init = function(baseline, pGridX, pGridY, pWidth, pHeight, pBrush, pParams) {
    gridX = pGridX;
    gridY = pGridY;
    width = pWidth * 2;
    height = pHeight * 2;
    brush = pBrush;
    params = pParams;
    
    canvas.width = width;
    canvas.height = height;
    canvas.style.width = pWidth + "px";
    canvas.style.height = pHeight + "px";
    
    params = defaultParams(params);
    
    deltaX = (width - 2) / gridX;
    deltaY = (height - 2) / gridY;
    
    pixels = initArray(gridY, gridX);
    
    if (baseline) copyFrom1D(baseline);
    
    redrawCanvas();
  };

  var initArray = function(rows, cols) {
    var a = [];
    for (var r = 0; r < rows; r++) {
      a[r] = [];
      for (var c = 0; c < cols; c++) {
        a[r][c] = 0.0;
      }
    }
    return a;
  };
  
  var copyFrom1D = function(from) {
    for (var r = 0; r < gridY; r++) {
      for (var c = 0; c < gridX; c++) {
        pixels[r][c] = Math.max(0.0, Math.min(1.0, from[r * gridX + c]));
      }
    }
  };
  
  var drawGrid = function() {
    context.strokeStyle = params.grid.color;
    context.lineWidth = 1;

    for (var posX = 1; posX < width; posX += deltaX) {
      context.moveTo(posX, 1);
      context.lineTo(posX, height);
    }

    for (var posY = 1; posY < height; posY += deltaY) {
      context.moveTo(1, posY);
      context.lineTo(width, posY);
    }

    context.stroke();
  };
  
  var hexToRgb = function(hex) {
    var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    return result ? {
        r: parseInt(result[1], 16),
        g: parseInt(result[2], 16),
        b: parseInt(result[3], 16)
    } : null;
  };
  
  var buildRGBA = function(rgb, alpha) {
    return "rgba(" + rgb.r + ", " + rgb.g + "," + rgb.b + "," + alpha + ")";
  };

  var redrawCanvas = function() {
    if (!width || !height) return;
    
    context.clearRect(0, 0, context.canvas.width, context.canvas.height);
    drawGrid();

    var rgbFill = hexToRgb(params.fill.color);
    for (var r = 0; r < gridY; r++)
      for (var c = 0; c < gridX; c++)
        if(pixels[r][c]) {
          context.fillStyle = buildRGBA(rgbFill, pixels[r][c]);
          context.fillRect(1 + deltaX * c, 1 + deltaY * r, deltaX, deltaY);
        }
  };

  var setPixelFromMouse = function(e, left, top) {
    var rect = canvas.getBoundingClientRect();
    var pixelX = Math.floor(1.0 * gridX * (e.clientX - rect.left) / (rect.right - rect.left));
    var pixelY = Math.floor(1.0 * gridY * (e.clientY - rect.top) / (rect.bottom - rect.top));

    var offsetY = Math.floor(brush.length / 2);
    for (var br = 0; br < brush.length; br++) {
      var offsetX = Math.floor(brush[br].length / 2);
      for (var bc = 0; bc < brush[br].length; bc++) {
        var r = pixelY - offsetY + br;
        var c = pixelX - offsetX + bc;
        
        if (r >= 0 && r < gridX && c >= 0 && c < gridY && brush[br][bc]) {
          pixels[r][c] = Math.min(1.0, pixels[r][c] + brush[br][bc]);
        }
      }
    }
  };

  var canvasMouseDown = function(e) {
    if (onMouseDownCallback) onMouseDownCallback();
    if (!mouseIsDown) pixels = initArray(gridY, gridX);
    
    setPixelFromMouse(e, this.offsetLeft, this.offsetTop);
    mouseIsDown = true;

    redrawCanvas();
  };

  var canvasMouseMove = function(e) {
    if (mouseIsDown) setPixelFromMouse(e, this.offsetLeft, this.offsetTop);
    redrawCanvas();
  };

  var canvasMouseUp = function(e) {
    if (onMouseUpCallback) onMouseUpCallback();
    
    mouseIsDown = false;
    if (onChangeCallback) onChangeCallback(pixels);
  };
  
  var touchToMouse = function(event) {
    var touch = event.changedTouches[0];
    event.preventDefault();
    event.clientX = touch.clientX;
    event.clientY = touch.clientY;
    return event;
  };
  
  var canvasTouchStart = function(e) {
    canvasMouseDown(touchToMouse(e));
  };

  var canvasTouchMove = function(e) {
    canvasMouseMove(touchToMouse(e));
  };

  var canvasTouchEnd = function(e) {
    canvasMouseUp(touchToMouse(e));
  };

  if ('ontouchstart' in document.documentElement) {
    canvas.addEventListener('touchstart', canvasTouchStart, { passive: false });
    canvas.addEventListener('touchmove', canvasTouchMove, { passive: false });
    canvas.addEventListener('touchend', canvasTouchEnd, { passive: false });
  } 
  else {
    canvas.addEventListener("mousedown", canvasMouseDown, false);
    canvas.addEventListener("mousemove", canvasMouseMove, false);
    document.addEventListener("mouseup", canvasMouseUp, false);
  }

  this.getElement = function() {
    return canvas;
  };

  this.getPixels = function() {
    return pixels;
  };
  
  this.onChange = function(callback) {
    onChangeCallback = callback;
  };
  
  this.onMouseDown = function(callback) {
    onMouseDownCallback = callback;
  };
  
  this.onMouseUp = function(callback) {
    onMouseUpCallback = callback;
  };
}