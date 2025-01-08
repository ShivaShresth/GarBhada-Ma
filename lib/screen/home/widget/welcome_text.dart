import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:renthouse/firebase_firestore/firebase_firestore.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(  
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [  
              GestureDetector(
                onTap: (){  
                  FirebaseFirestoreHelper.instance.addProducts();
                },
                child: Text("Welcome Shiva,",  
           //     style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16,fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10,),
              Text(" Ghar-BhadaMa",  
            //  style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 20,fontWeight: FontWeight.bold),
              )
            ],
          ),
  CircleAvatar(
                  backgroundImage: AssetImage(  
                    'assets/b.png'
                  ),
                ),        ],
      ),
    );
  }
}