import 'package:flutter/material.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenFacebook extends StatefulWidget {
  final CategoryModel? categoryModel;
  const OpenFacebook({super.key,required this.categoryModel});

  @override
  _OpenFacebookState createState() => _OpenFacebookState();
}

class _OpenFacebookState extends State<OpenFacebook> {
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    // Simulating the delay to fetch data
    Future.delayed(Duration(seconds: 0), () {
      setState(() {
        _isDataLoaded = true;
      });
      // Check if categoryModel and its facebook field are not null
      if (widget.categoryModel != null && widget.categoryModel!.facebook!.isNotEmpty) {
        _openFacebook();
      }
    });
  }

  // Function to open Facebook URL
  Future<void> _openFacebook() async {
    final categoryModel = widget.categoryModel;
    if (categoryModel != null && categoryModel.facebook!.isNotEmpty) {
      final Uri url = Uri.parse(categoryModel.facebook!);

      try {
        // Attempt to open Facebook URL in browser or Facebook app
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } catch (e) {
        print("Cannot launch URL: $e");
        // Optionally, show an alert or dialog if the URL can't be opened
      }
    } else {
      // Handle the case where categoryModel or facebook is null
      print("Category model or Facebook URL is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if data is loaded, show loading indicator if not
    if (!_isDataLoaded) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Once data is loaded, show the relevant content
    return Scaffold(
      appBar: AppBar(
        title: Text("Open Facebook"),
      ),
      body: Center(
        child: Text("Facebook is ...${widget.categoryModel!.facebook!}"),
      ),
    );
  }
}
