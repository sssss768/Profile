// 跳转页面入口函数
@Builder
export function StartBuilder() {
  Start();
}

@Component
struct Start {
  pathStack: NavPathStack = new NavPathStack();
  @State time: number = 3; // 使用@State装饰器
  timerID: number = -1;   // 存储定时器ID

  aboutToAppear(): void {
    // 使用单个定时器，每秒更新
    this.timerID = setInterval(() => {
      if (this.time > 1) {
        this.time -= 1; // 减少时间
      } else {
        clearInterval(this.timerID); // 清除定时器
        this.pathStack.replacePathByName('Login', null, false); // 跳转
      }
    }, 1000); // 每秒执行一次
  }

  // 组件消失时清除定时器
  aboutToDisappear(): void {
    if (this.timerID !== -1) {
      clearInterval(this.timerID);
    }
  }

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.TopEnd }) {
        // Image($r('app.media.start'))
        Image($r('app.media.begin'))
          .width("100%")
          .height("100%")
          .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

        // 动态显示剩余时间
        Button(`跳过 ${this.time}s`)
          .onClick(() => {
            // 清除定时器并跳转
            if (this.timerID !== -1) {
              clearInterval(this.timerID);
            }
            this.pathStack.replacePathByName('Login', null, false);
          })
          .margin({ right: 15 })
          .backgroundColor($r('app.color.Stone_Gray'))
      }
    }
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })
  }
}