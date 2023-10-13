import 'package:clean_framework/clean_framework.dart';
import '../domain/splash_use_case.dart';
import '/src/features/splash/domain/splash_entity.dart';

final splashUseCaseProvider =
    UseCaseProvider.autoDispose<SplashEntity, SplashUseCase>(
  SplashUseCase.new,
);
