import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/transaction_provider.dart';
import 'providers/preferences_provider.dart';
import 'services/hive_service.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_transaction_screen.dart';
import 'theme/app_theme.dart';
import 'models/transaction_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await HiveService.init();

  // Initialize preferences
  final prefsProvider = PreferencesProvider();
  await prefsProvider.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider.value(value: prefsProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, prefsProvider, child) {
        return MaterialApp(
          title: 'Kharcha Pani',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: prefsProvider.isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          initialRoute: '/',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(builder: (_) => const SplashScreen());
              case '/onboarding':
                return MaterialPageRoute(
                  builder: (_) => const OnboardingScreen(),
                );
              case '/home':
                return MaterialPageRoute(builder: (_) => const HomeScreen());
              case '/add-transaction':
                final args = settings.arguments as Map<String, dynamic>?;
                return MaterialPageRoute(
                  builder: (_) => AddTransactionScreen(
                    initialType: args?['type'] as TransactionType?,
                    transaction: args?['transaction'] as TransactionModel?,
                  ),
                );
              default:
                return MaterialPageRoute(builder: (_) => const SplashScreen());
            }
          },
        );
      },
    );
  }
}
