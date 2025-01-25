import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renthouse/constants/constants.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/provider/app_provider.dart';

class Update_Profile extends StatefulWidget {
  final CategoryModel categoryModel;
  final int index;

  const Update_Profile({Key? key, required this.categoryModel, required this.index})
      : super(key: key);

  @override
  State<Update_Profile> createState() => _Update_ProfileState();
}

class _Update_ProfileState extends State<Update_Profile> {
  TextEditingController addressController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  bool _isToggled = false; // For managing the toggle (switch) button
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize with existing values from categoryModel
    addressController.text = widget.categoryModel.address;
    rentController.text = widget.categoryModel.rent;
    _isToggled = widget.categoryModel.isFavourite; // Set initial value for toggle
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Update The Personal Information"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Input Address
                  Text("Input Address"),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: addressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Address cannot be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Address",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Input Rent
                  Text("Input Rent"),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: rentController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Rent cannot be empty";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter Rent",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Occupancy Status (Switch)
                  Row(
                    children: [
                      Text(
                        _isToggled ? 'UnOccupied' : 'Occupied',
                        style: TextStyle(
                          fontSize: 20,
                          color: _isToggled ? Colors.green : Colors.red,
                        ),
                      ),
                      Switch(
                        value: _isToggled,
                        onChanged: (bool newValue) {
                          setState(() {
                            _isToggled = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Update Button
                  MaterialButton(
                    color: Colors.blue,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Update Firestore data if form is valid
                        _updateProfile();
                      }
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to update Firestore
  Future<void> _updateProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        // User is not logged in, handle this case
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("User not logged in."),
        ));
        return;
      }

      // Get the DocumentReference
      final viewId = widget.categoryModel.viewId;
      DocumentReference doc = FirebaseFirestore.instance
          .collection("cat")
          .doc(user.uid)
          .collection("cats")
          .doc(viewId);

      // Ensure rent is a valid number
      String rentValue;
      try {
        rentValue = rentController.text;
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Invalid rent value. Please enter a valid number."),
        ));
        return;
      }

      // Perform Firestore update
      await doc.update({
        'address': addressController.text,
        'rent': rentValue.toString(),
        'isFavourite': _isToggled, // Add the toggle status here
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Profile updated successfully"),
      ));

      // Optionally, navigate back or close the screen
      Navigator.pop(context);
    } catch (error) {
      // Show error message if update fails
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error: $error"),
      ));
    }
  }
}
