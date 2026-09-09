## 2.0.2

- Fix: the overlay entry is now released when the float is disposed. Previously a
  float that was visible while its page went away leaked into the root overlay and
  stayed on screen across navigation.
- Fix: `FFloatController` bindings are released on dispose, with an owner guard so a
  rebuild cannot be clobbered by the previous instance tearing down. `dismiss()` /
  `show()` no longer silently act on a dead instance.
- Remove leftover debug `print` calls from the position calculation.
- Replace the internal lint package in `dev_dependencies` with `flutter_lints`.

## 2.0.1
-  适配 3.7 运算

## 2.0.0
-  适配 3.7

## 1.0.2

- FFloatController adds setState function to support external partial refresh of FFloat content

```dart
controller.setState(() {
  // update your float ui
});
```

## 1.0.1

- Supports `alignment` configuration in absolute position mode

- Fix FFloatController status monitoring problem

## 1.0.0

- First version
