import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_cleanframework_todo_app/src/features/splash/domain/splash_entity.dart';
import 'package:flutter_cleanframework_todo_app/src/features/splash/domain/splash_ui_output.dart';
import 'package:flutter_cleanframework_todo_app/src/features/splash/domain/splash_use_case.dart';
import 'package:flutter_cleanframework_todo_app/src/features/splash/presentation/splash_presenter.dart';
import 'package:flutter_cleanframework_todo_app/src/features/splash/presentation/splash_view_model.dart';
import 'package:flutter_cleanframework_todo_app/src/features/splash/providers/splash_use_case_providers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SplashPresenter tests |', () {
    presenterTest<SplashViewModel, SplashUIOutput, SplashUseCase>(
      'creates proper view model',
      create: (builder) => SplashPresenter(builder: builder),
      overrides: [
        splashUseCaseProvider.overrideWith(SplashUseCaseFake()),
      ],
      setup: (useCase) {
        useCase.debugEntityUpdate(
          (e) => e.copyWith(status: SplashStatus.initial),
        );
      },
      expect: () => [
        isA<SplashViewModel>()
            .having((vm) => vm.isLoading, 'Loading check', false),
      ],
    );
  });
}

class SplashUseCaseFake extends SplashUseCase {
  @override
  Future<void> navigateToHome(int delay) async {}
}

class TodoFormUseCaseMock extends UseCaseMock<SplashEntity>
    implements SplashUseCase {
  TodoFormUseCaseMock()
      : super(
          entity: const SplashEntity(),
          transformers: [
            SplashUIOutputTransformer(),
          ],
        );
}
