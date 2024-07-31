import 'package:date_app/provider/data.dart';
import 'package:date_app/screen/admin_screen.dart';
import 'package:date_app/screen/annoce_admin_screen.dart';
import 'package:date_app/screen/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(

  );
  await Firebase.initializeApp(

  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=>Data()),
    ],
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
          home: HomeScreen(),
      routes: {
        AdminScreen.routName:(context)=>AdminScreen(),
        PostAnnouncement.routName:(context)=>PostAnnouncement(),
      },
    ),);
  }
}
