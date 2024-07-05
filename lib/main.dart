import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loginscreen/Screens/Auth.dart';
import 'package:loginscreen/shared/sharedHelper.dart';

import 'Cubit/blocObser_cubit.dart';
import 'Screens/inner_screen/addPost.dart';
import 'Screens/main_screen.dart';
import 'Screens/outer_screen/sigIn.dart';
import 'Screens/outer_screen/sigin.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await SharedPreferencesHelper.init();
  await Firebase.initializeApp();
  runApp(
      MaterialApp(
    routes: {
       // "Login": (context) => const SigIn(),
       // "SigIn": (context) => const SigIn(),
       "Auth": (context) => const Auth(),
       "MainScreen": (context) => const MainScreen(),
       "addPost": (context) => const AddPost(),
    },
    theme: ThemeData(
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.black,
          size: 25,
        ),
        scrolledUnderElevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleTextStyle: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    debugShowCheckedModeBanner: false,
    home: const Auth(),
  ));
}
