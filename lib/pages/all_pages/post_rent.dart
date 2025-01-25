import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostRent extends StatefulWidget {
  const PostRent({super.key});

  @override
  State<PostRent> createState() => _PostRentState();
}

class _PostRentState extends State<PostRent> {
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
        double width=MediaQuery.of(context).size.width;

    return   Container( 
      margin: EdgeInsets.only(bottom: 20,top: 20),
      padding: EdgeInsets.symmetric(vertical: 10,),
decoration: BoxDecoration(  
borderRadius: BorderRadius.circular(10),
color: Colors.blue
),
height: 220,
        width: width*0.95, 
        child:Column(  
          children: [  
            Row(  
              children: [  
                Container(

                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                  child: Column( 
                    crossAxisAlignment: CrossAxisAlignment.start, 
                    children: [  
                      Text("Post Your Room For Rent",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                      SizedBox(height: 10,),
                      Container(
                        width: 190,
                        child: Text("You just need to post your room, we will showcase it.",style: TextStyle(color: Colors.white,fontSize: 18),)),
                                              SizedBox(height: 10,),

                      MaterialButton(
                        color: Colors.green,
                        onPressed: (){},child: Text("POST FOR FREE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                    ],
                  ),
                )
              ],
            ),
          ],
        )
      );
    
  }
}