import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ffloat/ffloat.dart';

Widget _host(Widget body) => MaterialApp(home: Scaffold(body: body));

void main() {
  group('show / dismiss basics', () {
    testWidgets('tapping the anchor shows the float content', (tester) async {
      await tester.pumpWidget(_host(FFloat(
        (setState) => const Text('float-content'),
        anchor: const Text('anchor'),
      )));
      await tester.pumpAndSettle();

      expect(find.text('float-content'), findsNothing,
          reason: 'before tapping, the float must not be visible');

      await tester.tap(find.text('anchor'));
      await tester.pumpAndSettle();

      expect(find.text('float-content'), findsOneWidget);
    });

    testWidgets('controller.show() shows without a tap', (tester) async {
      final controller = FFloatController();
      await tester.pumpWidget(_host(FFloat(
        (setState) => const Text('float-content'),
        anchor: const Text('anchor'),
        controller: controller,
      )));
      await tester.pumpAndSettle();

      expect(controller.isShow, isFalse);
      controller.show();
      await tester.pumpAndSettle();

      expect(controller.isShow, isTrue);
      expect(find.text('float-content'), findsOneWidget);
    });

    testWidgets('controller.dismiss() hides the float', (tester) async {
      final controller = FFloatController();
      await tester.pumpWidget(_host(FFloat(
        (setState) => const Text('float-content'),
        anchor: const Text('anchor'),
        controller: controller,
      )));
      await tester.pumpAndSettle();

      controller.show();
      await tester.pumpAndSettle();
      expect(find.text('float-content'), findsOneWidget);

      controller.dismiss();
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      expect(find.text('float-content'), findsNothing);
      expect(controller.isShow, isFalse);
    });

    testWidgets('show -> dismiss -> show round-trip', (tester) async {
      final controller = FFloatController();
      await tester.pumpWidget(_host(FFloat(
        (setState) => const Text('float-content'),
        anchor: const Text('anchor'),
        controller: controller,
      )));
      await tester.pumpAndSettle();

      controller.show();
      await tester.pumpAndSettle();
      expect(find.text('float-content'), findsOneWidget);

      controller.dismiss();
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
      expect(find.text('float-content'), findsNothing);

      controller.show();
      await tester.pumpAndSettle();
      expect(find.text('float-content'), findsOneWidget,
          reason: 'a second show after a dismiss must work');
    });
  });

  // The core of the 2.0.2 fix: _FFloat.dispose() now removes its OverlayEntry.
  // Before the fix dispose left the entry dangling, so the float stayed on
  // screen and was carried into subsequent pages — exactly issues #2 and #7.
  group('dispose removes the overlay entry (the 2.0.2 fix)', () {
    testWidgets('float is gone from the overlay after the widget is removed',
        (tester) async {
      await tester.pumpWidget(_host(FFloat(
        (setState) => const Text('float-content'),
        anchor: const Text('anchor'),
      )));
      await tester.pumpAndSettle();

      await tester.tap(find.text('anchor'));
      await tester.pumpAndSettle();
      expect(find.text('float-content'), findsOneWidget,
          reason: 'precondition: the float must be visible before disposal');

      // Replace FFloat with a plain widget. MaterialApp + Navigator + Overlay
      // are reused (same type at the same position), so the Overlay persists
      // across this swap. Only FFloat's State is torn down — which is exactly
      // when the fix must remove the lingering entry.
      await tester.pumpWidget(_host(const SizedBox()));
      await tester.pumpAndSettle();

      expect(find.text('float-content'), findsNothing,
          reason: 'the overlay entry must be removed when the widget is '
              'disposed, otherwise the float leaks onto the next screen');
    });

    testWidgets('REGRESSION: a controller outliving the widget is a no-op',
        (tester) async {
      final controller = FFloatController();
      await tester.pumpWidget(_host(FFloat(
        (setState) => const Text('float-content'),
        anchor: const Text('anchor'),
        controller: controller,
      )));
      await tester.pumpAndSettle();

      controller.show();
      await tester.pumpAndSettle();

      // Dispose the widget; the controller now points at a dead instance.
      await tester.pumpWidget(_host(const SizedBox()));
      await tester.pumpAndSettle();
      expect(find.text('float-content'), findsNothing);

      // Calling dismiss / show after disposal must not throw and must not
      // resurrect anything.
      controller.dismiss();
      await tester.pumpAndSettle();
      expect(find.text('float-content'), findsNothing);

      controller.show();
      await tester.pumpAndSettle();
      expect(find.text('float-content'), findsNothing,
          reason: 'a controller whose widget is gone cannot re-show; the '
              'overlay entry was removed on dispose');
    });

    testWidgets('rebuild keeps the controller binding alive', (tester) async {
      final controller = FFloatController();
      int value = 0;

      Widget tree() => _host(FFloat(
            (setState) => Text('float-$value'),
            anchor: const Text('anchor'),
            controller: controller,
          ));

      await tester.pumpWidget(tree());
      await tester.pumpAndSettle();

      controller.show();
      await tester.pumpAndSettle();
      expect(find.text('float-0'), findsOneWidget,
          reason: 'precondition: the float must be visible before rebuild');

      // Rebuild with new builder content; didUpdateWidget must keep the
      // binding working so a subsequent dismiss lands.
      value = 1;
      await tester.pumpWidget(tree());
      await tester.pumpAndSettle();

      controller.dismiss();
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
      expect(find.text('float-1'), findsNothing,
          reason: 'after a rebuild the controller must still drive dismissal');
    });
  });

  group('autoDismiss', () {
    testWidgets('float hides itself after the duration', (tester) async {
      await tester.pumpWidget(_host(FFloat(
        (setState) => const Text('float-content'),
        anchor: const Text('anchor'),
        autoDismissDuration: const Duration(seconds: 1),
      )));
      await tester.pumpAndSettle();

      await tester.tap(find.text('anchor'));
      await tester.pumpAndSettle();
      expect(find.text('float-content'), findsOneWidget,
          reason: 'precondition: the float must be visible before the timer');

      // Well before the 1s timer fires.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('float-content'), findsOneWidget,
          reason: 'the float must still be visible before autoDismiss fires');

      // Past the 1s autoDismiss window.
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();
      expect(find.text('float-content'), findsNothing);
    });
  });

  group('canTouchOutside', () {
    testWidgets('tapping outside the float dismisses it when enabled',
        (tester) async {
      await tester.pumpWidget(_host(FFloat(
        (setState) => const SizedBox(
          width: 80,
          height: 40,
          child: Center(child: Text('float-content')),
        ),
        anchor: const Text('anchor'),
        canTouchOutside: true,
      )));
      await tester.pumpAndSettle();

      await tester.tap(find.text('anchor'));
      await tester.pumpAndSettle();
      expect(find.text('float-content'), findsOneWidget);

      // Tap at the top-left corner — well outside the float content.
      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
      expect(find.text('float-content'), findsNothing,
          reason: 'canTouchOutside=true must dismiss on an outside tap');
    });
  });
}
