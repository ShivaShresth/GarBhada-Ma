import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renthouse/firebase_helper/firebase_auth/firebasee_auth_helper.dart';
import 'package:renthouse/firebase_options.dart';
import 'package:renthouse/pages/bottom_navigation_bar.dart';
import 'package:renthouse/pages/login.dart';
import 'package:renthouse/pages/singup.dart';
import 'package:renthouse/provider/app_provider.dart';
import 'package:renthouse/provider/categories_provider.dart';
import 'package:renthouse/screen/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider()),
        ChangeNotifierProvider(create: (context) => CategoriesProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   backgroundColor: Color(0xFFF5F6F6),
        //   primaryColor: Color(0xFF811B83),
        //   textTheme: TextTheme(headline1: TextStyle(color: Color(0xFF100E34),
        //   ),
        //   bodyText1: TextStyle(color: Color(0xFF100E34).withOpacity(0.5)),
        //   )
        // ),
        home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Bottom_Navigation_Bar();
            }
            return SingUP();
          },
        ),
      ),
    );
  }
}
