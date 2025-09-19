import MyRdb from '../sqlite/MyRdb'
import { taskpool } from '@kit.ArkTS'
import { UserInfo, MerchantInfo, RiderInfo, UserInfoWithPassword, MerchantInfoWithPassword, RiderInfoWithPassword } from '../common/UserInfo'
import { Context } from '@kit.AbilityKit'

/*
 * 用户插入任务（使用线程池）
 * @Concurrent 装饰器表示此函数将在非主线程执行，意味着其无法访问UI组件。
 * */
@Concurrent
async function insertUser(context: Context, username: string, password: string, phone: string, avatar_url: string, campus_id: number): Promise<void> {
  // 调用单例RDB实例插入用户数据
  await MyRdb.getInstance().insertUser(context, username, password, phone, avatar_url, campus_id)
}

/*
 * 线程池封装
 * @param context Ability上下文
 * @param username 用户名
 * @param password 密码（需提前加密）
 * @param phone 手机号
 * @param avatar_url 头像URL
 * @param campus_id 关联的校区ID
 * @returns 空或错误对象
 * */
export async function taskPoolInsertUser(context: Context, username: string, password: string, phone: string, avatar_url: string, campus_id: number): Promise<void | Error> {
  try {
    const task = new taskpool.Task(insertUser, context, username, password, phone, avatar_url, campus_id)
    await taskpool.execute(task)
  } catch (e) {
    const error = e as Error
    console.error("RdbTaskPool", "taskPoolInsertUser", error.message)
    return error
  }
}

// 用户查询任务
@Concurrent
async function queryUserByPhone(context: Context, phone: string): Promise<UserInfoWithPassword | null> {
  return await MyRdb.getInstance().queryUserByPhone(context, phone)
}

// 通过手机号查询用户
export async function taskPoolQueryUserByPhone(context: Context, phone: string): Promise<UserInfoWithPassword | null | Error> {
  try {
    const task = new taskpool.Task(queryUserByPhone, context, phone)
    return await taskpool.execute(task) as UserInfoWithPassword | null
  } catch (e) {
    const error = e as Error
    console.error("RdbTaskPool", "taskPoolQueryUserByPhone", error.message)
    return error
  }
}

// 商家插入任务
@Concurrent
async function insertMerchant(context: Context, shop_name: string, address: string, contact_phone: string, campus_id: number, admin_id: number, password: string): Promise<void> {
  await MyRdb.getInstance().insertMerchant(context, shop_name, address, contact_phone, campus_id, admin_id, password)
}

// 插入商家数据
export async function taskPoolInsertMerchant(context: Context, shop_name: string, address: string, contact_phone: string, campus_id: number, admin_id: number, password: string): Promise<void | Error> {
  try {
    const task = new taskpool.Task(insertMerchant, context, shop_name, address, contact_phone, campus_id, admin_id, password)
    await taskpool.execute(task)
  } catch (e) {
    const error = e as Error
    console.error("RdbTaskPool", "taskPoolInsertMerchant", error.message)
    return error
  }
}

// 商家查询任务
@Concurrent
async function queryMerchantByPhone(context: Context, contact_phone: string): Promise<MerchantInfoWithPassword | null> {
  return await MyRdb.getInstance().queryMerchantByPhone(context, contact_phone)
}

// 通过手机号查询任务
export async function taskPoolQueryMerchantByPhone(context: Context, contact_phone: string): Promise<MerchantInfoWithPassword | null | Error> {
  try {
    const task = new taskpool.Task(queryMerchantByPhone, context, contact_phone)
    return await taskpool.execute(task) as MerchantInfoWithPassword | null
  } catch (e) {
    const error = e as Error
    console.error("RdbTaskPool", "taskPoolQueryMerchantByPhone", error.message)
    return error
  }
}

@Concurrent
async function insertRider(context: Context, username: string, password: string, phone: string): Promise<void> {
  await MyRdb.getInstance().insertRider(context, username, password, phone)
}

export async function taskPoolInsertRider(context: Context, username: string, password: string, phone: string): Promise<void | Error> {
  try {
    const task = new taskpool.Task(insertRider, context, username, password, phone)
    await taskpool.execute(task)
  } catch (e) {
    const error = e as Error
    console.error("RdbTaskPool", "taskPoolInsertRider", error.message)
    return error
  }
}

@Concurrent
async function queryRiderByPhone(context: Context, phone: string): Promise<RiderInfoWithPassword | null> {
  return await MyRdb.getInstance().queryRiderByPhone(context, phone)
}

export async function taskPoolQueryRiderByPhone(context: Context, phone: string): Promise<RiderInfoWithPassword | null | Error> {
  try {
    const task = new taskpool.Task(queryRiderByPhone, context, phone)
    return await taskpool.execute(task) as RiderInfoWithPassword | null
  } catch (e) {
    const error = e as Error
    console.error("RdbTaskPool", "taskPoolQueryRiderByPhone", error.message)
    return error
  }
} 