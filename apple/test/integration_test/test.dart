import 'package:flutter_driver/driver_extension.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test/integration_test_driver.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:apple/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('group', () {
    testWidgets('main page', (widgetTester) async {
      app.main();
      await widgetTester.pumpAndSettle();
      expect(find.text('Todo 一覧'), findsOneWidget);
    });
  });
}
