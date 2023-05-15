import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Custom imports for widgets and routes
import 'routes/welcome.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // making the status bar transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: WelcomeRoute(),
    );
  }
}
