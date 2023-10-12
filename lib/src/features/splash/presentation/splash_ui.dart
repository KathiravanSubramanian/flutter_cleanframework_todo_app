import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import '../../../core/core.dart';
import 'splash_presenter.dart';
import 'splash_view_model.dart';

class SplashUI extends UI<SplashViewModel> {
  SplashUI({super.key});

  @override
  SplashPresenter create(WidgetBuilder builder) {
    return SplashPresenter(builder: builder);
  }

  @override
  Widget build(BuildContext context, SplashViewModel viewModel) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(26.0),
                child: Text(
                  AppStrings.appName,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Text(
                'CRUD Operations using Clean Architecture',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 5),
              Text(
                'version: 1.0.0',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
