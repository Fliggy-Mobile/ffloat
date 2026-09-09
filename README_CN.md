<p align="center">
  <a href="https://github.com/Fliggy-Mobile">
    <img width="200" src="https://gw.alicdn.com/tfs/TB1a288sxD1gK0jSZFKXXcJrVXa-360-360.png">
  </a>
</p>

<h1 align="center">ffloat</h1>


<div align="center">

<p><strong>FFloat</strong> ，虽简单易用，但能满足你对浮层的一切想象。</p>

<p>生而优雅，支持精准的位置控制。圆角、边框、渐变、阴影装饰三角？应有尽有 😃。️</p>

<p><strong>主理人：<a href="https://github.com/chenBingX">Newton</a></strong></p>

<p>

<a href="https://pub.dev/packages/ffloat#-readme-tab-">
    <img height="20" src="https://img.shields.io/badge/Version-1.0.2-important.svg">
</a>


<a href="https://github.com/Fliggy-Mobile/ffloat">
    <img height="20" src="https://img.shields.io/badge/Build-passing-brightgreen.svg">
</a>


<a href="https://github.com/Fliggy-Mobile">
    <img height="20" src="https://img.shields.io/badge/Team-FAT-ffc900.svg">
</a>

<a href="https://www.dartcn.com/">
    <img height="20" src="https://img.shields.io/badge/Language-Dart-blue.svg">
</a>

<a href="https://pub.dev/documentation/ffloat/latest/ffloat/ffloat-library.html">
    <img height="20" src="https://img.shields.io/badge/API-done-yellowgreen.svg">
</a>

<a href="http://www.apache.org/licenses/LICENSE-2.0.txt">
   <img height="20" src="https://img.shields.io/badge/License-Apache--2.0-blueviolet.svg">
</a>

<p>
<p>

<img height="700" src="https://gw.alicdn.com/tfs/TB1j5H_GuH2gK0jSZFEXXcqMpXa-720-922.png">

</div>

**[English](https://github.com/Fliggy-Mobile/ffloat) | 简体中文**

> 感觉还不错？请投出您的 **Star** 吧 🥰 ！

# ✨ 特性

- 支持基于锚点元素的**浮层位置**控制

- 便捷的浮层**显示/隐藏控制**

- 自带优雅的**交互效果**

- 灵活美观的**装饰三角**

- 支持对**圆角**精准控制

- 美妙的**渐变**效果支持

- 简单但强大的**边框**支持

- 支持绝对位置**双模式** 


# 🛠 使用指南


## ⚙️ 参数

### 🔩 基础参数

|参数|类型|必要|默认值|说明|
|---|---|:---:|---|---|
|builder|FloatBuilder|是|null|通过 [FloatBuilder] 返回 [FFloat] 的内容组件。如果只更新内容区域的话，通过 `setter((){})` 进行|
|color|Color|否|`Color(0x7F000000)`|[FFloat] 的颜色|
|gradient|Gradient|否|null|渐变色。会覆盖 color|
|anchor|Widget|否|null|锚点组件|
|location|Offset|否|null|位置。通过 [location] 指定 [FFloat] 的位置后，基于锚点确定位置的所有配置将失效|
|alignment|FFloatAlignment|否|FFloatAlignment.topCenter|[FFloat] 基于 [anchor] 锚点元素的相对位置。|
|margin|EdgeInsets|否|EdgeInsets.zero|[FFloat] 基于相对确定锚定点的间距|
|padding|EdgeInsets|否|null|[FFloat] 内部间距|
|canTouchOutside|bool|否|false|点击 [FFloat] 范围外区域是否隐藏。|
|backgroundColor|Color|否|Colors.transparent|[FFloat] 浮出时，背景区域的颜色|
|autoDismissDuration|Duration|否|null|自动消失时长。如果为 null，就不会自动消失|
|controller|FFloatController|否|null|通过 [FFloatController] 可以控制 [FFloat] 的显示/隐藏。详见 [FFloatController]|
|animDuration|Duration|否|`Duration(milliseconds: 100)`|显示/隐藏动效时长|

### 🔺 三角

|参数|类型|必要|默认值|说明|
|---|---|:---:|---|---|
|triangleWidth|double|否|12|三角的宽|
|triangleHeight|double|否|6|三角的高|
|triangleAlignment|TriangleAlignment|否|TriangleAlignment.center|三角的相对位置|
|triangleOffset|Offset|否|Offset.zero|三角的位置偏移|
|hideTriangle|bool|否|false|是否隐藏装饰三角|

### 🔆 圆角 & 边框

|参数|类型|必要|默认值|说明|
|---|---|:---:|---|---|
|corner|FFloatCorner|否|null|圆角|
|cornerStyle|FFloatCornerStyle|否|FFloatCornerStyle.round|圆角样式|
|strokeColor|Color|否|null|描边颜色|
|strokeWidth|double|否|null|描边宽度|

### 🔳 阴影参数

|参数|类型|必要|默认值|说明|
|---|---|:---:|---|---|
|shadowColor|Color|否|null|阴影颜色|
|shadowOffset|Offset|否|null|阴影偏移量|
|shadowBlur|double|否|null|值越大，阴影越大|


## 📺 使用示例

### 🔩 基本使用


![](https://gw.alicdn.com/tfs/TB1GwD9FhD1gK0jSZFyXXciOVXa-464-140.gif)

```dart
FFloat(
  (_) => createContent(),
  controller: controller1,
  padding: EdgeInsets.only(left: 9, right: 9, top: 6, bottom: 6),
  corner: FFloatCorner.all(10),
  alignment: floatAlignment1,
  canTouchOutside: false,
  anchor: buildAnchor1(),
)
```

**FFloat** 能够去包裹一个正常的组件（即将正常组件赋值给 **FFloat** 的 `anchor` 参数），使得该组件具备点击弹出浮层的能力。

而且 **FFloat** 不会对原本的组件产生任何的不利影响，这很神奇吧！

或者，你也可以通过 **FFloatController** 来控制浮层的展示。当然，前提是你需要创建一个  **FFloatController** ，然后把它赋值给 **FFloat** 的 `controller` 属性。

```dart
FFloatController controller = FFloatController();

FFloat(
  controller: controller,
)

/// 显示浮层
controller.show();
/// 隐藏浮层
controller.dismiss();
```

**FFloat** 足够的聪明，它能够根据 `anchor` 的位置自动的确定自己应该出现在什么地方。通过 `alignment` 和 `margin`，你能够以难以置信的简单的方式调整浮层的位置，直到你认为这可以了。

这是一种前所未有的改变 👍！

在过去，如果你想要基于一个元素的位置展示一个浮层，那你不得不经过一系列繁琐的操作，以获得元素的位置。然后再进行坐标转换，根据浮层的尺寸进行位置的计算。

天呐，光是想想就已经够复杂的了。更别提当遇到需要居中、居左对齐的场景了，那简直是噩梦 👿。

至于浮层的内容，只需要通过 `buidler` 参数，在 **FloatBuilder** 函数中返回一个 **Widget** 就可以了。

如果你的浮层内容需要刷新， **FloatBuilder** 函数提供了一个 **StateSetter** 参数，通过它可以只针对浮层中的内容刷新，而不影响浮层外的内容。真是高效呀。

```dart
FFloat(
  (setter){
    return GestureDetector(
      onTap:(){
        setter((){
          /// update something
        });
      }
      anchor: buildWidgte());
  },
  anchor: buildAnchor()
)
```


### 💫 背景 & 动画

![](https://gw.alicdn.com/tfs/TB179P9GuH2gK0jSZFEXXcqMpXa-720-135.gif)

```dart
FFloat(
  (_) => FSuper(
    text: "Surprise😃 !",
    textColor: Colors.white,
  ),
  controller: controller2_1,
  color: Color(0xff5D5D5E),
  corner: FFloatCorner.all(6),
  margin: EdgeInsets.only(bottom: 10),
  padding: EdgeInsets.only(left: 9, right: 9, top: 3, bottom: 3),
  anchor: buildAnchor(),
  canTouchOutside: false,
  autoDismissDuration: Duration(milliseconds: 2000),
),

FFloat(
  (_) => buildSearch(),
    child2Alignment: Alignment.centerLeft,
    child2Margin: EdgeInsets.only(left: (9.0 + 18.0 + 9.0)),
  ),
  controller: controller2_2,
  color: Colors.black.withOpacity(0.95),
  backgroundColor: Colors.black26,
  corner: FFloatCorner.all(20),
  margin: EdgeInsets.only(bottom: 10, left: 10),
  anchor: buildAnchor(),
  alignment: FFloatAlignment.topRight,
  triangleAlignment: TriangleAlignment.end,
  triangleOffset: Offset(-39, 0),
)
```

当 **FFloat** 的浮层出现时，你可以选择是否需要背景色，通过配置 `backgroundColor`。

而通过 `canTouchOutside` 属性，你设置你的浮层是否可以通过点击浮层外区域关闭。

当设置为 `canTouchOutside = false` 时，往往就意味着你需要通过一个 **FFloatController** 来控制浮层的隐藏。

默认情况下，**FFloat** 附赠了一个 **缩放** 的显示/隐藏动画。

依据你设置的浮层方位，**FFloat** 能够智能的判断动画的起始锚点。这让一切都更加自然。

如果你不需要动画效果的话，只需要通过 `animDuration` 参数传入 **null**，就可以取消动画效果，回归比较突兀的显示/隐藏了。

在你配置了 `autoDismissDuration` 参数的情况下，**FFloat** 会进入自动消失模式。这意味着，在浮层弹出后，将在你期望的时间点自动消失。你无需过多干预。


### 🔺 装饰三角

![](https://gw.alicdn.com/tfs/TB1L3JoFEH1gK0jSZSyXXXtlpXa-753-220.gif)

```dart
FFloat(
  (setter) => buildContent(),
  shadowColor: Colors.black38,
  shadowBlur: 8.0,
  shadowOffset: Offset(2.0, 2.0),
  color: Colors.white,
  corner: FFloatCorner.all(3),
  controller: controller3_1,
  alignment: FFloatAlignment.bottomLeft,
  hideTriangle: true,
  anchor: buildAnchor(),
),

FFloat(
  (setter) => buildContent(),
  controller: controller3_2,
  alignment: FFloatAlignment.bottomLeft,
  margin: EdgeInsets.only(top: 2),
  shadowColor: Colors.black38,
  shadowBlur: 8.0,
  shadowOffset: Offset(2.0, 2.0),
  corner: FFloatCorner.all(3),
  color: Colors.white,
  triangleAlignment: TriangleAlignment.start,
  triangleOffset: Offset(10, 10),
  triangleWidth: 20,
  triangleHeight: 15,
  anchor: buildAnchor(),
),
```

**FFloat** 贴心的内置了装饰三角。默认情况下你就能看到它。如果你不希望得到一个有装饰三角的浮层，可以通过 `hideTriangle` 属性来控制它的显示/隐藏。

再次说明，**FFloat** 真的很聪明，装饰三角能够自动根据浮层与锚点元素的相对位置判断自己应该出现在什么位置，看起来才足够精致。

装饰三角和浮层的主题样式是浑然天成的，在色彩方面，**FFloat** 完全省去了你的烦恼。无论是纯色、边框、渐变色，一切都无需额外的处理。

`triangleAlignment` 提供了简易的方式来调整装饰三角的位置。

如果你还是不满意，`triangleOffset` 能够让你基于相对位置进一步偏移。对于 **FFloat** 而言，没有什么不可能的。

当然，**FFloat** 一定会为你准备装饰三角的尺寸控制的，就像 `triangleWidth` 和 `triangleHeight` 要解决的问题那样。

### 🔆 圆角 & 边框

![](https://gw.alicdn.com/tfs/TB1xbhyFqL7gK0jSZFBXXXZZpXa-670-241.gif)

```dart

FFloat(
  (setter) {
    return buildContent();
  },
  anchor: buildAnchor(),
  controller: controller4,
  color: Colors.white,
  corner: FFloatCorner.all(6),
  strokeColor: mainShadowColor,
  strokeWidth: 1.0,
  alignment: FFloatAlignment.bottomLeft,
  hideTriangle: true,
  margin: EdgeInsets.only(top: 9),
  padding: EdgeInsets.only(top: 9, bottom: 9),
)
```

如你所见，一个漂亮的带边框的圆角浮层，构建起来是如此的简单。

**FFloat** 提供了 **FWidget** 系列组件一脉相承的，简单的设置圆角的方式，仅仅通过一个简单的 `corner` 属性就能灵活的配置圆角。

与 `corner` 配套的 `cornerStyle` 属性，允许你随时切换圆角的风格（圆角 or 斜切角）。

如果你已经是 **FWidget** 的用户，相信你已经知道了，我们为组件配置边框效果，仅仅需要通过 `strokeWidth` 和 `strokeColor` 这样两个简单的属性即可。

我们的初心，始终是想帮助开发者能够更加快捷的构建出精美的应用。


### 🔳 渐变 & 阴影

![](https://gw.alicdn.com/tfs/TB11GHPFrj1gK0jSZFuXXcrHpXa-414-179.gif)

```dart

FFloat(
  (setter) => buildContent(),
  anchor: buildAnchor(),
  controller: controller5,
  gradient: SweepGradient(
    colors: [
      Color(0xffE271C0),
      Color(0xffC671EB),
      Color(0xff7673F3),
      Color(0xff8BEBEF),
      Color(0xff93FCA8),
      Color(0xff94FC9D),
      Color(0xffEDF980),
      Color(0xffF0C479),
      Color(0xffE07E77),
    ],
  ),
  corner: FFloatCorner.all(100),
  hideTriangle: true,
  margin: EdgeInsets.only(top: 9),
  alignment: FFloatAlignment.bottomCenter,
  shadowColor: Colors.black38,
  shadowBlur: 3,
  shadowOffset: Offset(3, 2),
)
```

是的，**FFloat** 在兼具了诸多能力之后，仍然对渐变进行了支持。

当然，仅仅是通过一个简单的 `gradient` 属性，你就能获得漂亮的渐变效果。

此外，作为一个现代化的组件，**FFloat** 当然会对阴影作出支持。

你只需要通过 `shadowColor` 属性就能获得一个基础的阴影效果，如果你想要进一步对阴影作出调整的，可以使用 `shadowBlur` 和 `shadowOffset` 属性。

### 📌 基于绝对坐标的位置控制

![](https://gw.alicdn.com/tfs/TB1gnz8GrH1gK0jSZFwXXc7aXXa-858-508.gif)

```dart
GestureDetector(
  onPanDown: (details) {
    FFloat(
      (setter) => createContent(),
      autoDismissDuration: Duration(milliseconds: 2000),
      alignment: _alignment,
      canTouchOutside: false,

      /// 通过绝对坐标配置浮动元素位置
      location: Offset(details.globalPosition.dx, details.globalPosition.dy),
    ).show(context); /// 显示
  },
  child: FSuper(...),
)
```

在一些情况下，我们的浮动元素不需要基于一个锚点出现，而是希望它出现在一个确定的位置。

如果开发者知道一个这样的位置的话，就用 `location` 参数来设置 **FFloat** 的位置吧。

此时，开发者完全不需要将 **FFloat** 放到视图树中包裹任何的元素。这意味着开发者可以随时随地，在任何回调或者函数中创建一个浮动元素。

通过 `FFloat.show(context)` 和  `FFloat.dismiss()`，开放着可以随时轻松的控制浮动元素的 **显示/隐藏** 。

而 **FFloat** 的其它一切配置都依旧有效。

### 👏 更多的精彩

![](https://gw.alicdn.com/tfs/TB1NGfIFAL0gK0jSZFtXXXQCXXa-460-500.gif)

在 **FFloat** 中，浮层能够自动的跟随锚点元素移动，你无需关注因位置变化而产生的一些列计算。  

**FFloat** 都帮你处理的足够好了！

让 **FFloat** 来解决你的一切浮层问题吧，你只需要用心美化你的应用就够了。


# 😃 如何使用？

在项目 `pubspec.yaml` 文件中添加依赖：

## 🌐 pub 依赖方式

```
dependencies:
  ffloat: ^<版本号>
```

> ⚠️ 注意，请到 [**pub**](https://pub.dev/packages/ffloat) 获取 **ffloat** 最新版本号

## 🖥 git 依赖方式

```
dependencies:
  ffloat:
    git:
      url: 'git@github.com:Fliggy-Mobile/ffloat.git'
      ref: '<分支号 或 tag>'
```


> ⚠️ 注意，分支号 或 tag 请以 [**ffloat**](https://github.com/Fliggy-Mobile/ffloat) 官方项目为准。


# 💡 License

```
Copyright 2020-present Fliggy Android Team.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at following link.

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

```


### 感觉还不错？请投出您的 [**Star**](https://github.com/Fliggy-Mobile/ffloat) 吧 🥰 ！


--

# 如何运行 Demo 工程？

1. **clone** 工程到本地

2. 进入工程 `example` 目录，运行以下命令

```
flutter create .
```

3. 运行 `example` 中的 Demo

# [🛸传送门：更新日志](https://github.com/Fliggy-Mobile/ffloat/blob/master/CHANGELOG.md)
