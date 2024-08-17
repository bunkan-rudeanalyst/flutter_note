import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_architecture_demo/presentation_demo/presentation/app.dart';

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
