import Food from "../../entity/Food";
import OrderBean from "../../entity/OrderBean";
import DbUtil from "../../utils/DbUtil";
import { TabCustomer, TabClass, tabBuilder } from "../../utils/tab";
import { personalBuilder } from "../central/personal";
import { Cart } from "./Cart";
import { customerHome } from "./CustomerHome";
import { Order } from "./Order";

@Builder
export function customerBuilder() {
  customer()
}


@Component
struct customer {
  @State cartList: Food[] = [];
  @State orderList: OrderBean[] = [];
  @State currentIndex: number = 0;
  @State shopName: String = '云海肴';
  pathStack: NavPathStack = new NavPathStack();

  private changeTab(index: number) {
    this.currentIndex = index;
  }

  build() {
    NavDestination() {

      Tabs({ index: this.currentIndex, barPosition: BarPosition.End }) {
        ForEach(TabCustomer, (item: TabClass, index: number) => {
          TabContent() {
            if (this.currentIndex === 0) {
              customerHome()
            } else if (this.currentIndex === 1) {
              Cart({
                changeTab: this.changeTab.bind(this),
                cartList: this.cartList
              });
            } else if (this.currentIndex === 2) {
              Order({ orderList: this.orderList });
            } else {
              personalBuilder('user')
            }
          }
          .tabBar(tabBuilder(item))
          .backgroundColor($r('app.color.Light_Cream'))
          .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
        })
      }
      .onChange(async (index: number) => {
        if (index == 1) {
          this.cartList = await DbUtil.queryFoodList()
          console.log(JSON.stringify(this.cartList))
        } else if (index == 2) {
          this.orderList = await DbUtil.queryOrderList()
        }
        this.currentIndex = index
      })
      .backgroundColor($r('app.color.Light_Cream'))
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })
  }
}