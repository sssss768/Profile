import MyRdb from '../../sqlite/MyRdb';
import MyData from '../../entity/MyData';
import Food from '../../entity/Food';

export class FoodDataService {
  private static instance: FoodDataService;
  private myRdb = MyRdb.getInstance();

  private constructor() {}

  public static getInstance(): FoodDataService {
    if (!FoodDataService.instance) {
      FoodDataService.instance = new FoodDataService();
    }
    return FoodDataService.instance;
  }

  // 初始化数据库并导入示例数据
  public async initDatabase(): Promise<void> {
    try {
      await this.myRdb.initRdbStore(getContext());

      const existingFoods = await this.getAllFoods();
      if (existingFoods.length === 0) {
        await this.importSampleData();
      }
    } catch (e) {
      console.error("数据库初始化失败:", e);
      throw new Error(`数据库初始化失败: ${e}`);
    }
  }

  // 导入示例数据
  public async importSampleData(): Promise<void> {
    const allFoods: Food[] = [];

    MyData.categoryList.forEach(category => {
      category.foodList.forEach((food : Food) => {
        allFoods.push({
          id_: food.id_,
          name: food.name,
          stock: food.stock,
          price: food.price,
          des: food.des,
          icon_id: food.icon_id,
        });
      });
    });

    for (const food of allFoods) {
      await this.myRdb.addFood(getContext(), food);
    }
  }

  // 商品CRUD操作
  public async getAllFoods(): Promise<Food[]> {
    return this.myRdb.getAllFoods(getContext());
  }

  public async addFood(food: Food): Promise<void> {
    await this.myRdb.addFood(getContext(), {
      id_: food.id_,
      name: food.name,
      stock: food.stock,
      price: food.price,
      des: food.des,
      icon_id: food.icon_id
    });
  }

  public async updateFood(food: Food): Promise<void> {
    await this.myRdb.updateFood(getContext(), {
      id_: food.id_,
      name: food.name,
      stock: food.stock,
      price: food.price,
      des: food.des,
      icon_id: food.icon_id
    });
  }

  public async deleteFood(id: string): Promise<void> {
    await this.myRdb.deleteFood(getContext(), id);
  }
}