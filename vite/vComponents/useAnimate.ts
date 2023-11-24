// Animate.css 的組合函式

export function useAnimate(
  toggleState1: string,
  toggleState2: string,
  animateOutIn: string | string[],
  modifier?: string
) {
  const cls = ref('')
  const currState = ref(toggleState1)
  let animateOut: string
  let animateIn: string
  if (typeof animateOutIn === 'string') {
    animateOut = animateOutIn.includes('Out')
      ? animateOutIn
      : animateOutIn.replace('In', 'Out')
    animateIn = animateOutIn.includes('In')
      ? animateOutIn
      : animateOutIn.replace('Out', 'In')
  }
  if (animateOutIn instanceof Array) {
    animateOut = animateOutIn[0]
    animateIn = animateOutIn[1]
  }

  function cycle() {
    cls.value = 'animate__animated ' + animateOut + ' ' + modifier
    setTimeout(() => {
      currState.value =
        currState.value === toggleState1 ? toggleState2 : toggleState1
      cls.value = 'animate__animated ' + animateIn + ' ' + modifier
    }, 500)
  }

  // cycle 循環狀態的切換
  // currState 目前的狀態
  // cls 目前的動畫類別
  return { cycle, currState, cls }
}
