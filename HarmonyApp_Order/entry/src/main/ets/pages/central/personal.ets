import User from "../../entity/User"
import { AppStorageV2, promptAction, router } from '@kit.ArkUI';
import MyData from '../../entity/MyData';
import OrderBean from '../../entity/OrderBean';
import DbUtil from '../../utils/DbUtil';
import { ShopBean } from '../../entity/types';
import MyRdb from "../../sqlite/MyRdb";
import Food from "../../entity/Food";
import { UserInfo, UserInfoWithPassword } from '../../common/UserInfo';
import { GlobalStorage } from "../../entity/GlobalStorage";


// Define FoodItem interface
interface FoodItem {
  name: string;
  count: number;
  price: number;
}

// Define DeliveryOrder class
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

@CustomDialog
struct UserEditDialog {
  @State pathStack: NavPathStack = AppStorageV2.connect(NavPathStack, "navStack", () => new NavPathStack())!
  @State userInfo: UserInfoWithPassword = {
    user_id: 0,
    username: '',
    password: '',
    phone: '',
    avatar_url: '',
    campus_id: 0,
    balance: 0
  }
  controller: CustomDialogController
  onConfirm: (user: UserInfoWithPassword) => void = () => {
  }
  path: () => void = () => {
  }

  build() {
    Column() {
      // 标题栏
      Row() {
        Text('编辑个人信息')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2c2c2c')
          .width('100%')
          .padding({top:30})

      }
      .width('100%')
      .padding({
        left: 20,
        right: 20,
        top: 15,
        bottom: 15
      })
      .backgroundColor('#E7D1BB')

      Scroll() {
        Column() {
          // 用户名输入
          Row() {
            Text('用户名:')
              .height(45)
            TextInput({ placeholder: '请填写用户名', text: this.userInfo.username })
              .width('75%')
              .height(45)
              .margin({ left: 10 })
              .padding(10)
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
              .onChange((value: string) => {
                this.userInfo.username = value; // 正确绑定用户名
              })
          }
          .margin({ top: 5 })
          .padding(5)

          // 手机号输入
          Row() {
            Text('手机号:')
              .height(45)
            TextInput({ placeholder: '请填写手机号', text: this.userInfo.avatar_url })
              .width('75%')
              .height(45)
              .margin({ left: 10 })
              .padding(10)
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
              .onChange((value: string) => {
                this.userInfo.avatar_url = value; // 正确绑定手机号
              })
          }
          .padding(5)
          .margin({ top: 15 })

          // 密码输入
          Row() {
            Text('密码:')
              .height(45)
            TextInput({ placeholder: '请填写密码', text: this.userInfo.password })
              .width('75%')
              .height(45)
              .margin({ left: 10 })
              .padding(10)
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
              .onChange((value: string) => {
                this.userInfo.password = value;
              })
          }
          .margin({ top: 5 })
          .padding(5)
        }
        .padding({ left: 15, right: 15 })
      }
      .margin({ top: 50 })
      .width('90%')
      .height('50%')
      .align(Alignment.Center)
      .padding(15)
      .backgroundColor('#ede4d3')
      .borderRadius(12)
      .layoutWeight(1)

      Column() {

      }
      .width('100%')
      .margin({ bottom: 30 })

      // 底部按钮
      Column() {
        Row() {
          Button('取消', { type: ButtonType.Capsule })
            .width('45%')
            .height(40)
            .backgroundColor('#F5F5F5')
            .fontColor('#333')
            .onClick(() => this.controller.close())
          Button('确定', { type: ButtonType.Capsule })
            .width('45%')
            .height(40)
            .backgroundColor('#F5F5F5')
            .fontColor('#333')
            .onClick(() => {
              this.onConfirm(this.userInfo);
              this.controller.close();
            })

        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ bottom: 30 })

        Row() {
          Button('退出登录', { type: ButtonType.Capsule })
            .width('100%')
            .height(40)
            .backgroundColor($r('app.color.Orange'))
            .fontColor('#FFFFFF')
            .onClick(() => {
              this.pathStack.pushPathByName("Login", null, false)
              GlobalStorage.getInstance().phone = '';
              this.controller.close()

            }
            )
        }
        .width('70%')
      }
      .width('80%')
      .height('30%')
    }
    .backgroundColor('#F7EEDD')
    .borderRadius(16)
  }
}

@Builder
export function personalBuilder(userType: string) {
  personal({ userType: userType })
}

@Component
struct personal {
  @State deliveryList: DeliveryOrder[] = []
  userType: string = ''
  @State pathStack: NavPathStack = AppStorageV2.connect(NavPathStack, "navStack", () => new NavPathStack())!

  async aboutToAppear() {
    await MyRdb.getInstance().initRdbStore(getContext(this));
    this.loadDeliveryOrders()
  }

  @State userInfo: UserInfoWithPassword = {
    user_id: 0,
    username: 'Rshgdasx',
    phone: '',
    password: '',
    avatar_url: '19133384921',
    campus_id: 0,
    balance: 0
  };
  private myRdb = MyRdb.getInstance();
  // 编辑对话框控制器
  private dialogController: CustomDialogController = new CustomDialogController({
    builder: UserEditDialog({
      userInfo: this.userInfo,
      onConfirm: (user: UserInfoWithPassword) => {
        this.updateUserInfo(user);
      }
    }),
    customStyle: true,
    alignment: DialogAlignment.Center
  });


  build() {
    NavDestination() {
      Column({ space: 16 }) {
        Row({ space: 12 }) {
          // 左侧内容
          Row({ space: 12 }) {
            // 头像
            Stack() {
              Image($r('app.media.personal'))
                .width(48)
                .height(48)
                .borderRadius(24)
            }
            .width(48)
            .height(48)
            .borderRadius(24)

            // 姓名与职位，从数据库获取
            Column({ space: 2 }) {
              Text(this.userInfo.username)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
              Text('手机号：' + this.userInfo.avatar_url)
                .fontSize(14)
                .fontColor('#666666')
            }
            .alignItems(HorizontalAlign.Start)
          }
          .flexGrow(1)

          // 编辑
          Image($r('app.media.edit'))
            .width(24)
            .height(24)
            .onClick(() => {
              // this.pathStack.pushPathByName("Login", null, false)
              this.dialogController.open(); // 打开编辑对话框
              // 打开修改个人信息页面，和商品一样
            })
        }
        .width('100%')

        // 统计概览：Total Hours、Daily Streak、Friends
        this.buildSummaryStats()

        // 当前订单
        this.buildRecent()

        // 历史订单
        this.buildHistory()

      }
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
      .width('100%')
      .padding(16)
      .backgroundColor('#F5EFE0')
      .height('100%')
    }
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .onReady(async (context: NavDestinationContext) => {
      const result = await MyRdb.getInstance().queryUserByPhone(
        getContext(this),
        GlobalStorage.getInstance().phone
      ) as UserInfoWithPassword | null;

      if (result) {
        // 安全访问 - result 已被收窄为 UserInfoWithPassword
        this.userInfo = result;

      }
    })
  }


  // 统计概览：总订单数，本月订单数，总消费金额
  @Builder
  buildSummaryStats() {
    Row() {
      Row({ space: 5 }) {
        Image($r('app.media.fork2'))
          .fillColor($r('app.color.Charcoal_Gray'))
          .width(30)
          .height(30)

        Column({ space: 2 }) {
          Text('本月订单')
            .fontSize(13)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.Charcoal_Gray'))
          Text(this.deliveryList.length.toString())
            .fontSize(13)
            .fontColor($r('app.color.Charcoal_Gray'))
        }
        .alignItems(HorizontalAlign.Start)

      }
      .width('28%')
      .margin({ left: 20 })

      Divider()
        .vertical(true)
        .height(50)
        .color($r('app.color.Charcoal_Gray'))
        .opacity(0.5)
        .margin({ right: 10 })
        .strokeWidth(1.2)
        .border({ radius: 12 })

      Row({ space: 5 }) {
        Image($r('app.media.register'))
          .fillColor($r('app.color.Charcoal_Gray'))
          .width(30)
          .height(30)

        Column({ space: 2 }) {
          Text('总订单')
            .fontSize(13)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.Charcoal_Gray'))
          Text(this.deliveryList.length.toString())
            .fontSize(13)
            .fontColor($r('app.color.Charcoal_Gray'))
        }
        .margin({ right: 3 })
        .alignItems(HorizontalAlign.Start)

      }
      .width('30%')

      Divider()
        .vertical(true)
        .height(50)
        .color($r('app.color.Charcoal_Gray'))
        .opacity(0.5)
        .margin({ right: 10 })
        .strokeWidth(1.2)
        .border({ radius: 12 })

      Row({ space: 5 }) {
        Image($r('app.media.money'))
          .fillColor($r('app.color.Charcoal_Gray'))
          .width(30)
          .height(30)

        // 加入判定，如果是用户显示消费金额，如果是商家显示收益，如果是棋手显示佣金（订单金额4%）
        Column({ space: 2 }) {
          if (this.userType === 'user') {
            Text('消费金额')
              .fontSize(13)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.Charcoal_Gray'))
            Text(this.getTotalAmount().toFixed(0))
              .fontSize(13)
              .fontColor($r('app.color.Charcoal_Gray'))
          } else if (this.userType === 'merchant') {
            Text('收益')
              .fontSize(13)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.Charcoal_Gray'))
            Text(this.getTotalAmountMerchant().toFixed(0))
              .fontSize(13)
              .fontColor($r('app.color.Charcoal_Gray'))
          } else {
            Text('佣金')
              .fontSize(13)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.Charcoal_Gray'))
            Text(this.getTotalAmountDelivery().toFixed(0))
              .fontSize(13)
              .fontColor($r('app.color.Charcoal_Gray'))
          }

        }
        .alignItems(HorizontalAlign.Start)

      }
      .width('32%')
    }
    .height(90)
    .width('100%')
    .justifyContent(FlexAlign.Start)
    .margin({ top: 5, bottom: 5 })
    .backgroundColor($r('app.color.Orange'))
    .border({ radius: 10 })
  }

  // 当前订单
  @Builder
  buildRecent() {
    Column({ space: 15 }) {
      Text('当前订单')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.Charcoal_Gray'))
        .alignSelf(ItemAlign.Start)

      if (this.deliveryList.length > 0) {
        List() {
          if (this.deliveryList.length > 0) {
            ListItem() {
              this.DeliveryItem(this.deliveryList[this.deliveryList.length - 1])
            }
          }
        }
        .height(220)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
      } else {
        Row() {
          Text('暂无当前订单')
            .fontSize(14)
            .fontColor('#999999')
            .textAlign(TextAlign.Center)
        }
        .backgroundColor(Color.White)
        .height(100)
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .border({ radius: 12 })
      }
    }
  }

  // 历史订单
  @Builder
  buildHistory() {
    Column({ space: 12 }) {
      Text('历史订单')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .alignSelf(ItemAlign.Start)

      if (this.deliveryList.length > 1) {
        List() {
          ForEach(
            this.changeStatusHistory(this.deliveryList.slice(0, -1).reverse()), // 截取并倒序
            (item: DeliveryOrder) => {
              ListItem() {
                this.DeliveryItem(item)
              }
            }
          )
        }
        .height('40%')
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
      } else {
        Row() {
          Text('暂无历史订单')
            .fontSize(14)
            .fontColor('#999999')
            .textAlign(TextAlign.Center)
        }
        .backgroundColor(Color.White)
        .height(100)
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .border({ radius: 12 })
      }
    }
  }

  private changeStatusHistory(orders: DeliveryOrder[]): DeliveryOrder[] {
    orders.forEach(order => {
      order.status = '已完成'; // 直接修改原对象的状态
    });
    return orders; // 返回修改后的原数组
  }

  // 订单状态相关方法
  private getStatusText(): string {
    switch (this.userType) {
      case 'user':
        return '配送中'
      case 'merchant':
        return '配送中'
      case 'delivery':
        return '待取餐'
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

  // 计算总消费金额
  private getTotalAmount(): number {
    return this.deliveryList.reduce((total, order) => total + order.totalPrice, 0)
  }

  private getTotalAmountMerchant(): number {
    return this.getTotalAmount() * 0.8
  }

  private getTotalAmountDelivery(): number {
    return this.getTotalAmount() * 0.05
  }

  // 订单项组件 - 使用hometakeout的样式
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
            .fontSize(18)
            .fontColor('#FF6B35')
            .fontWeight(FontWeight.Bold)
          Text('订单金额')
            .fontSize(12)
            .fontColor('#999999')
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        if (item.status === '配送中') {
          Row() {
            Circle({ width: 8, height: 8 })
              .fill('#4CAF50')
              .margin({ right: 6 })
            Text('配送中')
              .fontSize(14)
              .fontColor('#4CAF50')
              .fontWeight(FontWeight.Medium)
          }
        } else if (item.status === '已完成') {
          Text('已完成')
            .fontSize(14)
            .fontColor('#9E9E9E')
            .fontWeight(FontWeight.Medium)
        } else {
          Text('待取餐')
            .fontSize(14)
            .fontColor('#FF6B35')
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
      this.deliveryList = await Promise.all(
        orders.map(async (order: OrderBean) => {
          const deliveryOrder = new DeliveryOrder();

          // 基础订单信息
          deliveryOrder.orderCode = order.order_code;
          deliveryOrder.status = this.getStatusText();
          deliveryOrder.shopName = order.shop_name;
          deliveryOrder.imgId = order.img_id;
          deliveryOrder.dateAdded = order.date_added;
          deliveryOrder.totalPrice = order.total_price;
          deliveryOrder.orderId = order.id;

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

  //用户信息加载与更新
  private async loadUserInfo() {
    try {
      const user = await this.myRdb.queryUserByPhone(getContext(this), this.userInfo.phone);
      if (user) {
        this.userInfo = user; // 更新本地用户信息
      }
    } catch (e) {
      console.error("加载用户信息失败:", e);
    }
  }

  // 更新用户信息到数据库
  private async updateUserInfo(user: UserInfoWithPassword) {
    try {
      await this.myRdb.updateUser(getContext(this), user);
      this.userInfo = user; // 同步更新本地状态
      this.showToast('更新成功');
    } catch (e) {
      console.error("更新用户信息失败:", e);
      this.showToast('更新失败');
    }
  }

  // 显示提示信息
  private showToast(message: string) {
    this.getUIContext().getPromptAction().showToast({
      message,
      duration: 2000
    });
  }
}