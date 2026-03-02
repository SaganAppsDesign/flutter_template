// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/main.dart';
import 'package:myapp/core/di/injection_container.dart' as di;

void main() {
  setUp(() async {
    // Initialize dependency injection for the test environment
    await di.init();
  });

  testWidgets('Premium Template initial UI test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app bar has the correct title.
    expect(find.text('Premium Template'), findsOneWidget);

    // Verify that the initial placeholder exists.
    expect(find.text('Current Value'), findsOneWidget);
    expect(find.text('--'), findsOneWidget);

    // Verify the action button exists.
    expect(find.text('Generate Number'), findsOneWidget);
  });
}
