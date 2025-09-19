// 导入必要模块
import { ToolBar } from "@ohos.arkui.advanced.ToolBar";
import promptAction from '@ohos.promptAction';
import { taskPoolInsertUser, taskPoolInsertMerchant, taskPoolInsertRider } from '../../taskpool/RdbTaskpool';
import { UserType } from '../../common/UserInfo';
import { NavParam } from '../../common/common';

// import { NavDestinationContext } from '@ohos.arkui.navigation';

// 跳转页面入口函数
@Builder
export function registerBuilder() {
  register();
}

@Preview
@Component
struct register {
  @State pathStack: NavPathStack = new NavPathStack();
  // 注册页面的状态变量
  @State userName: string = '';
  @State password: string = '';
  @State password2: string = '';
  @State shopName: string = '';
  @State address: string = '';
  @State registUserType: UserType = 'user';

  aboutToAppear() {
  //给user赋值
  }

  // 导航回登录页面
  private backToLogin(): void {
    this.pathStack.pop();
  }

  // 注册按钮点击处理
  async registBtnClick() {
    if (!this.userName || !this.password || !this.password2) {
      promptAction.showToast({
        message: '手机号、密码不能为空',
        duration: 1000,
        bottom: '360vp'
      })
      return
    }

    if (this.password !== this.password2) {
      promptAction.showToast({
        message: '两次密码输入不一致',
        duration: 1000,
        bottom: '360vp'
      })
      return
    }

    if (this.registUserType === 'merchant' && (!this.shopName || !this.address)) {
      promptAction.showToast({
        message: '店铺名称和地址不能为空',
        duration: 1000,
        bottom: '360vp'
      })
      return
    }

    try {
      if (this.registUserType === 'user') {
        await taskPoolInsertUser(getContext(this), this.userName, this.password, this.userName, '', 1);
      } else if (this.registUserType === 'merchant') {
        await taskPoolInsertMerchant(getContext(this), this.shopName, this.address, this.userName, 1, 1, this.password);
      } else {
        await taskPoolInsertRider(getContext(this), this.userName, this.password, this.userName);
      }

      promptAction.showToast({
        message: '注册成功',
        duration: 1000,
        bottom: '360vp'
      })
      this.backToLogin(); // 注册成功后返回到登录页面
    } catch (e) {
      promptAction.showToast({
        message: '注册失败: ' + e.message,
        duration: 1000,
        bottom: '360vp'
      })
    }
  }

  build() {
    //Navigation(this.pathStack) {
    // 注册页面
    NavDestination() {
      Column() {
        Row() {
          Button('<返回')
            .fontSize(16)
            .fontColor($r('app.color.Charcoal_Gray'))
            .width('20%')
            .height(45)
            .backgroundColor($r('app.color.Light_Cream'))
            .onClick(() => {
              this.backToLogin(); // 返回登录页面
            })
        }
        .margin({bottom:30,top:25})
        .width('100%')
        .justifyContent(FlexAlign.Start)

        Column() {
          Column(){
          Image($r("app.media.register"))
            .fillColor(Color.Black)
            .width(60)
            .margin({top:17,left:2})
          }
          .margin({ bottom: 30, top: 10 })
          .width(100)
          .height(100)
          .borderRadius(50)
          .backgroundColor($r('app.color.Orange'))


          Text(this.registUserType === 'user' ? '用户注册' :
            this.registUserType === 'merchant' ? '商家注册' : '骑手注册')
            .fontSize(25)
            .fontColor($r('app.color.Charcoal_Gray'))
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 30 })

          Row() {
            Divider()
              .vertical(true)
              .height(60)
              .color($r('app.color.Deep_Orange'))
              .opacity(4)
              .strokeWidth(6)
              .margin({left:-2})

            Image($r('app.media.personal'))
              .fillColor($r('app.color.Charcoal_Gray'))
              .margin({ left: 10, right: -10 })
              .width(30)

            TextInput({ placeholder: '输入手机号' })
              .backgroundColor($r('app.color.Warm_Sand'))
              .width('86%')
              .inputStyle()
              .maxLength(11)
              .onChange(data => {
                this.userName = data;
              })

          }
          .width('90%')
          .height(60)
          .margin({ bottom: 20 })
          .borderWidth(1)
          .borderColor($r('app.color.Charcoal_Gray'))


          Row() {
            Divider()
              .vertical(true)
              .height(60)
              .color($r('app.color.Deep_Orange'))
              .opacity(4)
              .strokeWidth(6)
              .margin({left:-2})

            Image($r('app.media.personal'))
              .fillColor($r('app.color.Charcoal_Gray'))
              .margin({ left: 10, right: -10 })
              .width(30)

            TextInput({ placeholder: '输入密码' })
              .backgroundColor($r('app.color.Warm_Sand'))
              .width('86%')
              .type(InputType.Password)
              .inputStyle()
              .onChange(data => {
                this.password = data;
              })

          }
          .width('90%')
          .height(60)
          .margin({ bottom: 20 })
          .borderWidth(1)
          .borderColor($r('app.color.Charcoal_Gray'))


          Row() {
            Divider()
              .vertical(true)
              .height(60)
              .color($r('app.color.Deep_Orange'))
              .opacity(4)
              .strokeWidth(6)
              .margin({left:-2})

            Image($r('app.media.personal'))
              .fillColor($r('app.color.Charcoal_Gray'))
              .margin({ left: 10, right: -10 })
              .width(30)

            TextInput({ placeholder: '再次输入密码' })
              .backgroundColor($r('app.color.Warm_Sand'))
              .width('86%')
              .type(InputType.Password)
              .inputStyle()
              .onChange(data => {
                this.password2 = data;
              })

          }
          .width('90%')
          .height(60)
          .margin({ bottom: 20 })
          .borderWidth(1)
          .borderColor($r('app.color.Charcoal_Gray'))



          if (this.registUserType === 'merchant') {
            Row() {
              Divider()
                .vertical(true)
                .height(60)
                .color($r('app.color.Deep_Orange'))
                .opacity(4)
                .strokeWidth(6)
                .margin({left:-2})

              Image($r('app.media.personal'))
                .fillColor($r('app.color.Charcoal_Gray'))
                .margin({ left: 10, right: -10 })
                .width(30)

              TextInput({ placeholder: '输入店铺名称' })
                .backgroundColor($r('app.color.Warm_Sand'))
                .width('86%')
                .type(InputType.Password)
                .inputStyle()
                .onChange(data => {
                  this.shopName = data;
                })

            }
            .width('90%')
            .height(60)
            .margin({ bottom: 20 })
            .borderWidth(1)
            .borderColor($r('app.color.Charcoal_Gray'))

            Row() {
              Divider()
                .vertical(true)
                .height(60)
                .color($r('app.color.Deep_Orange'))
                .opacity(4)
                .strokeWidth(6)
                .margin({left:-2})

              Image($r('app.media.personal'))
                .fillColor($r('app.color.Charcoal_Gray'))
                .margin({ left: 10, right: -10 })
                .width(30)

              TextInput({ placeholder: '输入店铺地址' })
                .backgroundColor($r('app.color.Warm_Sand'))
                .width('86%')
                .type(InputType.Password)
                .inputStyle()
                .onChange(data => {
                  this.address = data;
                })

            }
            .width('90%')
            .height(60)
            .margin({ bottom: 20 })
            .borderWidth(1)
            .borderColor($r('app.color.Charcoal_Gray'))

          }

          Button('注册', { type: ButtonType.Capsule })
            .width('50%')
            .fontColor($r('app.color.Charcoal_Gray'))
            .margin({
              top: 20,
              left: 20,
              right: 20,
              bottom: 150
            })
            .backgroundColor($r('app.color.Cream'))
            .onClick(() => {
              this.registBtnClick();
            })
        }
        .width('90%')
        .borderRadius(20)
        .backgroundColor($r('app.color.Warm_Sand'))
      }
      .backgroundColor($r('app.color.Light_Cream'))
      .justifyContent(FlexAlign.Start)
      .width('100%')
      .height('100%')
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }
    .title('注册') // 注册页面标题
    .onReady((context: NavDestinationContext) => {
      // 保留路径栈设置
      const param = context.pathInfo?.param as NavParam;
      if (param?.userType) {
        this.registUserType = param.userType;
      }
      this.pathStack = context.pathStack;
    })
    .hideTitleBar(true)
    .hideToolBar(true)

  }

  //}
}

// 样式扩展保持不变
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