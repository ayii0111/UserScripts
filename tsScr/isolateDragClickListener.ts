
interface Fn {
  (event: Event): void
}
export function isolateDragClickListener(elem: HTMLElement, fn: Fn) {
  let isDragging = false
  let startX = 0
  let startY = 0

  elem.addEventListener('mousedown', (event) => {
    isDragging = false
    startX = event.clientX
    startY = event.clientY

    const onMouseMove = (moveEvent: MouseEvent) => {
      const dx = Math.abs(moveEvent.clientX - startX)
      const dy = Math.abs(moveEvent.clientY - startY)
      if (dx > 5 || dy > 5) {
        isDragging = true
        elem.removeEventListener('mousemove', onMouseMove)
      }
    }

    elem.addEventListener('mousemove', onMouseMove)

    elem.addEventListener(
      'mouseup',
      (event) => {
        elem.removeEventListener('mousemove', onMouseMove)
        if (isDragging) {
          return 'exit'
        }
        // 處理點擊事件
        fn(event)
      },
      { once: true },
    )
  })
}