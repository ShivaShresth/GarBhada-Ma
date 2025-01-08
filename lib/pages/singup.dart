import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:random_string/random_string.dart';
import 'package:renthouse/constants/constants.dart';
import 'package:renthouse/constants/custom_theme.dart';
import 'package:renthouse/constants/routes.dart';
import 'package:renthouse/firebase_helper/firebase_auth/firebasee_auth_helper.dart';
import 'package:renthouse/pages/bottom_navigation_bar.dart';
import 'package:renthouse/pages/login.dart';
import 'package:renthouse/screen/detail/detail.dart';
import 'package:renthouse/screen/home/home.dart';
import 'package:renthouse/service/database.dart';
import 'package:renthouse/service/shared_pref.dart';
import 'package:renthouse/widgets/custom_text_field.dart';


class SingUP extends StatefulWidget {
  const SingUP({super.key});

  @override
  State<SingUP> createState() => _SingUPState();
}

class _SingUPState extends State<SingUP> {
  String email = "", password = "", name = "" ,mobileNumber="";
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
    //TextEditingController confirmPasswordController = new TextEditingController();


  final _formKey = GlobalKey<FormState>();

registration()async{
  if(password!=null ){
    try{
        showLoaderDialog(context);  

      UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
String Id=randomAlphaNumeric(10);
String user=emailController.text.replaceAll("@gmail.com", "");
String updateusername=user.replaceFirst(user[0], user[0].toUpperCase());
String firstletter=user.substring(0,1).toUpperCase();
print("Search key"+firstletter);
Map<String,dynamic> userInfoMap={
  "Name":nameController.text,
  "E-mail":emailController.text,
  "username":updateusername.toUpperCase(),
  "SearchKey":firstletter,
  "Photo":"https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg",
"Id":Id,
};

await DatabaseMethods().addUserDetails(userInfoMap, Id);
await SharedPreferenceHelper().saveUserId(Id);
await SharedPreferenceHelper().saveUserDisplayName(nameController.text);
await SharedPreferenceHelper().saveUserEmail(emailController.text);
await SharedPreferenceHelper().saveUserPic("https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg");
await SharedPreferenceHelper().saveUserName(emailController.text.replaceAll("@gmail.com", "").toUpperCase());
Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Login()));
    }on FirebaseAuthException catch (e){
       showMessage(e.code.toString());
             Navigator.pop(context);

  return false;  
      // if(e.code=='weak-password'){
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //                       backgroundColor: Colors.orangeAccent,

      //     content: Text("Password Provided is too weak",style: TextStyle(fontSize: 18.0),)));
      // }else if(e.code=='email-already-in-use'){

      //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //             backgroundColor: Colors.orangeAccent,
      //             content: Text("Account Already exists",style: TextStyle(fontSize: 18.0),)));

      // }
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
                  padding: const EdgeInsets.only(top:20,left: 5,right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Create GarBhadaMa Account",
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
                      SizedBox(height: 10,),
                      Container(
                        margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 5),
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
                                      hintText: "Enter Full Name",
                                      label: "Full Name",
                                      prefixIcon: Icons.people_outline,
                                      controller: nameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Name Cannot be empty";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  
                                    SizedBox(
                                      height: 5,
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
                                      controller: mobileController,
                                      hintText: "Enter MobileNumber",
                                      label: "Mobile Number",
                                      prefixIcon: Icons.lock_outline,
                                      maximumLength: 10,
                                      
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Mobile Number Cannot be empty";
                                        } else if (value.length < 10) {
                                          return "Mobile Number must be at least 10 character long";
                                        } else {
                                          return null;
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
                                     
                                    // CustomTextField(
                                    //   controller:confirmPasswordController,
                                    //   hintText: "Enter Confirm Password",
                                    //   label: "Confirm Password",
                                    //   prefixIcon: Icons.lock_outline,
                                    //   validator: (value) {
                                    //     if (value == null || value.isEmpty) {
                                    //       return "Password Cannot be empty";
                                    //     } else if (value.length < 6) {
                                    //       return "Password must be same ";
                                    //     } else {
                                    //       return null;
                                    //     }
                                    //   },
                                    // ),
                                  
                                   
                                    
                              
                                  
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),   
                  SizedBox(height: 40,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: ()async{
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  email = emailController.text;
                                  name = nameController.text;
                                  password = passwordController.text;
                                 // confirmPassword = confirmPasswordController.text;
                                  mobileNumber=mobileController.text;

                                
                                });
                              }
                                
                            
                                                               print("name${name}");



                              bool isValidated= signUpVaildation(emailController.text, passwordController.text,nameController.text,mobileNumber.toString());

       if(isValidated){  
       bool isLogined=await FirebaseAuthHelper.instance.signUp(name,email, password,context,);
            Navigator.of(context).pop();

        if(isLogined){  
          Routes.instance.pushAndRomoveUnitl(widget: HomePage(), context: context);
        }
       }        
                          //                                 Navigator.of(context,rootNavigator: true).pop();

                          //      Navigator.of(context).pop();

                          // bool isLogined=await FirebaseAuthHelper.instance.signUp(name, email, password, context);
                          
                          // if(isLogined){  


                          //             Routes.instance.pushAndRomoveUnitl(widget: HomePage(), context: context);

                          // }
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
                                        "SignUP",
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
                                        Navigator.push(context, PageTransition(child:Login(), type: PageTransitionType.fade,duration: Duration(milliseconds: 400)));
  
                          },
                          child: Text(
                            "Login",
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
