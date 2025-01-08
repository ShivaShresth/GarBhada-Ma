import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/model/product_model.dart';
import 'package:renthouse/provider/app_provider.dart';

class BestOffer extends StatefulWidget {
  final String categoryName;
  final String categoryAddress; // New parameter

  BestOffer({Key? key, required this.categoryName, required this.categoryAddress}) : super(key: key);

  @override
  State<BestOffer> createState() => _BestOfferState();
}

class _BestOfferState extends State<BestOffer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Best Offer'),
                  Text('See All'),
                ],
              ),
              SizedBox(height: 10),
              Text(
                widget.categoryName, // Display the category address
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Consumer<AppProvider>(
                  builder: (context, appProvider, _) {
                  //  appProvider.getProductByCategory(widget.categoryName);
                    List<ProductModel> products = appProvider.productByCategoryLists;
                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        ProductModel product = products[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 5,
                                offset: Offset(2, 2),
                              )
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Uncomment if you want to display product images
                              // ClipRRect(
                              //   borderRadius: BorderRadius.circular(8),
                              //   child: Image.network(
                              //     product.image.isNotEmpty ? product.image[0] : '',
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
                              SizedBox(height: 10),
                              Text(product.name ?? ''),
                              SizedBox(height: 5),
                              Text(product.description ?? ''),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.favorite_outline),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
