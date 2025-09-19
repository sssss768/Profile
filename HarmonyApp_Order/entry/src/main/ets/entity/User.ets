/**
 * 用户实体(app注册用户)
 */
export default class User {
  // 用户编号
  id: number = 0;
  // 用户名
  username: string;
  // 密码
  password: string;
  // 手机，注册使用手机好吗
  phone: string;
  // 通过可选参数方式实现多个构造函数方式
  constructor(username: string, password: string, phone: string, id?: number) {
    this.username = username;
    this.password = password;
    this.phone = phone;
    if (id != undefined) {
      this.id = id;
    }
  }
}