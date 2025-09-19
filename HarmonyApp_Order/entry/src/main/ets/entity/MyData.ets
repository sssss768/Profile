import Food, { Category } from './Food'
import { ItemType, ShopBean } from './types'

class MyData {
  funcAreaList: Array<ItemType> = [
    {
      title: '东北菜',
      img: $r("app.media.xican")
    },
    {
      title: '京菜',
      img: $r('app.media.icon_kaoya')
    },
    {
      title: '新疆菜',
      img: $r('app.media.icon_xiaochi')
    },
    {
      title: '湘菜',
      img: $r('app.media.icon_xiangcai')
    },
    {
      title: '清真',
      img: $r('app.media.icon_qingzhen')
    },
    {
      title: '西北菜',
      img: $r('app.media.icon_shanxi')
    },
    {
      title: '川菜',
      img: $r('app.media.icon_chuancai')
    },
    {
      title: '云南菜',
      img: $r('app.media.icon_yunnan')
    }

  ]
  private cateImgIdList: number[] = [10, 20, 30, 40, 50]
  private cateImgResList: Resource[] = [
  //10
  //   $r('app.media.xican'),
  //   //20
  //   $r('app.media.chaocai'),
  //   //30
  //   $r('app.media.miantiao'),
  //   //40
  //   $r('app.media.gaifan'),
  //   //50
  //   $r('app.media.yinliao'),

    $r('app.media.merchant'),
    //20
    $r('app.media.merchant'),
    //30
    $r('app.media.merchant'),
    //40
    $r('app.media.merchant'),
    //50
    $r('app.media.merchant'),
  ]

  getCateIcon(imgId: number): Resource {
    let ind = this.cateImgIdList.indexOf(imgId)
    return this.cateImgResList[ind]
  }

  private foodImgIdList: number[] = [
    11, 12, 13, 14, 15, 16,
    21, 22, 23,
    31, 32, 33,
    41, 42, 43,
    51, 52, 53]
  private foodImgResList: Resource[] = [
  //10
    $r('app.media.food_xihongshi'),
    $r('app.media.food_tudou_niurou'),
    $r('app.media.food_yangrou'),
    $r('app.media.food_doufu'),
    $r('app.media.food_jidan_huanggua'),
    $r('app.media.food_xiaren'),
    //20
    $r('app.media.food_yang_tang'),
    $r('app.media.food_yu_tang'),
    $r('app.media.food_ji_tang'),
    //30
    $r('app.media.food_chao_mian'),
    $r('app.media.food_dao_xiao_mian'),
    $r('app.media.food_ban_mian'),
    //40
    $r('app.media.food_chaofan'),
    $r('app.media.food_xiaochaorou'),
    $r('app.media.food_yarou'),
    //50
    $r('app.media.kele'),
    $r('app.media.chengzhi'),
    $r('app.media.lvcha'),

  ]

  getFoodImg(imgId: number): Resource {
    //let a = imgId.toString().substring(1)
    //let b = Number.parseInt(a)
    //let ind = this.foodImgIdList.indexOf(b)
    let ind = this.foodImgIdList.indexOf(imgId)
    return this.foodImgResList[ind]
  }

  commonFoodList_chao_cai: Food[] = [
    {
      id_: '11',
      name: '西红柿炒鸡蛋',
      stock: 998,
      price: 15,
      des: 'xx',
      icon_id: 11
    },
    {
      id_: '12',
      name: '土豆牛肉',
      stock: 91,
      price: 13,
      des: 'xx',
      icon_id: 12
    },
    {
      id_: '13',
      name: '葱爆羊肉',
      stock: 77,
      price: 8,
      des: 'xx',
      icon_id: 13
    },
    {
      id_: '14',
      name: '经典麻辣豆腐',
      stock: 59,
      price: 13,
      des: 'xx',
      icon_id: 14
    },
    {
      id_: '15',
      name: '鸡蛋炒黄瓜',
      stock: 91,
      price: 19,
      des: 'xx',
      icon_id: 15
    },
    {
      id_: '16',
      name: '爆炒虾仁',
      stock: 99,
      price: 21,
      des: 'xx',
      icon_id: 16
    }
  ]
  commonFoodList_tang: Food[] = [
    {
      id_: '21',
      name: '羊汤',
      stock: 998,
      price: 15,
      des: 'xx',
      icon_id: 21
    },
    {
      id_: '22',
      name: '鱼汤',
      stock: 91,
      price: 13,
      des: 'xx',
      icon_id: 22
    },
    {
      id_: '23',
      name: '鸡汤',
      stock: 77,
      price: 8,
      des: 'xx',
      icon_id: 23
    }
  ]
  commonFoodList_mian: Food[] = [
    {
      id_: '31',
      name: '炒面',
      stock: 998,
      price: 15,
      des: 'xx',
      icon_id: 31
    },
    {
      id_: '32',
      name: '刀削面',
      stock: 91,
      price: 13,
      des: 'xx',
      icon_id: 32
    },
    {
      id_: '33',
      name: '宽板面',
      stock: 77,
      price: 8,
      des: 'xx',
      icon_id: 33
    }
  ]
  commonFoodList_gai_fan: Food[] = [
    {
      id_: '41',
      name: '鸡蛋火腿炒饭',
      stock: 998,
      price: 15,
      des: 'xx',
      icon_id: 41
    },
    {
      id_: '42',
      name: '辣椒炒肉盖饭',
      stock: 91,
      price: 13,
      des: 'xx',
      icon_id: 42
    },
    {
      id_: '43',
      name: '红烧羊肉盖饭',
      stock: 77,
      price: 8,
      des: 'xx',
      icon_id: 43
    }
  ]
  commonFoodList_yin_liao: Food[] = [
    {
      id_: '51',
      name: '可乐',
      stock: 998,
      price: 15,
      des: 'xx',
      icon_id: 51
    },
    {
      id_: '52',
      name: '橙汁',
      stock: 91,
      price: 13,
      des: 'xx',
      icon_id: 52
    },
    {
      id_: '53',
      name: '绿茶',
      stock: 77,
      price: 8,
      des: 'xx',
      icon_id: 53
    }
  ]
  shopBeanList: Array<ShopBean> = [
    {
      id: '1',
      name: '哈尔滨百年餐馆',
      address: '东城区建国路98号东城分店',
      rate: '4',
      comment: '231',
      icon: $r("app.media.shop_icon_dongbei"),
      backgroud_img: $r("app.media.shop_bg_inner1"),
    },
    {
      id: '2',
      name: '北京老字号-局气',
      address: '西城区湾湾大街32号西城分店',
      rate: '4',
      comment: '331',
      icon: $r("app.media.shop_icon_jingcai"),
      backgroud_img: $r("app.media.shop_bg_inner2"),
    },
    {
      id: '3',
      name: '穆斯林餐厅',
      address: '南城区伊斯兰村村口15号院穆斯林餐厅',
      rate: '5',
      comment: '231',
      icon: $r("app.media.shop_icon_xinjiang"),
      backgroud_img: $r("app.media.shop_bg_inner3"),
    },
    {
      id: '4',
      name: '寻湘记',
      address: '南城区大明路辅路15号餐厅',
      rate: '4',
      comment: '231',
      icon: $r('app.media.shop_icon_xiangcai'),
      backgroud_img: $r("app.media.shop_bg_inner4"),
    },
    {
      id: '5',
      name: '清真食府',
      address: '岭南区小清街77号上德大厦2层食府',
      rate: '4',
      comment: '231',
      icon: $r("app.media.shop_icon_qingzhen"),
      backgroud_img: $r("app.media.shop_bg_inner1"),
    },
    {
      id: '6',
      name: '陕甘味道',
      address: '山北区大马街70号苏州路苏州大厦2层味道',
      rate: '4',
      comment: '231',
      icon: $r("app.media.shop_icon_shanxi"),
      backgroud_img: $r("app.media.shop_bg_inner2"),
    },
    {
      id: '7',
      name: '川菜总店',
      address: '山东区大洋马街69号杭州路总店',
      rate: '4',
      comment: '231',
      icon: $r("app.media.shop_icon_chuancai"),
      backgroud_img: $r("app.media.shop_bg_inner3"),
    },
    {
      id: '8',
      name: '云海肴',
      address: '黄埔区小日子东街54号兖州路22号',
      rate: '4',
      comment: '231',
      icon: $r("app.media.shop_icon_yunhaiyao"),
      backgroud_img: $r("app.media.shop_bg_inner4"),
    },

  ]

  getShopIconByName(shopName: string): Resource {
    // 1. 查找匹配的商家（返回ShopBean | undefined）
    const matchedShop = mydata.shopBeanList.find(shop => shop.name === shopName);

    // 2. 类型收窄：如果找到匹配项，直接返回其icon
    if (matchedShop && matchedShop.icon) {
      return matchedShop.icon;
    }

    // 3. 兜底逻辑：未找到时返回默认图标（确保返回Resource类型）
    console.warn(`未找到名称为「${shopName}」的商家，使用默认图标`);
    return $r("app.media.shop_icon_yunhaiyao"); // 需提前定义默认图标资源
  }

  getShopById(id: String): ShopBean {
    // this.shopBeanList.forEach((item:ShopBean,index:number)=>{
    //   if(item.id == id){
    //     return  item
    //   }
    // })
    // this.shopBeanList.filter((item, index) => {
    //   return item.id == id
    // })
    let arr = this.shopBeanList
    for (let i = 0; i <= arr.length - 1; i++) {
      if (arr[i].id == id) {
        return arr[i]
      }
    }
    return arr[0]
  }

  categoryList: Category[] = [
    {
      name: '炒菜',
      logo_id: 10,
      foodList: this.commonFoodList_chao_cai
    },
    {
      name: '煲汤类',
      logo_id: 20,
      foodList: this.commonFoodList_tang
    },
    {
      name: '面条类',
      logo_id: 30,
      foodList: this.commonFoodList_mian
    },
    {
      name: '盖饭类',
      logo_id: 40,
      foodList: this.commonFoodList_gai_fan
    },
    {
      name: '饮品类',
      logo_id: 50,
      foodList: this.commonFoodList_yin_liao
    }
  ]
}

let mydata = new MyData()

export default mydata as MyData