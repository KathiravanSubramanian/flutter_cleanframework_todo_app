import 'package:flutter/material.dart';

class AppScope extends InheritedWidget {
  const AppScope({
    super.key,
    required super.child,
  });

  @override
  bool updateShouldNotify(AppScope oldWidget) => false;
}
