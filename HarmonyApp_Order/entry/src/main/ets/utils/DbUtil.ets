import { relationalStore, ValuesBucket } from '@kit.ArkData';
import { AsyncCallback, BusinessError } from '@kit.BasicServicesKit';
import Food from '../entity/Food';
import OrderBean from '../entity/OrderBean';
import DateUtil from './DateUtil';

// 数据库操作工具类
class DbUtil {
  private STORE_CONFIG: relationalStore.StoreConfig = {
    name: "RdbTest.db",
    securityLevel: relationalStore.SecurityLevel.S1
  };
  private rdbStore?: relationalStore.RdbStore
  private TABLE_CART = 'TABLE_CART'
  private TABLE_ORDER = 'TABLE_ORDER'
  private SQL_CREATE_CART = `create table if not exists ${this.TABLE_CART} (
        id integer primary key autoincrement,
        id_ text,
        name text,
        stock integer,
        price integer,
        des text,
        icon_id integer
      )`
  private SQL_CREATE_ORDER = `create table if not exists ${this.TABLE_ORDER} (
        id integer primary key autoincrement,
        state integer,
        order_code text,
        total_price integer,
        score integer,
        goods_ids text,
        shop_name text,
        img_id integer,
        date_added text,
        timestamp integer
      )`

  // 初始化
  init(context: Context) {
    relationalStore.getRdbStore(context, this.STORE_CONFIG,
      (err: BusinessError, rdbStore: relationalStore.RdbStore) => {
        this.rdbStore = rdbStore
        rdbStore.executeSql(this.SQL_CREATE_CART,
          (err) => {
            console.log(`zhu Food 创建数据库 err=${err}`)
            rdbStore.executeSql(this.SQL_CREATE_ORDER,
              (err) => {
                console.log(`zhu Order创建数据库 err=${err}`)

              })
          })
      })
  }

  // 新增食物，Food实体类
  async insertFood(value: Food) {
    const rowId = await this.rdbStore?.insert(this.TABLE_CART, value)
    console.log('zhu Food 增 rowId=' + rowId)

    return (rowId && rowId > -1) ? Promise.resolve(rowId) : Promise.reject('insert error')
  }

  // 批量新增
  async batchInsertFood(values: Food[]) {
    const rowId = await this.rdbStore?.batchInsert(this.TABLE_CART, values)
    console.log('zhu Food 批量增 rowId=' + rowId)
    return rowId ? Promise.resolve(rowId) : Promise.reject('batchInsert error')
  }

  // 更新
  async updateFood(item: Food) {
    if (!item.id_) {
      return Promise.reject('id error')
    }
    const predicates = new relationalStore.RdbPredicates(this.TABLE_CART)
    predicates.equalTo('id_', item.id_)
    const rowCount = await this.rdbStore?.update(item, predicates)
    console.log('zhu Food 改 rowCount=' + rowCount)
    return rowCount ? Promise.resolve(rowCount) : Promise.reject('update error')
  }

  // 删除
  async deleteFood(id_: string) {
    const predicates = new relationalStore.RdbPredicates(this.TABLE_CART)
    predicates.equalTo('id_', id_)
    const rowCount = await this.rdbStore?.delete(predicates)
    console.log('zhu Food 删 rowCount=' + rowCount)
    return rowCount ? Promise.resolve(rowCount) : Promise.reject('delete error')
  }

  // 批量删除
  async batchDeleteFood(ids: string[]) {
    const predicates = new relationalStore.RdbPredicates(this.TABLE_CART)
    predicates.in('id_', ids)
    const rowCount = await this.rdbStore?.delete(predicates)
    console.log('zhu Food 批量删 rowCount=' + rowCount)
    return rowCount ? Promise.resolve(rowCount) : Promise.reject('delete error')
  }

  // 查询
  async queryFoodListById(id_: string) {
    const predicates = new relationalStore.RdbPredicates(this.TABLE_CART)
    // 添加日期倒序排列
    predicates.orderByDesc('date_added')
    // 如果有 id
    if (id_) {
      predicates.equalTo('id_', id_)
    }
    const resultSet = await this.rdbStore?.query(predicates)
    const list: Food[] = []
    while (resultSet && resultSet.goToNextRow()) {
      // 获取数据
      const data: Food = {
        id_: resultSet.getString(resultSet.getColumnIndex('id_')),
        name: resultSet.getString(resultSet.getColumnIndex('name')),
        stock: resultSet.getLong(resultSet.getColumnIndex('stock')),
        price: resultSet.getLong(resultSet.getColumnIndex('price')),
        des: resultSet.getString(resultSet.getColumnIndex('des')),
        icon_id: resultSet.getLong(resultSet.getColumnIndex('icon_id')),

      }
      // 追加到数组中
      list.push(data)
    }
    console.log('zhu Food 查询所有 list=' + JSON.stringify(list))
    // 释放资源
    resultSet?.close()
    return list
  }

  // 查询
  async queryFoodList() {
    const predicates = new relationalStore.RdbPredicates(this.TABLE_CART)
    // 添加日期倒序排列
    //predicates.orderByDesc('date_added')
    // 如果有 id
    // if (id_) {
    //   predicates.equalTo('id_', id_)
    // }
    const resultSet = await this.rdbStore?.query(predicates)
    const list: Food[] = []
    while (resultSet && resultSet.goToNextRow()) {
      // 获取数据
      const data: Food = {
        id_: resultSet.getString(resultSet.getColumnIndex('id_')),
        name: resultSet.getString(resultSet.getColumnIndex('name')),
        stock: resultSet.getLong(resultSet.getColumnIndex('stock')),
        price: resultSet.getLong(resultSet.getColumnIndex('price')),
        des: resultSet.getString(resultSet.getColumnIndex('des')),
        icon_id: resultSet.getLong(resultSet.getColumnIndex('icon_id')),

      }
      // 追加到数组中
      list.push(data)
    }
    console.log('zhu Food 查询所有 list2=' + JSON.stringify(list))
    // 释放资源
    resultSet?.close()
    return list
  }

  // 新增菜品（点菜）
  async insertOrder(bean: OrderBean) {

    bean.order_code = DateUtil.generateOrderCode()
    bean.date_added = DateUtil.generateDateStr()
    bean.timestamp = DateUtil.getMs()

    let vb: ValuesBucket = {
      state: bean.state,
      order_code: bean.order_code,
      total_price: bean.total_price,
      score: bean.score,
      goods_ids: bean.goods_ids,
      shop_name: bean.shop_name,
      img_id: bean.img_id,
      date_added: bean.date_added,
      timestamp: bean.timestamp
    }
    const rowId = await this.rdbStore?.insert(this.TABLE_ORDER, vb)
    console.log('zhu Order增 rowId=' + rowId)
    return (rowId && rowId > -1) ? Promise.resolve(rowId) : Promise.reject('insert error')
  }

  // 更新
  async updateOrder(bean: OrderBean) {
    if (!bean.id) {
      return Promise.reject('id error')
    }
    let vb: ValuesBucket = {
      id: bean.id,
      state: bean.state,
      order_code: bean.order_code,
      total_price: bean.total_price,
      score: bean.score,
      goods_ids: bean.goods_ids,
      shop_name: bean.shop_name,
      img_id: bean.img_id,
      date_added: bean.date_added,
      timestamp: bean.timestamp
    }
    const predicates = new relationalStore.RdbPredicates(this.TABLE_ORDER)
    predicates.equalTo('id', bean.id)
    const rowCount = await this.rdbStore?.update(vb, predicates)
    console.log('zhu Order改 rowCount=' + rowCount)
    return rowCount ? Promise.resolve(rowCount) : Promise.reject('update error')
  }

  // 删除
  async deleteOrder(id: number) {
    const predicates = new relationalStore.RdbPredicates(this.TABLE_ORDER)
    predicates.equalTo('id', id)
    const rowCount = await this.rdbStore?.delete(predicates)
    console.log('zhu Order删 rowCount=' + rowCount)
    return rowCount ? Promise.resolve(rowCount) : Promise.reject('delete error')
  }

  // 查询
  async queryOrderList() {
    const predicates = new relationalStore.RdbPredicates(this.TABLE_ORDER)
    // 添加日期倒序排列
    //predicates.orderByDesc('timestamp')
    // 如果有 id
    // if (id_) {
    //   predicates.equalTo('id_', id_)
    // }
    const resultSet = await this.rdbStore?.query(predicates)
    const list: OrderBean[] = []
    while (resultSet && resultSet.goToNextRow()) {
      // 获取数据
      const data: OrderBean = {
        id: resultSet.getLong(resultSet.getColumnIndex('id')),
        state: resultSet.getLong(resultSet.getColumnIndex('state')),
        order_code: resultSet.getString(resultSet.getColumnIndex('order_code')),
        total_price: resultSet.getLong(resultSet.getColumnIndex('total_price')),
        score: resultSet.getLong(resultSet.getColumnIndex('score')),
        goods_ids: resultSet.getString(resultSet.getColumnIndex('goods_ids')),
        shop_name: resultSet.getString(resultSet.getColumnIndex('shop_name')),
        img_id: resultSet.getLong(resultSet.getColumnIndex('img_id')),
        date_added: resultSet.getString(resultSet.getColumnIndex('date_added')),
        timestamp: resultSet.getLong(resultSet.getColumnIndex('timestamp'))

      }
      // 追加到数组中
      list.push(data)
    }
    console.log('zhu Order查询所有 list2=' + JSON.stringify(list))
    // 释放资源
    resultSet?.close()
    return list
  }
}

let util2 = new DbUtil()

export default util2 as DbUtil