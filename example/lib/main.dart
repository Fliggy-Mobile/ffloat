import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ffloat/ffloat.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    print('PageA - initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('PageA - didChangeDependencies');
  }

  @override
  void didUpdateWidget(MyApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('PageA - didUpdateWidget');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('PageA - deactivate');
  }

  @override
  void dispose() {
    super.dispose();
    print('PageA - dispose');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageC(),
    );
  }
}

class PageB extends StatefulWidget {
  @override
  _PageBState createState() => _PageBState();
}

class _PageBState extends State<PageB> {
  @override
  Widget build(BuildContext context) {
    print('PageB - build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Page B'),
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return PageC();
                },
              ));
            },
            child: Text("Open"),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print('PageB - initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('PageB - didChangeDependencies');
  }

  @override
  void didUpdateWidget(PageB oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('PageB - didUpdateWidget');
  }

  @override
  void deactivate() {
    super.deactivate();
    print(
        'PageB - deactivate，isCurrent = ${ModalRoute.of(context).isCurrent}，isActive = ${ModalRoute.of(context).isActive}');
  }

  @override
  void dispose() {
    super.dispose();
    print('PageB - dispose');
  }
}

class PageC extends StatefulWidget {
  @override
  _PageCState createState() => _PageCState();
}

class _PageCState extends State<PageC> {
  FFloatController controller = FFloatController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page C'),
      ),
      body: Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            color: Colors.redAccent,
          ),
          Container(
//            margin: EdgeInsets.only(right: 100, top: 100),
            child: FFloat(
//          Text(
//          "这是一条提示",
//          style: TextStyle(
//              decoration: TextDecoration.none,
//              fontSize: 12,
//              color: Colors.white),
//        ),
              Column(
                children: <Widget>[
                  Text("data1"),
                  const SizedBox(height: 16),
                  Text("data2"),
                ],
              ),
              padding:
                  EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
              alignment: FFloatAlignment.topRight,
              triangleAlignment: TriangleAlignment.center,
              triangleWidth: 30,
              triangleHeight: 20,
              hideTriangle: true,
//              canTouchOutside: true,
//            autoDismissDuration: Duration(milliseconds: 2000),
//            triangleOffset: Offset(10, 0),
              corner: FFloatCorner(
                leftBottomCorner: 12,
                rightBottomCorner: 12,
                rightTopCorner: 12,
              ),
//            margin: EdgeInsets.only(right: 10, top: 10),
              strokeColor: Colors.black87,
//              strokeWidth: 1,
              location: Offset(100, 100),
              controller: controller,
              child: Text("OOO"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print('PageC - initState');
    Timer(Duration(milliseconds: 1000), () {
      controller.show();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('PageC - didChangeDependencies');
  }

  @override
  void didUpdateWidget(PageC oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('PageC - didUpdateWidget');
    Timer(Duration(milliseconds: 1000), () {
      controller.show();
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    print(
        'PageC - deactivate，isCurrent = ${ModalRoute.of(context).isCurrent}，isActive = ${ModalRoute.of(context).isActive}');
  }

  @override
  void dispose() {
    super.dispose();
    print('PageC - dispose');
  }
}
