import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Login/LoginPage.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
@override
  State createState(){
  return _MyAppState();
}
}
class _MyAppState extends State<MyApp>{
  @override
  void initState (){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Firebase tutorial",
      home: LoginPage(),
    );
  }
}
