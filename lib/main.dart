import 'package:fitbit/core/app.dart';
import 'package:fitbit/core/network/local/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  HiveService().init();
  // HiveService().deleteHive();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
