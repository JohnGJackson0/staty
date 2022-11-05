import 'package:flutter_test/flutter_test.dart';

import 'package:staty/main.dart';
import 'package:staty/services/app_router.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(appRouter: AppRouter()));

  });
}
