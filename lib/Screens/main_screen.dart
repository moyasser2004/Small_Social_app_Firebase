import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/Cubit/Screen_cubit.dart';
import 'package:loginscreen/const.dart';



class MainScreen extends StatefulWidget {

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var displayWidth=MediaQuery.of(context).size.width ;
    return  BlocProvider(
        create: (BuildContext context)=>AppScreenCubit()..getUsers()..getUserData()..getPost()..getUsers(),
        child: BlocConsumer<AppScreenCubit,AppScreenStates>(
         listener: (context,state){},
         builder: (context,state){
           AppScreenCubit c=AppScreenCubit.get(context);
           return Scaffold(
             appBar: AppBar(
               title: Text(c.listOfStrings[c.currentIndex]),
               elevation: 5.0,
               actions:  [
                 IconButton(
                   icon: const Icon(Icons.notification_add_outlined,),
                   onPressed: (){
                     Navigator.of(context).pushNamed("addPost");
                   },
                 ),IconButton(
                   icon: const  Icon(Icons.wechat_sharp,),
                   onPressed: (){
                     if (kDebugMode) {
                       print(U_I_D);
                     }
                   },
                 ),
               ],
             ),
             bottomNavigationBar: Container(
               margin: EdgeInsets.all(displayWidth * .05),
               height: displayWidth * .155,
               decoration: BoxDecoration(
                 color: Colors.white,
                 boxShadow: [
                   BoxShadow(
                     color: Colors.black.withOpacity(.1),
                     blurRadius: 10,
                     offset: const Offset(0, 10),
                   ),
                 ],
                 borderRadius: BorderRadius.circular(50),
               ),
               child: ListView.builder(
                 itemCount: 4,
                 scrollDirection: Axis.horizontal,
                 padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
                 itemBuilder: (context, index) => InkWell(
                   onTap: () {
                     setState(() {
                       c.changeIndex(index);
                     });
                   },
                   splashColor: Colors.transparent,
                   highlightColor: Colors.transparent,
                   child: Stack(
                     children: [
                       AnimatedContainer(
                         duration: const Duration(seconds: 1),
                         curve: Curves.fastLinearToSlowEaseIn,
                         width: index == c.currentIndex
                             ? displayWidth * .32
                             : displayWidth * .18,
                         alignment: Alignment.center,
                         child: AnimatedContainer(
                           duration: const Duration(seconds: 1),
                           curve: Curves.fastLinearToSlowEaseIn,
                           height: index == c.currentIndex ? displayWidth * .12 : 0,
                           width: index == c.currentIndex ? displayWidth * .32 : 0,
                           decoration: BoxDecoration(
                             color: index == c.currentIndex
                                 ? Colors.blueAccent.withOpacity(.3)
                                 : Colors.transparent,
                             borderRadius: BorderRadius.circular(50),
                           ),
                         ),
                       ),
                       AnimatedContainer(
                         duration: const Duration(seconds: 1),
                         curve: Curves.fastLinearToSlowEaseIn,
                         width: index == c.currentIndex
                             ? displayWidth * .31
                             : displayWidth * .18,
                         alignment: Alignment.center,
                         child: Stack(
                           children: [
                             Row(
                               children: [
                                 AnimatedContainer(
                                   duration: const Duration(seconds: 1),
                                   curve: Curves.fastLinearToSlowEaseIn,
                                   width:
                                   index == c.currentIndex ? displayWidth * .13 : 0,
                                 ),
                                 AnimatedOpacity(
                                   opacity: index == c.currentIndex ? 1 : 0,
                                   duration: const Duration(seconds: 1),
                                   curve: Curves.fastLinearToSlowEaseIn,
                                   child: Text(
                                     index == c.currentIndex
                                         ? c.listOfStrings[index]:"",
                                     style: const TextStyle(
                                       color: Colors.black,
                                       fontWeight: FontWeight.w600,
                                       fontSize: 15,
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                             Row(
                               children: [
                                 AnimatedContainer(
                                   duration: const Duration(seconds: 1),
                                   curve: Curves.fastLinearToSlowEaseIn,
                                   width:
                                   index == c.currentIndex ? displayWidth * .03 : 20,
                                 ),
                                 Icon(
                                   c.listOfIcons[index],
                                   size: displayWidth * .076,
                                   color: index == c.currentIndex
                                       ? Colors.red[400]
                                       : Colors.black26,
                                 ),
                               ],
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
             ),
             body: c.screens[c.currentIndex],
           );
         },
    )
    );
  }
}




