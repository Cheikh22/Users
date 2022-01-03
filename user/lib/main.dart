import 'package:flutter/material.dart';
import 'package:user/router.dart';

void main() {
  runApp(MyHome(
    router: AppRouter(),
  ));
}

class MyHome extends StatelessWidget {
  
  final AppRouter? router;
  const MyHome({Key? key,this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router!.generateRoute,
    );
  }
}


