export class GlobalStorage {
  private static instance: GlobalStorage;
  public shopName: string = '云海肴'; // 存储店铺名称
  public phone: string = ''; //

  private constructor() {}

  // 修改：直接使用类名GlobalStorage，而非this
  public static getInstance(): GlobalStorage {
    if (!GlobalStorage.instance) {
      GlobalStorage.instance = new GlobalStorage();
    }
    return GlobalStorage.instance;
  }
}