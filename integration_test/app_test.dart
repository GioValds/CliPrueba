import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:testing_demo/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App launches successfully', (WidgetTester tester) async {
    // Launch the app
    app.main();
    await tester.pumpAndSettle();

    // Verify that our app starts correctly
    expect(find.text('Number A'), findsOneWidget);
    expect(find.text('Number B'), findsOneWidget);
    expect(find.text('Result:'), findsOneWidget);
  });

  testWidgets('Calculator buttons are present', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Check that all calculator buttons are present
    expect(find.text('+'), findsOneWidget);
    expect(find.text('-'), findsOneWidget);
    expect(find.text('×'), findsOneWidget);
    expect(find.text('÷'), findsOneWidget);
  });
}
