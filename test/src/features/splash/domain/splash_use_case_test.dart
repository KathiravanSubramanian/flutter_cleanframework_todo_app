import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_cleanframework_todo_app/src/features/splash/domain/splash_entity.dart';
import 'package:flutter_cleanframework_todo_app/src/features/splash/domain/splash_ui_output.dart';
import 'package:flutter_cleanframework_todo_app/src/features/splash/domain/splash_use_case.dart';
import 'package:flutter_cleanframework_todo_app/src/features/splash/providers/splash_use_case_providers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SplashUseCase test |', () {
    useCaseTest<SplashUseCase, SplashEntity, SplashUIOutput>(
      'fetchData; success',
      provider: splashUseCaseProvider,
      execute: (useCase) {
        const SplashUIOutput(
          status: SplashStatus.loading,
        );
        useCase.navigateToHome(2);
      },
      expect: () => [
        const SplashUIOutput(
          status: SplashStatus.loading,
        ),
      ],
    );
  });
}
