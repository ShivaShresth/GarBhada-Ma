import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:pinput/pinput.dart';
import 'package:renthouse/pages/bottom_navigation_bar.dart';
import 'package:renthouse/screen/home/home.dart';
import 'package:renthouse/widgets/custom_text_field.dart';

class OtpScreen extends StatefulWidget {


  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;
  @override
  Widget build(BuildContext context){
   // final isLoading=Provider.of<AuthProvider>(context,listen: true).isLoading;
    return  Scaffold(
      body: SafeArea(   
       // child:isLoading==true?Center(child:CircularProgressIndicator(),): Center(  
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding( 
              padding: EdgeInsets.only(right: 15,left: 15,top: 0), 
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Column( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center, 
                  children: [
                    Text("Recovery Password",style: TextStyle(color: Color.fromRGBO( 93, 46, 142,1),fontSize: 35,fontWeight: FontWeight.bold),),
                        
                 SizedBox(  
                          height: 40,
                        ),     
                        Container(  
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(   
                shape: BoxShape.circle,
                color:  Color.fromRGBO( 93, 46, 142,1)
                          ),
                          child: Icon(Icons.home_outlined,size: 180,color: Colors.white,),
                        ),
                        SizedBox(  
                          height: 10,
                        ),
                        Text("Ghar-Bhadma",style: TextStyle(color: Color.fromRGBO( 93, 46, 142,1),fontSize: 46,fontWeight: FontWeight.bold),),
                        SizedBox(  
                          height: 20,
                        ),
                        
                        Pinput( 
                          length: 6,
                          showCursor: true,
                          defaultPinTheme: PinTheme(   
                width: 60,
                height: 60,
                decoration: BoxDecoration(  
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.purple.shade200)
                ),
                textStyle: const TextStyle(  
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )
                          ),
                          onCompleted: (value){  
                setState(() {
                  otpCode=value;
                });
                          },
                        
                        ),
                        SizedBox(  
                          height: 30,
                        ),
                        SizedBox(  
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: MaterialButton( 
                           color: Color.fromRGBO( 93, 46, 142,1), 
                 minWidth: 200,
                child: Text("Verify",style: TextStyle(color: Colors.white),),
                onPressed: (){
                              Navigator.push(context, PageTransition(child:Bottom_Navigation_Bar(), type: PageTransitionType.fade,duration: Duration(milliseconds: 400)));
              
                        if(otpCode!=null){  
                         // verifyOtp(context, otpCode!);
                        }else{  
                          //showSnackBar(context, "Enter 6-Digit code");
                        }
                },
                          ),
                        ),
                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                    Text(  
                
                  "Didn't receive any code?"
                
                ),
                SizedBox(width: 10,),
                Text("Resend!",style: TextStyle( decoration: TextDecoration.underline,
                decorationColor: Colors.blue, // Optional: Set the underline color
                decorationThickness: 1.8,  ),)
                          ],
                        )
                        
                        
                        
                        ]),
              )),
          )));
  }

//   //verify otp
// void verifyOtp(BuildContext context, String userOtp){
//   //final ap=Provider.of<AuthProvider>(context,listen: false);
//   ap.verifyOtp(
//     context: context,
//      verificationId:widget.verificationId,
//       userOtp: userOtp, 
//       onSucess: (){ 
// ap.checkExistingUser().then((value)async{  
//   if(value==true){  
//     //user exists in our app
// ap.getDataFromSP().then((value) => ap.setSignIn().then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false)));
//   }else{  
//     //new user
//     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>UserInformationScreen()), (route) => false);
//   }
// });
//       });
// }



}

