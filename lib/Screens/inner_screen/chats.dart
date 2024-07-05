import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/Cubit/Screen_cubit.dart';

import '../../Model/userdata_model.dart';
import '../inner-chat-Screen.dart';

class Chats extends StatelessWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppScreenCubit, AppScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: ListView.separated(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: AppScreenCubit.get(context).users.length,
          itemBuilder: (context, index) {
            return usersBuilder(
                AppScreenCubit.get(context).users[index], context);
          },
          separatorBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(8),
              child: Divider(
                height: 3,
                thickness: 2,
                color: Colors.grey[300],
              ),
            );
          },
        ));
      },
    );
  }

  Widget usersBuilder(UserDataModel model, BuildContext context) =>
      InkWell(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: 25.0,
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
            ],
          ),
        ),
        onTap: () async {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return InnerChat(model);
          }));
        },
      );
}
