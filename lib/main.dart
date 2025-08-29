import 'package:demo/feature/login/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_root_checker/flutter_root_checker.dart';

import 'core/networking/dio_factory.dart';
import 'core/storage/local_storage.dart';

void main() async{
  if (FlutterRootChecker.isAndroidRoot) {
    print("Root access detected on this Android device!");
  } else if (FlutterRootChecker.isIosJailbreak) {
    print("Jailbreak detected on this iOS device!");
  } else {
    print("Device is secure.");
  }

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

