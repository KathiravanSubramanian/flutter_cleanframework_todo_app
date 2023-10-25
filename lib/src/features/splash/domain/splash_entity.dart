import 'package:clean_framework/clean_framework.dart';

enum SplashStatus { initial, loading, loaded, failed }

class SplashEntity extends Entity {
  final SplashStatus status;

  const SplashEntity({
    this.status = SplashStatus.initial,
  });

  @override
  SplashEntity copyWith({
    SplashStatus? status,
  }) {
    return SplashEntity(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
