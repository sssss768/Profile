// 菜单栏组件

export interface TabClass {
  text: string;
  icon: ResourceStr;
}

@Builder
export function tabBuilder(item: TabClass) {
  Column({space:5}) {
    Image(item.icon).width(24).fillColor($r('app.color.Stone_Gray') )
    Text(item.text).fontSize(14).fontColor($r('app.color.Stone_Gray') )
  }
}

export const  TabCustomer : TabClass[] = [
  { text: '商店', icon : $r('app.media.home')},
  { text: '购物车', icon : $r('app.media.fork')},
  { text: '订单', icon : $r('app.media.list')},
  { text: '我的', icon : $r('app.media.personal')},]

export const  TabDelivery : TabClass[] = [
  { text: '订单', icon : $r('app.media.home')},
  { text: '我的', icon : $r('app.media.personal')}]

export const  TabStore : TabClass[] = [
  { text: '菜品', icon : $r('app.media.fork')},
  { text: '我的', icon : $r('app.media.personal')}]
