import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_cleanframework_todo_app/src/features/features.dart';
import 'package:flutter_cleanframework_todo_app/src/features/splash/presentation/splash_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SplashUI tests |', () {
    uiTest(
      'shows loading',
      ui: SplashUI(),
      viewModel: const SplashViewModel(
        isLoading: true,
      ),
      verify: (tester) async {
        expect(find.text('CRUD Operations using Clean Architecture'),
            findsOneWidget);
      },
    );

    uiTest(
      'shows loading',
      ui: SplashUI(),
      viewModel: const SplashViewModel(
        isLoading: false,
      ),
      verify: (tester) async {
        expect(find.text('CRUD Operations using Clean Architecture'),
            findsOneWidget);
      },
    );
  });
}
