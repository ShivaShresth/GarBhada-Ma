import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/provider/app_provider.dart';
import 'package:renthouse/screen/detail/slider/slider_screen.dart';

class DetailAppBar extends StatefulWidget {
  final CategoryModel? categoryModel;
  final int? plus;

  const DetailAppBar({super.key, this.categoryModel, this.plus});

  @override
  State<DetailAppBar> createState() => _DetailAppBarState();
}

class _DetailAppBarState extends State<DetailAppBar> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final appProvider = Provider.of<AppProvider>(context);

    // Safeguard against null categoryModel
    if (widget.categoryModel == null) return Container();

    return Container(
      child: Stack(
        children: [
          Container(
            color: Colors.green,
            height: 520,
            width: MediaQuery.of(context).size.width,
            child: SliderScreen(
              categoryModel: widget.categoryModel,
              plus: widget.plus!,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.all(5),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.124,
            right: 10,
            child: InkWell(
              onTap: () {
                setState(() {
                  // Toggle the isFavourite property
                  widget.categoryModel!.isFavourite =
                      !widget.categoryModel!.isFavourite;
                });

                // Update the favorite list in AppProvider
                if (widget.categoryModel!.isFavourite) {
                  print("Adding to favorites");
                  appProvider.addFavouriteProduct(
                      widget.categoryModel!, widget.categoryModel!.viewId!);
                } else {
                  print("Removing from favorites");
                  print("Removing from ${widget.categoryModel!.isFavourite}");

                  appProvider.removeFavouriteProduct(
                      widget.categoryModel!, widget.categoryModel!.viewId!);
                }

                print(
                    "Current favorites: ${appProvider.getFavouriteProductList}");
              },
              child: Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(5),
                child: Icon(
                  Icons.favorite,
                  color: widget.categoryModel!.isFavourite
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
