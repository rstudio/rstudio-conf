const rescaleSlides = () => {
  const slides = document.querySelectorAll('.remark-slide-scaler')
  slides.forEach(slide => {
    /* In the future, might enable remark scaling restore
    slide.dataset.original = JSON.stringify({
      top: slide.style.top,
      left: slide.style.left,
      width: slide.style.width,
      height: slide.style.height,
    });
    */
    slide.style.width = `${window.innerWidth}px`
    slide.style.height = `${window.innerHeight}px`
    slide.style.transform = 'scale(1)'
    slide.style.top = '0'
    slide.style.left = '0'
  })
}

const rescaleOnResize = ev => {
  ev.stopPropagation()
  rescaleSlides()
}

const startFitScreen = () => {
  window.addEventListener('resize', rescaleOnResize)
  rescaleSlides()
}

document.addEventListener('keydown', ev => {
  if (ev.altKey && ev.keyCode === 70) {
    // Alt + F
    startFitScreen()
  }
})

const addFitScreenHelpText = () => {
  const helpTable = document.querySelector(
    '.remark-help-content table.light-keys'
  )
  if (!helpTable) {
    console.error(
      'Could not find remark help table, has remark been initialized?'
    )
    return
  }
  const newRow = document.createElement('tr')
  newRow.innerHTML += '<td><span class="key">Alt</span> + <span class="key">f</span></td>'
  newRow.innerHTML += '<td>Fit Slides to Screen</td>'
  helpTable.append(newRow)
}

document.addEventListener('DOMContentLoaded', addFitScreenHelpText)
