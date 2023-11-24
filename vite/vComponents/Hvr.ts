// hover.css 的組合函式

// 使用方式
// const isAnimating = useHvr()
// 應在 setup() 週其中使用，不可在 onMounted()中使用，否則本檔的 onMounted 裡面的代碼不會被執行
// 傳入的參數為 ref物件 or reactive物件，而非 ref變數.value
// isAnimating.value = true 會運行動畫
// isAnimating.value = false 會恢復原狀

// 依賴 Hover.css 套件，且需要修改 css 檔
// 修改的 指令
// # 基礎樣式
// gsed -i -E 's/(\.[a-zA-Z0-9\.\-]+) \{/\1-init {/g' node_modules/hover.css/css/hover.css

// # 動畫樣式
// gsed -i -E 's/([a-zA-Z0-9\.\-]+):(hover|focus|active)/\1-anim/g' node_modules/hover.css/css/hover.css





// useHvr() 可使用參數
// useHvr(refElement, 樣式名稱)
// useHvr(reactivElementsArr, index, 樣式名稱)

// 詳細說明
// 使用函式多載
// 第一種是僅輸入一個 refElement 元素物件的響應變數與樣式名稱
// 第二種是輸入一個 reactiveElementsDom元素陣列的響應變數與索引值，以及樣式名稱
// 第三個則是參數與型別的整合（即需將上述參數與型別整合起來）
import type { Ref } from 'vue'
export function useHvr(refElement: Ref<HTMLDivElement | null>, animate: string): Ref<boolean | null>
export function useHvr(
  reactivElementsArr: Ref<HTMLDivElement[] | HTMLDivElement | null>,
  index: number,
  animate: string
): Ref<boolean | null>

export function useHvr(
  element: Ref<HTMLDivElement[] | HTMLDivElement | null>,
  indexOrAnimate: number | string,
  animate?: string
) {
  // 將第二第三個參數，解析出 _animate 或 _index與_animate
  let _index: number
  let _animate: string
  if (typeof indexOrAnimate == 'number') {
    _index = indexOrAnimate
    _animate = animate!
  } else {
    _animate = indexOrAnimate
  }

  let clsInit = `hvr-${_animate}-init`
  let clsAnim = `hvr-${_animate}-anim`
  let el: HTMLDivElement | null
  onMounted(() => {
    // 將 Dom元素物件解析為 el變數，再來操作
    Array.isArray(element.value) ? (el = element.value[_index]) : (el = element.value)
    el!.classList.add(clsInit)
  })
  const isAnimating = ref<boolean | null>(null)
  watch(isAnimating, () => {
    isAnimating.value ? el!.classList.add(clsAnim) : el!.classList.remove(clsAnim)
  })

  // 當只有回傳單一物件時，不可以使用花括號
  return isAnimating
}

