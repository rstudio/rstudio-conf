(function (window, document) {
  const videoOpts = { first: true }

  function setVideoOptions () {
    if (!videoOpts.width) {
      const opts = JSON.parse(
        document.getElementById('xaringanExtra-webcam-options').textContent
      )
      videoOpts.width = opts.width || 200
      videoOpts.height = opts.height || 200
      videoOpts.margin = opts.margin || '1em'
    }
  }

  function createVideoElement () {
    setVideoOptions()
    const vid = document.createElement('video')
    vid.setAttribute('autoplay', true)
    vid.setAttribute('draggable', true)
    vid.id = 'xaringanExtra-webcam'
    vid.width = videoOpts.width
    vid.height = videoOpts.height
    vid.style.position = 'absolute'
    vid.style.top = 0
    vid.style.right = 0
    vid.style.margin = videoOpts.margin
    vid.style.zIndex = 1000
    vid.style.transform = 'rotateY(180deg)'
    vid.style.cursor = 'move'
    return vid
  }

  function findVideo () {
    return document.getElementById('xaringanExtra-webcam')
  }

  function alertNoVideo () {
    let msg = 'Webcam is not available in this browser.'
    if (!/^https/.test(window.location.protocol)) {
      msg += '\n\nAre you using https for this site?'
    }
    window.alert(msg)
  }

  function startVideo () {
    if (document.body.classList.contains('remark-presenter-mode')) {
      return
    }

    if (findVideo()) {
      return
    }

    if (!navigator.mediaDevices) {
      alertNoVideo()
      return
    }

    navigator
      .mediaDevices
      .getUserMedia({
        audio: false,
        video: {
          facingMode: 'user',
          width: { ideal: videoOpts.width },
          height: { ideal: videoOpts.height }
        }
      })
      .then(function (stream) {
        const vid = createVideoElement()
        videoOpts.el = vid
        document.body.appendChild(vid)

        vid.addEventListener('dragstart', dragStart, false)
        document.body.addEventListener('dragover', dragOver, false)
        document.body.addEventListener('drop', dragDrop, false)
        vid.srcObject = stream
      })
      .catch(err => {
        if (videoOpts.first) {
          alertNoVideo()
          videoOpts.first = false
        }
        console.error(err)
      })
  }

  function stopVideo () {
    const vid = findVideo()
    if (!vid) return
    vid.srcObject.getTracks().forEach(track => track.stop())
    vid.parentNode.removeChild(vid)
    videoOpts.el = null
    document.body.removeEventListener('dragover', dragOver)
    document.body.removeEventListener('drop', dragDrop)
  }

  function toggleVideo () {
    findVideo() ? stopVideo() : startVideo()
  }

  function moveVideo (top = '0px', right = '0px', bottom = null, left = null) {
    videoOpts.el.style.top = top
    videoOpts.el.style.right = right
    videoOpts.el.style.bottom = bottom
    videoOpts.el.style.left = left
  }

  function moveVideoNextCorner () {
    const { top, right, bottom, left } = videoOpts.el.style
    if (top === '0px' && right === '0px') {
      moveVideo(null, '0px', '0px', null)
    } else if (right === '0px' && bottom === '0px') {
      moveVideo(null, null, '0px', '0px')
    } else if (bottom === '0px' && left === '0px') {
      moveVideo('0px', null, null, '0px')
    } else if (top === '0px' && left === '0px') {
      moveVideo('0px', '0px', null, null)
    } else {
      moveVideo()
    }
  }

  function dragStart (event) {
    const { clientX, clientY } = event
    const style = window.getComputedStyle(event.target, null)
    const x = parseInt(style.getPropertyValue('left'), 10) - clientX
    const y = parseInt(style.getPropertyValue('top'), 10) - clientY
    event.dataTransfer.setData('text', `${x},${y}`)
  }

  function dragOver (event) {
    event.preventDefault()
    return false
  }

  function dragDrop (event) {
    let offset = event.dataTransfer.getData('text')
    offset = offset.split(',').map(x => parseInt(x, 10))
    const { clientX, clientY } = event
    moveVideo(`${clientY + offset[1]}px`, null, null, `${clientX + offset[0]}px`)
    event.preventDefault()
    return false
  }

  document.addEventListener('keydown', function (ev) {
    if (ev.code === 'KeyW') {
      ev.shiftKey ? moveVideoNextCorner() : toggleVideo()
    }
  })
})(window, document)
