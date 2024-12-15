import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutternew/Features/App/User_auth/presentation/Pages/login_page.dart';
import 'package:flutternew/Features/App/splash_screen/splash_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBoEfynFgftXEWeTKigDaWS0FK1Zczk1rY",
        appId: "1:935307424826:android:6ba63ec26bea64438e3103",
        messagingSenderId: "935307424826",
        projectId: "wastewisepro"
    )
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(primarySwatch: Colors.green),
      home: splash_screen(
        debugShowCheckedModeBanner: false,
        child: loginPage(
        ),

      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(

    );
  }
}
