import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:random_string/random_string.dart';
import 'package:renthouse/constants/constants.dart';
import 'package:renthouse/constants/custom_theme.dart';
import 'package:renthouse/pages/bottom_navigation_bar.dart';
import 'package:renthouse/pages/forget_password.dart';
import 'package:renthouse/pages/singup.dart';
import 'package:renthouse/service/database.dart';
import 'package:renthouse/service/shared_pref.dart';
import 'package:renthouse/widgets/custom_text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "", password = "", name = "", confirmPassword = "",id="";
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      QuerySnapshot querySnapshot =
          await DatabaseMethods().getUserbyemail(email);

     try{  
       name = "${querySnapshot.docs[0]["Name"]}";
      // username = "${querySnapshot.docs[0]["username"]}";
      // pic = "${querySnapshot.docs[0]["Photo"]}";
      id = querySnapshot.docs[0].id;
     }catch(e){  
      print(e);
     }

      await SharedPreferenceHelper().saveUserDisplayName(name);
     // await SharedPreferenceHelper().saveUserName(username);
      await SharedPreferenceHelper().saveUserId(id);
     // await SharedPreferenceHelper().saveUserPic(pic);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Bottom_Navigation_Bar()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
      }else{  
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.78,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF7f30fe), Color(0xFF6380fb)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 105.0))),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top:125,left: 5,right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Login GarBhadaMa Account",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Signup to get Started",
                          style: TextStyle(
                              color: Color(0xFFbbb0ff),
                              fontSize: 18.0,
                      
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 50,),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 10.0),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    
                                   
                                    SizedBox(
                                      height: 10,
                                    ),
                                 
                                    CustomTextField(
                                      hintText: "ABC@gmail.com",
                                      label: "Email",
                                      prefixIcon: Icons.email_outlined,
                                      controller: emailController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Email Cannot be empty";
                                        } else if (EmailValidator.validate(value)) {
                                          return null;
                                        } else {
                                          return "Plese enter valid email address";
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                   
                                   
                                    CustomTextField(
                                      controller: passwordController,
                                      hintText: "Enter Password",
                                      label: "Password",
                                      prefixIcon: Icons.lock_outline,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Password Cannot be empty";
                                        } else if (value.length < 6) {
                                          return "Password must be at least 6 character long";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                   
                            
                                  
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),   
                  SizedBox(height: 60,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  email = emailController.text;
                                  password = passwordController.text;
                                });
                              }
                              bool isloginVaildation=loginVaildation(emailController.text, passwordController.text);

       if(isloginVaildation){  
        userLogin();
            // Navigator.of(context).pop();

     
       }        
                            },
                            child: Center(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.0),
                                width: MediaQuery.of(context).size.width,
                                child: Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF6380fb),
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Center(
                                          child: Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(onPressed: (){
                                            Navigator.push(context, PageTransition(child: Forget_Password(), type: PageTransitionType.fade,duration: Duration(milliseconds: 400)));

                              }, child: Text("Forget Password?",style: TextStyle(color: Colors.black),))),
                          ),
                          SizedBox(
                      height: 15.0,
                      ),
                      
                            Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: (){
                                        Navigator.push(context, PageTransition(child: SingUP(), type: PageTransitionType.fade,duration: Duration(milliseconds: 400)));
  
                          },
                          child: Text(
                            "SignUP",
                            style: TextStyle(
                                color: Color(0xFF7f30fe), fontSize: 16.0),
                          ),
                        ),
                      ],
                      ),
                       SizedBox(
                      height: 5.0,
                      ),
                        ],
                      ),
                       
                     
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
