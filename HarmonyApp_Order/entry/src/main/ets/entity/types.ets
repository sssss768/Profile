export class ShopBean {
  id?: string;
  name?: string  ;
  address?: string ;
  rate?: string ;
  comment?: string ;
  icon?: Resource ;
  backgroud_img?: Resource ;
}

export interface ItemType {
  id?: number;
  title?: string | Resource;
  img?: string | Resource;
}

export class GoodsType {
  id: number = 0;
  img_id: number = 0;
  title: string = '';
  desc: string = '';
  goods_desc: string = '';
  comment: number = 0;
  rate: number = 0;
  real_price: number = 0;
  sub_price: number = 0;
  is_selected?: number = 0;
}

export class RouteParam {
  content?: Object
}
