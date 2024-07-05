import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginscreen/Model/postdata_model.dart';
import 'package:loginscreen/Screens/inner_screen/home.dart';
import 'package:loginscreen/const.dart';
import 'dart:io';
import '../Model/userdata_model.dart';
import '../Model/usersChat_model.dart';
import '../Screens/inner_screen/chats.dart';
import '../Screens/inner_screen/setting.dart';
import '../Screens/inner_screen/user.dart';
import '../shared/sharedHelper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;




abstract class AppScreenStates{}
class  AppScreenInstate extends AppScreenStates{}


class AppScreenLoading extends AppScreenStates{}
class AppScreenSuccess extends AppScreenStates{}
class AppScreenBoNavBar extends AppScreenStates{}


class SocialUserUpdateLoadingState extends AppScreenStates{}

class SocialPostLoadingState extends AppScreenStates{}
class SocialPostSuccessState extends AppScreenStates{}
class SocialPostErrorState extends AppScreenStates{}

class SocialUploadProfileImageErrorState extends AppScreenStates{}

class SocialProfileImagePickedSuccessState extends AppScreenStates{}
class SocialProfileImagePickedErrorState extends AppScreenStates{}

class SocialPostImagePickedSuccessState extends AppScreenStates{}
class SocialPostImagePickedErrorState extends AppScreenStates{}

class UploadPostLoadingState extends AppScreenStates{}

class GetPostLoadingState  extends AppScreenStates{}

class GetUsersLoadingState  extends AppScreenStates{}
class UpdateUserLoadingState extends AppScreenStates{}


class GetPostSuccessState  extends AppScreenStates{}

class GetUsersSuccessState  extends AppScreenStates{}

class UploadPostErrorState extends AppScreenStates{}
class UploadPostSuccessState extends AppScreenStates{}


class AppScreenLikeLoading extends AppScreenStates{}
class AppScreenLikeSuccess extends AppScreenStates{}



class  UpdateUserErrorState extends AppScreenStates{
  final String error;
  UpdateUserErrorState(this.error);
}

class  GetPostErrorState extends AppScreenStates{
  final String error;
  GetPostErrorState(this.error);
}

class  GetUsersErrorState extends AppScreenStates{
  final String error;
  GetUsersErrorState(this.error);
}

class AppScreenError extends AppScreenStates{
 final String error;
  AppScreenError(this.error);
}

class AppScreenLikeError extends AppScreenStates{
  final String error;
  AppScreenLikeError(this.error);
}


class AppScreenCubit extends Cubit<AppScreenStates>{

 AppScreenCubit():super(AppScreenInstate());

 static  AppScreenCubit get(context)=>BlocProvider.of(context);

 int currentIndex =0;

 void changeIndex(int i){
    currentIndex=i;
    if(currentIndex==1){
      getUsers();
    }
    emit(AppScreenBoNavBar());
 }

 List<Widget> screens=[
    const Home(),
    const Chats(),
    const Users(),
    const Setting(),
 ];

  List<String> listOfStrings=[
   "Home",
   "Chats",
   "Users",
   "Setting",
  ];

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.wechat_sharp,
    Icons.settings_rounded,
    Icons.person_outline_rounded,
  ];

  
  late UserDataModel model;
  
  void getUserData(){
    emit(AppScreenLoading());
    FirebaseFirestore.instance.collection("user").doc(U_I_D).get().then(
            (val){
          model = UserDataModel.fromJson(val.data()!);
          SharedPreferencesHelper.setUid(
            key:"uId" ,
            value:model.uId.toString(),
          ).then((value){
            if (kDebugMode) {
              print("UserDataModel==========${value.data()}");
            }
          }).catchError((error){});
          emit(AppScreenSuccess());
        }).catchError((error){
      emit(AppScreenError(error.toString())) ;
    });
  }



  File ? coverImage;
  var picker2 = ImagePicker();
  Future<void> getCoverImage() async {
    final pickedFile = await picker2.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      if (kDebugMode) {
        print(pickedFile.path);
      }
      emit(SocialProfileImagePickedSuccessState());
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
      emit(SocialProfileImagePickedErrorState());
    }
  }

 void uploadCoverImage({
    required String email,
    required String password,
  }){
     emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value)
      {
        updateUserData(
          email: email,
          password: password,
          coverImage: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }


  
  
 File ? profileImage;
 var picker = ImagePicker();

 Future<void> getProfileImage() async {
   final pickedFile = await picker.getImage(
     source: ImageSource.gallery,
   );

   if (pickedFile != null) {
     profileImage = File(pickedFile.path);
     if (kDebugMode) {
       print(pickedFile.path);
     }
     emit(SocialProfileImagePickedSuccessState());
   } else {
     if (kDebugMode) {
       print('No image selected.');
     }
     emit(SocialProfileImagePickedErrorState());
   }
 }

  void uploadProfileImage({
    required String email,
    required String password,
  }){
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value)
      {
        updateUserData(
          email: email,
          password: password,
          profileImage: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }


  void updateUserData({
    String? name,
    String ?email,
    String ?password,
    String ?coverImage,
    String ?bio,
    String ?profileImage,
  }){
      emit(UpdateUserLoadingState());
      UserDataModel mode = UserDataModel(
          email:email??model.email.toString(),
          name: name??model.name.toString(),
          uId: U_I_D ,
          password: password??model.password.toString(),
          coverImage: coverImage.toString(),
          bio: bio??model.bio.toString(),
          prImage: profileImage??model.prImage,
      );
      FirebaseFirestore.instance.collection("user").doc(U_I_D).update(mode.toJson()).then((vall){
        getUserData();
      }).catchError((error) {
        emit(UpdateUserErrorState(error.toString()));
      });

     if(profileImage==null||coverImage==null){
      emit(UpdateUserLoadingState());
      UserDataModel mode=UserDataModel(
        email:email??model.email.toString() ,
        name: name??model.name.toString() ,
        uId: U_I_D ,
        password: password??model.password,
        coverImage: coverImage??model.coverImage,
        bio: bio??model.bio,
        prImage: profileImage??model.prImage,
      );
      FirebaseFirestore.instance.collection("user").doc(U_I_D).update(mode.toJson()).then((vall){
        getUserData();
      }).catchError((error) {
        emit(UpdateUserErrorState(error.toString()));
      });
    }
  }



  
  /////posts

  File? postImage;
  var picker3 = ImagePicker();

  Future<void> getPostImage() async {
    final pickedFile = await picker3.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      if (kDebugMode) {
        print(pickedFile.path);
      }
      emit(SocialPostImagePickedSuccessState());
    } else {
      emit(SocialPostImagePickedErrorState());
    }
  }


  void uploadPostImage({
    required String? text,
    required String? data,
  }) {
    if (postImage == null) {
      emit(SocialPostImagePickedErrorState());
      upLoadPost(
        text: text,
        data: data,
      );
    }
    emit(SocialPostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('post/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        upLoadPost(
          postImage: value,
          text: text,
          data: data,
        );
        emit(SocialPostSuccessState());
      }).catchError((error) {
        emit(SocialPostErrorState());
      });
    }).catchError((error) {
      emit(SocialPostErrorState());
    });
  }


  void upLoadPost({
    String? name,
    String? uid,
    String? image,
    String? postImage,
    String? date,
    String? text,
    required String? data,
  }) {
    emit(UploadPostLoadingState());

    PostDataModel mode = PostDataModel(
      dateTime: data,
      image: model.prImage,
      name: model.name,
      text: text,
      postImage: postImage,
      uid: model.uId,
    );
    FirebaseFirestore.instance.collection("post").add(mode.toJson()).then((vall) {
      emit(UploadPostSuccessState());
    }).catchError((error) {
      emit(UploadPostErrorState());
    });
  }



//post like implementation

  List<PostDataModel> post=[];
  List<String> likes=[];
  List<int> likesNumbers=[];

  // List<String> comment=[];
  // List<dynamic> commentWords=[];
  // List<String> commentId=[];
  // List<int> commentNumbers=[];
   // List<String> check=[];

  void getPost(){
    emit(GetPostLoadingState());
    FirebaseFirestore.instance.collection("post").get().then((value){
      emit(GetPostSuccessState());

      value.docs.forEach((element){
        element.reference.collection("like").get().then((value){

          likes.add(element.id);
          post.add(PostDataModel.fromJson(element.data()));
          likesNumbers.add(value.docs.length);

        }).catchError((error){
          emit(GetPostErrorState(error));
        });
      });

      // value.docs.forEach((element){
      //   element.reference.collection("comment").get().then((value){
      //       commentNumbers.add(value.docs.length);
      //       comment.add(element.id);
      //     value.docs.forEach((e){
      //       commentWords.add(e.data().values);
      //       commentId.add(e.id);
      //     });
            // for(int i=0; i<commentId.length; i++) {
            //   for(int j=0; j<post.length; j++) {
            //     if(commentId[i]==post[j].uid){
            //       if (kDebugMode) {
            //         check.add(commentId[i]);
            //         print("=========${check}///////");
            //         break;
            //       }
            //     }
            //
            //   }
            // }
      //   }).catchError((error){
      //     emit(GetPostErrorState(error));
      //   });
      // });

    }).catchError((error) {
      emit(GetPostErrorState(error));
    });
  }




  void putLike({required String uId}){
    emit(AppScreenLikeLoading());
    FirebaseFirestore.instance.collection("post").
    doc(uId).
    collection("like").
    doc(model.uId).set({
      "like":true,
    }).
    then((value){
      emit(AppScreenLikeSuccess());
   }).catchError((error) {
      emit(AppScreenLikeError(error.toString()));
    });
  }


  // void getComment({required String uId,required String comment }){
  //   emit(AppScreenLikeLoading());
  //   FirebaseFirestore.instance.collection("post").
  //   doc(uId).
  //   collection("comment").
  //   doc(model.uId).set({
  //     "comment":comment,
  //   }).
  //   then((value){
  //     emit(AppScreenLikeSuccess());
  //   }).catchError((error) {
  //     emit(AppScreenLikeError(error.toString()));
  //   });
  // }
//chat Aplication


  // get users from firebase

  List<UserDataModel> users=[];

  void getUsers(){
    users=[];
    emit(GetUsersLoadingState());
    FirebaseFirestore.instance.collection("user").get().then((value){
      value.docs.forEach((element){
        if(element.data()["uId"]!=model.uId) {
          users.add(UserDataModel.fromJson(element.data()));
        }
      });
      emit(GetUsersSuccessState());
    }).catchError((error) {
      emit(GetUsersErrorState(error.toString()));
    });
  }






 // chat application

  void sendMessage({
  required String text,
  required String reciverId,
  required String date,
}){
    UsersMessages chat=UsersMessages(
      text:text ,
      senderId: model.uId,
      reciverId: reciverId,
      date: DateTime.now().toString(),
    );
//send message from me to reciver
    FirebaseFirestore.instance.collection("user")
    .doc( model.uId)
    .collection("chats")
    .doc(reciverId)
    .collection("messages")
    .add(chat.toJson()).then((value){

    }).catchError((error){

    });
//send message from reciver to me
    FirebaseFirestore.instance.collection("user")
        .doc(reciverId)
        .collection("chats")
        .doc( model.uId)
        .collection("messages")
        .add(chat.toJson()).then((value){

    }).catchError((error){

    });

   }

   List<UsersMessages> messages =[];

  void getMessage({
    required String ?reciverId,
 }){
    FirebaseFirestore.instance.collection("user")
        .doc(model.uId)
        .collection("chats")
        .doc(reciverId)
        .collection("messages")
        .snapshots()
        .listen((event){
          event.docs.forEach((element){
            messages.add(UsersMessages.fromJson(element.data()));
          });
    });

    emit(GetUsersSuccessState());

    }



  }







