import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Cubit/Screen_cubit.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> password = GlobalKey<FormState>();
    final TextEditingController passwordController =
        TextEditingController();

    final GlobalKey<FormState> bio = GlobalKey<FormState>();
    final TextEditingController bioController =
        TextEditingController();

    File? proImage = AppScreenCubit.get(context).profileImage;
    File? covImage = AppScreenCubit.get(context).coverImage;

    return BlocConsumer<AppScreenCubit, AppScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var c = AppScreenCubit.get(context);
          passwordController.text = c.model.password ?? "";
          bioController.text = c.model.bio ?? "";
          return Scaffold(
              body: SafeArea(
                  child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 230,
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Stack(
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  alignment: Alignment.topCenter,
                                  height: 190.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(
                                      4.0,
                                    ),
                                    image: DecorationImage(
                                      image: covImage != null
                                          ? Image.file(
                                              covImage,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ).image
                                          : NetworkImage(c
                                                  .model.coverImage ??
                                              "https://tse3.mm.bing.net/th?id=OIP.eluLjywG2GQ4-gyh0aboHgHaEK&pid=Api&P=0&h=180"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 20,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.add,
                                      size: 20,
                                    ),
                                    onPressed: () async {
                                      await c.getCoverImage();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    CircleAvatar(
                                      radius: 58.0,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 55.0,
                                        backgroundImage: proImage ==
                                                null
                                            ? NetworkImage(c
                                                    .model.prImage ??
                                                "https://images.ctfassets.net/hrltx12pl8hq/7yQR5uJhwEkRfjwMFJ7bUK/dc52a0913e8ff8b5c276177890eb0129/offset_comp_772626-opt.jpg?fit=fill&w=800&h=300")
                                            : Image.file(
                                                proImage,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ).image,
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 16,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.add,
                                          size: 17,
                                        ),
                                        onPressed: () async {
                                          await c.getProfileImage();
                                        },
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      Text(
                        c.model.name ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        c.model.bio ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            child: Column(
                              children: [
                                const Text(
                                  "save",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "profile",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.red[600]),
                                )
                              ],
                            ),
                            onPressed: () {
                              c.uploadProfileImage(
                                email: c.model.email.toString(),
                                password: c.model.password.toString(),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: MaterialButton(
                            child: Column(
                              children: [
                                const Text(
                                  "2010",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "friends",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.red[600]),
                                )
                              ],
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {},
                            child: Column(
                              children: [
                                const Text(
                                  "100",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "posts",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.red[600]),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: MaterialButton(
                            child: Column(
                              children: [
                                const Text(
                                  "300",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "like",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.red[600]),
                                )
                              ],
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: OutlinedButton(
                          child: const Text("Editing CoverImage"),
                          onPressed: () {
                            c.uploadCoverImage(
                              email: c.model.email.toString(),
                              password: c.model.password.toString(),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          child: const Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            if (password.currentState!.validate()) {
                              c.updateUserData(
                                password: passwordController.text
                                    .toString(),
                              );
                            }
                            if (bio.currentState!.validate()) {
                              c.updateUserData(
                                bio: bioController.text.toString(),
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10),
                    child: Form(
                      key: password,
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                              Icons.remove_red_eye_outlined),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.blueAccent)),
                          errorMaxLines: 1,
                          labelText: " Password :",
                          labelStyle: const TextStyle(
                              fontSize: 13,
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
                        onFieldSubmitted: (val) {},
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      child: Form(
                        key: bio,
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: bioController,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                                Icons.currency_bitcoin_outlined),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.blueAccent)),
                            errorMaxLines: 1,
                            labelText: " Bio :",
                            labelStyle: const TextStyle(
                                fontSize: 13,
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
                          onFieldSubmitted: (val) {},
                        ),
                      )),
                ],
              ),
            ),
          )));
        });
  }
}
