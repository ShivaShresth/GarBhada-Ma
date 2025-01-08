import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:renthouse/constants/custom_theme.dart';
import 'package:renthouse/pages/otp_screen.dart';
import 'package:renthouse/pages/singup.dart';
import 'package:renthouse/widgets/custom_text_field.dart';

class Forget_Password extends StatefulWidget {
  const Forget_Password({super.key});

  @override
  State<Forget_Password> createState() => _Forget_PasswordState();
}

class _Forget_PasswordState extends State<Forget_Password> {
  String email = "", password = "", name = "", confirmPassword = "";
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

// registration()async{
//   if(password!=null  && password==confirmPassword){
//     try{
// //       UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
// // String Id=randomAlphaNumeric(10);
// String user=emailController.text.replaceAll("@gmail.com", "");
// String updateusername=user.replaceFirst(user[0], user[0].toUpperCase());
// String firstletter=user.substring(0,1).toUpperCase();
// print("Search key"+firstletter);
// Map<String,dynamic> userInfoMap={
//   "Name":nameController.text,
//   "E-mail":emailController.text,
//   "username":updateusername.toUpperCase(),
//   "SearchKey":firstletter,
//   "Photo":"https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg",
// "Id":Id,
// };

// await DatabaseMethods().addUserDetails(userInfoMap, Id);
// await SharedPreferenceHelper().saveUserId(Id);
// await SharedPreferenceHelper().saveUserDisplayName(nameController.text);
// await SharedPreferenceHelper().saveUserEmail(emailController.text);
// await SharedPreferenceHelper().saveUserPic("https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg");
// await SharedPreferenceHelper().saveUserName(emailController.text.replaceAll("@gmail.com", "").toUpperCase());
// Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Home()));
//     }on FirebaseAuthException catch (e){
//       if(e.code=='weak-password'){
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                             backgroundColor: Colors.orangeAccent,

//           content: Text("Password Provided is too weak",style: TextStyle(fontSize: 18.0),)));
//       }else if(e.code=='email-already-in-use'){

//                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                   backgroundColor: Colors.orangeAccent,
//                   content: Text("Account Already exists",style: TextStyle(fontSize: 18.0),)));

//       }
//     }
//   }
// }

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
                  padding: const EdgeInsets.only(top:90,left: 5,right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Forgot Password",
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
                          "Recover Your GarBhadaMa Password",
                          style: TextStyle(
                              color: Color(0xFFbbb0ff),
                              fontSize: 18.0,
                      
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 130,),
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
                                });
                              }
                              // registration();
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
                                          child: GestureDetector(
                                            onTap: (){
                                                          Navigator.push(context, PageTransition(child:OtpScreen(), type: PageTransitionType.fade,duration: Duration(milliseconds: 400)));
  
                                            },
                                            child: Text(
                                                                                  "RECOVER",
                                                                                  style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                                                                ),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
