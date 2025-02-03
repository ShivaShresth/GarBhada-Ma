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
    double height=MediaQuery.of(context).size.height;
    // AppProvider appProvider = Provider.of<AppProvider>(
    //   context,
    // );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Text(
              "Settings",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: BoxDecoration(  
              color: Colors.white
            ),
           // padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Align(
                          alignment: Alignment.topLeft, child: Text("MeanWhile",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(Icons.person,size: 80,),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: Column(
                    children: [
                      Divider(),
                      ListTile(
                        onTap: () {},
                        leading: Icon(Icons.edit),
                        title: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Edit_Page()));
                            },
                            child: Text("Edit")),
                      ),
                      Divider(),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => About_GarBhadama()));
            
                          // Routes.instance
                          // .push(widget: FavouriteScreen(), context: context);
                        },
                        leading: Icon(Icons.house_outlined),
                        title: Text("About GarBhadama"),
                      ),
                                          Divider(),
            
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PrivacyPolicy()));
                        },
                        leading: Icon(Icons.privacy_tip_outlined),
                        title: Text("Privacy Policy"),
                      ),
                                          Divider(),
            
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Term_Conditions()));
                        },
                        leading: Icon(Icons.list_alt_outlined),
                        title: Text("Term & Conditions"),
                      ),
                                          Divider(),
            
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Contact_Team()));
                        },
                        leading: Icon(Icons.email_outlined),
                        title: Text("Contact our team"),
                      ),
                                          Divider(),
            
                      ListTile(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          setState(() {});
                        },
                        leading: Icon(Icons.exit_to_app),
                        title: Text("Log Out"),
                      ),
                                          Divider(),
            
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
      ),
    );
  }
}
