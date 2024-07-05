import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loginscreen/Cubit/Screen_cubit.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => AppScreenCubit()
        ..getUsers()
        ..getUserData(),
      child: BlocConsumer<AppScreenCubit, AppScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var c = AppScreenCubit.get(context);
          File? postImage = AppScreenCubit.get(context).postImage;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Add Post",
                style: GoogleFonts.robotoCondensed(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              actions: [
                TextButton(
                  child: Text("Add Post",
                      style: GoogleFonts.robotoCondensed()),
                  onPressed: () {
                    c.uploadPostImage(
                      data: DateTime.now().toString(),
                      text: controller.text.trim().toString(),
                    );
                  },
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(c
                                  .model.prImage ??
                              "https://tse3.mm.bing.net/th?id=OIP.eluLjywG2GQ4-gyh0aboHgHaEK&pid=Api&P=0&h=18")),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        c.model.name ?? "",
                        style: const TextStyle(
                          height: 1.4,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your post keywords......"),
                    ),
                  ),
                  Expanded(
                    child: postImage == null
                        ? Container()
                        : Image.file(
                            postImage,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.grey[400],
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                c.getPostImage();
                              },
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                size: 40,
                                color: Colors.red,
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                                onPressed: () {},
                                child: const Icon(
                                  Icons.web_stories,
                                  size: 40,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
