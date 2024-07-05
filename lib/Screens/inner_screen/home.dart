import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/Cubit/Screen_cubit.dart';

import '../../Model/postdata_model.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController commentController=TextEditingController();
  GlobalKey<FormState> commentKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<AppScreenCubit,AppScreenStates>(
      listener: (context,state) {},
      builder: (context,state) {
        return Scaffold(
            body:SafeArea(
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  child:Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: AppScreenCubit.get(context).post.length,
                        itemBuilder:(context,index){
                          return  buildPostItem(AppScreenCubit.get(context).post[index],context,index);
                        },
                        separatorBuilder: (context,index){
                          return Container(
                            padding: const EdgeInsets.all(8),
                            child: Divider(
                              height: 3,
                              thickness: 2,
                              color: Colors.grey[300],
                            ),
                          );
                        },


                      )
                    ],
                  )
              ),
            )
        );
      },
    );

  }


  Widget buildPostItem(PostDataModel model, BuildContext context,int index) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: const EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    "${ model.image}"
                )
              ),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                      children: [
                        Text(
                          '${model.name}',
                          style: const TextStyle(
                            height: 1.4,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.blueAccent,
                          size: 16.0,
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              IconButton(
                icon: const Icon(
                  Icons.more_horiz,
                  size: 20.0,
                ),
                onPressed: () {},
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            "${model.text}",
            style: Theme.of(context).textTheme.titleMedium,
          ),

           if(model.postImage!=null)
             Padding(
               padding: const EdgeInsets.only(
                 bottom: 10.0,
                 top: 1.0,
               ),
               child: SizedBox(
                 width: double.infinity,
                 child: Wrap(
                   children: [
                     Padding(
                       padding: const EdgeInsetsDirectional.only(
                         end: 6.0,
                       ),
                       child: SizedBox(
                         height: 25.0,
                         child: MaterialButton(
                           onPressed: () {},
                           minWidth: 1.0,
                           padding: EdgeInsets.zero,
                           child: Text(
                             '#software',
                             style:
                             Theme.of(context).textTheme.bodySmall?.copyWith(
                               color: Colors.blueAccent,
                             ),
                           ),
                         ),
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsetsDirectional.only(
                         end: 6.0,
                       ),
                       child: SizedBox(
                         height: 25.0,
                         child: MaterialButton(
                           onPressed: () {},
                           minWidth: 1.0,
                           padding: EdgeInsets.zero,
                           child: Text(
                             '#flutter',
                             style:
                             Theme.of(context).textTheme.bodySmall?.copyWith(
                               color: Colors.blueAccent,
                             ),
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
             ),
          if(model.postImage!=null)
             Padding(
               padding: const EdgeInsets.all(10),
               child: Container(
                 height: 220.0,
                 width: double.infinity,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(
                     4.0,
                   ),
                   image:  DecorationImage(
                     image: NetworkImage(
                         "${model.postImage}"
                     ),
                     fit: BoxFit.cover,
                   ),
                 ),
               ),
             ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child:  const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.heart_broken_rounded,
                            size: 16.0,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),



                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.wechat_sharp,
                            size: 16.0,
                            color: Colors.amber,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '120 comment',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: 18.0,
                      backgroundImage:NetworkImage(
                          "${AppScreenCubit.get(context).model.prImage}"
                      )
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  // Container(
                  //     height: 40,
                  //     width: 150,
                  //     decoration: BoxDecoration(
                  //         color: Colors.grey[300],
                  //         borderRadius: BorderRadius.circular(20)),
                  //     child: Form(
                  //      // key:commentKey ,
                  //       child: TextFormField(
                  //         textAlign: TextAlign.start,
                  //         keyboardType: TextInputType.text,
                  //         controller: commentController,
                  //         decoration:  InputDecoration(
                  //           icon: SizedBox(
                  //             width: 30,
                  //             child: IconButton(
                  //               icon: Icon( Icons.text_increase_rounded,color: Colors.grey[500],),
                  //               onPressed: (){
                  //               },
                  //             ),
                  //           ),
                  //           border: InputBorder.none,
                  //           // errorMaxLines: 1,
                  //           errorBorder: InputBorder.none,
                  //           hintText: " Add comment :",
                  //
                  //           hintStyle: const TextStyle(
                  //               fontSize: 15,
                  //               color: Colors.black, fontWeight: FontWeight.w400),
                  //         ),
                  //         validator: (String? value) {
                  //           if (value!.isEmpty) {
                  //             return "confirm password not equal password ";
                  //           }else{
                  //             return null;
                  //           }
                  //         },
                  //         onFieldSubmitted: (val) {
                  //             AppScreenCubit.get(context).getComment(
                  //               uId: AppScreenCubit.get(context).comment[index],
                  //               comment: commentController.text.trim().toString(),
                  //
                  //             );
                  //         },
                  //       ),
                  //     )),
                ],
              ),
              InkWell(
                child: const Row(
                  children: [
                    Icon(
                      Icons.heart_broken_rounded,
                      size: 16.0,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                  // if(AppScreenCubit.get(context).check[0]==model.uid)
                  //   Text(
                  //     //'${model.uid}',
                  //     style: Theme.of(context).textTheme.bodySmall,
                  //   ),
                  ],
                ),
                onTap: () {
                 // AppScreenCubit.get(context).test();
                 // print(AppScreenCubit.get(context).commentWords);
                  AppScreenCubit.get(context).putLike(uId: AppScreenCubit.get(context).likes[index]);
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );


}


