import Food, { Category } from "../../entity/Food";
import MyData from "../../entity/MyData";
import { RouteParam, ShopBean } from "../../entity/types";
import DbUtil from "../../utils/DbUtil";
import Toast from "../../utils/Toast";
import { AppStorageV2 } from "@kit.ArkUI";
import { GlobalStorage } from "../../entity/GlobalStorage";

//跳转页面入口函数
@Builder
export function ShopPageBuilder() {
  ShopPage()
}

@Entry
@Component
export struct ShopPage {
  routeParam!: RouteParam;
  @State currCateIndex: number = 0;
  @State currFoodIndex: number = 0;
  @State shopBean: ShopBean = MyData.shopBeanList[0]
  @State cateList: Category[] = []
  @State rightFoodList: Food[] = []
  pathStack : NavPathStack = AppStorageV2.connect(NavPathStack,"navStack",()=> new NavPathStack())!
  allFood: Food[] = []
  searchkeyStr: string = ''

  // @State currCateInd ex: number = 0;
  // @State currFoodIndex: number = 0;2
  // @State shopBean: ShopBean = MyData.shopBeanList[0]
  // @State cateList: Category[] = []
  // @State rightFoodList: Food[] = []
  // allFood: Food[] = []
  // searchkeyStr: string = ''

  aboutToAppear(): void {
    // const routeParam = router.getParams() as RouteParam

    const routeParam = this.pathStack.getParamByIndex(1) as RouteParam
    console.info(`接收到的 param.content: ${routeParam.content}`); // 打印接收到的参数值
    let shop_id = routeParam.content as string
    // const routeParam = this.pathStack.getParamByName("Customer") as RouteParam;
    // const shop_id = routeParam.content as string;
    // if (routeParam) {
    //   const shop_id = routeParam.content as string;
    //   console.info(`接收到的 shop_id: ${shop_id}`);
    //   // 后续用 shop_id 做数据查询等操作，比如从 MyData 取对应店铺数据
    //   const shopBean = MyData.getShopById(shop_id);
    // } else {
    //   console.error("未获取到有效路由参数");
    // }
    this.shopBean = MyData.getShopById(shop_id)
    this.cateList = MyData.categoryList
    this.rightFoodList = this.cateList[this.currCateIndex].foodList
    console.info(`接收到的 shop_id: ${routeParam}`); // 打印接收到的参数值
    console.info(`对应的 shopBean: ${JSON.stringify(routeParam)}`); // 打印加载的数据

    console.info(`对应的 shopBean: ${JSON.stringify(this.shopBean)}`); // 打印加载的数据

    this.cateList.map((cate, cateInd) => {
      cate.foodList.map((food) => {
        this.allFood.push(food)
      })
    })

  }

  onSearchClick() {
    this.rightFoodList = []
    this.allFood.map((food) => {
      if (food.name.indexOf(this.searchkeyStr) >= 0) {
        this.rightFoodList.push(food)
      }
    })
  }

  onCateClick(cateIndex: number) {
    this.currCateIndex = cateIndex
    this.rightFoodList = this.cateList[this.currCateIndex].foodList
  }

  onAddBtnClick(item: Food) {
    Toast.show('加入成功')
    DbUtil.insertFood(item)
    GlobalStorage.getInstance().shopName = this.shopBean?.name || '云海肴';
  }

  build() {
    NavDestination() {
      Column() {
        Stack() {
          // Image($r('app.media.order_top')).height('100%').width('100%')
          Image(this.shopBean?.backgroud_img).height('100%').width('100%')
          Column() {
            Blank().height(30)
            //.backgroundColor('#ff4c4a4a')

            RelativeContainer() {
            Button('返回')
               .fontColor($r('app.color.Charcoal_Gray'))
              .backdropBlur(13) // 关键：背景模糊效果
              .backgroundColor('rgba(247, 238, 221, 0.5)') // 半透明背景
                .width(80)
                .height(40)
                .margin({ left: 16 ,bottom:20})
                .alignRules({
                  left: {
                    anchor: '__container__',
                    align: HorizontalAlign.Start
                  },
                  center: {
                    anchor: '__container__',
                    align: VerticalAlign.Center
                  }
                })
            }
            .width('100%')
            .height(40)
            //.backgroundColor($r('app.color.main'))
            .onClick(() => {
              this.pathStack.pop();
            })

            //.backgroundColor('#ff8fc629')

            Blank().layoutWeight(1)
            //.backgroundColor('#ff4c4a4a')

            Column() {
              Row() {
                Text(this.shopBean?.name)
                  .fontWeight(400)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.White)
                  .margin({ right: 10 })
                Text(`[餐厅星级:${this.shopBean?.rate}]`)
                  .fontColor(Color.White)
                  .fontSize(15)
              }
              .margin({ left: 18 })

              Row() {
                Image($r('app.media.map'))
                  .width(15)
                  .margin({ right: 5 })
                  .fillColor(Color.Red)
                Text(this.shopBean?.address)
                  .fontColor(Color.White)
                  .fontSize(15)
              }.margin({ top: 6 })

              Text(`最近好评数：${this.shopBean?.comment}`)
                .fontColor(Color.White)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.White)
                .margin({ top: 6, left: 18 })
            }
            .padding({ left: 16, bottom: 10 })
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          //.backgroundColor('#ffc62929')
          .height('100%')
        }.height(200)

        // 搜索框
        Row() {
          Image($r('app.media.search'))
            .width(21)
            .margin({ left: 16 })

          TextInput({ placeholder: '搜索食物' })
            .textAlign(TextAlign.Start)
            // .backgroundColor(Color.Transparent)
            .backgroundColor(" #F3F3F5")
            .onChange((value: string, previewText?: PreviewText) => {
              this.searchkeyStr = value
            })
            .layoutWeight(1)

          Text('搜索')
            .fontSize(16)
            .fontColor(Color.White)
            .backgroundColor("#FFD100")
            // .backgroundColor($r("app.color.Stone_Gray"))
            .margin({ right: 16 })
            .padding({
              left: 14,
              top: 4,
              right: 14,
              bottom: 4
            })
            .borderRadius(13)
            .onClick(() => {
              this.onSearchClick()
            })
        }
        .margin(12)
        .borderRadius(20)
        .backgroundColor(" #F3F3F5")
        // .backgroundColor($r('app.color.Charcoal_Gray'))


        // 商品列表
        Row() {
          // 左侧分类
          Column() {
            Scroll() {
              List() {
                ForEach(this.cateList, (cate: Category, cateIndex: number) => {
                  ListItem() {
                    Column() {
                      Image(MyData.getFoodImg(cate.logo_id))
                        .width(20)
                        .height(20)
                        .borderRadius(5)
                      Text(cate.name)// 根据实际情况显示数据项的某个属性
                        .fontSize(14)
                        .margin({ top: 5 })
                        .width('100%')
                        .textAlign(TextAlign.Center) // 设置文字横向居中
                    }
                    .height(60)
                    .padding({ top: 6, bottom: 6 })
                    .alignItems(HorizontalAlign.Center)
                    .justifyContent(FlexAlign.Center)
                    .border({
                      width: { left: 5 },
                      color: this.currCateIndex === cateIndex ?
                      $r('app.color.Orange') : Color.White,
                    })
                    .backgroundColor(this.currCateIndex === cateIndex ?
                    Color.White : "#F3F3F5")
                    .onClick(() => {

                      this.onCateClick(cateIndex)
                    })
                  }

                });
              }
            }
            .scrollable(ScrollDirection.Vertical)
            .scrollBarWidth(5)
            .edgeEffect(EdgeEffect.Fade)
            .scrollBar(BarState.Off)
          }
          .width('25%')
          .height('100%')
          .backgroundColor("#F3F3F5")
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.Start)
          .margin({ left: 0 })

          // 右侧菜品
          Column() {
            List() {
              ForEach(this.rightFoodList, (item: Food, index: number) => {
                ListItem() {
                  Row() {
                    Column() {
                      Image(MyData.getFoodImg(item.icon_id) || $r("app.media.food_doufu"))
                        .width(90)
                        .height(90)
                        .borderRadius(10)
                    }

                    Column() {
                      Text(item.name)
                      Text('评分：' + item.stock)
                        .fontSize(12)
                        .fontColor('#ffcac9c9')
                        .margin({ top: 5 })
                      Text("￥ " + item.price)
                        .margin({ top: 5 })
                        .fontColor(Color.Red)
                      Row() {
                        Button({ type: ButtonType.Normal, stateEffect: true }) {
                          Row() {
                            Text('加入菜单').fontSize(12).fontColor(0xffffff).margin({ left: 5, right: 5 })
                          }.alignItems(VerticalAlign.Center)
                        }
                        .borderRadius(15)
                        .padding({
                          left: 8,
                          right: 8,
                          top: 5,
                          bottom: 5
                        })
                        .margin({ top: 5 })
                        .backgroundColor($r("app.color.Orange"))
                        .onClick(() => {
                          this.onAddBtnClick(item)
                        })
                      }
                      .width('100%')
                      .padding({ right: 30 })
                      .justifyContent(FlexAlign.End)
                    }
                    .alignItems(HorizontalAlign.Start)
                    .margin({ left: 10, top: 0 })
                    .layoutWeight(1)
                  }

                  .width('100%')
                  .height(90)
                  .margin({ left: 10, top: 10 })
                }
              })
            }
          }
          .width('75%')
          .height('100%')
          .backgroundColor(Color.White)

        }

      }
      .height('70%')
      .width('100%')
      .justifyContent(FlexAlign.Start)
    }
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
      this.routeParam = context.pathInfo.param as RouteParam;
    })
    .hideTitleBar(true)  // 隐藏标题栏
  }
}
