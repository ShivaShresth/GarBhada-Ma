import 'package:flutter/material.dart';
import 'package:renthouse/Profile%20Screen/term_conditions.dart';

class About_GarBhadama extends StatefulWidget {
  const About_GarBhadama({super.key});

  @override
  State<About_GarBhadama> createState() => _About_GarBhadamaState();
}

class _About_GarBhadamaState extends State<About_GarBhadama> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation:1,
        title:Text(
                    "About Us",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ) ,
         leading: InkWell(
          onTap: (){  
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios)),
              backgroundColor: Colors.white,

      ),
      body: Container(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
            
              SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Welcome to Ghar-Bhadama",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                  "Ghar-Bhadama.com provides services to those who want torent their properties. It is an online marketplace for those who want to deal with properties in Nepal. It is a platform where the buyer and the seller can deal with the properties directly with each other. Bhar-Bhadama.com is simply a bridge between the buyers and the sellers."),
              SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Our Vision",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                  "If you are someone who wants to rent your properties at a good price then you can post the details about your properties in Ghar-Bhadama.com"),
              SizedBox(
                height: 10,
              ),
              Text(
                  "Ghar-Bhadama.com reviews the information you have provided about your property and publishes it on the website for the public to see. To make the property look nicer in the website, Ghar-Bhadama.com provides you professional photography services. These photos are carefully edited to make it more attractive so that buyers can contact you. Fees are applicable for onsite professional photography services."),
              SizedBox(
                height: 10,
              ),
              Text(
                  "You can start posting your property in the catogry 'Normal listing' on the website which is free of cost. If you want to post your property as featured, which is shown on the homepage, you can request a fetured listing with additional applicable fees. For more details about Ghar-Bhadama.com services, please visit here. Once the property is rent, it will be removed from the website."),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Our Mission",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                  "If you are a buyer, you can find a lot of nice properties and directly contact and negotiate with the sellers."),
              SizedBox(
                height: 10,
              ),
              Text(
                  "If you are thinking of letting our properties for rent, you can also put your property details so that those who are seeking for properties for rent will contact you."),
              SizedBox(
                height: 10,
              ),
              Text(
                  "Information about the properties listed in the site is taken from the consent of the sellers. In case of the wrong information, the seller will be responsible for that. Ghar-Bhadama.com is not responsible for any wwrong information provided by the sellers."),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text("See more for "),
                    InkWell(
                    
                         onTap: (){  
                    Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Term_Conditions()));
                        
                      },
                      child: Text(
                        "Terms and Conditions",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
