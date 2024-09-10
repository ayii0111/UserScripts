export const randomTimeTask = (secondsRange: number, taskIndex: number | string) =>
  new Promise((resolve) => {
    let s = Math.floor(Math.random() * secondsRange)
    setTimeout(() => {
      console.log(`任務${taskIndex}完成 (耗費 ${s}秒)`)
      resolve(taskIndex)
    }, s * 1000) // 隨機產生 0 ~ s 秒的任務
  })

