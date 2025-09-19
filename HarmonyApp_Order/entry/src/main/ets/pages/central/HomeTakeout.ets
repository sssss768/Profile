import { promptAction, router } from '@kit.ArkUI';
import MyData from '../../entity/MyData';
import OrderBean from '../../entity/OrderBean';
import DbUtil from '../../utils/DbUtil';
import MyRdb from "../../sqlite/MyRdb";
import { ShopBean } from '../../entity/types';

// Define FoodItem interface
interface FoodItem {
  name: string;
  count: number;
  price: number;
}

// Define DeliveryOrder class instead of interface
class DeliveryOrder {
  orderCode: string;
  status: string;
  shopName: string;
  imgId: number;
  dateAdded: string;
  totalPrice: number;
  orderId: number | null;
  foodList: FoodItem[];
  address: string;
  phone: string;

  constructor() {
    this.orderCode = '';
    this.status = '';
    this.shopName = '';
    this.imgId = 0;
    this.dateAdded = '';
    this.totalPrice = 0;
    this.orderId = null;
    this.foodList = [];
    this.address = '';
    this.phone = '';
  }
}

@Component
export struct HomeTakeout {
  @State deliveryList: DeliveryOrder[] = []
  userType: string = ''

  async aboutToAppear() {
    await MyRdb.getInstance().initRdbStore(getContext(this));
    this.loadDeliveryOrders()
  }

  build() {
    Column() {
      // 顶部标题栏 - 模仿图片样式
      Row() {

        Text('配送订单')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
      }
      .width('100%')
      .height(56)
      .margin({ top: 17 })
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F7EEDD')
      .border({
        width: { bottom: 1 },
        color: '#F0F0F0'
      })

      // 订单列表容器
      Scroll() {
        Column({ space: 12 }) {
          ForEach(this.deliveryList, (item: DeliveryOrder) => {
            this.DeliveryItem(item)
          })
        }
        .padding({
          left: 16,
          right: 16,
          top: 16,
          bottom: 16
        })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7EEDD')
  }

  private getStatusText(state: number): string {
    switch (state) {
      case 0:
        return '待取餐'
      case 1:
        return '配送中'
      case 2:
        return '已完成'
      default:
        return '未知状态'
    }
  }


  private getStatusColor(status: string): string {
    switch (status) {
      case '待取餐':
        return '#FF6B35'
      case '配送中':
        return '#4CAF50'
      case '已完成':
        return '#9E9E9E'
      default:
        return '#FF6B35'
    }
  }

  async updateOrderStatus(orderId: number | null) {
    if (orderId === null) return

    try {
      const orders = await DbUtil.queryOrderList()
      const order = orders.find(o => o.id === orderId)
      if (order) {
        order.state = 1 // 更新为配送中状态
        await DbUtil.updateOrder(order)
        await this.loadDeliveryOrders()
      }
    } catch (error) {
      console.error('更新订单状态失败', error.message)
    }
  }

  @Builder
  DeliveryItem(item: DeliveryOrder) {
    Column() {
      // 订单状态栏和编号
      Row() {
        Row() {
          Text(item.status)
            .fontSize(12)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Medium)
        }
        .height(24)
        .padding({ left: 8, right: 8 })
        .backgroundColor(this.getStatusColor(item.status))
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)

        Blank()

        Text(`订单编号：${item.orderCode}`)
          .fontSize(13)
          .fontColor('#666666')
      }
      .width('100%')
      .margin({ bottom: 12 })

      // 主要内容区域
      Row() {
        // 商品图片
        Image(MyData.getShopIconByName(item.shopName))
          .width(60)
          .height(60)
          .borderRadius(8)
          .backgroundColor('#F0F0F0')

        // 订单信息
        Column() {
          // 商家信息
          Row() {
            Image($r('app.media.app_icon'))
              .width(16)
              .height(16)
              .fillColor('#FF6B35')
            Text(item.shopName)
              .fontSize(16)
              .fontColor('#333333')
              .fontWeight(FontWeight.Medium)
              .margin({ left: 4 })
          }
          .width('100%')
          .margin({ bottom: 8 })

          // 商品信息预览
          Column() {
            ForEach(item.foodList.slice(0, 2), (food: FoodItem, index: number) => {
              Row() {
                Text(food.name)
                  .fontSize(14)
                  .fontColor('#666666')
                  .layoutWeight(1)
                Text(`x${food.count}`)
                  .fontSize(14)
                  .fontColor('#666666')
                  .margin({ left: 8 })
              }
              .width('100%')
              .margin({ bottom: index === 0 ? 4 : 0 })
            })

            if (item.foodList.length > 2) {
              Text(`...等${item.foodList.length}种商品`)
                .fontSize(12)
                .fontColor('#999999')
                .width('100%')
                .margin({ top: 4 })
            }
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ bottom: 8 })

          // 时间信息
          Text(`下单时间：${item.dateAdded}`)
            .fontSize(12)
            .fontColor('#999999')
            .width('100%')
        }
        .layoutWeight(1)
        .margin({ left: 12 })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      // 底部价格区域
      Row() {
        Column() {
          Text(`￥${item.totalPrice.toFixed(2)}`)
            .fontSize(20)
            .fontColor('#FF6B35')
            .fontWeight(FontWeight.Bold)
          Text('订单金额')
            .fontSize(12)
            .fontColor('#999999')
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        if (item.status === '待取餐') {
          Button('接单', { type: ButtonType.Capsule })
            .width(80)
            .height(36)
            .fontSize(14)
            .fontColor('#FFFFFF')
            .backgroundColor('#FF6B35')
            .onClick(async () => {
              await this.updateOrderStatus(item.orderId)
              promptAction.showToast({
                message: '接单成功！',
                duration: 2000
              })
            })
        } else if (item.status === '配送中') {
          Row() {
            Circle({ width: 8, height: 8 })
              .fill('#4CAF50')
              .margin({ right: 6 })
            Text('配送中')
              .fontSize(14)
              .fontColor('#4CAF50')
              .fontWeight(FontWeight.Medium)
          }
        } else {
          Text('已完成')
            .fontSize(14)
            .fontColor('#9E9E9E')
            .fontWeight(FontWeight.Medium)
        }
      }

      .width('100%')
      .margin({ top: 12 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({
      radius: 8,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 2
    })
    .margin({ bottom: 10 })
    .onClick(() => {
      this.showOrderDetail(item)
    })
  }

  // 显示订单详情
  private showOrderDetail(order: DeliveryOrder) {
    AlertDialog.show({
      title: '订单详情',
      message: this.buildOrderDetailMessage(order),
      alignment: DialogAlignment.Center,
      primaryButton: {
        value: '确定',
        fontColor: '#FFFFFF',
        backgroundColor: '#FF6B35',
        action: () => {
          console.info('关闭订单详情')
        }
      },
      secondaryButton: {
        value: '取消',
        fontColor: '#666666',
        backgroundColor: '#F5F5F5',
        action: () => {
          console.info('取消订单详情')
        }
      }
    })
  }

  // 构建订单详情消息
  private buildOrderDetailMessage(order: DeliveryOrder): string {
    let message = `📋 订单编号：${order.orderCode}\n`
    message += `📍 订单状态：${order.status}\n`
    message += `🏪 商家名称：${order.shopName}\n`
    message += `⏰ 下单时间：${order.dateAdded}\n`
    message += `📍 配送地址：${order.address}\n`
    message += `📞 联系电话：${order.phone}\n`
    message += `💰 订单金额：￥${order.totalPrice}\n`
    message += '\n🍽️ 商品清单：\n'

    order.foodList.forEach((item, index) => {
      message += `${index + 1}. ${item.name} x${item.count} ￥${(item.price * item.count).toFixed(2)}\n`
    })

    return message
  }

  // 加载配送订单
  async loadDeliveryOrders() {
    try {
      // 1. 查询所有订单
      const orders: OrderBean[] = await DbUtil.queryOrderList()

      // 2. 为每个订单获取详细信息
      // 2. 为每个订单获取详细信息
      this.deliveryList = await Promise.all(
        orders
          .sort((a, b) => new Date(b.date_added).getTime() - new Date(a.date_added).getTime()) // 倒序
          .map(async (order: OrderBean, index: number) => {
            const deliveryOrder = new DeliveryOrder();

            // 基础订单信息
            deliveryOrder.orderCode = order.order_code;
            deliveryOrder.status = index === 0 ? '配送中' : '已完成'; // 👈 关键逻辑
            deliveryOrder.shopName = order.shop_name;
            deliveryOrder.imgId = order.img_id;
            deliveryOrder.dateAdded = order.date_added;
            deliveryOrder.totalPrice = order.total_price;
            deliveryOrder.orderId = order.id;

            // 其余代码不变...

          // 3. 根据订单中的 goods_ids 查询菜品详情
          try {
            if (order.goods_ids) {
              const goodsIds = this.parseGoodsIds(order.goods_ids);

              // 1. 使用Map统计每个商品ID的出现次数
              const idCountMap = new Map<string, number>();
              goodsIds.forEach(id => {
                idCountMap.set(id, (idCountMap.get(id) || 0) + 1);
              });

              // 2. 获取唯一ID列表
              const uniqueIds = Array.from(idCountMap.keys());

              // 3. 批量查询商品信息（保持原有的串行查询方式，避免并行压力）
              const foodList: FoodItem[] = [];
              for (const id of uniqueIds) {
                const food = await MyRdb.getInstance().getFoodById(getContext(this), id);
                if (food) {
                  foodList.push({
                    name: food.name,
                    count: idCountMap.get(id) || 1, // 使用统计的数量
                    price: food.price
                  });
                }
              }

              deliveryOrder.foodList = foodList;
            } else {
              deliveryOrder.foodList = [];
            }
          } catch (error) {
            console.error('查询菜品详情失败:', error);
            deliveryOrder.foodList = [];
          }

          // 4. 设置配送地址和电话
          deliveryOrder.address = '学源街中国计量大学258号';
          deliveryOrder.phone = '15906635646';

          return deliveryOrder;
        })
      );

      // 分离当前订单和历史订单


      console.log('个人页面订单加载完成:', this.deliveryList);
    } catch (error) {
      console.error('加载订单失败', error.message);
      this.deliveryList = [];

    }
  }

  // 辅助方法：解析商品ID字符串
  private parseGoodsIds(goodsIds: string): string[] {
    try {
      if (goodsIds.startsWith('[') || goodsIds.startsWith('{')) {
        return JSON.parse(goodsIds);
      } else if (goodsIds.includes(',')) {
        return goodsIds.split(',').map(id => id.trim());
      } else {
        return [goodsIds];
      }
    } catch (error) {
      console.error('解析商品ID失败:', error);
      return [];
    }
  }
}