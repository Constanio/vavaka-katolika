import 'package:flutter_test/flutter_test.dart';
import 'package:vavaka/main.dart';

void main() {
  testWidgets('Vavaka app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const VavakaApp());
    expect(find.text('Vavaka Katolika'), findsOneWidget);
  });
}