import 'package:demo/feature/login/ui/login_screen.dart';
import 'package:flutter/material.dart';

import 'core/networking/dio_factory.dart';
import 'core/storage/local_storage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioFactory.init();
  await LocalStorage.init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: LoginScreen()
    );
  }
}

