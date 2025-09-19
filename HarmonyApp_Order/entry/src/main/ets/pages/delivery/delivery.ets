import { TabDelivery, TabClass, tabBuilder } from "../../utils/tab";
import { HomeTakeout } from "../central/HomeTakeout";
import { personalBuilder } from "../central/personal";

@Builder
export function deliveryBuilder() {
  delivery()
}

@Preview
@Component
struct delivery {
  @State currentIndex : number = 0;
  pathStack: NavPathStack = new NavPathStack();

  private changeTab(index: number) {
    this.currentIndex = index;
  }

  build() {
    NavDestination() {
      Tabs({ index: this.currentIndex,barPosition: BarPosition.End }) {
        ForEach(TabDelivery, (item: TabClass, index: number) => {
          TabContent() {
            if (this.currentIndex === 0) {
              HomeTakeout()
            } else  {
              personalBuilder('delivery')
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