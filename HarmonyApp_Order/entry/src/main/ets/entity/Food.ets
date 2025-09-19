import { ValuesBucket } from "@kit.ArkData"

export default interface Food extends ValuesBucket {
  id_: string
  //名称
  name: string
  //库存
  stock: number
  //价格
  price: number
  //描述
  des: string
  //图片id
  icon_id: number
}

export class Category {
  //id_: string = ''
  name: string = '';
  logo_id: number = 10
  foodList: Food[] = []
}


