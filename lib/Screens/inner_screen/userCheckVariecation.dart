import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loginscreen/Cubit/Screen_cubit.dart';


// this class used to check if the user have email verified or not
// and not used

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppScreenCubit()..getUserData(),
      child: BlocConsumer<AppScreenCubit,AppScreenStates>(
        listener: (context,state){},
        builder: (context,state){
          if(!user!.emailVerified){
           return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Email: ${user?.email }",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(40),
                        child: GestureDetector(
                          onTap: ()async {
                           await user!.sendEmailVerification().then((value){}).catchError((error){
                              Fluttertoast.showToast(
                                  msg: error.toString(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            });
                          },
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.amber),
                              child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      "verify your email now ",
                                      style: GoogleFonts.almendra(
                                        fontSize: 22,
                                      ),
                                    ),
                                  ))
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(40),
                        child: GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                          },
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.amber),
                              child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      "Sig Out",
                                      style: GoogleFonts.almendra(
                                        fontSize: 22,
                                      ),
                                    ),
                                  ))
                          ),
                        )),
                  ],
                ),
              ),
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
