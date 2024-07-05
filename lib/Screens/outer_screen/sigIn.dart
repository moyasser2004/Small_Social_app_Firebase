import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../Cubit/callApp_cubit.dart';
import '../../shared/sharedHelper.dart';

class SigIn extends StatefulWidget {

  const SigIn({Key? key}) : super(key: key);

  @override
  State<SigIn> createState() => _SigInState();
}

class _SigInState extends State<SigIn> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final GlobalKey<FormState> _email = GlobalKey<FormState>();
  final GlobalKey<FormState> _password = GlobalKey<FormState>();
  final GlobalKey<FormState> _confirmPassword = GlobalKey<FormState>();
  final GlobalKey<FormState> _name = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CallAppCubit(),
      child: BlocConsumer<CallAppCubit, CallAppStates>(
        listener: (context, state) {
          if (state is CallApPErrorLogin) {
            Fluttertoast.showToast(
                msg: state.error.toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state is CallAppSuccessLogin) {
            
            SharedPreferencesHelper.setUid(
              key: "uId",
              value: state.uId.toString(),
            ).then((vall) {}).catchError((error) {});

            Fluttertoast.showToast(
                msg: "Go to your Account ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          CallAppCubit c = CallAppCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.grey[50],
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.grey[50],
                ),
              ),
              backgroundColor: Colors.grey[50],
              body: SafeArea(
                  child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Lottie.asset(
                        'images/sigIn.json',
                        height: 200,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "LogIn ",
                      style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "This is amazing to see you  login now !!!",
                          style: GoogleFonts.robotoCondensed(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "  : - )",
                          style: GoogleFonts.robotoCondensed(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.green),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20)),
                          child: Form(
                            key: _name,
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: _nameController,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.person,),
                                border: InputBorder.none,
                                hintText: "Name :",
                                hintStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                              validator: (String? value) {
                                if (value!.isEmpty || value.length < 5) {
                                  return " name can`t be empty";
                                } else {
                                  return null;
                                }
                              },
                              onFieldSubmitted: (val) {
                                if (_name.currentState!.validate()) {}
                              },
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20)),
                          child: Form(
                            key: _email,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.email_outlined,
                                ),
                                border: InputBorder.none,
                                hintText: "Email :",
                                hintStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                              validator: (String? value) {
                                if (value!.isEmpty || value.length < 5) {
                                  return " email can`t be empty";
                                } else {
                                  return null;
                                }
                              },
                              onFieldSubmitted: (val) {
                                if (_email.currentState!.validate()) {}
                              },
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20)),
                          child: Form(
                            key: _password,
                            child: TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: c.obscure1,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                icon: SizedBox(
                                  width: 30,
                                  child: IconButton(
                                    icon: Icon(
                                      !c.obscure1
                                          ? Icons.remove_red_eye_rounded
                                          : Icons.visibility_off_rounded,
                                      color: Colors.grey[500],
                                    ),
                                    onPressed: () {
                                      c.obscur1eChange();
                                    },
                                  ),
                                ),
                                border: InputBorder.none,
                                errorMaxLines: 1,
                                errorBorder: InputBorder.none,
                                hintText: "Password :",
                                hintStyle: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return " password can`t be empty";
                                } else if (value.length < 6) {
                                  return "password can`t be less 6 keyword ";
                                } else {
                                  return null;
                                }
                              },
                              onFieldSubmitted: (val) {
                                if (_password.currentState!.validate() &&
                                    _email.currentState!.validate()) {
                                  c.sigIn(
                                    password: _passwordController,
                                    email: _emailController,
                                    context: context,
                                    passwordConfirm: _confirmPasswordController,
                                    name: _nameController,
                                  );
                                }
                              },
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20)),
                          child: Form(
                            key: _confirmPassword,
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: c.obscure0,
                              controller: _confirmPasswordController,
                              decoration: InputDecoration(
                                icon: SizedBox(
                                  width: 30,
                                  child: IconButton(
                                    icon: Icon(
                                      c.obscure0
                                          ? Icons.visibility_off_rounded
                                          : Icons.remove_red_eye_rounded,
                                      color: Colors.grey[500],
                                    ),
                                    onPressed: () {
                                      c.obscureChange();
                                    },
                                  ),
                                ),
                                border: InputBorder.none,
                                // errorMaxLines: 1,
                                errorBorder: InputBorder.none,
                                hintText: "Confirm Password :",

                                hintStyle: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return " confirm password can`t be empty";
                                } else if (value.length < 6) {
                                  return "confirm password can`t be less 6 keyword ";
                                } else if (_passwordController.text.trim() !=
                                    _confirmPasswordController.text.trim()) {
                                  return "confirm password not equal password ";
                                } else {
                                  return null;
                                }
                              },
                              onFieldSubmitted: (val) {
                                if (_password.currentState!.validate() &&
                                    _email.currentState!.validate()) {
                                  c.sigIn(
                                    password: _passwordController,
                                    email: _emailController,
                                    context: context,
                                    passwordConfirm: _confirmPasswordController,
                                    name: _nameController,
                                  );
                                }
                              },
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(40),
                        child: GestureDetector(
                          onTap: () {
                            if (_password.currentState!.validate() &&
                                _email.currentState!.validate()) {
                              c.sigIn(
                                password: _passwordController,
                                email: _emailController,
                                context: context,
                                passwordConfirm: _confirmPasswordController,
                                name: _nameController,
                              );
                            }
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
                                  "Log In",
                                  style: GoogleFonts.almendra(
                                    fontSize: 22,
                                  ),
                                ),
                              ))),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          " Have Account",
                          style: GoogleFonts.robotoCondensed(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        TextButton(
                          child: Text(
                            "SigIn ",
                            style: GoogleFonts.almendra(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed("SigIn");
                          },
                        )
                      ],
                    )
                  ],
                ),
              )));
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
