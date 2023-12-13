import 'package:date_picker_plus/src/date/days_picker.dart';
import 'package:date_picker_plus/src/shared/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DaysPicker', () {
    testWidgets('should show the correct leading header date',
        (WidgetTester tester) async {
      final DateTime initialDate = DateTime(2022, 6, 1);
      final DateTime minDate = DateTime(2022, 1, 1);
      final DateTime maxDate = DateTime(2022, 12, 31);

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: DaysPicker(
              currentDate: initialDate,
              initialDate: initialDate,
              minDate: minDate,
              maxDate: maxDate,
              todayTextStyle: const TextStyle(),
              daysNameTextStyle: const TextStyle(),
              enabledDaysTextStyle: const TextStyle(),
              selectedDayTextStyle: const TextStyle(),
              disbaledDaysTextStyle: const TextStyle(),
              todayDecoration: const BoxDecoration(),
              enabledDaysDecoration: const BoxDecoration(),
              selectedDayDecoration: const BoxDecoration(),
              disbaledDaysDecoration: const BoxDecoration(),
              leadingDateTextStyle: const TextStyle(),
              slidersColor: Colors.black,
              slidersSize: 20,
              splashColor: Colors.black,
              highlightColor: Colors.black,
            ),
          ),
        ),
      );

      final Finder headerFinder = find.byType(Header);
      expect(headerFinder, findsOneWidget);

      final Text headerTextWidget = tester.widget<Text>(
          find.descendant(of: headerFinder, matching: find.byType(Text)));
      expect(
          headerTextWidget.data,
          MaterialLocalizations.of(tester.element(headerFinder))
              .formatMonthYear(initialDate));
    });

    testWidgets('should change the page forward and backward on drag.',
        (WidgetTester tester) async {
      final DateTime initialDate = DateTime(2020, 6, 1);
      final DateTime minDate = DateTime(2000, 1, 1);
      final DateTime maxDate = DateTime(2030, 12, 31);

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: DaysPicker(
              currentDate: initialDate,
              initialDate: initialDate,
              minDate: minDate,
              maxDate: maxDate,
              todayTextStyle: const TextStyle(),
              daysNameTextStyle: const TextStyle(),
              enabledDaysTextStyle: const TextStyle(),
              selectedDayTextStyle: const TextStyle(),
              disbaledDaysTextStyle: const TextStyle(),
              todayDecoration: const BoxDecoration(),
              enabledDaysDecoration: const BoxDecoration(),
              selectedDayDecoration: const BoxDecoration(),
              disbaledDaysDecoration: const BoxDecoration(),
              leadingDateTextStyle: const TextStyle(),
              slidersColor: Colors.black,
              slidersSize: 20,
              splashColor: Colors.black,
              highlightColor: Colors.black,
            ),
          ),
        ),
      );

      final Finder pageViewFinder = find.byType(PageView);
      expect(pageViewFinder, findsOneWidget);

      final DateTime newDisplayedMonth = DateTime(2020, 7, 1);

      await tester.drag(
          pageViewFinder, const Offset(-600, 0)); // Drag the page forward
      await tester.pumpAndSettle();

      final Finder headerFinder = find.byType(Header);
      final Text headerTextWidget = tester.widget<Text>(
          find.descendant(of: headerFinder, matching: find.byType(Text)));
      expect(
          headerTextWidget.data,
          MaterialLocalizations.of(tester.element(headerFinder))
              .formatMonthYear(newDisplayedMonth));

      await tester.drag(
          pageViewFinder, const Offset(600, 0)); // Drag the page backward
      await tester.pumpAndSettle();

      final Finder newHeaderFinder = find.byType(Header);
      final Text newHeaderTextWidget = tester.widget<Text>(
          find.descendant(of: newHeaderFinder, matching: find.byType(Text)));
      expect(
          newHeaderTextWidget.data,
          MaterialLocalizations.of(tester.element(newHeaderFinder))
              .formatMonthYear(initialDate));
    });

    testWidgets(
        'should change the page when tapping on the next page icon and update header.',
        (WidgetTester tester) async {
      final DateTime initialDate = DateTime(2022, 6, 1);
      final DateTime minDate = DateTime(2022, 1, 1);
      final DateTime maxDate = DateTime(2022, 12, 31);

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: DaysPicker(
              currentDate: initialDate,
              initialDate: initialDate,
              minDate: minDate,
              maxDate: maxDate,
              todayTextStyle: const TextStyle(),
              daysNameTextStyle: const TextStyle(),
              enabledDaysTextStyle: const TextStyle(),
              selectedDayTextStyle: const TextStyle(),
              disbaledDaysTextStyle: const TextStyle(),
              todayDecoration: const BoxDecoration(),
              enabledDaysDecoration: const BoxDecoration(),
              selectedDayDecoration: const BoxDecoration(),
              disbaledDaysDecoration: const BoxDecoration(),
              leadingDateTextStyle: const TextStyle(),
              slidersColor: Colors.black,
              slidersSize: 20,
              splashColor: Colors.black,
              highlightColor: Colors.black,
            ),
          ),
        ),
      );

      final Finder pageViewFinder = find.byType(PageView);
      expect(pageViewFinder, findsOneWidget);

      final int initialPage =
          tester.widget<PageView>(pageViewFinder).controller.initialPage;

      final Finder nextPageIconFinder =
          find.byIcon(CupertinoIcons.chevron_right);
      expect(nextPageIconFinder, findsOneWidget);

      final Finder headerFinder = find.byType(Header);
      final Text headerTextWidget = tester.widget<Text>(
          find.descendant(of: headerFinder, matching: find.byType(Text)));
      expect(
          headerTextWidget.data,
          MaterialLocalizations.of(tester.element(headerFinder))
              .formatMonthYear(initialDate));

      await tester.tap(nextPageIconFinder);
      await tester.pumpAndSettle();

      final int currentPage =
          tester.widget<PageView>(pageViewFinder).controller.page!.round();

      expect(currentPage, equals(initialPage + 1));

      final DateTime newDisplayedMonth = DateTime(2022, 7, 1);

      final Finder newHeaderFinder = find.byType(Header);
      final Text newHeaderTextWidget = tester.widget<Text>(
          find.descendant(of: newHeaderFinder, matching: find.byType(Text)));
      expect(
          newHeaderTextWidget.data,
          MaterialLocalizations.of(tester.element(newHeaderFinder))
              .formatMonthYear(newDisplayedMonth));
    });

    testWidgets(
        'should change the page when tapping on the previous page icon and update header.',
        (WidgetTester tester) async {
      final DateTime initialDate = DateTime(2022, 6, 1);
      final DateTime minDate = DateTime(2022, 1, 1);
      final DateTime maxDate = DateTime(2022, 12, 31);

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: DaysPicker(
              currentDate: initialDate,
              initialDate: initialDate,
              minDate: minDate,
              maxDate: maxDate,
              todayTextStyle: const TextStyle(),
              daysNameTextStyle: const TextStyle(),
              enabledDaysTextStyle: const TextStyle(),
              selectedDayTextStyle: const TextStyle(),
              disbaledDaysTextStyle: const TextStyle(),
              todayDecoration: const BoxDecoration(),
              enabledDaysDecoration: const BoxDecoration(),
              selectedDayDecoration: const BoxDecoration(),
              disbaledDaysDecoration: const BoxDecoration(),
              leadingDateTextStyle: const TextStyle(),
              slidersColor: Colors.black,
              slidersSize: 20,
              splashColor: Colors.black,
              highlightColor: Colors.black,
            ),
          ),
        ),
      );

      final Finder pageViewFinder = find.byType(PageView);
      expect(pageViewFinder, findsOneWidget);

      final int initialPage =
          tester.widget<PageView>(pageViewFinder).controller.initialPage;

      final Finder previousPageIconFinder =
          find.byIcon(CupertinoIcons.chevron_left);
      expect(previousPageIconFinder, findsOneWidget);

      final Finder headerFinder = find.byType(Header);
      final Text headerTextWidget = tester.widget<Text>(
          find.descendant(of: headerFinder, matching: find.byType(Text)));
      expect(
          headerTextWidget.data,
          MaterialLocalizations.of(tester.element(headerFinder))
              .formatMonthYear(initialDate));

      await tester.tap(previousPageIconFinder);
      await tester.pumpAndSettle();

      final int currentPage =
          tester.widget<PageView>(pageViewFinder).controller.page!.round();

      expect(currentPage, equals(initialPage - 1));

      final DateTime newDisplayedMonth = DateTime(2022, 5, 1);

      final Finder newHeaderFinder = find.byType(Header);
      final Text newHeaderTextWidget = tester.widget<Text>(
          find.descendant(of: newHeaderFinder, matching: find.byType(Text)));
      expect(
          newHeaderTextWidget.data,
          MaterialLocalizations.of(tester.element(newHeaderFinder))
              .formatMonthYear(newDisplayedMonth));
    });
    testWidgets(
      'should NOT change the page when tapping on the previous page icon when the range in max and min date are one year.',
      (WidgetTester tester) async {
        final DateTime initialDate = DateTime(2020, 1, 5);
        final DateTime minDate = DateTime(2020, 1, 1);
        final DateTime maxDate = DateTime(2020, 1, 31);

        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: DaysPicker(
                currentDate: initialDate,
                initialDate: initialDate,
                minDate: minDate,
                maxDate: maxDate,
                todayTextStyle: const TextStyle(),
                daysNameTextStyle: const TextStyle(),
                enabledDaysTextStyle: const TextStyle(),
                selectedDayTextStyle: const TextStyle(),
                disbaledDaysTextStyle: const TextStyle(),
                todayDecoration: const BoxDecoration(),
                enabledDaysDecoration: const BoxDecoration(),
                selectedDayDecoration: const BoxDecoration(),
                disbaledDaysDecoration: const BoxDecoration(),
                leadingDateTextStyle: const TextStyle(),
                slidersColor: Colors.black,
                slidersSize: 20,
                splashColor: Colors.black,
                highlightColor: Colors.black,
              ),
            ),
          ),
        );

        final Finder pageViewFinder = find.byType(PageView);
        expect(pageViewFinder, findsOneWidget);

        final int initialPage =
            tester.widget<PageView>(pageViewFinder).controller.initialPage;

        final Finder previousPageIconFinder =
            find.byIcon(CupertinoIcons.chevron_left);
        expect(previousPageIconFinder, findsOneWidget);

        final Finder headerFinder = find.byType(Header);
        final Text headerTextWidget = tester.widget<Text>(
          find.descendant(
            of: headerFinder,
            matching: find.byType(Text),
          ),
        );
        expect(
          headerTextWidget.data,
          MaterialLocalizations.of(tester.element(headerFinder))
              .formatMonthYear(initialDate),
        );

        await tester.tap(previousPageIconFinder);
        await tester.pumpAndSettle();

        final int currentPage =
            tester.widget<PageView>(pageViewFinder).controller.page!.round();

        expect(currentPage, equals(initialPage));

        final DateTime newDisplayedYear = DateTime(2020, 1, 1);

        final Finder newHeaderFinder = find.byType(Header);
        final Text newHeaderTextWidget = tester.widget<Text>(
          find.descendant(
            of: newHeaderFinder,
            matching: find.byType(Text),
          ),
        );
        expect(
          newHeaderTextWidget.data,
          MaterialLocalizations.of(tester.element(headerFinder))
              .formatMonthYear(newDisplayedYear),
        );
      },
    );

    testWidgets(
      'should NOT change the page when tapping on the next page icon when the range in max and min date are one year.',
      (WidgetTester tester) async {
        final DateTime initialDate = DateTime(2022, 1, 1);
        final DateTime minDate = DateTime(2022, 1, 1);
        final DateTime maxDate = DateTime(2022, 1, 31);

        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: DaysPicker(
                currentDate: initialDate,
                initialDate: initialDate,
                minDate: minDate,
                maxDate: maxDate,
                todayTextStyle: const TextStyle(),
                daysNameTextStyle: const TextStyle(),
                enabledDaysTextStyle: const TextStyle(),
                selectedDayTextStyle: const TextStyle(),
                disbaledDaysTextStyle: const TextStyle(),
                todayDecoration: const BoxDecoration(),
                enabledDaysDecoration: const BoxDecoration(),
                selectedDayDecoration: const BoxDecoration(),
                disbaledDaysDecoration: const BoxDecoration(),
                leadingDateTextStyle: const TextStyle(),
                slidersColor: Colors.black,
                slidersSize: 20,
                splashColor: Colors.black,
                highlightColor: Colors.black,
              ),
            ),
          ),
        );

        final Finder pageViewFinder = find.byType(PageView);
        expect(pageViewFinder, findsOneWidget);

        final int initialPage =
            tester.widget<PageView>(pageViewFinder).controller.initialPage;

        final Finder nextPageIconFinder =
            find.byIcon(CupertinoIcons.chevron_right);
        expect(nextPageIconFinder, findsOneWidget);

        final Finder headerFinder = find.byType(Header);
        final Text headerTextWidget = tester.widget<Text>(
          find.descendant(
            of: headerFinder,
            matching: find.byType(Text),
          ),
        );
        expect(
          headerTextWidget.data,
          MaterialLocalizations.of(tester.element(headerFinder))
              .formatMonthYear(initialDate),
        );

        await tester.tap(nextPageIconFinder);
        await tester.pumpAndSettle();

        final int currentPage =
            tester.widget<PageView>(pageViewFinder).controller.page!.round();

        expect(currentPage, equals(initialPage));

        final DateTime newDisplayedYear = DateTime(2022, 1, 1);

        final Finder newHeaderFinder = find.byType(Header);
        final Text newHeaderTextWidget = tester.widget<Text>(
          find.descendant(
            of: newHeaderFinder,
            matching: find.byType(Text),
          ),
        );
        expect(
          newHeaderTextWidget.data,
          MaterialLocalizations.of(tester.element(headerFinder))
              .formatMonthYear(newDisplayedYear),
        );
      },
    );

    testWidgets(
      'should NOT change the page forward and backward on drag when the range in max and min date are one year.',
      (WidgetTester tester) async {
        final DateTime initialDate = DateTime(2020, 1, 1);
        final DateTime minDate = DateTime(2020, 1, 1);
        final DateTime maxDate = DateTime(2020, 1, 31);

        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: DaysPicker(
                currentDate: initialDate,
                initialDate: initialDate,
                minDate: minDate,
                maxDate: maxDate,
                todayTextStyle: const TextStyle(),
                daysNameTextStyle: const TextStyle(),
                enabledDaysTextStyle: const TextStyle(),
                selectedDayTextStyle: const TextStyle(),
                disbaledDaysTextStyle: const TextStyle(),
                todayDecoration: const BoxDecoration(),
                enabledDaysDecoration: const BoxDecoration(),
                selectedDayDecoration: const BoxDecoration(),
                disbaledDaysDecoration: const BoxDecoration(),
                leadingDateTextStyle: const TextStyle(),
                slidersColor: Colors.black,
                slidersSize: 20,
                splashColor: Colors.black,
                highlightColor: Colors.black,
              ),
            ),
          ),
        );

        final Finder pageViewFinder = find.byType(PageView);
        expect(pageViewFinder, findsOneWidget);

        final DateTime newDisplayedYear = DateTime(2020, 1, 1);

        await tester.drag(
          pageViewFinder,
          const Offset(-600, 0),
        ); // Drag the page forward
        await tester.pumpAndSettle();

        final Finder headerFinder = find.byType(Header);
        final Text headerTextWidget = tester.widget<Text>(
          find.descendant(
            of: headerFinder,
            matching: find.byType(Text),
          ),
        );
        expect(
          headerTextWidget.data,
          MaterialLocalizations.of(tester.element(headerFinder))
              .formatMonthYear(newDisplayedYear),
        );

        await tester.drag(
          pageViewFinder,
          const Offset(600, 0),
        ); // Drag the page backward
        await tester.pumpAndSettle();

        final Finder newHeaderFinder = find.byType(Header);
        final Text newHeaderTextWidget = tester.widget<Text>(
          find.descendant(
            of: newHeaderFinder,
            matching: find.byType(Text),
          ),
        );
        expect(
          newHeaderTextWidget.data,
          MaterialLocalizations.of(tester.element(headerFinder))
              .formatMonthYear(initialDate),
        );
      },
    );

    testWidgets(
      'Should the height of the animated container be 52 * 6 when it\'s a six rows month',
      (WidgetTester tester) async {
        final DateTime initialDate = DateTime(2023);
        final DateTime minDate = DateTime(2000);
        final DateTime maxDate = DateTime(2030);

        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: DaysPicker(
                currentDate: initialDate,
                initialDate: initialDate,
                minDate: minDate,
                maxDate: maxDate,
                todayTextStyle: const TextStyle(),
                daysNameTextStyle: const TextStyle(),
                enabledDaysTextStyle: const TextStyle(),
                selectedDayTextStyle: const TextStyle(),
                disbaledDaysTextStyle: const TextStyle(),
                todayDecoration: const BoxDecoration(),
                enabledDaysDecoration: const BoxDecoration(),
                selectedDayDecoration: const BoxDecoration(),
                disbaledDaysDecoration: const BoxDecoration(),
                leadingDateTextStyle: const TextStyle(),
                slidersColor: Colors.black,
                slidersSize: 20,
                splashColor: Colors.black,
                highlightColor: Colors.black,
              ),
            ),
          ),
        );

        final Finder animatedContainerFinder = find.byType(AnimatedContainer);
        expect(animatedContainerFinder, findsOneWidget);

        const constraints = BoxConstraints.tightFor(height: 52 * 6);

        final AnimatedContainer animatedContainerWidget =
            tester.widget<AnimatedContainer>(animatedContainerFinder);

        expect(animatedContainerWidget.constraints, equals(constraints));
      },
    );
    testWidgets(
      'Should the height of the animated container be 52 * 7 when it\'s a seven rows month',
      (WidgetTester tester) async {
        final DateTime initialDate = DateTime(2023, 7);
        final DateTime minDate = DateTime(2000);
        final DateTime maxDate = DateTime(2030);

        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: DaysPicker(
                currentDate: initialDate,
                initialDate: initialDate,
                minDate: minDate,
                maxDate: maxDate,
                todayTextStyle: const TextStyle(),
                daysNameTextStyle: const TextStyle(),
                enabledDaysTextStyle: const TextStyle(),
                selectedDayTextStyle: const TextStyle(),
                disbaledDaysTextStyle: const TextStyle(),
                todayDecoration: const BoxDecoration(),
                enabledDaysDecoration: const BoxDecoration(),
                selectedDayDecoration: const BoxDecoration(),
                disbaledDaysDecoration: const BoxDecoration(),
                leadingDateTextStyle: const TextStyle(),
                slidersColor: Colors.black,
                slidersSize: 20,
                splashColor: Colors.black,
                highlightColor: Colors.black,
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final Finder animatedContainerFinder = find.byType(AnimatedContainer);
        expect(animatedContainerFinder, findsOneWidget);

        const constraints = BoxConstraints.tightFor(height: 52 * 7);

        final AnimatedContainer animatedContainerWidget =
            tester.widget<AnimatedContainer>(animatedContainerFinder);

        expect(animatedContainerWidget.constraints, equals(constraints));
      },
    );

    testWidgets(
      'Should show the correct day on pick',
      (WidgetTester tester) async {
        final DateTime initialDate = DateTime(2010);
        final DateTime minDate = DateTime(2000);
        final DateTime maxDate = DateTime(2011);
        final DateTime dayToSelect = DateTime(2010, 1, 2);
        late final DateTime expectedDay;
        const selectedDayColor = Colors.green;

        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: DaysPicker(
                currentDate: initialDate,
                initialDate: initialDate,
                minDate: minDate,
                maxDate: maxDate,
                todayTextStyle: const TextStyle(),
                daysNameTextStyle: const TextStyle(),
                enabledDaysTextStyle: const TextStyle(),
                selectedDayTextStyle: const TextStyle(
                  color: selectedDayColor,
                ),
                disbaledDaysTextStyle: const TextStyle(),
                todayDecoration: const BoxDecoration(),
                enabledDaysDecoration: const BoxDecoration(),
                selectedDayDecoration: const BoxDecoration(),
                disbaledDaysDecoration: const BoxDecoration(),
                leadingDateTextStyle: const TextStyle(),
                slidersColor: Colors.black,
                slidersSize: 20,
                splashColor: Colors.black,
                highlightColor: Colors.black,
                onChange: (value) {
                  expectedDay = value;
                },
              ),
            ),
          ),
        );

        final selectedDayFinder = find.byWidgetPredicate((widget) {
          if (widget is Container &&
              widget.child is Center &&
              (widget.child as Center).child is Text) {
            return ((widget.child as Center).child as Text).data ==
                    dayToSelect.day.toString() &&
                ((widget.child as Center).child as Text).style?.color ==
                    selectedDayColor;
          }
          return false;
        });

        final dayFinder = find.byWidgetPredicate((widget) {
          if (widget is Container &&
              widget.child is Center &&
              (widget.child as Center).child is Text) {
            return ((widget.child as Center).child as Text).data ==
                dayToSelect.day.toString();
          }
          return false;
        });

        expect(selectedDayFinder, findsNothing);

        await tester.tap(dayFinder);
        await tester.pumpAndSettle();

        expect(expectedDay, dayToSelect);
      },
    );
    testWidgets(
      'Should show the correct text style for the leading date',
      (WidgetTester tester) async {
        final DateTime initialDate = DateTime(2010);
        final DateTime minDate = DateTime(2000);
        final DateTime maxDate = DateTime(2011);
        const leadingDayColor = Colors.green;

        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: DaysPicker(
                currentDate: initialDate,
                initialDate: initialDate,
                minDate: minDate,
                maxDate: maxDate,
                todayTextStyle: const TextStyle(),
                daysNameTextStyle: const TextStyle(),
                enabledDaysTextStyle: const TextStyle(),
                selectedDayTextStyle: const TextStyle(),
                disbaledDaysTextStyle: const TextStyle(),
                todayDecoration: const BoxDecoration(),
                enabledDaysDecoration: const BoxDecoration(),
                selectedDayDecoration: const BoxDecoration(),
                disbaledDaysDecoration: const BoxDecoration(),
                leadingDateTextStyle: const TextStyle(
                  color: leadingDayColor,
                ),
                slidersColor: Colors.black,
                slidersSize: 20,
                splashColor: Colors.black,
                highlightColor: Colors.black,
              ),
            ),
          ),
        );

        final leadingDayFinder = find.byWidgetPredicate((widget) {
          if (widget is Text) {
            return widget.data == 'January 2010' &&
                widget.style?.color == leadingDayColor;
          }
          return false;
        });

        expect(leadingDayFinder, findsOneWidget);
      },
    );

    testWidgets(
      'Should show the correct color and size for page sliders',
      (WidgetTester tester) async {
        final DateTime initialDate = DateTime(2010);
        final DateTime minDate = DateTime(2000);
        final DateTime maxDate = DateTime(2011);
        const slidersColors = Colors.green;
        const slidersSize = 18.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: DaysPicker(
                currentDate: initialDate,
                initialDate: initialDate,
                minDate: minDate,
                maxDate: maxDate,
                todayTextStyle: const TextStyle(),
                daysNameTextStyle: const TextStyle(),
                enabledDaysTextStyle: const TextStyle(),
                selectedDayTextStyle: const TextStyle(),
                disbaledDaysTextStyle: const TextStyle(),
                todayDecoration: const BoxDecoration(),
                enabledDaysDecoration: const BoxDecoration(),
                selectedDayDecoration: const BoxDecoration(),
                disbaledDaysDecoration: const BoxDecoration(),
                leadingDateTextStyle: const TextStyle(),
                slidersColor: slidersColors,
                slidersSize: slidersSize,
                splashColor: Colors.black,
                highlightColor: Colors.black,
              ),
            ),
          ),
        );

        final leftIconFinder = find.byWidgetPredicate((widget) {
          if (widget is Icon) {
            return widget.color == slidersColors &&
                widget.size == slidersSize &&
                widget.icon == CupertinoIcons.chevron_left;
          }
          return false;
        });

        expect(leftIconFinder, findsOneWidget);

        final rightIconFinder = find.byWidgetPredicate((widget) {
          if (widget is Icon) {
            return widget.color == slidersColors &&
                widget.size == slidersSize &&
                widget.icon == CupertinoIcons.chevron_right;
          }
          return false;
        });

        expect(rightIconFinder, findsOneWidget);
      },
    );
  });
}
