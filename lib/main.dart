import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_module.dart';
import 'features/upcoming_movies/presentation/pages/upcoming_movies_list_page.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: PaySmartApp()));
}

class PaySmartApp extends StatelessWidget {
  const PaySmartApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(disabledColor: Colors.black),
      home: const MoviesList(),
    );
  }
}
