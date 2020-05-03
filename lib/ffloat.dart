import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

enum TriangleAlignment {
  start,
  center,
  end,
}

enum FFloatAlignment {
  topLeft,
  topCenter,
  topRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
  leftTop,
  leftCenter,
  leftBottom,
  rightTop,
  rightCenter,
  rightBottom,
}

class FFloat extends StatefulWidget {
  final double triangleWidth;
  final double triangleHeight;
  final TriangleAlignment triangleAlignment;
  final Offset triangleOffset;
  final Color color;
  final Widget child;
  final Offset location;
  FFloatAlignment alignment;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color strokeColor;
  final double strokeWidth;
  final FFloatCorner corner;
  final FFloatCornerStyle cornerStyle;
  final Widget float;
  final bool canTouchOutside;
  final Color backgroundColor;
  final bool hideTriangle;
  final Duration autoDismissDuration;
  final FFloatController controller;

  FFloat(
    this.float, {
    this.child,
    this.location,
    this.margin = EdgeInsets.zero,
    this.triangleWidth = 12,
    this.triangleHeight = 6,
    this.triangleAlignment = TriangleAlignment.center,
    this.triangleOffset = Offset.zero,
    this.alignment = FFloatAlignment.topCenter,
    this.padding,
    this.color = _FFloatContent.DefaultColor,
    this.strokeColor,
    this.strokeWidth,
    this.corner,
    this.cornerStyle = FFloatCornerStyle.round,
    this.backgroundColor = Colors.transparent,
    this.canTouchOutside = true,
    this.hideTriangle = false,
    this.autoDismissDuration,
    this.controller,
  });

  @override
  _FFloatState createState() => _FFloatState();
}

class _FFloatState extends State<FFloat> {
  GlobalKey key = GlobalKey();
  Offset childLocation;
  Size childSize;

  OverlayEntry _overlayEntry;
  bool _isShow = false;

  bool get isShow => _isShow;

  set isShow(bool value) {
    if (_isShow == value) return;
    _isShow = value;
    if (widget.controller != null) {
      widget.controller.isShow = value;
    }
  }

  Timer dismissTimer;

  _FTipContentController ffloatContentController;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller._state = this;
    }
    ffloatContentController = new _FTipContentController();
    if (widget.location == null) {
      postUpdateCallback();
    }
  }

  void postUpdateCallback() {
    WidgetsBinding.instance.addPostFrameCallback((time) {
      if (!mounted) return;
      RenderBox box = key.currentContext.findRenderObject();
      Offset location = box?.localToGlobal(Offset.zero);
      Size size = box?.size;
      bool needUpdate = false;
      if (location != null && location != childLocation) {
        needUpdate = true;
        childLocation = location;
      }
      if (size != null && size != childSize) {
        needUpdate = true;
        childSize = size;
      }
      if (ffloatContentController != null && needUpdate && isShow) {
        ffloatContentController.update(childSize, childLocation);
      }
      postUpdateCallback();
    });
  }

  @override
  void dispose() {
//    print("dispose");
    if (widget.controller != null) {
      widget.controller.dispose();
    }
    if (ffloatContentController != null) {
      ffloatContentController.dispose();
    }
    dismiss();
    super.dispose();
  }

  @override
  void didUpdateWidget(FFloat oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != null) {
      widget.controller._state = this;
    }
    if (isShow) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _showTip();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.location != null) {
      return Container();
    } else {
      return LayoutBuilder(
        key: key,
        builder: (context, _) {
          return GestureDetector(
            onTap: showTip,
            child: widget.child,
          );
        },
      );
    }
  }

  void showTip() {
    /// 防止重复显示
    if (isShow) return;
    isShow = true;
    _showTip();
  }

  void rebuildShowTip() {
    isShow = true;
    _showTip();
  }

  void _showTip() {
    if (_overlayEntry != null) {
      _overlayEntry.remove();
    }
    OverlayState overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(builder: (BuildContext context) {
      Widget tipContent = _FFloatContent(
        (widget.location != null ? widget.location : childLocation) ??
            Offset.zero,
        widget.float,
        anchorSize: childSize ?? Size.zero,
        alignment: widget.location != null
            ? FFloatAlignment.bottomLeft
            : widget.alignment,
        triangleWidth: widget.triangleWidth,
        triangleHeight: widget.triangleHeight,
        triangleOffset: widget.triangleOffset,
        triangleAlignment: widget.triangleAlignment,
        margin: widget.margin,
        padding: widget.padding,
        color: widget.color,
        strokeColor: widget.strokeColor,
        strokeWidth: widget.strokeWidth,
        corner: widget.corner,
        cornerStyle: widget.cornerStyle,
        backgroundColor: widget.backgroundColor,
        onTouchBackground: widget.canTouchOutside ? dismiss : null,
        hideTriangle: widget.hideTriangle,
        controller: ffloatContentController,
      );
      return tipContent;
    });
    overlayState.insert(_overlayEntry);
    if (widget.autoDismissDuration != null && dismissTimer == null) {
      dismissTimer = Timer(widget.autoDismissDuration, () {
        if (_overlayEntry != null) {
          dismissTimer = null;
          dismiss();
        }
      });
    }
  }

  void dismiss() {
    isShow = false;
    if (dismissTimer != null && dismissTimer.isActive) {
      dismissTimer.cancel();
      dismissTimer = null;
    }
    if (_overlayEntry != null) {
      _overlayEntry.remove();
      _overlayEntry = null;
    }
  }
}

class _FFloatContent extends StatefulWidget {
  static const Color DefaultColor = Color(0x7F000000);

  Size anchorSize;
  Offset location;
  Widget child;
  double triangleWidth;
  double triangleHeight;
  TriangleAlignment triangleAlignment;
  Offset triangleOffset;
  Color color;
  FFloatAlignment alignment;
  EdgeInsets margin;
  EdgeInsets padding;
  Color strokeColor;
  double strokeWidth;
  FFloatCorner corner;
  FFloatCornerStyle cornerStyle;
  Color backgroundColor;
  VoidCallback onTouchBackground;
  bool hideTriangle;
  _FTipContentController controller;

  _FFloatContent(
    this.location,
    this.child, {
    this.anchorSize = Size.zero,
    this.triangleWidth = 12,
    this.triangleHeight = 6,
    this.triangleAlignment = TriangleAlignment.center,
    this.triangleOffset = Offset.zero,
    this.alignment = FFloatAlignment.topCenter,
    this.margin = EdgeInsets.zero,
    this.padding,
    this.color = DefaultColor,
    this.strokeColor,
    this.strokeWidth = 0.0,
    this.corner,
    this.cornerStyle = FFloatCornerStyle.round,
    this.backgroundColor = Colors.transparent,
    this.onTouchBackground,
    this.hideTriangle = false,
    this.controller,
  });

  @override
  _FFloatContentState createState() => _FFloatContentState();
}

class _FFloatContentState extends State<_FFloatContent> {
  GlobalKey key = GlobalKey();
  Size areaSize;
  Offset location;
  Size anchorSize;

  @override
  void initState() {
    super.initState();
    location = widget.location;
    anchorSize = widget.anchorSize;
    if (widget.controller != null) {
      widget.controller.state = this;
    }
    postUpdateCallback();
  }

  void postUpdateCallback() {
    WidgetsBinding.instance.addPostFrameCallback((time) {
      if (!mounted) return;
      RenderBox box = key.currentContext?.findRenderObject();
      Size size = box?.size;
      if (size != null && areaSize != size) {
        areaSize = size;
        setState(() {});
      }
    });
  }

  @override
  void didUpdateWidget(_FFloatContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    location = widget.location;
    anchorSize = widget.anchorSize;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hideTriangle) {
      widget.triangleWidth = 0;
      widget.triangleHeight = 0;
    }
    List<Widget> children = [];
    Widget background = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: widget.backgroundColor,
    );
    if (widget.onTouchBackground != null) {
      background = GestureDetector(
        onTap: widget.onTouchBackground,
        child: background,
      );
    } else {
      background = IgnorePointer(
        child: background,
      );
    }
    children.add(background);
    children.add(buildFloatContent());
    return Stack(
      overflow: Overflow.visible,
      children: children,
    );
  }

  Widget buildFloatContent() {
    List<Widget> children = [];
    Color color = widget.color ?? _FFloatContent.DefaultColor;
    BorderRadius borderRadius = widget.corner == null
        ? BorderRadius.all(Radius.circular(0))
        : BorderRadius.only(
            topLeft: Radius.circular(widget.corner.leftTopCorner),
            topRight: Radius.circular(widget.corner.rightTopCorner),
            bottomRight: Radius.circular(widget.corner.rightBottomCorner),
            bottomLeft: Radius.circular(widget.corner.leftBottomCorner),
          );
    var sideColor = widget.strokeColor ?? Colors.transparent;
    var borderSide = BorderSide(
      width: widget.strokeWidth ?? 0,
      color: sideColor,
      style: BorderStyle.solid,
    );
    var shape = widget.cornerStyle == FFloatCornerStyle.round
        ? RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: borderSide,
          )
        : BeveledRectangleBorder(
            borderRadius: borderRadius,
            side: borderSide,
          );
    var decoration = ShapeDecoration(color: color, shape: shape);
    Widget content = Container(
      decoration: decoration,
      padding: widget.padding,
      key: key,
      child: widget.child,
    );
    children.add(content);
    if (areaSize != null) {
      double rotate = calculateTriangleRotate();
      EdgeInsets triangleOffset = calculateTriangleOffset();
      Widget triangle = Positioned(
        left: triangleOffset.left == 0 ? null : triangleOffset.left,
        top: triangleOffset.top == 0 ? null : triangleOffset.top,
        right: triangleOffset.right == 0 ? null : triangleOffset.right,
        bottom: triangleOffset.bottom == 0 ? null : triangleOffset.bottom,
        child: Transform.rotate(
          angle: rotate,
          child: CustomPaint(
            size: Size(widget.triangleWidth, widget.triangleHeight),
            painter: _TrianglePainter(
              color: color,
              strokeColor: widget.strokeColor,
              strokeWidth: widget.strokeWidth,
            ),
          ),
        ),
      );
      children.add(triangle);
    }
    Offset areaOffset = calculateAreaOffset();
    Widget floatContent = Positioned(
      left: location.dx + areaOffset.dx,
      top: location.dy + areaOffset.dy,
      child: Offstage(
        offstage: areaSize == null,
        child: Material(
          color: Colors.transparent,
          child: Stack(
            overflow: Overflow.visible,
            children: children,
          ),
        ),
      ),
    );
    return floatContent;
  }

  Offset calculateAreaOffset() {
    if (areaSize == null) return Offset.zero;
    Offset offset = Offset(
      widget.margin.left - widget.margin.right,
      widget.margin.top - widget.margin.bottom,
    );
    switch (widget.alignment) {
      case FFloatAlignment.topLeft:
        return Offset(
              0,
              -areaSize.height - widget.triangleHeight,
            ) +
            offset;
      case FFloatAlignment.topCenter:
        return Offset(
              anchorSize.width / 2.0 - areaSize.width / 2.0,
              -areaSize.height - widget.triangleHeight,
            ) +
            offset;
      case FFloatAlignment.topRight:
        return Offset(
              anchorSize.width - areaSize.width,
              -areaSize.height - widget.triangleHeight,
            ) +
            offset;
      case FFloatAlignment.bottomLeft:
        return Offset(
              0,
              anchorSize.height + widget.triangleHeight,
            ) +
            offset;
      case FFloatAlignment.bottomCenter:
        return Offset(
              anchorSize.width / 2.0 - areaSize.width / 2.0,
              anchorSize.height + widget.triangleHeight,
            ) +
            offset;

      case FFloatAlignment.bottomRight:
        return Offset(
              anchorSize.width - areaSize.width,
              anchorSize.height + widget.triangleHeight,
            ) +
            offset;

      case FFloatAlignment.leftTop:
        return Offset(
              -areaSize.width - widget.triangleHeight,
              0,
            ) +
            offset;

      case FFloatAlignment.leftCenter:
        return Offset(
              -areaSize.width - widget.triangleHeight,
              anchorSize.height / 2.0 - areaSize.height / 2.0,
            ) +
            offset;

      case FFloatAlignment.leftBottom:
        return Offset(
              -areaSize.width - widget.triangleHeight,
              anchorSize.height - areaSize.height,
            ) +
            offset;

      case FFloatAlignment.rightTop:
        return Offset(
              anchorSize.width + widget.triangleHeight,
              0,
            ) +
            offset;

      case FFloatAlignment.rightCenter:
        return Offset(
              anchorSize.width + widget.triangleHeight,
              anchorSize.height / 2.0 - areaSize.height / 2.0,
            ) +
            offset;

      case FFloatAlignment.rightBottom:
        return Offset(
              anchorSize.width + widget.triangleHeight,
              anchorSize.height - areaSize.height,
            ) +
            offset;
    }
  }

  double calculateTriangleRotate() {
    switch (widget.alignment) {
      case FFloatAlignment.topLeft:
      case FFloatAlignment.topCenter:
      case FFloatAlignment.topRight:
        return pi;
      case FFloatAlignment.bottomLeft:
      case FFloatAlignment.bottomCenter:
      case FFloatAlignment.bottomRight:
        return 0.0;
      case FFloatAlignment.leftTop:
      case FFloatAlignment.leftCenter:
      case FFloatAlignment.leftBottom:
        return pi / 2.0;
      case FFloatAlignment.rightTop:
      case FFloatAlignment.rightCenter:
      case FFloatAlignment.rightBottom:
        return -pi / 2.0;
    }
  }

  EdgeInsets calculateTriangleOffset() {
    Offset srcOffset = widget.triangleOffset;
    EdgeInsets offset = EdgeInsets.zero;

    /// 三角和内容区域会有一点间距，可能是由于计算精度和绘制像素精度有差异造成的
    double fixOffset = 0.13 + (widget.strokeWidth ?? 0.0) / 2.0;
    switch (widget.alignment) {
      case FFloatAlignment.topLeft:
      case FFloatAlignment.topCenter:
      case FFloatAlignment.topRight:
        double bottom = -widget.triangleHeight + fixOffset;
        switch (widget.triangleAlignment) {
          case TriangleAlignment.start:
            offset = EdgeInsets.only(
              left: srcOffset.dx,
              bottom: bottom,
            );
            break;
          case TriangleAlignment.center:
            offset = EdgeInsets.only(
              left: srcOffset.dx +
                  areaSize.width / 2.0 -
                  widget.triangleWidth / 2,
              bottom: bottom,
            );
            break;
          case TriangleAlignment.end:
            offset = EdgeInsets.only(
              left: srcOffset.dx + areaSize.width - widget.triangleWidth,
              bottom: bottom,
            );
            break;
        }
        break;
      case FFloatAlignment.bottomLeft:
      case FFloatAlignment.bottomCenter:
      case FFloatAlignment.bottomRight:
        double top = -widget.triangleHeight + fixOffset;
        switch (widget.triangleAlignment) {
          case TriangleAlignment.start:
            offset = EdgeInsets.only(
              left: srcOffset.dx,
              top: top,
            );
            break;
          case TriangleAlignment.center:
            offset = EdgeInsets.only(
              left: srcOffset.dx +
                  areaSize.width / 2.0 -
                  widget.triangleWidth / 2,
              top: top,
            );
            break;
          case TriangleAlignment.end:
            offset = EdgeInsets.only(
              left: srcOffset.dx + areaSize.width - widget.triangleWidth,
              top: top,
            );
            break;
        }
        break;
      case FFloatAlignment.leftTop:
      case FFloatAlignment.leftCenter:
      case FFloatAlignment.leftBottom:
        double startTop = srcOffset.dy +
            -widget.triangleHeight / 2.0 +
            widget.triangleWidth / 2.0;
        double right = -widget.triangleWidth / 2.0 -
            widget.triangleHeight / 2.0 +
            fixOffset;
        switch (widget.triangleAlignment) {
          case TriangleAlignment.start:
            offset = EdgeInsets.only(
              right: right,
              top: startTop,
            );
            break;
          case TriangleAlignment.center:
            offset = EdgeInsets.only(
              right: right,
              top:
                  startTop + areaSize.height / 2.0 - widget.triangleWidth / 2.0,
            );
            break;
          case TriangleAlignment.end:
            offset = EdgeInsets.only(
              right: right,
              top: startTop + areaSize.height - widget.triangleWidth,
            );
            break;
        }
        break;
      case FFloatAlignment.rightTop:
      case FFloatAlignment.rightCenter:
      case FFloatAlignment.rightBottom:
        double startTop = srcOffset.dy +
            -widget.triangleHeight / 2.0 +
            widget.triangleWidth / 2.0;
        double left = -widget.triangleWidth / 2.0 -
            widget.triangleHeight / 2.0 +
            fixOffset;
        switch (widget.triangleAlignment) {
          case TriangleAlignment.start:
            offset = EdgeInsets.only(
              left: left,
              top: startTop,
            );
            break;
          case TriangleAlignment.center:
            offset = EdgeInsets.only(
              left: left,
              top:
                  startTop + areaSize.height / 2.0 - widget.triangleWidth / 2.0,
            );
            break;
          case TriangleAlignment.end:
            offset = EdgeInsets.only(
              left: left,
              top: startTop + areaSize.height - widget.triangleWidth,
            );
            break;
        }
        break;
    }
    return offset;
  }
}

class _FTipContentController {
  _FFloatContentState state;

  update(Size anchorSize, Offset location) {
    if (state != null && state.mounted) {
      state.setState(() {
        state.anchorSize = anchorSize;
        state.location = location;
      });
    }
  }

  dispose() {
    state = null;
  }
}

/// 圆角。
///
/// corner
class FFloatCorner {
  final double leftTopCorner;
  final double rightTopCorner;
  final double rightBottomCorner;
  final double leftBottomCorner;

  /// 指定每一个圆角的大小
  ///
  /// Specify the size of each rounded corner
  const FFloatCorner({
    this.leftTopCorner = 0,
    this.rightTopCorner = 0,
    this.rightBottomCorner = 0,
    this.leftBottomCorner = 0,
  });

  /// 设置所有圆角为一个大小
  ///
  /// Set all rounded corners to one size
  FFloatCorner.all(double radius)
      : leftTopCorner = radius,
        rightTopCorner = radius,
        rightBottomCorner = radius,
        leftBottomCorner = radius;
}

/// 圆角风格。
/// [round] - 圆角
/// [bevel] - 斜角
///
/// Rounded corner style.
/// [round]-rounded corners
/// [bevel]-beveled corners
enum FFloatCornerStyle {
  round,
  bevel,
}

class FFloatController {
  VoidCallback _callback;

  bool _isShow = false;

  bool get isShow => _isShow;

  set isShow(bool value) {
    if (_isShow == value) return;
    _isShow = value;
    if (_callback != null) {
      _callback();
    }
  }

  _FFloatState _state;

  void dismiss() {
    if (_state != null && _state.mounted) {
      _state.dismiss();
    }
  }

  void show() {
    if (_state != null && _state.mounted) {
      _state.showTip();
    }
  }

  void rebuildShow() {
    if (_state != null && _state.mounted) {
      _state.rebuildShowTip();
    }
  }

  dispose() {
    _state = null;
    _callback = null;
  }

  setStateChangedListener(VoidCallback listener) {
    _callback = listener;
  }
}

class _TrianglePainter extends CustomPainter {
  Color color;
  double strokeWidth;
  Color strokeColor;

  _TrianglePainter({
    this.color = _FFloatContent.DefaultColor,
    this.strokeWidth = 0,
    this.strokeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..isAntiAlias = true
      ..color = color
      ..strokeWidth = strokeWidth ?? 0
      ..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
    if (strokeColor != null && strokeWidth != null && strokeWidth > 0) {
      paint
        ..color = strokeColor
        ..style = PaintingStyle.stroke;
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_TrianglePainter oldDelegate) {
    return true;
  }
}
