import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renthouse/constants/constants.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/provider/app_provider.dart';

class Update_Profile extends StatefulWidget {
  final CategoryModel categoryModel;
  final int index;
  const Update_Profile({Key? key, required this.categoryModel, required this.index}) : super(key: key);

  @override
  State<Update_Profile> createState() => _Update_ProfileState();
}

class _Update_ProfileState extends State<Update_Profile> {
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      body: Consumer<AppProvider>(
        builder: (context, value, child) {
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Hello"),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: widget.categoryModel.address,
                  ),
                ),
                MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    CategoryModel categoryModel = widget.categoryModel.copyWith(address: name.text);
                    appProvider.updateUserList(widget.index, categoryModel);
                    showMessage("Update Successfully");
                  },
                  child: Text("Update"),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
