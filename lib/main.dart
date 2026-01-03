import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/crayon_theme.dart';
import 'screens/chore_chart_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  
  runApp(const ChoreChartApp());
}

class ChoreChartApp extends StatelessWidget {
  const ChoreChartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chore Chart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: CrayonTheme.forestGreen,
          secondary: CrayonTheme.mustardYellow,
          surface: CrayonTheme.cream,
          error: CrayonTheme.brickRed,
        ),
        scaffoldBackgroundColor: CrayonTheme.lightCream,
        fontFamily: 'ComicNeue', // Using a rounded font if available, otherwise default
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: CrayonTheme.darkBrown,
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            color: CrayonTheme.darkBrown,
          ),
        ),
      ),
      home: const ChoreChartScreen(),
    );
  }
}
