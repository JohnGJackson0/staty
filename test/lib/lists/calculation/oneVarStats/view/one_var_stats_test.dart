// unit test one_var_stats_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:staty/lists/calculation/oneVarStats/view/one_var_stats.dart';
import 'package:staty/lists/management/model/data_point.dart';
import 'package:staty/lists/management/model/list_model.dart';

void main() {
  testWidgets('1-var stats shows message with empty list',
      (WidgetTester tester) async {
    var list = const ListModel(
        uid: 'test', name: 'test', data: [], lastEditedDate: '');

    await tester
        .pumpWidget(MaterialApp(home: Scaffold(body: OneVarStats(list: list))));

    Finder noDataFinder = find.text('Please select a list with items in it.');
    expect(noDataFinder, findsOneWidget);

    // this is incorrect
    // on empty data it does not show the list name
    Finder titleFinder = find.text('1-var-stats');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('1-var stats shows message with empty list',
      (WidgetTester tester) async {
    var list = const ListModel(
        uid: 'test', name: 'test', data: [], lastEditedDate: '');

    await tester
        .pumpWidget(MaterialApp(home: Scaffold(body: OneVarStats(list: list))));

    Finder noDataFinder = find.text('Please select a list with items in it.');
    expect(noDataFinder, findsOneWidget);

    Finder titleFinder = find.text('1-var-stats');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('1-var stats shows stats with filled list',
      (WidgetTester tester) async {
    var list = const ListModel(
        uid: 'test',
        name: 'test',
        data: [
          DataPoint(value: 3, id: '1'),
          DataPoint(value: 30, id: '2'),
          DataPoint(value: 34, id: '3'),
          DataPoint(value: 1, id: '4'),
          DataPoint(value: 13, id: '5'),
          DataPoint(value: 50, id: '6'),
          DataPoint(value: 43, id: '7'),
          DataPoint(value: 1, id: '8'),
          DataPoint(value: 13, id: '9'),
          DataPoint(value: 50, id: '10'),
          DataPoint(value: 43, id: '11'),
        ],
        lastEditedDate: '');

    await tester
        .pumpWidget(MaterialApp(home: Scaffold(body: OneVarStats(list: list))));

    Finder noDataFinder = find.text('Please select a list with items in it.');
    expect(noDataFinder, findsNothing);

    Finder listTitleFinder = find.text('test');
    expect(listTitleFinder, findsOneWidget);

    Finder statFinder = find.text('Mean x̄:');
    expect(statFinder, findsOneWidget);
  });

  test('1-var-stats', () {
    var list = const ListModel(
        uid: 'test',
        name: 'test',
        data: [
          DataPoint(value: 3, id: '1'),
          DataPoint(value: 30, id: '1'),
          DataPoint(value: 34, id: '1'),
          DataPoint(value: 1, id: '1'),
          DataPoint(value: 13, id: '1'),
          DataPoint(value: 50, id: '1'),
          DataPoint(value: 43, id: '1'),
          DataPoint(value: 1, id: '1'),
          DataPoint(value: 13, id: '1'),
          DataPoint(value: 50, id: '1'),
          DataPoint(value: 43, id: '1'),
        ],
        lastEditedDate: '');

    OneVarStats(list: list);
  });

  testWidgets('has correct calculations', (WidgetTester tester) async {
    var list = const ListModel(
        uid: 'test',
        name: 'test',
        data: [
          DataPoint(value: 3, id: '1'),
          DataPoint(value: 30, id: '2'),
          DataPoint(value: 34, id: '3'),
          DataPoint(value: 1, id: '4'),
          DataPoint(value: 13, id: '5'),
          DataPoint(value: 50, id: '6'),
          DataPoint(value: 43, id: '7'),
          DataPoint(value: 1, id: '8'),
          DataPoint(value: 13, id: '9'),
          DataPoint(value: 50, id: '10'),
          DataPoint(value: 43, id: '11'),
        ],
        lastEditedDate: '');

    await tester
        .pumpWidget(MaterialApp(home: Scaffold(body: OneVarStats(list: list))));

    Finder noDataFinder = find.text('Please select a list with items in it.');
    expect(noDataFinder, findsNothing);

    Finder meanFinder = find.text('25.545454545454547 \n');
    expect(meanFinder, findsOneWidget);

    Finder sumXFinder = find.text('281.0 \n');
    expect(sumXFinder, findsOneWidget);

    Finder sumSqrdFinder = find.text('11103.0 \n');
    expect(sumSqrdFinder, findsOneWidget);

    Finder smplStndDev = find.text('19.81092444265858 \n');
    expect(smplStndDev, findsOneWidget);

    Finder popStndDev = find.text('18.888975314446043 \n');
    expect(popStndDev, findsOneWidget);

    Finder nFinder = find.text('11 \n');
    expect(nFinder, findsOneWidget);

    Finder minXFinder = find.text('1.0 \n');
    expect(minXFinder, findsOneWidget);

    Finder q1Finder = find.text('3.0 \n');
    expect(q1Finder, findsOneWidget);

    Finder medFinder = find.text('30.0 \n');
    expect(medFinder, findsOneWidget);

    Finder q3Finder = find.text('43.0 \n');
    expect(q3Finder, findsOneWidget);

    Finder maxFinder = find.text('50.0 \n');
    expect(maxFinder, findsOneWidget);
  });
}
