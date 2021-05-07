import 'dart:math';

import 'package:fbutton/fbutton.dart';
import 'package:ffloat/ffloat.dart';
import 'package:ffloat_example/color.dart';
import 'package:flutter/material.dart';
import 'package:fradio/fradio.dart';
import 'package:fsuper/fsuper.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FFloatPage(),
    );
  }
}

class FFloatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FFloatPage();
  }
}

class _FFloatPage extends State<FFloatPage> {
  /// controllers
  FFloatController controller1 = FFloatController();
  FFloatController controller2_1 = FFloatController();
  FFloatController controller2_2 = FFloatController();
  FFloatController controller2_3 = FFloatController();
  FFloatController controller3_1 = FFloatController();
  FFloatController controller3_2 = FFloatController();
  FFloatController controller3_3 = FFloatController();
  FFloatController controller4 = FFloatController();
  FFloatController controller5 = FFloatController();

  String text_1 = "Click, Now!";
  FFloatAlignment floatAlignment1 = FFloatAlignment.topCenter;

  List<String> fileMenuList = [];
  List<String> clickList = [];
  int groupMenuValue1 = -1;
  int groupMenuValue2 = -1;
  int groupMenuValue3 = -1;

  int groupToolbarValue = -1;

  int groupCornerValue = -1;

  List<FFloatAlignment> alignmentList;

  @override
  void initState() {
    controller1.setStateChangedListener(() {
      print('controller1.isShow = ${controller1.isShow}');
      if (!controller1.isShow) {
        setState(() {
          floatAlignment1 = randomFloatAlignment(floatAlignment1);
        });
      }
    });
    controller2_2.setStateChangedListener(() {
      print('controller2_2.isShow = ${controller2_2.isShow}');
    });
    fileMenuList.add("New Finder Window           ⌘N");
    fileMenuList.add("New Smart Folder              ");
    fileMenuList.add("New Tab                              ⌘T");
    fileMenuList.add("Open in New Tab              ^⌘O");

    /// clickList
    clickList.add("Android");
    clickList.add("iOS");
    clickList.add("Flutter");
    clickList.add("Fuchsia");

    alignmentList = [
//      FFloatAlignment.topLeft,
      FFloatAlignment.topCenter,
//      FFloatAlignment.topRight,
//      FFloatAlignment.bottomLeft,
      FFloatAlignment.bottomCenter,
//      FFloatAlignment.bottomRight,
//      FFloatAlignment.leftTop,
      FFloatAlignment.leftCenter,
//      FFloatAlignment.leftBottom,
//      FFloatAlignment.rightTop,
      FFloatAlignment.rightCenter,
//      FFloatAlignment.rightBottom,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: AppBar(
        backgroundColor: mainBackgroundColor,
        title: const Text(
          'FFloat',
          style: TextStyle(color: mainTextTitleColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildTitle("Base Demo"),
            buildMiddleMargin(),

            /// baseDemo
            baseDemo(),
            buildMiddleMargin(),
            buildTitle("Background & Animation"),
            buildMiddleMargin(),
            buildMiddleMargin(),
            buildMiddleMargin(),

            /// backgroundDemo
            backgroundDemo(),
            buildMiddleMargin(),
            buildTitle("Triangle"),
            buildMiddleMargin(),
            buildMiddleMargin(),

            /// Triangle
            triangleDemo(),
            buildMiddleMargin(),
            buildMiddleMargin(),
            buildMiddleMargin(),
            buildMiddleMargin(),
            buildMiddleMargin(),
            buildMiddleMargin(),
            buildTitle("Corner & Stroke"),
            buildMiddleMargin(),

            /// cornerDemo
            cornerDemo(),
            buildMiddleMargin(),
            buildMiddleMargin(),
            buildMiddleMargin(),
            buildMiddleMargin(),
            buildMiddleMargin(),
            buildMiddleMargin(),
            buildMiddleMargin(),
            buildMiddleMargin(),
            buildTitle("Gradient & Shadow"),
            buildMiddleMargin(),

            /// gradientDemo
            gradientDemo(),
            buildMiddleMargin(),
            buildMiddleMargin(),
            buildMiddleMargin(),
            buildMiddleMargin(),
            buildMiddleMargin(),
            buildTitle("More Surprise"),
            buildMiddleMargin(),
            buildMiddleMargin(),

            /// moreDemo
            moreDemo(),
            buildMiddleMargin(),
            buildMiddleMargin(),
            buildMiddleMargin(),
            buildMiddleMargin(),
            buildMiddleMargin(),

            buildTitle("Absolute Position Demo"),
            buildMiddleMargin(),
            buildMiddleMargin(),

            /// Absolute Position Demo
            buildAbsolutePositionDemo(context),
            buildMiddleMargin(),
            buildMiddleMargin(),
            buildMiddleMargin(),
          ],
        ),
      ),
    );
  }

  GestureDetector buildAbsolutePositionDemo(BuildContext context) {
    return GestureDetector(
      onPanDown: (details) {
        FFloat(
          (setter) => Text(
            "Hello",
            style: TextStyle(color: Colors.white),
          ),
          location: Offset(details.globalPosition.dx, details.globalPosition.dy),
          autoDismissDuration: Duration(milliseconds: 2000),
          padding: EdgeInsets.all(6.0),
          corner: FFloatCorner.all(6.0),
          canTouchOutside: false,
          alignment: randomAlignment(),
        ).show(context);
      },
      child: FSuper(
        width: 300,
        height: 200,
        backgroundColor: Colors.white,
        shadowColor: mainShadowColor,
        shadowOffset: Offset(3.0, 3.0),
        shadowBlur: 5.0,
        corner: FCorner.all(6.0),
      ),
    );
  }

  Container moreDemo() {
    return Container(
      width: double.infinity,
      height: 250,
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Color(0xffe2f1fa),
        borderRadius: BorderRadius.all(Radius.circular(6)),
        boxShadow: [
          BoxShadow(color: mainShadowColor, blurRadius: 5, offset: Offset(5, 5)),
        ],
      ),
      alignment: Alignment.center,
      child: Stack(
        children: [
          Positioned(
            left: 300,
            child: FFloat(
              (_) {
                return Text(
                  "Airpos",
                  style: TextStyle(color: Colors.white),
                );
              },
              padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 15),
              margin: EdgeInsets.only(bottom: 3),
              corner: FFloatCorner(leftTopCorner: 50, rightTopCorner: 50, leftBottomCorner: 35, rightBottomCorner: 35),
              triangleWidth: 30,
              triangleHeight: 10,
              anchor: Image.asset(
                "assets/airpos.png",
                width: 60,
              ),
              canTouchOutside: false,
            ),
          ),
          Positioned(
            left: 100,
            top: 10,
            child: FFloat(
              (_) {
                return Text(
                  "Apple Tv",
                  style: TextStyle(color: Colors.white),
                );
              },
              padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 15),
              margin: EdgeInsets.only(bottom: 3),
              corner: FFloatCorner(leftTopCorner: 80, rightTopCorner: 80, leftBottomCorner: 35, rightBottomCorner: 35),
              triangleWidth: 55,
              triangleHeight: 10,
              anchor: Image.asset(
                "assets/appletv.png",
                width: 60,
              ),
              canTouchOutside: false,
            ),
          ),
          Positioned(
            left: 80,
            top: 90,
            child: FFloat(
              (_) {
                return Text(
                  "iPhone",
                  style: TextStyle(color: Colors.white),
                );
              },
              padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              margin: EdgeInsets.only(bottom: 10, right: 3),
              corner: FFloatCorner(leftTopCorner: 50, rightTopCorner: 25, leftBottomCorner: 50, rightBottomCorner: 25),
              triangleWidth: 23,
              triangleHeight: 10,
              alignment: FFloatAlignment.leftTop,
              anchor: Image.asset(
                "assets/iphone.png",
                width: 80,
              ),
              canTouchOutside: false,
            ),
          ),
          Positioned(
            left: 200,
            top: 10,
            child: FFloat(
              (_) {
                return Text(
                  "Switch",
                  style: TextStyle(color: Colors.white),
                );
              },
              padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 15),
              margin: EdgeInsets.only(bottom: 3),
              corner: FFloatCorner(leftTopCorner: 80, rightTopCorner: 80, leftBottomCorner: 40, rightBottomCorner: 40),
              triangleWidth: 41,
              triangleHeight: 10,
              anchor: Image.asset(
                "assets/switch.png",
                width: 60,
              ),
              canTouchOutside: false,
            ),
          ),
          Positioned(
            left: 250,
            top: 100,
            child: FFloat(
              (_) {
                return Text(
                  "Watch",
                  style: TextStyle(color: Colors.white),
                );
              },
              padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              margin: EdgeInsets.only(bottom: 3),
              corner: FFloatCorner(leftTopCorner: 50, rightTopCorner: 80, leftBottomCorner: 50, rightBottomCorner: 80),
              alignment: FFloatAlignment.rightCenter,
              triangleWidth: 19,
              triangleHeight: 10,
              anchor: Image.asset(
                "assets/watch.png",
                width: 60,
              ),
              canTouchOutside: false,
            ),
          ),
        ],
      ),
    );
  }

  FFloat gradientDemo() {
    return FFloat(
      (setter) {
        return Container(
          width: 100,
          height: 100,
        );
      },
      anchor: FButton(
        width: 72,
        height: 30,
        corner: FCorner.all(3),
        padding: EdgeInsets.all(0),
        color: Color(0xff373737),
        clickEffect: true,
        image: Image.asset("assets/icon_color.png", width: 18),
        onPressed: () {
          controller5.show();
        },
        hoverColor: Color(0xff373737).withOpacity(0.6),
      ),
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
    );
  }

  FFloat cornerDemo() {
    return FFloat(
      (setter) {
        return SizedBox(
          width: 150,
          height: 100,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: clickList.length,
              itemBuilder: (context, index) {
                return FRadio.custom(
                  value: index,
                  groupValue: groupCornerValue,
                  onChanged: (value) {
                    setter(() {
                      groupCornerValue = value;
                    });
                  },
                  normal: FSuper(
                    width: double.infinity,
                    textAlign: TextAlign.left,
                    text: clickList[index],
                    padding: EdgeInsets.only(left: 20, right: 10, top: 3, bottom: 3),
                  ),
                  selected: FSuper(
                    width: double.infinity,
                    text: clickList[index],
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
                    backgroundColor: Color(0xff008FFF),
                    padding: EdgeInsets.only(left: 20, right: 10, top: 3, bottom: 3),
                  ),
                  hover: FSuper(
                    width: double.infinity,
                    text: clickList[index],
                    textAlign: TextAlign.left,
                    backgroundColor: Colors.black38.withOpacity(0.1),
                    padding: EdgeInsets.only(left: 20, right: 10, top: 3, bottom: 3),
                  ),
                );
              }),
        );
      },
      anchor: FButton(
        width: 80,
        height: 40,
        onPressed: () {
          controller4.show();
        },
        text: "Click",
        style: Theme.of(context).textTheme.button.copyWith(color: mainTextNormalColor),
        color: Colors.white,
        clickEffect: true,
        padding: EdgeInsets.zero,
        corner: FCorner.all(6),
        shadowColor: mainShadowColor,
        shadowOffset: Offset(1, 1),
        shadowBlur: 5.0,
        image: Icon(
          Icons.arrow_drop_down,
          size: 20,
          color: mainTextNormalColor,
        ),
        imageAlignment: ImageAlignment.right,
      ),
      controller: controller4,
      color: Colors.white,
      corner: FFloatCorner.all(6),
      strokeColor: mainShadowColor,
      strokeWidth: 1.0,
      alignment: FFloatAlignment.bottomLeft,
      hideTriangle: true,
      margin: EdgeInsets.only(top: 9),
      padding: EdgeInsets.only(top: 9, bottom: 9),
    );
  }

  Container triangleDemo() {
    return Container(
      width: double.infinity,
      height: 22,
      decoration: BoxDecoration(color: Color(0xff5D5D5E), boxShadow: [
        BoxShadow(
          color: Colors.black38,
          offset: Offset(0, 8),
          blurRadius: 8.0,
        )
      ]),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset("assets/icon_apple2.png", width: 13.5, height: 16),
          const SizedBox(width: 16),
          FFloat(
            (setter) => Container(
              width: 230,
              height: 121,
              padding: EdgeInsets.only(top: 6, bottom: 6),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: fileMenuList.length,
                  itemBuilder: (context, index) {
                    return FRadio.custom(
                      value: index,
                      groupValue: groupMenuValue1,
                      onChanged: (value) {
                        setter(() {
                          groupMenuValue1 = value;
                        });
                      },
                      normal: FSuper(
                        width: double.infinity,
                        textAlign: TextAlign.left,
                        text: fileMenuList[index],
                        padding: EdgeInsets.only(left: 20, right: 10, top: 3, bottom: 3),
                      ),
                      selected: FSuper(
                        width: double.infinity,
                        text: fileMenuList[index],
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
                        backgroundColor: Color(0xff008FFF),
                        padding: EdgeInsets.only(left: 20, right: 10, top: 3, bottom: 3),
                      ),
                      hover: FSuper(
                        width: double.infinity,
                        text: fileMenuList[index],
                        textAlign: TextAlign.left,
                        backgroundColor: Colors.black38.withOpacity(0.1),
                        padding: EdgeInsets.only(left: 20, right: 10, top: 3, bottom: 3),
                      ),
                    );
                  }),
            ),
            shadowColor: Colors.black38,
            shadowBlur: 8.0,
            shadowOffset: Offset(2.0, 2.0),
            color: Colors.white,
            corner: FFloatCorner.all(3),
            controller: controller3_1,
            alignment: FFloatAlignment.bottomLeft,
            hideTriangle: true,
            anchor: FRadio.custom(
              width: 56,
              height: 22,
              value: 0,
              groupValue: groupToolbarValue,
              onChanged: (value) {
                setState(() {
                  groupToolbarValue = value;
                });
                controller3_1.show();
              },
              normal: FSuper(
                text: "Finder",
                style: Theme.of(context).textTheme.button.copyWith(color: Colors.white, fontSize: 14),
                textAlignment: Alignment.center,
                padding: EdgeInsets.only(left: 6, right: 6, top: 3, bottom: 3),
              ),
              hover: FSuper(
                text: "Finder",
                style: Theme.of(context).textTheme.button.copyWith(color: Colors.white, fontSize: 14),
                textAlignment: Alignment.center,
                padding: EdgeInsets.only(left: 6, right: 6, top: 3, bottom: 3),
                backgroundColor: Color(0xff008FFF).withOpacity(0.2),
              ),
              selected: FSuper(
                text: "Finder",
                style: Theme.of(context).textTheme.button.copyWith(color: Colors.white, fontSize: 14),
                padding: EdgeInsets.only(left: 6, right: 6, top: 3, bottom: 3),
                backgroundColor: Color(0xff008FFF),
              ),
            ),
          ),
          const SizedBox(width: 4),
          FFloat(
            (setter) => Container(
              width: 230,
              height: 121,
              padding: EdgeInsets.only(top: 6, bottom: 6),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: fileMenuList.length,
                  itemBuilder: (context, index) {
                    return FRadio.custom(
                      value: index,
                      groupValue: groupMenuValue2,
                      onChanged: (value) {
                        setter(() {
                          groupMenuValue2 = value;
                        });
                      },
                      normal: FSuper(
                        width: double.infinity,
                        textAlign: TextAlign.left,
                        text: fileMenuList[index],
                        padding: EdgeInsets.only(left: 20, right: 10, top: 3, bottom: 3),
                      ),
                      selected: FSuper(
                        width: double.infinity,
                        text: fileMenuList[index],
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
                        backgroundColor: Color(0xff008FFF),
                        padding: EdgeInsets.only(left: 20, right: 10, top: 3, bottom: 3),
                      ),
                      hover: FSuper(
                        width: double.infinity,
                        text: fileMenuList[index],
                        textAlign: TextAlign.left,
                        backgroundColor: Colors.black38.withOpacity(0.1),
                        padding: EdgeInsets.only(left: 20, right: 10, top: 3, bottom: 3),
                      ),
                    );
                  }),
            ),
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
            anchor: FRadio.custom(
              width: 38,
              height: 22,
              value: 1,
              groupValue: groupToolbarValue,
              onChanged: (value) {
                setState(() {
                  groupToolbarValue = value;
                });
                controller3_2.show();
              },
              normal: FSuper(
                text: "File",
                style: Theme.of(context).textTheme.button.copyWith(color: Colors.white, fontSize: 14),
                textAlignment: Alignment.center,
                padding: EdgeInsets.only(left: 6, right: 6, top: 3, bottom: 3),
              ),
              hover: FSuper(
                text: "File",
                style: Theme.of(context).textTheme.button.copyWith(color: Colors.white, fontSize: 14),
                textAlignment: Alignment.center,
                padding: EdgeInsets.only(left: 6, right: 6, top: 3, bottom: 3),
                backgroundColor: Color(0xff008FFF).withOpacity(0.2),
              ),
              selected: FSuper(
                text: "File",
                style: Theme.of(context).textTheme.button.copyWith(color: Colors.white, fontSize: 14),
                padding: EdgeInsets.only(left: 6, right: 6, top: 3, bottom: 3),
                backgroundColor: Color(0xff008FFF),
              ),
            ),
          ),
          const SizedBox(width: 4),
          FFloat(
            (setter) => Container(
              width: 230,
              height: 121,
              padding: EdgeInsets.only(top: 6, bottom: 6),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: fileMenuList.length,
                  itemBuilder: (context, index) {
                    return FRadio.custom(
                      value: index,
                      groupValue: groupMenuValue3,
                      onChanged: (value) {
                        setter(() {
                          groupMenuValue3 = value;
                        });
                      },
                      normal: FSuper(
                        width: double.infinity,
                        textAlign: TextAlign.left,
                        text: fileMenuList[index],
                        padding: EdgeInsets.only(left: 20, right: 10, top: 3, bottom: 3),
                      ),
                      selected: FSuper(
                        width: double.infinity,
                        text: fileMenuList[index],
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
                        backgroundColor: Color(0xff008FFF),
                        padding: EdgeInsets.only(left: 20, right: 10, top: 3, bottom: 3),
                      ),
                      hover: FSuper(
                        width: double.infinity,
                        text: fileMenuList[index],
                        textAlign: TextAlign.left,
//                                backgroundColor: Color(0xff008FFF),
                        backgroundColor: Colors.black38.withOpacity(0.1),
                        padding: EdgeInsets.only(left: 20, right: 10, top: 3, bottom: 3),
                      ),
                    );
                  }),
            ),
            controller: controller3_3,
            alignment: FFloatAlignment.rightTop,
            margin: EdgeInsets.only(bottom: 8),
            corner: FFloatCorner.all(3),
            shadowColor: Colors.black38,
            shadowBlur: 8.0,
            shadowOffset: Offset(2.0, 2.0),
            color: Colors.white,
            triangleAlignment: TriangleAlignment.start,
            triangleOffset: Offset(10, 10),
            triangleWidth: 20,
            triangleHeight: 15,
            anchor: FRadio.custom(
              width: 38,
              height: 22,
              value: 2,
              groupValue: groupToolbarValue,
              onChanged: (value) {
                setState(() {
                  groupToolbarValue = value;
                });
                controller3_3.show();
              },
              normal: FSuper(
                text: "Edit",
                style: Theme.of(context).textTheme.button.copyWith(color: Colors.white, fontSize: 14),
                textAlignment: Alignment.center,
                padding: EdgeInsets.only(left: 6, right: 6, top: 3, bottom: 3),
              ),
              hover: FSuper(
                text: "Edit",
                style: Theme.of(context).textTheme.button.copyWith(color: Colors.white, fontSize: 14),
                textAlignment: Alignment.center,
                padding: EdgeInsets.only(left: 6, right: 6, top: 3, bottom: 3),
                backgroundColor: Color(0xff008FFF).withOpacity(0.2),
              ),
              selected: FSuper(
                text: "Edit",
                style: Theme.of(context).textTheme.button.copyWith(color: Colors.white, fontSize: 14),
                padding: EdgeInsets.only(left: 6, right: 6, top: 3, bottom: 3),
                backgroundColor: Color(0xff008FFF),
              ),
            ),
          ),
        ],
      ),
      padding: EdgeInsets.only(left: 12),
    );
  }

  String test = "Surprise😃 !";
  Widget backgroundDemo() {
    return FSuper(
      width: double.infinity,
      height: 40,
      backgroundColor: Color(0xff000000),
      child1: Row(
        children: [
          FFloat(
            (_) => FSuper(
//              text: "Surprise😃 !",
              text: test,
              style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
            ),
            controller: controller2_1,
            color: Color(0xff5D5D5E),
            corner: FFloatCorner.all(6),
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.only(left: 9, right: 9, top: 3, bottom: 3),
            anchor: FButton(
              width: 72,
              height: 30,
              text: "esc",
              style: Theme.of(context).textTheme.button.copyWith(color: Colors.white, fontSize: 15),
              alignment: Alignment.center,
              corner: FCorner.all(3),
              padding: EdgeInsets.all(0),
              color: Color(0xff373737),
              clickEffect: true,
              onPressed: () {
                if (!controller2_1.isShow) {
                  test = "Surprise😃 !";
                  controller2_1.show();
                } else {
                  controller2_1.setState(() {
                    test = "Changed!";
                  });
                }
              },
              hoverColor: Colors.white60.withOpacity(0.3),
            ),
            canTouchOutside: false,
            autoDismissDuration: Duration(milliseconds: 2000),
          ),
          const SizedBox(width: 16),
          FFloat(
            (_) => FSuper(
              text: "HA🌝 !",
              style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
            ),
            controller: controller2_3,
            color: Color(0xff5D5D5E),
            corner: FFloatCorner.all(6),
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.only(left: 9, right: 9, top: 3, bottom: 3),
            anchor: FButton(
              width: 72,
              height: 30,
              corner: FCorner.all(3),
              imageAlignment: ImageAlignment.left,
              image: Icon(Icons.add, color: Colors.white, size: 18),
              padding: EdgeInsets.all(0),
              color: Color(0xff373737),
              clickEffect: true,
              onPressed: () {
                controller2_3.show();
              },
              hoverColor: Colors.white60.withOpacity(0.3),
            ),
            animDuration: Duration(milliseconds: 800),
          ),
        ],
      ),
      child1Alignment: Alignment.centerLeft,
      child1Margin: EdgeInsets.only(left: 20),
      child2: FFloat(
        (_) => Container(
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 12.0),
              Icon(
                Icons.search,
                color: Colors.white,
              ),
              const SizedBox(width: 9.0),
              Container(
                width: 200,
                height: 50,
                child: TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "SEARCH",
                    hintStyle: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  cursorColor: Colors.white30,
                ),
              ),
            ],
          ),
        ),
        controller: controller2_2,
        color: Colors.black.withOpacity(0.95),
        backgroundColor: Colors.black26,
        corner: FFloatCorner.all(25),
        margin: EdgeInsets.only(bottom: 10, left: 10),
        anchor: FButton(
          width: 72,
          height: 30,
          corner: FCorner.all(3),
          imageAlignment: ImageAlignment.left,
          image: Icon(Icons.search, color: Colors.white, size: 18),
          padding: EdgeInsets.all(0),
          color: Color(0xff373737),
          clickEffect: true,
          onPressed: () {
            controller2_2.show();
          },
          hoverColor: Colors.white60.withOpacity(0.3),
        ),
        alignment: FFloatAlignment.topRight,
        triangleAlignment: TriangleAlignment.end,
        triangleOffset: Offset(-39, 0),
      ),
      child2Alignment: Alignment.centerRight,
      child2Margin: EdgeInsets.only(right: 20),
    );
  }

  Widget baseDemo() {
    return Container(
      width: double.infinity,
      height: 100,
      alignment: Alignment.center,
      child: FFloat(
        (_) => createFloat1(),
        controller: controller1,
        padding: EdgeInsets.only(left: 9, right: 9, top: 6, bottom: 6),
        corner: FFloatCorner.all(10),
        alignment: floatAlignment1,
        canTouchOutside: false,
        anchor: buildChild1(),
      ),
    );
  }

  FSuper buildChild1() {
    return FSuper(
      width: 200,
      height: 50,
      textAlignment: Alignment.center,
      text: text_1,
      style: Theme.of(context).textTheme.button.copyWith(color: mainTextNormalColor, fontSize: 18),
      corner: FCorner.all(10),
      backgroundColor: Colors.white,
      padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
      shadowColor: mainShadowColor,
      shadowBlur: 5.0,
      shadowOffset: Offset(2.0, 2.0),
    );
  }

  Widget createFloat1() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "Found me!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 6),
        InkWell(
          onTap: () => controller1.dismiss(),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Icon(
              Icons.close,
              size: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  SizedBox buildMiddleMargin() {
    return const SizedBox(
      height: 26,
    );
  }

  SizedBox buildSmallMargin() {
    return const SizedBox(
      height: 18,
    );
  }

  Padding buildDesc(String desc) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          desc,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ));
  }

  Container buildTitle(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(9),
      color: Color(0xffe0e0e0).withOpacity(0.38),
      child: Text(
        title,
        style: TextStyle(color: mainTextSubColor.withOpacity(0.7)),
      ),
    );
  }

  FFloatAlignment randomFloatAlignment(FFloatAlignment alignment) {
    switch (alignment) {
      case FFloatAlignment.topLeft:
        return FFloatAlignment.topCenter;
      case FFloatAlignment.topCenter:
        return FFloatAlignment.topRight;
      case FFloatAlignment.topRight:
        return FFloatAlignment.bottomLeft;
      case FFloatAlignment.bottomLeft:
        return FFloatAlignment.bottomCenter;
      case FFloatAlignment.bottomCenter:
        return FFloatAlignment.bottomRight;
      case FFloatAlignment.bottomRight:
        return FFloatAlignment.leftTop;
      case FFloatAlignment.leftTop:
        return FFloatAlignment.leftCenter;
      case FFloatAlignment.leftCenter:
        return FFloatAlignment.leftBottom;
      case FFloatAlignment.leftBottom:
        return FFloatAlignment.rightTop;
      case FFloatAlignment.rightTop:
        return FFloatAlignment.rightCenter;
      case FFloatAlignment.rightCenter:
        return FFloatAlignment.rightBottom;
      case FFloatAlignment.rightBottom:
        return FFloatAlignment.topLeft;
    }
    return FFloatAlignment.topCenter;
  }

  FFloatAlignment randomAlignment() {
    return alignmentList[Random().nextInt(alignmentList.length)];
  }
}
