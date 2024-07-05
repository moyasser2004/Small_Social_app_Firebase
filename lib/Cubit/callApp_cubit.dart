import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Model/userdata_model.dart';





abstract class CallAppStates{}
class CallAppInitState extends CallAppStates{}


class CallAppLoadingLogin extends CallAppStates{}
class CallAppLoadingSigIn extends CallAppStates{}
class CallAppLoadingCreate extends CallAppStates{}

class CallAppSuccessLogin extends CallAppStates{
  final String uId;
  CallAppSuccessLogin(this.uId);
}

class CallAppSuccessSigIn extends CallAppStates{}
class CallAppSuccessCreate extends CallAppStates{}

class CallApPErrorLogin extends CallAppStates{
 final String error;
 CallApPErrorLogin(this.error);
}
class CallApPErrorSigIn extends CallAppStates{
  final String error;
  CallApPErrorSigIn(this.error);
}
class CallApPErrorCreate extends CallAppStates{
  final String error;
  CallApPErrorCreate(this.error);
}

class CallAppObse extends CallAppStates{}
class CallAppObse1 extends CallAppStates{}
class CallAppObses extends CallAppStates{}


class CallAppCubit extends Cubit<CallAppStates>{

  CallAppCubit():super(CallAppInitState());

  static CallAppCubit  get(context)=> BlocProvider.of(context);

  Future<void> sigIn({
   required TextEditingController email,
   required TextEditingController password,
   required TextEditingController passwordConfirm,
   required TextEditingController name,
   required BuildContext context,
  }) async {
      emit(CallAppLoadingLogin());
      
    if (password.text.trim() == passwordConfirm.text.trim()) {

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim()
      ).then((value) async {
        emit(CallAppSuccessLogin(value.user!.uid));
        await createUser(
          email:email.text.trim().toString() ,
          name:name.text.trim().toString() ,
          password: password.text.trim().toString(),
          uId:value.user!.uid.toString(),
        );

      }).catchError((error) {
        emit(CallApPErrorLogin(error.toString()));
        if (kDebugMode) {
          print(error.toString());
        }
      });
      Navigator.of(context).pushReplacementNamed("Auth");
    }
  }

  

  Future<void> logIn({
    required TextEditingController email,
    required TextEditingController password,
    required BuildContext context,
}) async {
    emit(CallAppLoadingSigIn());
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim() 
    ).then((vall) {
      emit(CallAppSuccessSigIn());
      if (kDebugMode) {
        print("UID====${vall.user!.uid}");
      }
    }).catchError((error) {
      emit(CallApPErrorSigIn(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
    Navigator.of(context).pushReplacementNamed("Auth");
  }



  Future createUser({
    required String email,
    required String uId,
    required String name,
    required String password,
   })async{
    emit(CallAppLoadingCreate());
    
    UserDataModel model=UserDataModel(
      email:email ,
      name: name,
      uId: uId,
      password: password,
      coverImage: "https://tse3.mm.bing.net/th?id=OIP.eluLjywG2GQ4-gyh0aboHgHaEK&pid=Api&P=0&h=180" ,
      bio: "hello",
      prImage: "https://images.ctfassets.net/hrltx12pl8hq/7yQR5uJhwEkRfjwMFJ7bUK/dc52a0913e8ff8b5c276177890eb0129/offset_comp_772626-opt.jpg?fit=fill&w=800&h=300"
    );
    
    await FirebaseFirestore.instance.collection(
      "user"
    ).doc(uId).set(
      model.toJson()
    ).then((value){
      emit(CallAppSuccessCreate());
    }).catchError((error){
      emit(CallApPErrorCreate(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }


  bool  obscure0=false;
  bool  obscure1=false;
  bool obscure2=false;


  void  obscureChange(){
    obscure0=!obscure0;
    emit(CallAppObse());
  }

  void  obscur1eChange(){
    obscure1=!obscure1;
    emit(CallAppObse1());
  }

  void  obscurseChange(){
    obscure2=!obscure2;
    emit(CallAppObses());
  }

}



















