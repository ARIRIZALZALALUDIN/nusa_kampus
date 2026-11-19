import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_kampus/app.dart';
import 'package:nusa_kampus/config/dependencies.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('NusaKampusApp builds without error', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: providers,
        child: const NusaKampusApp(),
      ),
    );

    // Selesaikan Future.delayed / animasi awal jika ada
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.byType(NusaKampusApp), findsOneWidget);
  });
}