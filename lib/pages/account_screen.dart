
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:renthouse/Profile%20Screen/about_garbhadama.dart';
import 'package:renthouse/Profile%20Screen/contact_team.dart';
import 'package:renthouse/Profile%20Screen/privacy_policy.dart';
import 'package:renthouse/Profile%20Screen/term_conditions.dart';
import 'package:renthouse/pages/all_pages/alter_page.dart';
import 'package:renthouse/pages/all_pages/order2.dart';
import 'package:renthouse/pages/edit_profile.dart';


class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    // AppProvider appProvider = Provider.of<AppProvider>(
    //   context,
    // );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 1, top: 4),
                child: Column(
                  children: [
                   // appProvider.getUserInformation.image == null
                        // ? Icon(
                        //     Icons.person_outline,
                        //     size: 120,
                        //   )
                        // : 
                        
                        // CircleAvatar(
                        //     backgroundImage: NetworkImage(
                        //         //appProvider.getUserInformation.image!
                        //         ),
                        //     radius: 70,
                        //   ),
                        Icon(Icons.person,size: 150,),
                    Text("Bikram Kumar Shrestha",
                     // appProvider.getUserInformation.name,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text("Flutter Developer",
                      //appProvider.getUserInformation.email,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    SizedBox(
                      width: 130,
                      // child: PrimaryButton(
                      //   title: "Edit Profile",
                      //   onPressed: () {
                      //     Routes.instance
                      //         .push(widget: EditProfile(), context: context);
                      //   },
                      // ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.shopping_bag_outlined),
                      title: GestureDetector(
                        onTap: (){ 
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>Edit_Page()));
                        },
                        child: Text("Edit")),
                    ),
                    ListTile(
                      onTap: () {
                                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>About_GarBhadama()));

                            // Routes.instance
                            // .push(widget: FavouriteScreen(), context: context);
                      },
                      leading: Icon(Icons.favorite_outline),
                      title: Text("About GarBhadama"),
                    ),
                    ListTile(
                      onTap: () {
                                                                          Navigator.push(context,MaterialPageRoute(builder: (context)=>PrivacyPolicy()));

                      },
                      leading: Icon(Icons.info_outline),
                      title: Text("Privacy Policy"),
                    ),
                    ListTile(
                      onTap: () {
               Navigator.push(context,MaterialPageRoute(builder: (context)=>Term_Conditions()));

                      },
                      leading: Icon(Icons.change_circle),
                      title: Text("Term & Conditions"),
                    ),
                    ListTile(
                      onTap: () {
                                       Navigator.push(context,MaterialPageRoute(builder: (context)=>Contact_Team()));

                      },
                      leading: Icon(Icons.support_outlined),
                      title: Text("Contact our team"),
                    ),
                    ListTile(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        setState(() {});
                      },
                      leading: Icon(Icons.exit_to_app),
                      title: Text("Log Out"),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text("Version 1.0.0"),
                    SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
