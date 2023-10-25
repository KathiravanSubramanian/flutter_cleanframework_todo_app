import 'package:flutter_cleanframework_todo_app/src/features/features.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  group('AppScope tests |', () {
    testWidgets('update should not notify', (tester) async {
      await tester.pumpWidget(
        AppScope(
          child: Builder(
            builder: (context) {
              // expect(
              //   AppScope.cacheManagerOf(context),
              //   isA<DefaultCacheManager>(),
              // );

              return const SizedBox.shrink();
            },
          ),
        ),
      );

      await tester.pumpWidget(
        AppScope(
          child: Builder(
            builder: (context) {
              // expect(
              //   AppScope.cacheManagerOf(context),
              //   isA<DefaultCacheManager>(),
              // );

              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });
}
