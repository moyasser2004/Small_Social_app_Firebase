import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/Cubit/Screen_cubit.dart';

import '../Model/userdata_model.dart';
import '../Model/usersChat_model.dart';

class InnerChat extends StatelessWidget {
  UserDataModel model;

  InnerChat(this.model, {super.key});

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        AppScreenCubit.get(context).getMessage(reciverId: model.uId ?? "");
        return BlocConsumer<AppScreenCubit, AppScreenStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 20.0,
                          backgroundImage: NetworkImage(model.prImage ??
                              "https://tse3.mm.bing.net/th?id=OIP.eluLjywG2GQ4-gyh0aboHgHaEK&pid=Api&P=0&h=180")),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        '${model.name}',
                        style: const TextStyle(
                          height: 1.4,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var message =
                              AppScreenCubit.get(context).messages[index];

                          if (AppScreenCubit.get(context).model.uId ==
                              message.senderId) {
                            return buildMyMessage(message);
                          }
                          return buildMessage(message);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 15.0,
                        ),
                        itemCount: AppScreenCubit.get(context).messages.length,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message here ...',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50.0,
                            color: Colors.indigo,
                            child: MaterialButton(
                              onPressed: () {
                                AppScreenCubit.get(context).sendMessage(
                                  text: messageController.text,
                                  reciverId: model.uId ?? "",
                                  date: DateTime.now().toString(),
                                );
                              },
                              minWidth: 1.0,
                              child: const Icon(
                                Icons.send,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(UsersMessages model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Text(
            model.text ?? "",
          ),
        ),
      );

  Widget buildMyMessage(UsersMessages model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Text(
            model.text ?? "",
          ),
        ),
      );
}
