import 'package:flutter/material.dart';
import 'constants.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const KharchaPaniApp());
}

class KharchaPaniApp extends StatelessWidget {
  const KharchaPaniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kharcha  Pani',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.dark(
          primary: AppColors.accent,
          surface: AppColors.surface,
          onPrimary: AppColors.background,
          onSurface: AppColors.textPrimary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent, // Allow custom shapes
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
