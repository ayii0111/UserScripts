// 使用：import '/path/to/whileLoopAsync'
interface CallBackFn<InitData> {
  (isBreak: boolean, options: { txData: InitData, index: number }): Promise<
    [boolean, InitData] | [boolean] | void | undefined
  >
}

async function whileLoop<InitData>(callBackFn: CallBackFn<InitData>, txData: InitData) {
  let isBreak = false
  let _txData: undefined | InitData
  let index = 0

  const loop = async () => {
    isBreak = !isBreak
      ;[isBreak, _txData] = (await callBackFn(isBreak, { txData, index })) ?? [!isBreak, txData]
    txData = _txData ?? txData
    if (isBreak) { return txData }
    index++
    return loop()
  }
  return loop()
}