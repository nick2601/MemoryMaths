/// Widget testing file for the Memory Math application.
/// Contains test cases to verify the functionality of widgets and their interactions.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mathsgames/main.dart';
import 'package:mathsgames/src/ui/app/app.dart';

/// Main test function containing widget tests for the application.
void main() {
  /// Test case to verify if the main App widget is being rendered
  testWidgets('App screen smoke test', (WidgetTester tester) async {
    // Initialize the app widget for testing
    await tester.pumpWidget(const MyApp());

    // Verify if the MyApp widget is present in the widget tree
    expect(find.byType(MyApp), findsOneWidget);
  });
}
