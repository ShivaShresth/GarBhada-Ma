import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:renthouse/firebase_firestore/firebase_firestore.dart';
import 'package:renthouse/google_map/direct_to_map.dart';
import 'package:renthouse/google_map/geolocation.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/model/product_model.dart';
import 'package:renthouse/provider/app_provider.dart';
import 'package:url_launcher/url_launcher.dart';
class About extends StatefulWidget {
   final CategoryModel? categoryModel;

  const About({super.key, this.categoryModel});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {

    List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];

  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();

    getCategoryList();
   
    super.initState();
  }

  bool isLoading = false;

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    // // FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
    // categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    // productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();

    // productModelList.shuffle();

    setState(() {
      isLoading = false;
    });
  }  
  Uri dialnumber=Uri(scheme: 'tel',path:'1234567890');
   
   callnumber()async{  
    await launchUrl(dialnumber);
   }

   directcall()async{   
    await FlutterPhoneDirectCaller.callNumber('1234567890');
   }

   Position? _currentLocation;
    late bool servicePermission = false;
    late LocationPermission permission;
     String? address1;
    String _currentAddress = "";
    Future<Position> _getCurrentLocation() async {
      servicePermission = await Geolocator.isLocationServiceEnabled();
      if (!servicePermission) {
        print("Service disabled");
      }
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      return await Geolocator.getCurrentPosition();
    }


    _getAddressFromCoordinates()async{  
      try{  
        List<Placemark> placesmarks=await placemarkFromCoordinates(_currentLocation!.latitude, _currentLocation!.longitude);
        Placemark place=placesmarks[0];
          Placemark placemark = placesmarks.first;
      String address = "${placemark.name}, ${placemark.locality}, ${placemark.country}";
      

        setState(() {
          _currentAddress="${place.locality},${place.country}";
address1=address;
        });
      }catch(e){ 
        print(e);
      }
    }

    @override
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10,right: 10,top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'About',
          //   style: Theme.of(context)
          //       .textTheme
          //       .headline1!
          //       .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          // ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Text(
                    "About",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor:
                            Colors.grey, // Optional: Set the underline color
                        decorationThickness: 3,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              GestureDetector(
                onTap: (){
                  callnumber();  
                  
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Center(
                    child: Text(
                      "Chat",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor:
                              Colors.grey, // Optional: Set the underline color
                          decorationThickness: 3,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
                            SizedBox(width: 10,),

              GestureDetector(
                onTap: ()async{  
    //                   Future.delayed(Duration(seconds: 0),()async{   
    //    _currentLocation = await _getCurrentLocation();
    //               await _getAddressFromCoordinates();
    // });
                 //Navigator.push(context, MaterialPageRoute(builder: (context)=>GeolocationApp()));
                    _currentLocation = await _getCurrentLocation();
                  await _getAddressFromCoordinates();
                  _launchMap();

                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                  decoration: BoxDecoration(  
                    border: Border.all(color: Colors.grey),
                    
                  ),
                  child: Center(
                    child: Text("Location",style: TextStyle( decoration: TextDecoration.underline,
                        decorationColor: Colors.grey, // Optional: Set the underline color
                        decorationThickness: 3, fontSize: 20,fontWeight: FontWeight.bold ),),
                  ),
                ),
              ),
                
            ],
          ),

          SizedBox(
            height: 10,
          ),
          Text(
           // "${widget.categoryModel!.name}",
           "${widget.categoryModel!.description} hi",
      
          ),
        ],
      ),
    );
  }

  
  Future<void> _launchMap() async {
    // Replace these coordinates with the desired location
    // double latitude = 37.7749;
    // double longitude = -122.4194;
     double latitude = 27.69786;
    double longitude = 85.34729;

    //  double latitude = double.parse(widget.categoryModel!.latitude);
    // double longitude = double.parse(widget.categoryModel!.longitude);
    print(widget.categoryModel!.latitude);
    print(longitude);

    String mapUrl = 'geo:$latitude,$longitude?q=$latitude,$longitude';

    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      throw 'Could not launch $mapUrl';
    }
  }
}
