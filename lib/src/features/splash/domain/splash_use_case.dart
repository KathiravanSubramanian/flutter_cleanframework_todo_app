import 'package:clean_framework/clean_framework.dart';
import '/src/features/splash/domain/splash_entity.dart';
import 'splash_ui_output.dart';

class SplashUseCase extends UseCase<SplashEntity> {
  SplashUseCase()
      : super(
          entity: const SplashEntity(),
          transformers: [SplashUIOutputTransformer()],
        );

  Future<void> navigateToHome(int delay) async {
    entity = entity.copyWith(status: SplashStatus.loading);
    await Future.delayed(Duration(seconds: delay));
    entity = entity.copyWith(status: SplashStatus.loaded);
  }
}

class SplashUIOutputTransformer
    extends OutputTransformer<SplashEntity, SplashUIOutput> {
  @override
  SplashUIOutput transform(SplashEntity entity) {
    return SplashUIOutput(
      status: entity.status,
    );
  }
}
