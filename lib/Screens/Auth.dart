import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/Screen_cubit.dart';
import '../const.dart';
import '../shared/sharedHelper.dart';
import 'main_screen.dart';
import 'outer_screen/sigIn.dart';


class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppScreenCubit()
          ..getUserData()
          ..getPost(),
        child: BlocConsumer<AppScreenCubit, AppScreenStates>(
          listener: (context, state) {},
          builder: (context, state) {
            SharedPreferencesHelper.getUid(key: "uId").then((value) {
              U_I_D = value;
            }).catchError((error) {});
            return Scaffold(
              body: StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapShot) {
                    if (snapShot.hasData) {
                      return const MainScreen();
                    } else {
                      return const SigIn();
                    }
                  }),
            );
          },
        ));
  }
}
