import 'package:flutter_test/flutter_test.dart';
import 'package:kharcha_pani/main.dart';

void main() {
  testWidgets('App loads and shows balance', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const KharchaPaniApp());

    // Verify that our title text is present.
    expect(find.text('Total Balance'), findsOneWidget);
  });
}
