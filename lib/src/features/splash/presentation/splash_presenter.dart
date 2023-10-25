import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_router/clean_framework_router.dart';
import 'package:flutter/material.dart';

import '../../../routes/routes.dart';
import '../domain/splash_entity.dart';
import '../domain/splash_ui_output.dart';
import '../domain/splash_use_case.dart';

import '../providers/splash_use_case_providers.dart';
import 'splash_view_model.dart';

class SplashPresenter
    extends Presenter<SplashViewModel, SplashUIOutput, SplashUseCase> {
  SplashPresenter({
    super.key,
    required super.builder,
  }) : super(provider: splashUseCaseProvider);

  @override
  SplashViewModel createViewModel(
      SplashUseCase useCase, SplashUIOutput output) {
    return SplashViewModel(
      isLoading: output.status == SplashStatus.loading,
    );
  }

  @override
  onLayoutReady(BuildContext context, SplashUseCase useCase) {
    useCase
        .navigateToHome(2)
        .then((value) => context.router.pushReplacement(Routes.todoList));
  }
}
