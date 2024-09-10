interface Singleton {
  (): string[]
  instance?: string[]
};

// 單例模式
export const singleton: Singleton = () => {
  if (singleton.instance === undefined) {
    singleton.instance = []
    return singleton.instance
  }
  return singleton.instance
}