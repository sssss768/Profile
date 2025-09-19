import relationalStore from "@ohos.data.relationalStore";
import { Context } from "@kit.AbilityKit";
import { ValuesBucket } from "@kit.ArkData";
import Food from '../entity/Food';
import { UserInfo, MerchantInfo, RiderInfo, UserInfoWithPassword, MerchantInfoWithPassword, RiderInfoWithPassword } from '../common/UserInfo';

export default class MyRdb {
  private static instance: MyRdb | null = null;
  private rdbStore: relationalStore.RdbStore | null = null;
  private TAG: string = "rdbStore";

  //表名常量
  private TABLE_USER: string = "TABLE_USER";
  private TABLE_MERCHANT: string = "TABLE_MERCHANT";
  private TABLE_RIDER: string = "TABLE_RIDER";
  private TABLE_FOOD: string = 'TABLE_FOOD';


  private constructor() {}

  public static getInstance(context?: Context): MyRdb {
    if (MyRdb.instance == null) {
      MyRdb.instance = new MyRdb();
    }
    return MyRdb.instance;
  }

  public async initRdbStore(context: Context) {
    console.info(this.TAG, "initRdbStore", "init begin");
    if (!context) {
      return
    }
    if (this.rdbStore) {
      console.info(this.TAG, "initRdbStore", "rdbStore is exist");
      return
    }
    const config: relationalStore.StoreConfig = {
      name: "MyRdb.db",
      securityLevel: relationalStore.SecurityLevel.S1
    }
    try {
      this.rdbStore = await relationalStore.getRdbStore(context, config)
      console.info(this.TAG, "initRdbStore", "rdbStore is success");

      //初始化所有表
      await this.createUserTable()
      await this.createMerchantTable()
      await this.createRiderTable()
      await this.createFoodTable()
    } catch (e) {
      console.info(this.TAG, "initRdbStore", "rdbStore create error" + e.message);
    }
  }

  // ========== 表创建方法 ========== //
  private async createUserTable() {
    console.info(this.TAG, "createUserTable", "createUserTable begin");
    const userSql = `
      CREATE TABLE IF NOT EXISTS ${this.TABLE_USER} (
        user_id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        phone TEXT NOT NULL,
        avatar_url TEXT,
        campus_id INTEGER,
        balance REAL DEFAULT 0,
        created_at TEXT NOT NULL
      )`

    if (this.rdbStore) {
      try {
        await this.rdbStore.executeSql(userSql)
        console.info(this.TAG, "createUserTable", "createUserTable is success");
      } catch (e) {
        console.info(this.TAG, "createUserTable", "createUserTable fail:" + e.message);
      }
    }
  }

  private async createMerchantTable() {
    console.info(this.TAG, "createMerchantTable", "createMerchantTable begin");
    const merchantSql = `
      CREATE TABLE IF NOT EXISTS ${this.TABLE_MERCHANT} (
        merchant_id INTEGER PRIMARY KEY AUTOINCREMENT,
        campus_id INTEGER,
        admin_id INTEGER,
        shop_name TEXT NOT NULL,
        password TEXT NOT NULL,
        address TEXT NOT NULL,
        contact_phone TEXT NOT NULL,
        avg_rating REAL DEFAULT 0
      )`

    if (this.rdbStore) {
      try {
        await this.rdbStore.executeSql(merchantSql)
        console.info(this.TAG, "createMerchantTable", "createMerchantTable is success");
      } catch (e) {
        console.info(this.TAG, "createMerchantTable", "createMerchantTable fail:" + e.message);
      }
    }
  }

  private async createRiderTable() {
    console.info(this.TAG, "createRiderTable", "createRiderTable begin");
    const riderSql = `
      CREATE TABLE IF NOT EXISTS ${this.TABLE_RIDER} (
        rider_id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        phone TEXT NOT NULL,
        status INTEGER DEFAULT 0,
        created_at TEXT NOT NULL
      )`

    if (this.rdbStore) {
      try {
        await this.rdbStore.executeSql(riderSql)
        console.info(this.TAG, "createRiderTable", "createRiderTable is success");
      } catch (e) {
        console.info(this.TAG, "createRiderTable", "createRiderTable fail:" + e.message);
      }
    }
  }
  // yym,商家商品表
  private async createFoodTable() {
    console.info(this.TAG, "createFoodTable", "createFoodTable begin");
    const foodSql = `
      CREATE TABLE IF NOT EXISTS ${this.TABLE_FOOD} (
        id_ TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        stock INTEGER DEFAULT 0,
        price REAL NOT NULL,
        des TEXT,
        icon_id INTEGER,
        createdAt TEXT,
        updatedAt TEXT
      )`;

    if (this.rdbStore) {
      try {
        await this.rdbStore.executeSql(foodSql);
        console.info(this.TAG, "createFoodTable", "createFoodTable is success");
      } catch (e) {
        console.info(this.TAG, "createFoodTable", "createFoodTable fail:" + e.message);
      }
    }
  }

  // ========== 用户相关方法 ========== //
  public async updateUser(context: Context, user: UserInfoWithPassword): Promise<void> {
    if (!this.rdbStore) {
      await this.initRdbStore(context); // 确保数据库已初始化
    }

    // 构建更新的字段（包含需要修改的用户信息）
    const valuesBucket: ValuesBucket = {
      username: user.username,
      phone: user.phone,
      password: user.password,
      avatar_url: user.avatar_url,
      campus_id: user.campus_id,
      balance: user.balance
    };

    // 创建查询条件：根据user_id更新
    const predicates = new relationalStore.RdbPredicates(this.TABLE_USER);
    predicates.equalTo('user_id', user.user_id); // 按用户ID定位要更新的记录

    await this.rdbStore!.update(valuesBucket, predicates);
  }

  public async insertUser(context: Context, username: string, password: string, phone: string, avatar_url: string, campus_id: number): Promise<void> {
    if (!this.rdbStore) {
      await this.initRdbStore(context);
    }
    let valuesBucket: ValuesBucket = {};
    valuesBucket.username = username;
    valuesBucket.password = password;
    valuesBucket.phone = phone;
    valuesBucket.avatar_url = avatar_url;
    valuesBucket.campus_id = campus_id;
    valuesBucket.created_at = new Date().toISOString();
    
    await this.rdbStore!.insert(this.TABLE_USER, valuesBucket);
  }

  public async queryUserByPhone(context: Context, phone: string): Promise<UserInfoWithPassword | null> {
    if (!this.rdbStore) {
      await this.initRdbStore(context);
    }
    const predicates = new relationalStore.RdbPredicates(this.TABLE_USER);
    predicates.equalTo('phone', phone);
    const resultSet = await this.rdbStore!.query(predicates);
    let user: UserInfoWithPassword | null = null;
    if (resultSet.rowCount > 0) {
      resultSet.goToFirstRow();
      const userWithPwd = new UserInfoWithPasswordImpl();
      userWithPwd.user_id = resultSet.getLong(resultSet.getColumnIndex('user_id'));
      userWithPwd.username = resultSet.getString(resultSet.getColumnIndex('username'));
      userWithPwd.phone = resultSet.getString(resultSet.getColumnIndex('phone'));
      userWithPwd.avatar_url = resultSet.getString(resultSet.getColumnIndex('avatar_url'));
      userWithPwd.campus_id = resultSet.getLong(resultSet.getColumnIndex('campus_id'));
      userWithPwd.balance = resultSet.getDouble(resultSet.getColumnIndex('balance'));
      userWithPwd.password = resultSet.getString(resultSet.getColumnIndex('password'));
      user = userWithPwd;
    }
    resultSet.close();
    return user;
  }

  // ========== 商家相关方法 ========== //
  public async insertMerchant(context: Context, shop_name: string, address: string, contact_phone: string, campus_id: number, admin_id: number, password: string): Promise<void> {
    if (!this.rdbStore) {
      await this.initRdbStore(context);
    }
    let valuesBucket: ValuesBucket = {};
    valuesBucket.shop_name = shop_name;
    valuesBucket.address = address;
    valuesBucket.contact_phone = contact_phone;
    valuesBucket.campus_id = campus_id;
    valuesBucket.admin_id = admin_id;
    valuesBucket.password = password;
    
    await this.rdbStore!.insert(this.TABLE_MERCHANT, valuesBucket);
  }

  public async queryMerchantByPhone(context: Context, contact_phone: string): Promise<MerchantInfoWithPassword | null> {
    if (!this.rdbStore) {
      await this.initRdbStore(context);
    }
    const predicates = new relationalStore.RdbPredicates(this.TABLE_MERCHANT);
    predicates.equalTo('contact_phone', contact_phone);
    const resultSet = await this.rdbStore!.query(predicates);
    let merchant: MerchantInfoWithPassword | null = null;
    if (resultSet.rowCount > 0) {
      resultSet.goToFirstRow();
      const merchantWithPwd = new MerchantInfoWithPasswordImpl();
      merchantWithPwd.merchant_id = resultSet.getLong(resultSet.getColumnIndex('merchant_id'));
      merchantWithPwd.shop_name = resultSet.getString(resultSet.getColumnIndex('shop_name'));
      merchantWithPwd.address = resultSet.getString(resultSet.getColumnIndex('address'));
      merchantWithPwd.contact_phone = resultSet.getString(resultSet.getColumnIndex('contact_phone'));
      merchantWithPwd.avg_rating = resultSet.getDouble(resultSet.getColumnIndex('avg_rating'));
      merchantWithPwd.password = resultSet.getString(resultSet.getColumnIndex('password'));
      merchant = merchantWithPwd;
    }
    resultSet.close();
    return merchant;
  }

  // ========== 骑手相关方法 ========== //
  public async insertRider(context: Context, username: string, password: string, phone: string): Promise<void> {
    if (!this.rdbStore) {
      await this.initRdbStore(context);
    }
    let valuesBucket: ValuesBucket = {};
    valuesBucket.username = username;
    valuesBucket.password = password;
    valuesBucket.phone = phone;
    valuesBucket.created_at = new Date().toISOString();
    
    await this.rdbStore!.insert(this.TABLE_RIDER, valuesBucket);
  }

  public async queryRiderByPhone(context: Context, phone: string): Promise<RiderInfoWithPassword | null> {
    if (!this.rdbStore) {
      await this.initRdbStore(context);
    }
    const predicates = new relationalStore.RdbPredicates(this.TABLE_RIDER);
    predicates.equalTo('phone', phone);
    const resultSet = await this.rdbStore!.query(predicates);
    let rider: RiderInfoWithPassword | null = null;
    if (resultSet.rowCount > 0) {
      resultSet.goToFirstRow();
      const riderWithPwd = new RiderInfoWithPasswordImpl();
      riderWithPwd.rider_id = resultSet.getLong(resultSet.getColumnIndex('rider_id'));
      riderWithPwd.username = resultSet.getString(resultSet.getColumnIndex('username'));
      riderWithPwd.phone = resultSet.getString(resultSet.getColumnIndex('phone'));
      riderWithPwd.status = resultSet.getLong(resultSet.getColumnIndex('status'));
      riderWithPwd.password = resultSet.getString(resultSet.getColumnIndex('password'));
      rider = riderWithPwd;
    }
    resultSet.close();
    return rider;
  }

  // ========== 商品相关方法 ========== //

  //添加商品
  public async addFood(context: Context, food: Food): Promise<number> {
    if (!this.rdbStore) {
      await this.initRdbStore(context);
    }

    const now = new Date().toISOString();
    const valuesBucket: ValuesBucket = {
      id_: food.id_,
      name: food.name,
      stock: food.stock,
      price: food.price,
      des: food.des,
      icon_id: food.icon_id,
    };

    const rowId = await this.rdbStore!.insert(this.TABLE_FOOD, valuesBucket);
    return rowId;
  }

  //更新商品
  public async updateFood(context: Context, food: Food): Promise<number> {
    if (!this.rdbStore) {
      await this.initRdbStore(context);
    }

    const predicates = new relationalStore.RdbPredicates(this.TABLE_FOOD);
    predicates.equalTo('id_', food.id_);

    const valuesBucket: ValuesBucket = {
      name: food.name,
      stock: food.stock,
      price: food.price,
      des: food.des,
      icon_id: food.icon_id,
    };

    const rowCount = await this.rdbStore!.update(valuesBucket, predicates);
    return rowCount;
  }

  //删除商品
  public async deleteFood(context: Context, id: string): Promise<number> {
    if (!this.rdbStore) {
      await this.initRdbStore(context);
    }

    const predicates = new relationalStore.RdbPredicates(this.TABLE_FOOD);
    predicates.equalTo('id_', id);

    const rowCount = await this.rdbStore!.delete(predicates);
    return rowCount;
  }

  public async getFoodById(context: Context, id: string): Promise<Food | null> {
    if (!this.rdbStore) {
      await this.initRdbStore(context);
    }

    const predicates = new relationalStore.RdbPredicates(this.TABLE_FOOD);
    // 添加ID等于条件（与getAllFoods相同的过滤方式）
    predicates.equalTo('id_', id);

    predicates.orderByDesc('updatedAt');
    // 限制只返回1条记录
    predicates.limitAs(1);

    const resultSet = await this.rdbStore!.query(predicates);
    let food: Food | null = null;

    if (resultSet.goToNextRow()) {
      food = {
        id_: resultSet.getString(resultSet.getColumnIndex('id_')),
        name: resultSet.getString(resultSet.getColumnIndex('name')),
        stock: Number(resultSet.getLong(resultSet.getColumnIndex('stock'))),
        price: Number(resultSet.getDouble(resultSet.getColumnIndex('price'))),
        des: resultSet.getString(resultSet.getColumnIndex('des')),
        icon_id: Number(resultSet.getLong(resultSet.getColumnIndex('icon_id'))),
      };
    }

    resultSet.close();
    return food;
  }


  //查询所有商品
  public async getAllFoods(context: Context): Promise<Food[]> {
    if (!this.rdbStore) {
      await this.initRdbStore(context);
    }

    const predicates = new relationalStore.RdbPredicates(this.TABLE_FOOD);
    predicates.orderByDesc('updatedAt');

    const resultSet = await this.rdbStore!.query(predicates);
    const foods: Food[] = [];

    while (resultSet.goToNextRow()) {
      foods.push({
        id_: resultSet.getString(resultSet.getColumnIndex('id_')),
        name: resultSet.getString(resultSet.getColumnIndex('name')),
        stock: Number(resultSet.getLong(resultSet.getColumnIndex('stock'))),
        price: Number(resultSet.getDouble(resultSet.getColumnIndex('price'))),
        des: resultSet.getString(resultSet.getColumnIndex('des')),
        icon_id: Number(resultSet.getLong(resultSet.getColumnIndex('icon_id'))),
      });
    }

    resultSet.close();
    return foods;
  }
}

// 实现类
class UserInfoWithPasswordImpl implements UserInfoWithPassword {
  user_id: number = 0;
  username: string = '';
  phone: string = '';
  avatar_url: string = '';
  campus_id: number = 0;
  balance: number = 0;
  password: string = '';
}

class MerchantInfoWithPasswordImpl implements MerchantInfoWithPassword {
  merchant_id: number = 0;
  shop_name: string = '';
  address: string = '';
  contact_phone: string = '';
  avg_rating: number = 0;
  password: string = '';
}

class RiderInfoWithPasswordImpl implements RiderInfoWithPassword {
  rider_id: number = 0;
  username: string = '';
  phone: string = '';
  status: number = 0;
  password: string = '';
}