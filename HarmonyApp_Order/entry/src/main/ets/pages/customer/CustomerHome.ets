import MyData from "../../entity/MyData";
import { ItemType, RouteParam,ShopBean} from "../../entity/types"
import { AppStorageV2 } from "@kit.ArkUI";





@Component // 关键：自定义组件必须添加 @Component 装饰器
export struct customerHome {
  pathStack : NavPathStack = AppStorageV2.connect(NavPathStack,"navStack",()=> new NavPathStack())!
  build() {
    Scroll() {
      Column() {
        //搜索框
        Row() {
          Stack() {
            TextInput({ placeholder: "老乡鸡" })
              .layoutWeight(1)
              .fontColor(Color.White)
              // 调整为与设计匹配的圆角、背景
              .border({ radius: 20, width: 0 })
              .backgroundColor("#FFFFFF")
              .placeholderColor(Color.Black)
              .padding({
                left: 12,
                right: 12,
                top: 8,
                bottom: 8
              })
            Button() {
              Row() {
                Image($r("app.media.search"))
                  .width(20)
                  .fillColor(Color.White)
                Text("搜索")
                  .fontSize(14)
                  .fontColor(Color.White)
                  .margin({ left: 4 })
              }
            }
            .backgroundColor("#FFD100")
            .borderRadius(20)
            .padding({
              left: 12,
              right: 12,
              top: 6,
              bottom: 6
            })
            .margin({ left: 240 })
          }
          .layoutWeight(1)

          Image($r("app.media.code"))
            .width("7%")
            .fillColor("#817D83")
            .margin({left:10,right:10})
        }
        .margin({bottom:10,left:10})
        // 轮播图 Swiper
        Swiper() {
          Image($r('app.media.ban1'))
          Image($r('app.media.banner2'))
          Image($r('app.media.banner3'))
        }
        .autoPlay(true)
        .border({ radius: 20 })
        .margin({ left: 5, right: 5, top: 0 })
        .aspectRatio(2) // 设置和图片一致的宽高比

        // 功能区 Grid
        Column() {
          Grid() {
            // ForEach 必须添加第三个参数（键值生成函数），确保列表项唯一
            ForEach(MyData.funcAreaList, // 数据源
               (item: ItemType,index:number) => { // 遍历项处理函数
                GridItem() {
                  Column() {
                    Image(item.img)
                      .width('25vp')
                      .height('25vp')
                    Text(item.title)
                      .fontSize('14fp')
                      .margin({ top: '4vp' })
                  }
                  .onClick(()=>{
                    const p = new RouteParam()
                    p.content = `${index + 1}`
                    this.pathStack.pushPathByName("ShopPage",p,false)
                    console.info(`传递的 PARAM: ${p.content}`); // 打印接收到的参数值
                  })
                }
              },
              (item: ItemType, index: number) => { // 第三个参数：唯一键生成函数（必填）
                return `funcArea_${index}_${item.title}`; // 确保唯一即可
              }
            )
          }
          .columnsTemplate('1fr 1fr 1fr 1fr') // 4列
          // 局
          .rowsTemplate('1fr 1fr') // 2行布局
          .height('120vp')
          .rowsGap('12vp') // 行间距
          .columnsGap('8vp') // 列间距
          .width('95%')
          .margin('13vp')
          .padding({ top: '10vp', bottom: '10vp' })
        }
        Column() {
          Text('商家推荐')
            .fontSize('16fp')
            .fontWeight(FontWeight.Medium)
            .alignSelf(ItemAlign.Start)
            .margin({left:10,top:20,bottom:10})
          // 列表
          List({ space: 12 }) {
            ForEach(MyData.shopBeanList, (item: ShopBean,index:number) => {
              ListItem() {
                Image(item.icon)
                  .objectFit(ImageFit.Cover)// 图片填充模式
                  .aspectRatio(2)//横纵比
                  .borderRadius(6)
              }
              .onClick(()=>{
                const p = new RouteParam()
                p.content = `${index + 1}`
                this.pathStack.pushPathByName("ShopPage",p,false)
              })
              .margin({ left: '10vp', right: '10vp' })
            })
          }
          .width('95%')
          .lanes(2) // 排列个数
        }
      }
    }
  }
}