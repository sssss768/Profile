import Food from "../../entity/Food";
import MyData from '../../entity/MyData';
import MyRdb from '../../sqlite/MyRdb'

@CustomDialog
struct FoodDialog {
  @State currentFood: Food = {
    id_: '',
    name: '',
    stock: 0,
    price: 0,
    des: '',
    icon_id: 0
  }
  private isEdit: boolean = false
  controller: CustomDialogController
  onConfirm: (food: Food) => void = () => {}

  aboutToAppear() {
    if (this.currentFood.id_ === '') {
      this.currentFood.id_ = Date.now().toString()
    }
  }

  build() {
    Column() {
      Row() {
        Text(this.isEdit ? '编辑商品' : '添加商品')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2c2c2c')
        Blank()
        Button({ type: ButtonType.Circle }) {
          Image($r('app.media.trash'))
            .width(24)
            .height(24)
            .align(Alignment.Center)
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          this.controller.close()
        })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 15, bottom: 15 })
      .backgroundColor('#E7D1BB')

      Scroll() {
        Column() {
          Row(){
            Text('商品名称:')
              .height(45)
            TextInput({ placeholder: '请填写商品名称', text: this.currentFood.name })
              .width('75%')
              .height(45)
              .margin({left: 10})
              .padding(10)
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
              .onChange((value: string) => {
                this.currentFood.name = value
              })
          }.margin({ top: 5 })
          .padding(5)

          Row(){
            Text('商品描述:')
              .height(15)
            TextInput({ placeholder: '请填写商品描述', text: this.currentFood.des })
              .width('75%')
              .height(45)
              .margin({left: 10})
              .padding(10)
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
              .onChange((value: string) => {
                this.currentFood.des = value
              })
          }.padding(5)
          .margin({ top: 15 })

          Row() {
            Text("价格:")
            TextInput({ placeholder: '商品价格', text: this.currentFood.price.toString() })
              .width('30%')
              .height(45)
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
              .padding(10)
              .type(InputType.Number)
              .onChange((value: string) => {
                this.currentFood.price = Number(value)
              })
            Text("库存:")
            TextInput({ placeholder: '库存数量', text: this.currentFood.stock.toString() })
              .width('30%')
              .height(45)
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
              .padding(10)
              .type(InputType.Number)
              .onChange((value: string) => {
                this.currentFood.stock = Number(value)
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({ top: 15 ,left: 10})
        }
        .padding({ left: 15, right: 15 })
      }
      .margin({top: 50})
      .width('90%')
      .height('50%')
      .align(Alignment.Center)
      .padding(15)
      .backgroundColor('#ede4d3')
      .borderRadius(12)
      .layoutWeight(1)

      Row() {
        Button('取消', { type: ButtonType.Capsule })
          .width('45%')
          .height(40)
          .backgroundColor('#F5F5F5')
          .fontColor('#333')
          .onClick(() => {
            this.controller.close()
          })
        Button('确定', { type: ButtonType.Capsule })
          .width('45%')
          .height(40)
          .backgroundColor($r('app.color.Orange'))
          .onClick(() => {
            this.onConfirm(this.currentFood)
            this.controller.close()
          })
      }
      .width('100%')
      .height("30%")
      .padding(15)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .backgroundColor('#F7EEDD')
    .borderRadius(16)
  }
}

@Component
export struct HomeMerchant {
  @State foodList: Food[] = [];
  @State isEdit: boolean = false;
  @State currentFood: Food = {
    id_: '',
    name: '',
    stock: 0,
    price: 0,
    des: '',
    icon_id: 0
  };
  private myRdb = MyRdb.getInstance();
  private dialogController: CustomDialogController = new CustomDialogController({
    builder: FoodDialog({
      isEdit: this.isEdit,
      currentFood: this.currentFood,
      onConfirm: (food: Food) => {
        if (this.isEdit) {
          this.updateFood(food)
        } else {
          this.addFood(food)
        }
      }
    }),
    customStyle: true,
    alignment: DialogAlignment.Center
  })

  aboutToAppear() {
    this.initDatabaseWithSampleData();
  }

  build() {
    Stack() {
      Column() {
        // 顶部操作栏
        Row() {
          Text('商品管理')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2c2c2c')
          Blank()
          Button({ type: ButtonType.Circle }) {
            Image($r('app.media.edit'))
              .width(24)
              .height(24)
              .align(Alignment.Center)
          }
          .width(40)
          .height(40)
          .backgroundColor(Color.Transparent)
          .onClick(() => {
            this.isEdit = false;
            this.currentFood = {
              id_: Date.now().toString(),
              name: '',
              stock: 0,
              price: 0,
              des: '',
              icon_id: 0
            };
            this.dialogController.open()
          })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 15, bottom: 15 })
        .backgroundColor('#E7D1BB')

        // 商品列表
        List({ space: 12 }) {
          ForEach(this.foodList, (item: Food) => {
            ListItem() {
              Row() {
                Image(MyData.getFoodImg(item.icon_id)||$r("app.media.edit")) //默认炒饭图片
                  .width(90)
                  .height(90)
                  .borderRadius(8)
                  .objectFit(ImageFit.Cover)
                Column() {
                  Text(item.name)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#333')
                  Text(item.des)
                    .fontSize(14)
                    .fontColor('#666')
                    .margin({ top: 8 })
                  Row() {
                    Text(`￥${item.price.toFixed(2)}`)
                      .fontSize(20)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#FF976A')
                    Text(`库存：${item.stock}`)
                      .fontSize(14)
                      .fontColor('#999')
                      .margin({ left: 12 })
                  }
                  .margin({ top: 8 })
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)
                .margin({ left: 15 })

                Column() {
                  Button({ type: ButtonType.Circle }) {
                    Image($r('app.media.edit'))
                      .width(20)
                      .height(20)
                  }
                  .width(36)
                  .height(36)
                  .backgroundColor(Color.Transparent)
                  .onClick(() => {
                    this.isEdit = true;
                    this.currentFood = {
                      id_: item.id_,
                      name: item.name,
                      stock: item.stock,
                      price: item.price,
                      des: item.des,
                      icon_id: item.icon_id
                    };
                    this.dialogController.open()
                  })

                  Button({ type: ButtonType.Circle }) {
                    Image($r('app.media.trash'))
                      .width(20)
                      .height(20)
                  }
                  .width(36)
                  .height(36)
                  .margin({ top: 8 })
                  .backgroundColor(Color.Transparent)
                  .onClick(() => this.deleteFood(item))
                }
              }
              .padding(15)
              .backgroundColor('#ffd299')
              .borderRadius(12)
              .shadow({
                radius: 8,
                color: '#1A000000',
                offsetX: 0,
                offsetY: 2
              })
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .padding(15)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#ede4d3')
    }
  }

  private async initDatabaseWithSampleData() {
    try {
      await this.myRdb.initRdbStore(getContext(this));
      // 检查数据库是否已有数据
      const existingFoods = await this.myRdb.getAllFoods(getContext(this));
      if (existingFoods.length === 0) {
        // 数据库为空，导入MyData中的示例数据
        await this.importSampleData();
      }
      // 加载商品列表
      this.foodList = await this.myRdb.getAllFoods(getContext(this));
    } catch (e) {
      console.error("加载商品列表失败:", e);
      this.getUIContext().getPromptAction().showToast({
        message: '加载数据失败',
        duration: 2000
      });
    }
  }

  private async importSampleData() {
    // 从MyData中获取所有分类的商品
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

    // 批量插入到数据库
    for (const food of allFoods) {
      await this.myRdb.addFood(getContext(this), food);
    }
  }

  // 删除商品
  private async deleteFood(food: Food) {
    try {
      await this.myRdb.deleteFood(getContext(this), food.id_);
      this.foodList = this.foodList.filter(f => f.id_ !== food.id_);
      this.showToast('删除成功');
    } catch (e) {
      console.error("删除商品失败:", e);
      this.showToast('删除失败');
    }
  }

  private async addFood(food: Food) {
    try {
      await this.myRdb.addFood(getContext(this), food);
      this.foodList = await this.myRdb.getAllFoods(getContext(this));
      this.showToast('添加成功');
    } catch (e) {
      console.error("添加商品失败:", e);
      this.showToast('添加失败');
    }
  }

  private async updateFood(food: Food) {
    try {
      await this.myRdb.updateFood(getContext(this), food);
      this.foodList = await this.myRdb.getAllFoods(getContext(this));
      this.showToast('更新成功');
    } catch (e) {
      console.error("更新商品失败:", e);
      this.showToast('更新失败');
    }
  }

  private showToast(message: string) {
    this.getUIContext().getPromptAction().showToast({
      message,
      duration: 2000
    });
  }

}