import 'package:flutter/material.dart';

class Products {
  final String name;
  final double price;

  Products({required this.name, required this.price});
}

class CategoryModel {
  final String address;
  final List<Products> products; // Add a property for storing products

  CategoryModel({required this.address, required this.products});
}
