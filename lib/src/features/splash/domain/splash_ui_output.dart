// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_framework/clean_framework.dart';

import 'splash_entity.dart';

class SplashUIOutput extends Output {
  final SplashStatus status;
  const SplashUIOutput({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}
