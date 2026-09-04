import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app_theme.dart';
import 'app/providers.dart';
import 'app/router.dart';
import 'core/services/log_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await log.initializeaza();
  log.prindeErorile();
  log.info('app', 'Pornire aplicație');
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const ElectroApp(),
    ),
  );
}

class ElectroApp extends ConsumerWidget {
  const ElectroApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mod = ref.watch(themeModeProvider);
    return MaterialApp.router(
      title: 'ElectroApp',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: mod,
      routerConfig: appRouter,
    );
  }
}
