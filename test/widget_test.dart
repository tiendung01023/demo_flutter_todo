// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:demo_flutter_todo/dependencies/app_dependencies.dart';
import 'package:demo_flutter_todo/pages/to_do/to_do_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:demo_flutter_todo/main.dart';

Future<void> main() async {
  await AppDependencies.setup();

  testWidgets(
    'Unit test widget',
    (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      
      // Start with 0 item
      expect(
        find.byElementPredicate((element) => element is ToDoItemWidget),
        findsNothing,
      );
      await tester.pumpAndSettle();

      // Add 5 items
      for (var i = 0; i < 5; i++) {
        String title = "Item $i";
        await _addItemIntoList(tester, title: title);
      }

      // Check has 5 item in list
      expect(find.byType(ToDoItemWidget), findsNWidgets(5));

      // Click to checkbox
      await _clickCheckboxByTitle(tester, title: "Item 0");
      await _clickCheckboxByTitle(tester, title: "Item 3");

      // Change to tab Complete
      // Check list has 2 items
      await tester.tap(find.text("Complete"));
      await tester.pumpAndSettle();
      expect(find.byType(ToDoItemWidget), findsNWidgets(2));
      await tester.pumpAndSettle(Duration(seconds: 1));

      // Change to tab Incomplete
      // Check list has 3 items
      await tester.tap(find.text("Incomplete"));
      await tester.pumpAndSettle();
      expect(find.byType(ToDoItemWidget), findsNWidgets(3));
      await tester.pumpAndSettle(Duration(seconds: 1));

      // Delete 1 item
      // Check list has 2 items
      await _clickDeleteByTitle(tester, title: "Item 1");
      expect(find.byType(ToDoItemWidget), findsNWidgets(2));
      await tester.pumpAndSettle(Duration(seconds: 1));

      // Change to tab All
      await tester.tap(find.text("All"));
      await tester.pumpAndSettle();
      expect(find.byType(ToDoItemWidget), findsNWidgets(4));
      await tester.pumpAndSettle(Duration(seconds: 1));

      // Change item title
      await _editItemIntoList(tester, title: "Item 3", newTitle: "Item 3a");
      expect(find.text("Item 3a"), findsOneWidget);

      // Pause for watch
      await tester.pumpAndSettle(Duration(seconds: 3));
    },
  );
}

Future<void> _addItemIntoList(WidgetTester tester,
    {required String title}) async {
  await tester.tap(find.byIcon(Icons.add));
  await tester.pumpAndSettle();

  // Enter to do
  await tester.enterText(
    find.byType(CupertinoTextField),
    title,
  );

  // Press OK
  await tester.tap(find.text("OK"));
  await tester.pumpAndSettle();
}

Future<void> _editItemIntoList(WidgetTester tester,
    {required String title, required String newTitle}) async {
  await _clickByTitle(tester, title: title);

  // Enter to do
  await tester.enterText(
    find.byType(CupertinoTextField),
    newTitle,
  );

  // Press OK
  await tester.tap(find.text("OK"));
  await tester.pumpAndSettle();
}

/// Click to checkbox of item by title
Future<void> _clickCheckboxByTitle(WidgetTester tester,
    {required String title}) async {
  final item = find.descendant(
    of: find.byType(ToDoItemWidget),
    matching: find.text(title),
  );

  final itemParent = find.ancestor(
    of: item,
    matching: find.byType(ToDoItemWidget),
  );

  final itemCheckBox = find.descendant(
    of: itemParent,
    matching: find.byType(Checkbox),
  );

  await tester.tap(itemCheckBox);
  await tester.pumpAndSettle();
}

/// Click to delete of item by title
Future<void> _clickDeleteByTitle(WidgetTester tester,
    {required String title}) async {
  final item = find.descendant(
    of: find.byType(ToDoItemWidget),
    matching: find.text(title),
  );

  final itemParent = find.ancestor(
    of: item,
    matching: find.byType(ToDoItemWidget),
  );

  final itemDelete = find.descendant(
    of: itemParent,
    matching: find.byIcon(Icons.cancel_outlined),
  );

  await tester.tap(itemDelete);
  await tester.pumpAndSettle();
}

/// Click to item by title
Future<void> _clickByTitle(WidgetTester tester, {required String title}) async {
  final item = find.descendant(
    of: find.byType(ToDoItemWidget),
    matching: find.text(title),
  );

  final itemParent = find.ancestor(
    of: item,
    matching: find.byType(ToDoItemWidget),
  );

  await tester.tap(itemParent);
  await tester.pumpAndSettle();
}
