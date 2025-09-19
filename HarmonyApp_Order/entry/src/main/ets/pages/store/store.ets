import { TabStore, TabClass, tabBuilder } from "../../utils/tab";
import { HomeTakeout } from "../central/HomeTakeout";
import { personalBuilder } from "../central/personal";
import { HomeMerchant } from "./HomeMerchant";

@Builder
export function storeBuilder() {
  store()
}


@Component
struct store {
  @State currentIndex: number = 0;
  pathStack: NavPathStack = new NavPathStack();

  private changeTab(index: number) {
    this.currentIndex = index;
  }

  build() {
    NavDestination() {
      Tabs({ index: this.currentIndex, barPosition: BarPosition.End }) {
        ForEach(TabStore, (item: TabClass, index: number) => {
          TabContent() {
            //     add
            if (this.currentIndex === 0) {
              HomeMerchant()
            } else {
              personalBuilder('merchant')
            }
          }
          .tabBar(tabBuilder(item))
          .backgroundColor($r('app.color.Light_Cream'))
          .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
        })
      }
      .onChange((index: number) => {
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