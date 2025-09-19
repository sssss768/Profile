import Food from '../../entity/Food';
import MyData from '../../entity/MyData';
import { emitter } from '@kit.BasicServicesKit';
import OrderBean from '../../entity/OrderBean';
import { App, promptAction } from '@kit.ArkUI';
import DbUtil from '../../utils/DbUtil';
import { GlobalStorage } from '../../entity/GlobalStorage';

interface FoodItem {
  food: Food;
  count: number;
}

@Component
export struct Cart {
  @State sumPrice: number = 0;
  @State cartList: Food[] = [];
  @State eatType: string = '精选';
  @State isCartEmpty: boolean = true;
  @State animationScale: number = 1;
  @State buttonHover: boolean = false;
  @State listItemAnimation: number = 0;
  private changeTab?: (index: number) => void;

  aboutToAppear() {
    this.loadCartData();

  }
  // 查重
  private  groupFoodByCount(cartList: Food[]): FoodItem[] {
    // 使用Map按ID分组食品，值为Food对象和计数
    const foodMap = new Map<string, FoodItem>();

    cartList.forEach(food => {
      if (!foodMap.has(food.id_)) {
        // 初始化新的分组项，直接使用原始Food对象
        foodMap.set(food.id_, {
          food,
          count: 1
        });
      } else {
        // 增加已有分组的计数
        const group = foodMap.get(food.id_)!;
        group.count++;
      }
    });

    // 将Map转换为数组返回
    return Array.from(foodMap.values());
  }

  // 计算总价
  private calculatePrice() {
    let tempPrice = 0;
    this.cartList.map((item: Food) => {
      tempPrice += item.price;
    });
    this.sumPrice = tempPrice;

    // 根据总价判断是否为空
    this.isCartEmpty = this.cartList.length === 0;
  }

  // 删除单个商品
  private deleteOne(item1: Food) {
    DbUtil.deleteFood(item1.id_);
    const newArray = this.cartList.filter(item => item.id_ != item1.id_);

    this.cartList = newArray;
    // 删除后，根据剩余总价计算购物车是否为空
    this.calculatePrice();
    promptAction.showToast({
      message: '删除成功!',
      duration: 1000,
      bottom: '320vp'
    });
  }


  // 提交订单
  private commitBtn(isPay: boolean) {
    if (this.sumPrice <= 0) {
      promptAction.showToast({
        message: '请选择商品!',
        duration: 1000,
        bottom: '360vp'
      });
      return;
    }

    // 按钮动画效果
    this.animationScale = 0.95;
    setTimeout(() => {
      this.animationScale = 1;
    }, 150);

    // 处理数据库
    let selectArr: string[] = [];
    this.cartList.map((item: Food) => {
      selectArr.push(item.id_);
    });
    DbUtil.batchDeleteFood(selectArr);

    let idsStr = selectArr.join(',');

    let order = new OrderBean();
    order.state = isPay ? 1 : 0;
    order.total_price = this.sumPrice;
    order.score = this.sumPrice;
    order.goods_ids = idsStr;
    order.shop_name = GlobalStorage.getInstance().shopName;;
    order.img_id = this.cartList[0].icon_id;
    DbUtil.insertOrder(order);


    // 处理本地数据
    this.cartList = [];
    this.calculatePrice();

    promptAction.showToast({
      message: isPay ? '支付成功!' : '下单成功!',
      duration: 1000,
      bottom: '320vp'
    });
  }

  // 加载购物车数据
  private loadCartData() {
    // 实际应用中应从数据库加载数据
    // this.cartList = MyData.categoryList[0].foodList;
    this.calculatePrice();

    // 监听事件
    emitter.on({ eventId: 1 }, (event) => {
      let eatType: string = event?.data?.['eatType'].toString();
      console.log('zhu emitter.on() eatType=' + eatType);
      this.eatType = eatType;
    });
  }

  // 构建购物车项
  @Builder
  CartItem(item: Food, index: number) {
    Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
      Row() {
        Row() {
          Text(this.eatType)
            .fontSize(12)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Medium)
        }
        .height(24)
        .padding({ left: 8, right: 8 })
        .backgroundColor($r('app.color.Orange'))
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)


        Text(GlobalStorage.getInstance().shopName)
          .fontSize(15)
          .margin({ left: 10 })
          .width('100%')
          .fontColor($r('app.color.Charcoal_Gray'))
      }
      .width('100%')
      .margin({ bottom: 12 })

      // 主要内容区域
      Row() {
        // 商品图片
        Image(MyData.getFoodImg(item.icon_id))
          .width(60)
          .height(60)
          .borderRadius(8)
          .backgroundColor('#F0F0F0')

        // 订单信息
        Row() {
          Text(item.name)
            .fontSize(16)
            .fontColor('#333333')
            .fontWeight(FontWeight.Medium)
            .margin({ left: 4 ,top:5})

          Blank()
          Column() {
            Text(item.price+` x `+index)
              .fontSize(13)
              .fontColor('#666666')
              .margin({ top:15 ,right:2})
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ bottom: 2 })
        }
        .layoutWeight(1)
        .margin({ left: 12 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      // 底部价格区域
      Row() {

        Column() {
          Text(`￥${item.price*index}`)
            .fontSize(20)
            .fontColor('#FF6B35')
            .fontWeight(FontWeight.Bold)

        }
        .width('100%')
        .margin({ right: 35 ,bottom:5})
        .alignItems(HorizontalAlign.End)
      }

    }
    .padding({
      left: 16,
      right: 16,
      top: 8,
      bottom: 8
    })
    .width('90%')
    .padding(16)
    .backgroundColor('#FFF')
    .borderRadius(12)
    .shadow({
      radius: 8,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 2
    })
    .margin({ bottom: 5, left: 17 })
    .height('150vp')
    .animation({
      duration: 300,
      curve: Curve.EaseInOut
    })
    .onAppear(() => {
      this.listItemAnimation = 1;
    })
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
          .fill($r('app.color.Warm_Sand')) // 浅卡其色背景

        Image($r('app.media.empty'))
          .width(120)
          .height(120)
          .opacity(0.8)
      }
      .margin({ bottom: 30 })

      Text('购物车空空如也呢')
        .fontSize(22)
        .fontColor($r('app.color.Charcoal_Gray'))
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 8 })

      Text('快去挑选喜欢的商品吧！')
        .fontSize(16)
        .fontColor('#666666')
        .margin({ bottom: 30 })

      Button('去逛逛', { type: ButtonType.Capsule })
        .width(200)
        .height(50)
        .fontSize(18)
        .backgroundColor($r('app.color.Orange'))
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
        .borderRadius(25)
        .animation({
          duration: 200,
          curve: Curve.EaseInOut
        })
        .onClick(() => {
          this.buttonHover = true;
          setTimeout(() => {
            this.buttonHover = false;
          }, 200);
          if (this.changeTab) {
            this.changeTab(0);
          }
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.Light_Cream'))

  }

  // 构建删除按钮
  @Builder
  DeleteBtn(item: Food) {
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
        Text('删除')
          .fontSize(14)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
      }
      .padding({ top: 16, bottom: 16 })
    }
    .onClick(() => {
      this.deleteOne(item);
    })
    .height(130)
    .width(90)
    .backgroundColor('#FF6B35') // 橙红色
    .borderRadius(20)
    .margin({ left: -20 })
    .shadow({
      radius: 8,
      color: '#FF6B35',
      offsetX: 0,
      offsetY: 4
    })
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#FF8C69', 0.0], ['#FF6B35', 1.0]]
    })
  }

  // 构建底部结算栏
  @Builder
  BottomView() {
    Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
      Column() {
        Text('总计')
          .fontSize(14)
          .fontColor('#8B4513')
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 4 })

        Row() {
          Text('￥')
            .fontSize(16)
            .fontColor('#FF6B35')
            .fontWeight(FontWeight.Bold)
          Text(`${this.sumPrice}`)
            .fontSize(24)
            .fontColor('#FF6B35')
            .fontWeight(FontWeight.Bold)
        }
      }
      .alignItems(HorizontalAlign.Start)

      Row() {
        Button('下单', { type: ButtonType.Capsule, stateEffect: true })
          .backgroundColor($r('app.color.Cream'))
          .fontSize(16)
          .margin({ right: 12 })
          .height(45)
          .width(100)
          .enabled(!this.isCartEmpty)
          .fontColor($r('app.color.Charcoal_Gray'))
          .fontWeight(FontWeight.Bold)
          .borderRadius(22)
          .shadow({
            radius: 6,
            color: this.sumPrice === 0 ? '#D3D3D3' : '#D4A574',
            offsetX: 0,
            offsetY: 3
          })
          .scale({ x: this.animationScale, y: this.animationScale })
          .animation({
            duration: 150,
            curve: Curve.EaseInOut
          })
          .onClick(() => {
            this.commitBtn(false);
          })


        Button('支付', { type: ButtonType.Capsule, stateEffect: true })
          .backgroundColor($r('app.color.Orange'))
          .fontSize(16)
          .height(45)
          .width(100)
          .enabled(!this.isCartEmpty)
          .fontColor($r('app.color.Charcoal_Gray'))
          .fontWeight(FontWeight.Bold)
          .borderRadius(22)
          .shadow({
            radius: 6,
            color: this.sumPrice === 0 ? '#D3D3D3' : '#FF6B35',
            offsetX: 0,
            offsetY: 3
          })
          .scale({ x: this.animationScale, y: this.animationScale })
          .animation({
            duration: 150,
            curve: Curve.EaseInOut
          })
          .onClick(() => {
            this.commitBtn(true);
          })
      }
    }
    .padding({
      right: 20,
      left: 20,
      top: 12,
      bottom: 12
    })
    .backdropBlur(13) // 关键：背景模糊效果
    .backgroundColor('rgba(247, 238, 221, 0.5)') // 半透明背景
    .width('100%')
    .height(70)
    .borderRadius({ topLeft: 20, topRight: 20 })
    .border({
      width: { top: 2 },
      color: $r('app.color.Orange'),
      style: BorderStyle.Solid
    })
  }


  // 构建主内容区
  @Builder
  MainContent() {
    Flex({ direction: FlexDirection.Column }) {
      // 顶部标题区域
      Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Start }) {
        Text('购物车')
          .fontSize(24)
          .fontColor($r('app.color.Charcoal_Gray'))
          .fontWeight(FontWeight.Bold)
          .margin({ left: 20 })

        if (this.cartList.length > 0) {
          Text(`${this.cartList.length} 件商品`)
            .fontSize(14)
            .fontColor('#666666')
            .margin({ right: 20 })
            .padding({
              left: 12,
              right: 12,
              top: 6,
              bottom: 6
            })
            .borderRadius(15)
        }
      }
      .backgroundColor($r('app.color.Light_Cream'))
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
      .width('100%')
      .height(60)
      .padding({ top: 20 })

      Stack({ alignContent: Alignment.Bottom }) {
        // 购物车列表
        Scroll() {
          Column() {
            if (this.cartList.length > 0) {

              List({ space: '20vp' }) {
                ForEach(this.groupFoodByCount(this.cartList), (item: FoodItem) => {
                  ListItem() {
                    if (item) {
                      this.CartItem(item.food,item.count );
                    }
                  }
                  .swipeAction({ end: this.DeleteBtn(item.food) })
                })
              }
              .padding({ top: 20, bottom: 20 })
            } else {
              Column() {
                this.emptyView();
              }
              .width('100%')
              .height('100%')
            }
          }
          .height('100%')
          .backgroundColor($r('app.color.Light_Cream'))
        }
        .backgroundColor($r('app.color.Light_Cream'))
        .scrollBar(BarState.Off)
        .width('100%')
        .height('100%')
        .borderRadius({ topLeft: 25, topRight: 25 })

        // 底部结算栏
        if (!this.isCartEmpty) {

          this.BottomView();
        }

      }
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
      .height('100%')
      .width('100%')
      .backgroundColor($r('app.color.Light_Cream'))
    }
  }

  build() {
    this.MainContent();
  }
}