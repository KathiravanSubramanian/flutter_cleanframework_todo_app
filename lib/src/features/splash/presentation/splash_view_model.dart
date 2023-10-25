import 'package:clean_framework/clean_framework.dart';

class SplashViewModel extends ViewModel {
  final bool isLoading;
  const SplashViewModel({
    required this.isLoading,
  });

  @override
  List<Object?> get props => [isLoading];
}
