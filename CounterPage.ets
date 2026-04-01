interface CounterStorage {
  count: number;
}

interface SpaceOptions {
  space: number;
}

interface CounterButtonOptions {
  label: string;
  step: number;
}

interface MarginOptions {
  top: number;
}

// 创建 LocalStorage 实例，并初始化计数器值为 0
const counterStorage: CounterStorage = { count: 0 };
let storage: LocalStorage = new LocalStorage(counterStorage);

// 子组件：负责显示按钮并修改计数器的值
@Component
struct CounterButton {
  // 使用 @LocalStorageLink 实现与 LocalStorage 中 count 的双向同步
  @LocalStorageLink('count') count: number = 0;
  @Require label: string = '';
  @Require step: number = 0;

  build() {
    Button(this.label)
      .width(120)
      .height(50)
      .fontSize(20)
      .onClick(() => {
        this.count += this.step;
      })
  }
}

// 入口组件：将 LocalStorage 实例与页面绑定
@Entry(storage)
@Component
struct CounterPage {
  // 使用 @LocalStorageLink 实现与 LocalStorage 中 count 的双向同步
  @LocalStorageLink('count') count: number = 0;

  build() {
    const columnOptions: SpaceOptions = { space: 30 };
    const rowOptions: SpaceOptions = { space: 20 };
    const increaseOptions: CounterButtonOptions = { label: '增加', step: 1 };
    const decreaseOptions: CounterButtonOptions = { label: '减少', step: -1 };
    const textMargin: MarginOptions = { top: 60 };

    Column(columnOptions) {
      Text(`${this.count}`)
        .fontSize(60)
        .fontWeight(FontWeight.Bold)
        .margin(textMargin)

      Row(rowOptions) {
        CounterButton(increaseOptions)
        CounterButton(decreaseOptions)
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}
