import MyData from '../../entity/MyData';
import OrderBean from '../../entity/OrderBean';
import DbUtil from '../../utils/DbUtil';
import { promptAction } from '@kit.ArkUI';
import Toast from '../../utils/Toast';

@Component
export struct Order {
  @State orderList: OrderBean[] = [];
  @State refreshing: boolean = false;
  @State animationScale: number = 1;
  @State selectedOrderId: string = '';
  @State showDeleteConfirm: boolean = false;
  @State pendingDeleteItem: OrderBean | null = null;
  @State buttonHover: boolean = false;
  @State listItemScale: number = 1;
  @State refreshAngle: number = 0;
  @State emptyImageOffsetY: number = 0;

  aboutToAppear() {
    this.loadOrderList();
    this.animateEmptyImage();
  }

  // Animate the image on the empty page
  private animateEmptyImage() {
    animateTo({
      duration: 2000,
      curve: Curve.EaseInOut,
      iterations: -1, // Loop indefinitely
      playMode: PlayMode.Alternate // Animate back and forth
    }, () => {
      this.emptyImageOffsetY = -15;
    });
  }

  // 加载订单数据
  private loadOrderList() {
    this.refreshing = true;
    animateTo({ duration: 1000, curve: Curve.Linear }, () => {
      this.refreshAngle += 360;
    });

    DbUtil.queryOrderList().then((r) => {
      this.orderList = r;
      this.refreshing = false;
    }).catch(() => {
      console.error('加载订单列表失败');
      this.refreshing = false;
    });
  }

  // 删除单个订单
  private deleteOne(item1: OrderBean) {
    this.showDeleteConfirm = false;
    this.pendingDeleteItem = null;

    DbUtil.deleteOrder(item1.id!);
    const newArray = this.orderList.filter(item => item.id != item1.id);
    this.orderList = newArray;
    promptAction.showToast({
      message: '删除成功! ✅',
      duration: 1000,
      bottom: '360vp'
    });
  }

  // 支付订单
  private commitBtn(item: OrderBean) {
    DbUtil.updateOrder(item);
    let tempArr: OrderBean[] = [];
    this.orderList.map((v) => {
      if (v.id == item.id) {
        v.state = 1;
      }
      tempArr.push(v);
    });
    this.orderList = tempArr;
    promptAction.showToast({
      message: '支付成功! 🎉',
      duration: 1000,
      bottom: '360vp'
    });
  }

  // 构建订单项
  @Builder
  OrderItem(item: OrderBean, index: number) {
    Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
      // 订单头部
      Row() {
        Row() {
          Text((item.state == 1) ? '已支付 ✅' : '未支付 ⏳')
            .textAlign(TextAlign.Center)
            .fontSize(12)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
        }
        .height(28)
        .padding({ left: 12, right: 12 })
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(item.state == 1 ? '#4CAF50' : '#FF6B35')
        .borderRadius(14)
        .shadow({
          radius: 4,
          color: item.state == 1 ? '#4CAF50' : '#FF6B35',
          offsetX: 0,
          offsetY: 2
        })

        Blank()

        Text(`#${item.order_code}`)
          .fontSize(13)
          .fontColor('#8B4513')
          .fontWeight(FontWeight.Medium)
          .opacity(0.8)
      }
      .width('100%')
      .margin({ top: 16, bottom: 12 })

      // 订单内容
      Row() {
        Image(MyData.getFoodImg(item.img_id))
          .height('90vp')
          .width('90vp')
          .objectFit(ImageFit.Cover)
          .borderRadius(16)
          .shadow({
            radius: 8,
            color: '#D4A574',
            offsetX: 0,
            offsetY: 4
          })
          .transition({ type: TransitionType.All })
          .brightness(this.selectedOrderId === item.order_code ? 0.9 : 1.0)

        Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.SpaceAround }) {
          Row() {
            Text('💰 总价：')
              .fontSize(14)
              .fontColor('#8B4513')
              .fontWeight(FontWeight.Medium)

            Row() {
              Text('￥')
                .fontSize(16)
                .fontColor('#FF6B35')
                .fontWeight(FontWeight.Bold)
              Text(`${item.total_price}`)
                .fontSize(20)
                .fontColor('#FF6B35')
                .fontWeight(FontWeight.Bold)
            }
          }
          .width('100%')
          .alignItems(VerticalAlign.Bottom)

          Row() {
            Text('🕒 创建时间：')
              .fontSize(12)
              .fontColor('#A0522D')
              .fontWeight(FontWeight.Regular)

            Text(`${item.date_added}`)
              .fontSize(12)
              .fontColor('#654321')
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .margin({ top: 8 })

          if (item.state == 0) {
            Row() {
              Blank()
              Button('立即支付 💳', { type: ButtonType.Capsule, stateEffect: true })
                .backgroundColor('#D4A574')
                .fontColor(Color.White)
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .height(36)
                .width(120)
                .shadow({ radius: 6, color: '#D4A574', offsetX: 0, offsetY: 3 })
                .linearGradient({
                  direction: GradientDirection.Bottom,
                  colors: [['#E6B887', 0.0], ['#D4A574', 1.0]]
                })
                .onClick(() => {
                  // CORRECTED: Replaced Curve.Spring with Curve.Friction
                  animateTo({ duration: 300, curve: Curve.Friction }, () => {
                    this.animationScale = 0.9;
                  });
                  animateTo({ duration: 300, curve: Curve.Friction, delay: 150 }, () => {
                    this.animationScale = 1;
                    item.state = 1;
                    this.commitBtn(item);
                  });
                })
                .scale({ x: this.animationScale, y: this.animationScale })
            }
            .width('100%')
            .margin({ top: 12 })
          }
        }
        .margin({ left: 16, top: 12, bottom: 12 })
        .width('50%')
      }
      .margin({ top: 8 })
      .width('100%')
    }
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .borderRadius(20)
    .backgroundColor(Color.White)
    .width('100%')
    .height('150vp')
    .scale({ x: this.selectedOrderId === item.order_code ? 1.03 : 1, y: this.selectedOrderId === item.order_code ? 1.03 : 1 })
    .shadow({
      radius: this.selectedOrderId === item.order_code ? 16 : 12,
      color: this.selectedOrderId === item.order_code ? '#FF6B35' : '#D4A574',
      offsetX: 0,
      offsetY: this.selectedOrderId === item.order_code ? 8 : 6
    })
    .border({
      width: this.selectedOrderId === item.order_code ? 1.5 : 1,
      color: this.selectedOrderId === item.order_code ? '#FF8C69' : '#F5DEB3',
      style: BorderStyle.Solid
    })
    // CORRECTED: Replaced Curve.Spring with a compatible curve like Curve.Friction
    .animation({ duration: 400, curve: Curve.Friction })
    .onClick(() => {
      this.selectedOrderId = this.selectedOrderId === item.order_code ? '' : item.order_code;
      Toast.show(`订单编号: ${item.order_code}`);
    })
    .gesture(
      LongPressGesture({ repeat: false })
        .onAction(() => {
          this.pendingDeleteItem = item;
          this.showDeleteConfirm = true;
        })
    )
  }

  // 构建空视图
  @Builder
  emptyView() {
    Flex({
      justifyContent: FlexAlign.Center,
      alignItems: ItemAlign.Center,
      direction: FlexDirection.Column
    }) {
      Stack() {
        Circle({ width: 200, height: 200 })
          .fill('#FFF8DC')
          .shadow({ radius: 20, color: '#D4A574', offsetX: 0, offsetY: 10 })

        Image($r('app.media.empty'))
          .width(120)
          .height(120)
          .opacity(0.8)
          .offset({ y: this.emptyImageOffsetY })
      }
      .margin({ bottom: 24 })

      Text('🤔 暂无订单')
        .fontSize(22)
        .fontColor('#8B4513')
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 8 })

      Text('快去下单吧～ 🛍️')
        .fontSize(16)
        .fontColor('#CD853F')
        .margin({ bottom: 40 })

      Button('去下单 ✨', { type: ButtonType.Capsule })
        .width(200)
        .height(50)
        .fontSize(18)
        .backgroundColor('#D4A574')
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
        .shadow({
          radius: 10,
          color: '#D4A574',
          offsetX: 0,
          offsetY: 6
        })
        .scale({ x: this.buttonHover ? 1.05 : 1.0 })
        .animation({ duration: 200, curve: Curve.EaseInOut })
        .onHover((isHover) => { this.buttonHover = isHover })
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#E6B887', 0.0], ['#D4A574', 1.0]]
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFAF0')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#FFFAF0', 0.0], ['#FFF8DC', 1.0]]
    })
  }

  // 构建删除按钮
  @Builder
  DeleteBtn(item: OrderBean) {
    Flex({
      direction: FlexDirection.Column,
      justifyContent: FlexAlign.Center,
      alignItems: ItemAlign.Center
    }) {
      Column() {
        Image($r('app.media.trash'))
          .width(28)
          .height(28)
          .margin({ bottom: 8 })
          .fillColor(Color.White)
        Text('删除 🗑️')
          .fontSize(14)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
      }
      .padding({ top: 16, bottom: 16 })
    }
    .onClick(() => {
      this.pendingDeleteItem = item;
      this.showDeleteConfirm = true;
    })
    .height(130)
    .width(90)
    .backgroundColor('#FF6B35')
    .borderRadius(20)
    .margin({ left: -20 })
    .shadow({ radius: 8, color: '#FF6B35', offsetX: 0, offsetY: 4 })
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#FF8C69', 0.0], ['#FF6B35', 1.0]]
    })
  }

  // 构建顶部导航栏
  @Builder
  TopBar() {
    Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
      Text('📜 我的订单')
        .fontSize(24)
        .fontColor('#654321')
        .fontWeight(FontWeight.Bold)
        .margin({ left: 20 })

      if (this.orderList.length > 0) {
        Text(`${this.orderList.length} 个订单`)
          .fontSize(14)
          .fontColor('#A0522D')
          .margin({ right: 20 })
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor('#FFF8DC')
          .borderRadius(15)
      }

      if (this.refreshing) {
        LoadingProgress()
          .width(20)
          .height(20)
          .color('#D4A574')
          .margin({ right: 20 })
      } else {
        Button({ type: ButtonType.Circle, stateEffect: true }) {
          Image($r('app.media.fork'))
            .width(16)
            .height(16)
            .fillColor('#D4A574')
        }
        .backgroundColor('#FFF8DC')
        .width(32)
        .height(32)
        .rotate({ z: 1, angle: this.refreshAngle })
        .animation({ duration: 1000, curve: Curve.EaseInOut })
        .onClick(() => {
          this.loadOrderList();
        })
        .margin({ right: 20 })
        .shadow({ radius: 4, color: '#D4A574', offsetX: 0, offsetY: 2 })
      }
    }
    .width('100%')
    .height(80)
    .padding({ top: 20 })
    .backgroundColor('#FFFAF0')
  }

  // 删除确认弹窗
  @Builder
  DeleteConfirmDialog() {
    if (this.showDeleteConfirm && this.pendingDeleteItem) {
      Stack() {
        Row() {}
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0,0,0,0.5)')
        .transition({ type: TransitionType.All, opacity: 0 })
        .onClick(() => {
          this.showDeleteConfirm = false;
          this.pendingDeleteItem = null;
        })

        Column() {
          Text('❓ 确认删除')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#654321')
            .margin({ bottom: 16 })

          Text(`确定要删除订单 #${this.pendingDeleteItem.order_code} 吗？`)
            .fontSize(14)
            .fontColor('#8B4513')
            .textAlign(TextAlign.Center)
            .margin({ bottom: 24 })

          Row() {
            Button('取消 ❌', { type: ButtonType.Capsule })
              .backgroundColor('#D3D3D3')
              .fontColor('#757575')
              .fontSize(14)
              .width(80)
              .height(36)
              .onClick(() => {
                this.showDeleteConfirm = false;
                this.pendingDeleteItem = null;
              })

            Blank().width(20)

            Button('确定 ✔️', { type: ButtonType.Capsule })
              .backgroundColor('#FF6B35')
              .fontColor(Color.White)
              .fontSize(14)
              .width(80)
              .height(36)
              .onClick(() => {
                if (this.pendingDeleteItem) {
                  this.deleteOne(this.pendingDeleteItem);
                }
              })
              .linearGradient({
                direction: GradientDirection.Bottom,
                colors: [['#FF8C69', 0.0], ['#FF6B35', 1.0]]
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
        }
        .padding(24)
        .backgroundColor('#FFF8DC')
        .borderRadius(16)
        .width('80%')
        .shadow({ radius: 16, color: '#D4A574', offsetX: 0, offsetY: 8 })
        .border({ width: 1, color: '#F5DEB3', style: BorderStyle.Solid })
        .transition({ type: TransitionType.All, scale: { x: 0.5, y: 0.5 }, opacity: 0 })
      }
      .width('100%')
      .height('100%')
      .position({ x: 0, y: 0 })
      .zIndex(1000)
    }
  }

  // 构建主内容区
  @Builder
  MainContent() {
    Stack() {
      Flex({ direction: FlexDirection.Column }) {
        this.TopBar()

        Scroll() {
          Column() {
            if (this.orderList.length > 0) {
              List({ space: '20vp' }) {
                ForEach(this.orderList.reverse(), (item: OrderBean, index?: number) => {
                  ListItem() {
                    if (index !== undefined) {
                      this.OrderItem(item, index)
                    }
                  }
                  .swipeAction({ end: this.DeleteBtn(item) })
                  .transition({ type: TransitionType.All, opacity: 0, scale: { x: 0.8, y: 0.8 } })
                })
              }
              .padding({ top: 20, bottom: 20 })
            } else {
              Column() {
                this.emptyView()
              }
              .width('100%')
              .height('100%')
            }
          }
          .height('100%')
        }
        .scrollBar(BarState.Off)
        .margin({ left: 16, right: 16 })
        .height('100%')
        .backgroundColor('#FFFAF0')
        .borderRadius({ topLeft: 25, topRight: 25 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFAF0')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#FFFAF0', 0.0], ['#FFF8DC', 1.0]]
      })
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

      this.DeleteConfirmDialog()
    }
    .width('100%')
    .height('100%')
  }

  build() {
    this.MainContent();
  }
}