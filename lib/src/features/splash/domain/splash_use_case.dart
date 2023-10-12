import 'package:clean_framework/clean_framework.dart';
import '/src/features/splash/domain/splash_entity.dart';
import 'splash_ui_output.dart';

class SplashUseCase extends UseCase<SplashEntity> {
  SplashUseCase()
      : super(
          entity: SplashEntity(),
          transformers: [
            OutputTransformer.from((_) => SplashUIOutput()),
          ],
        );
}
