import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:renthouse/constants/constants.dart';
import 'package:renthouse/pages/login.dart';
import 'package:renthouse/service/database.dart';
import 'package:renthouse/service/shared_pref.dart';

class FirebaseAuthHelper{

  static FirebaseAuthHelper instance=FirebaseAuthHelper();

  FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  Stream<User?> get getAuthChange=>_auth.authStateChanges();

Future<bool> login(String email, String password, BuildContext context)async{  
try{
  showLoaderDialog(context);  
//await _auth.signInWithEmailAndPassword(email: email, password: password);
  await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      QuerySnapshot querySnapshot =
          await DatabaseMethods().getUserbyemail(email);

    //  try{  
    //    name = "${querySnapshot.docs[0]["Name"]}";
    //   // username = "${querySnapshot.docs[0]["username"]}";
    //   // pic = "${querySnapshot.docs[0]["Photo"]}";
    //   id = querySnapshot.docs[0].id;
    //  }catch(e){  
    //   print(e);
    //  }

    //   await SharedPreferenceHelper().saveUserDisplayName(name);
    //  // await SharedPreferenceHelper().saveUserName(username);
    //   await SharedPreferenceHelper().saveUserId(id);
     // await SharedPreferenceHelper().saveUserPic(pic);
Navigator.of(context).pop();
return true;

}on FirebaseAuthException catch(error){
  showMessage(error.code.toString());
  return false;  

}
}

Future<bool> signUp(String name,String email, String password, BuildContext context)async{  
try{
  showLoaderDialog(context);  

      UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
String Id=randomAlphaNumeric(10);
String user=email.replaceAll("@gmail.com", "");
String updateusername=user.replaceFirst(user[0], user[0].toUpperCase());
String firstletter=user.substring(0,1).toUpperCase();
print("Search key"+firstletter);
Map<String,dynamic> userInfoMap={
  "Name":name,
  "E-mail":email,
  "username":updateusername.toUpperCase(),
  "SearchKey":firstletter,
  "Photo":"https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg",
"Id":Id,
};

await DatabaseMethods().addUserDetails(userInfoMap, Id);
await SharedPreferenceHelper().saveUserId(Id);
await SharedPreferenceHelper().saveUserDisplayName(name);
await SharedPreferenceHelper().saveUserEmail(email);
await SharedPreferenceHelper().saveUserPic("https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg");
await SharedPreferenceHelper().saveUserName(email.replaceAll("@gmail.com", "").toUpperCase());
// Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Login()));
Navigator.of(context,rootNavigator: true).pop();

 Navigator.of(context).pop();

return true;

}on FirebaseAuthException catch(error){
  showMessage(error.code.toString());
  return false;  

}
}

void singOut()async{  
  await _auth.signOut();
}


Future<bool> changePassword(String password, BuildContext context)async{  
try{
  showLoaderDialog(context);
  _auth.currentUser!.updatePassword(password); 
  // UserCredential userCredential=await _auth.createUserWithEmailAndPassword(email: email, password: password);
// UserModel userModel=UserModel(id: userCredential.user!.uid,name: name,email: email,image: null);

// _firestore.collection("users").doc(userModel.id).set(userModel.toJson());
Navigator.of(context,rootNavigator: true).pop();
showMessage("Password Changed");
Navigator.of(context).pop();

return true;

}on FirebaseAuthException catch(error){
  showMessage(error.code.toString());
  return false;  

}
}


}