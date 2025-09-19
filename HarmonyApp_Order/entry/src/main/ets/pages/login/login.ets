import { ToolBar } from "@ohos.arkui.advanced.ToolBar";
// 从原Login页面移植的导入
import promptAction from '@ohos.promptAction';
import {
  taskPoolQueryUserByPhone,
  taskPoolQueryMerchantByPhone,
  taskPoolQueryRiderByPhone
} from '../../taskpool/RdbTaskpool';
import {
  UserInfo,
  MerchantInfo,
  RiderInfo,
  UserType,
  UserInfoWithPassword,
  MerchantInfoWithPassword,
  RiderInfoWithPassword
} from '../../common/UserInfo';
import { NavParam } from '../../common/common';
import { GlobalStorage } from "../../entity/GlobalStorage";

// 跳转页面入口函数
@Builder
export function LoginBuilder() {
  Login();
}

@Preview
@Component
struct Login {
  @State pathStack: NavPathStack = new NavPathStack();
  @State user: string = '';
  @State password: string = '';
  @State userType: UserType = 'user';

  private async loginBtnClick(): Promise<void> {
    if (!this.user || !this.password) {
      promptAction.showToast({
        message: '手机号或密码不能为空',
        duration: 1000
      })
      return
    }

    try {
      if (this.userType === 'user') {
        const userInfo = await taskPoolQueryUserByPhone(getContext(this), this.user) as UserInfoWithPassword | null;
        if (!userInfo) {
          promptAction.showToast({
            message: '账号不存在',
            duration: 1000
          })
          return
        }

        if (userInfo.password !== this.password) {
          promptAction.showToast({
            message: '密码不正确',
            duration: 1000
          })
          return
        }

        // 创建不包含密码的用户信息对象
        const safeUserInfo: UserInfo = {
          user_id: userInfo.user_id,
          username: userInfo.username,
          phone: userInfo.phone,
          avatar_url: userInfo.avatar_url,
          campus_id: userInfo.campus_id,
          balance: userInfo.balance
        };

        promptAction.showToast({
          message: '登录成功',
          duration: 1000
        })

GlobalStorage.getInstance().phone = this.user
        this.pathStack.clear(); // 使用pathStack而非navPath
        this.pathStack.pushPath({
          name: 'Customer',
          param: {
            userType: this.userType,
            userInfo: safeUserInfo
          } as NavParam
        });

      } else if (this.userType === 'merchant') {
        const merchantInfo =
          await taskPoolQueryMerchantByPhone(getContext(this), this.user) as MerchantInfoWithPassword | null;
        if (!merchantInfo) {
          promptAction.showToast({
            message: '账号不存在',
            duration: 1000
          })
          return
        }

        if (merchantInfo.password !== this.password) {
          promptAction.showToast({
            message: '密码不正确',
            duration: 1000
          })
          return
        }

        // 创建不包含密码的商家信息对象
        const safeMerchantInfo: MerchantInfo = {
          merchant_id: merchantInfo.merchant_id,
          shop_name: merchantInfo.shop_name,
          address: merchantInfo.address,
          contact_phone: merchantInfo.contact_phone,
          avg_rating: merchantInfo.avg_rating
        };

        promptAction.showToast({
          message: '登录成功',
          duration: 1000
        })

        this.pathStack.clear();
        this.pathStack.pushPath({
          name: 'Store',
          param: {
            userType: this.userType,
            userInfo: safeMerchantInfo
          } as NavParam
        });
      } else {
        const riderInfo = await taskPoolQueryRiderByPhone(getContext(this), this.user) as RiderInfoWithPassword | null;
        if (!riderInfo) {
          promptAction.showToast({
            message: '账号不存在',
            duration: 1000
          })
          return
        }

        if (riderInfo.password !== this.password) {
          promptAction.showToast({
            message: '密码不正确',
            duration: 1000
          })
          return
        }

        // 创建不包含密码的骑手信息对象
        const safeRiderInfo: RiderInfo = {
          rider_id: riderInfo.rider_id,
          username: riderInfo.username,
          phone: riderInfo.phone,
          status: riderInfo.status
        };

        promptAction.showToast({
          message: '登录成功',
          duration: 1000
        })

        this.pathStack.clear();
        this.pathStack.pushPath({
          name: 'Delivery',
          param: {
            userType: this.userType,
            userInfo: safeRiderInfo
          } as NavParam
        });
      }
    } catch (e) {
      promptAction.showToast({
        message: '登录失败: ' + e.message,
        duration: 1000
      })
    }
  }

  private registBtnClick(): void {
    this.pathStack.pushPath({
      name: 'Register',
      param: {
        userType: this.userType,
      } as NavParam
    });
  }

  build() {
    NavDestination() {
      Stack() {
        Column() {
          // logo
          Row() {
            Image($r("app.media.app_icon"))
              .width(50)
              .borderRadius(10)
              .margin({ top: 20, bottom: '20vp', left : 60,right: 10 })

            // 欢迎文字
            Text('鸿蒙外卖')
              .fontSize(40)
              .fontColor($r('app.color.Charcoal_Gray'))
              .fontWeight(FontWeight.Bold)
          }
          .margin({top:30,bottom:10})
          .width('90%')

          Row() {
            Row({ space: 5 }) {
              Image($r('app.media.personal'))
                .fillColor($r('app.color.Charcoal_Gray'))
                .width(30)
                .height(30)
              Radio({ value: 'user', group: 'userType' })
                .checked(this.userType === 'user')
                .onChange((isChecked) => {
                  if (isChecked) {
                    this.userType = 'user';
                  }
                })
                .margin({ top: 8 })

            }
            .width('28%')
            .margin({ left: 20 })

            Divider()
              .vertical(true)
              .height(50)
              .color($r('app.color.Charcoal_Gray'))
              .opacity(0.5)
              .margin({ right: 10 })
              .strokeWidth(1.2)
              .border({ radius: 12 })

            Row({ space: 5 }) {
              Image($r('app.media.merchant'))
                .fillColor($r('app.color.Charcoal_Gray'))
                .width(30)
                .height(30)
              Radio({ value: 'merchant', group: 'userType' })
                .checked(this.userType === 'merchant')
                .onChange((isChecked) => {
                  if (isChecked) {
                    this.userType = 'merchant';
                  }
                })
                .margin({ top: 8 })

            }
            .width('32%')

            Divider()
              .vertical(true)
              .height(50)
              .color($r('app.color.Charcoal_Gray'))
              .opacity(0.5)
              .margin({ right: 10 })
              .strokeWidth(1.2)
              .border({ radius: 12 })

            Row({ space: 5 }) {
              Image($r('app.media.rider'))
                .fillColor($r('app.color.Charcoal_Gray'))
                .width(30)
                .height(30)
              Radio({ value: 'rider', group: 'userType' })
                .checked(this.userType === 'rider')
                .onChange((isChecked) => {
                  if (isChecked) {
                    this.userType = 'rider';
                  }
                })
                .margin({ top: 8 })

            }

            .width('32%')
          }
          .height(90)
          .width('90%')
          .justifyContent(FlexAlign.Start)
          .margin({ top: 30, bottom: 50 })
          .backgroundColor($r('app.color.Orange'))
          .border({ radius: 10 })


          // 用户名和密码输入框
          Row() {
            Divider()
              .vertical(true)
              .height(60)
              .color($r('app.color.Orange'))
              .opacity(4)
              .strokeWidth(4)

            Image($r('app.media.personal'))
              .fillColor($r('app.color.Charcoal_Gray'))
              .margin({ left: 10, right: -10 })
              .width(30)

            TextInput({ placeholder: '输入手机号' })
              .width('86%')
              .backgroundColor($r('app.color.Warm_Sand'))
              .inputStyle()// 公共样式函数
              .maxLength(11)
              .onChange(data => {
                this.user = data;
              })

          }
          .width('90%')
          .height(60)
          .margin({ bottom: 40 })
          .backgroundColor($r('app.color.Warm_Sand'))

          Row() {
            Divider()
              .vertical(true)
              .height(60)
              .color($r('app.color.Orange'))
              .opacity(4)
              .strokeWidth(4)

            Image($r('app.media.password'))
              .fillColor($r('app.color.Charcoal_Gray'))
              .margin({ left: 10, right: -10 })
              .width(30)

            TextInput({ placeholder: '输入密码' })
              .width('86%')
              .backgroundColor($r('app.color.Warm_Sand'))
              .type(InputType.Password)
              .inputStyle()
              .onChange(data => {
                this.password = data;
              })
          }
          .width('90%')
          .margin({bottom:20})
          .height(60)
          .backgroundColor($r('app.color.Warm_Sand'))

          Row() {
            Text('忘记密码?')
              .fontSize('16fp')
              .fontColor($r('app.color.Stone_Gray'))
              .margin({ right: 30, top: 10 ,bottom:10 })
          }
          .width('100%')
          .justifyContent(FlexAlign.End)

          Row() {
            Button('注册')
              .fontSize('16fp')
              .fontColor($r('app.color.Charcoal_Gray'))
              .backgroundColor($r('app.color.Warm_Sand'))
              .height(45)
              .width('35%')
              .margin({ top: 15, right: 20 })
              .onClick(() => {
                this.registBtnClick()
              })

            Button('登录', { type: ButtonType.Capsule })
              .fontColor($r('app.color.Charcoal_Gray'))
              .width('35%')
              .height(45)
              .margin({ top: 20 })
              .backgroundColor($r('app.color.Cream'))
              .onClick(() => {
                this.loginBtnClick()
              })
          }


          Row() {
            Blank().height(0.5).layoutWeight(1)
              .backgroundColor($r('app.color.Light_Cream'))
              .margin({ left: 10, right: 10 })
            Text('其他登录方式')
              .fontSize('16fp')
              .fontColor($r('app.color.Stone_Gray'))
            Blank().height(0.5).layoutWeight(1)
              .backgroundColor('app.color.Light_Cream')
              .margin({ left: 10, right: 10 })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ top: 40 })

          Row() {
            Row() {
              Image($r('app.media.huawei'))
                .fillColor($r('app.color.Orange'))
                .width(40)
                .height(40)
                .margin({right:10})
              Text('华为账号')
                .fontSize(16)
                .fontColor($r('app.color.Charcoal_Gray'))
            }
            .margin({right:30})
            .width('50%')



            Row() {
              Image($r('app.media.weixin'))
                .fillColor($r('app.color.Stone_Gray'))
                .width(40)
                .height(40)
                .margin({right:10})
              Text('微信')
                .fontSize(16)
                .fontColor($r('app.color.Charcoal_Gray'))
            }
            .layoutWeight(1)

          }
          .width('70%')
          .justifyContent(FlexAlign.SpaceAround)
          .margin('20vp')
        }
        .width('100%')
        .height('100%')
        .backgroundColor($r('app.color.Light_Cream'))
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
      }
      .width('100%')
      .height('100%')
    }
    .title('登录')
    .onReady((context: NavDestinationContext) => {
      // 保留路径栈设置
      this.pathStack = context.pathStack;
    })
    .hideTitleBar(true)
    .hideToolBar(true)
  }
}

// 样式扩展
@Extend(TextInput)
function inputStyle() {
  .placeholderColor($r('app.color.Charcoal_Gray'))
  .maxLength(6)
  .padding('12vp')
  .margin('10vp')
}

@Extend(Button)
function circleBtnStyle() {
  .width('60vp')
  .height('60vp')
}