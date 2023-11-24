// 使用：import '/path/to/forEachAsync'
export {} // 標記為非全局類別聲明檔

// 定義該原型方法的 Callback 泛型
interface CallBack<Elem, Initail> {
  (
    elem: Elem,
    options: {
      isBreak: boolean
      txData?: Initail
    }
  ): Promise<[boolean, Initail | undefined] | [boolean] | void>
  // 此處設計的回傳，可以用來限制使用者的回傳
}

// 宣告為全域型別
// 這裡的全局型別宣告，是利用 interface 宣告合併的技巧，以便在檔案外部該方法也有型別效果
declare global {
  interface Array<T> {
    forEachAsync: <Initail>(callback: CallBack<T, Initail>, initail?: Initail) => Promise<Initail | void>
  }
}

// 可跌異步迭代陣列的原型方法的定義
// 此處的 function<Elem,Initail> 是泛型的定義，用來在調用方法時，可以自動判斷類別，或手動輸入類別
Array.prototype.forEachAsync = async function<Elem, Initail> (callbackFn: CallBack<Elem, Initail>, initail?: Initail) {
  let isBreak: boolean = false // 中斷狀態的初始值，一旦被改成 true 後面迴圈都不會執行
  let txData: Initail | undefined = initail // 初始帶入值，可以為空

  // 因為 .reduce 的 CallBack 使用異步，因此每次回傳都是 Promise 物件，他僅用來作為異步阻塞
  // await this.reduce<Promise<Initail | undefined | void>>(async (promise, elem) => {
  await this.reduce(async (promise, elem) => {
    // 在「...reduce 與 ...await promise」之間的代碼，都是同步代碼，會直接執行，故上面不要寫任何代碼
    await promise // 此處作為每次迭代的異步堵塞

    if (isBreak) { return txData } // 條件成立，就會中斷迴圈，將傳遞值回傳

    // 傳遞給 CallBackFn 時，將 isBreak 顛倒邏輯
    // 因此在回調中取出 isBreak 的值，會是 true，若要中斷迴圈可以 return [isBreak]，若不想中斷迴圈可以 return [!isBreak]
    isBreak = !isBreak
    ;[isBreak, txData] = (await callbackFn(elem, { isBreak, txData })) ?? [!isBreak, txData]
    // 若 CallBackFn 回傳為空值，則將使用 [!isBreak, txData] 來繼續迭代
  }, Promise.resolve(initail))
  // .reduce() 的第二參數不能為空
  // 若為空，他會把陣列的第一個元素作為初始值，導致第一個回調函式參數中的第一個參數為陣列的第一個元素
  // 而第二個參數直接為陣列的第二個元素
  return txData
}