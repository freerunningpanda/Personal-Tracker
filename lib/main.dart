import 'package:flutter/material.dart';
import 'package:tracker/app.dart';
import 'package:tracker/core/di/injection_container.dart';
import 'package:tracker/core/presentation/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencyInjection();

  final appRouter = sl<AppRouter>();
  runApp(App(appRouter: appRouter));
}
