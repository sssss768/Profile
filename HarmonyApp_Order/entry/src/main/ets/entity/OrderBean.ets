import Food from "./Food";
export default class OrderBean {
  id: number | null
  //订单状态，0未支付、1已支付
  state: number
  //订单编号
  order_code: string
  //总价
  total_price: number
  //积分
  score: number
  //子商品id数组
  goods_ids: string
  //餐厅名称
  shop_name: string
  //订单图片id
  img_id: number
  //创建日期
  date_added: string
  //时间戳
  timestamp: number


  // food: Food = {
  //   id_: '',
  //   name: '',
  //   stock: 0,
  //   price: 0,
  //   des: '',
  //   icon_id: 0
  // };

  // 构造函数（可选，用于初始化属性）
  constructor() {
    this.id = null;
    this.state = 0;
    this.order_code = '';
    this.total_price = 0;
    this.score = 0;
    this.goods_ids = '';
    this.shop_name = '';
    this.img_id = 0;
    this.date_added = '';
    this.timestamp = 0;

  }

}





