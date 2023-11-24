interface Fn {
  (event: Event): void
}

// 雙擊、單擊事件的隔離
export function dblclickCancelSingleClick(fn: Fn, event: Event) {
  const clickTimeout = setTimeout(() => {
    console.log('單擊事件觸發')
    fn(event)
  }, 200) // 延遲執行，可以根據需要調整

  document.querySelector('body')!.addEventListener('dblclick', () => {
    // 雙擊事件觸發時，清除單擊事件的延遲
    clearTimeout(clickTimeout)
    console.log('雙擊事件觸發')
  })
}