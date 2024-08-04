import 'dart:async';
//import 'dart:developer';

import 'package:shopping_app_jhonny_mustafa/models/favorite_place.dart';
import 'package:shopping_app_jhonny_mustafa/models/product.dart';
import 'package:shopping_app_jhonny_mustafa/providers/product_service/product_service.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app_jhonny_mustafa/models/cart_model.dart';

class ServiceProvider extends ChangeNotifier {
  ServiceProvider();

  ProductService productService = ProductService();
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Product> _product = [];
  List<Product> get product => _product;

  Product _detailProduct = new Product();
  //Product get detailProduct => _detailProduct;

  final List<CartModel> _cart = [];

  List<CartModel> get cart => _cart;

  Future<void> fetchProduct() async {
    _isLoading = true;
    notifyListeners();

    try {
      _product = await productService
          .getProduct()
          .timeout(const Duration(seconds: 10));
    } on TimeoutException {
      _errorMessage = 'Request timeout';
    } catch (e) {
      _errorMessage = 'Error : $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearErrorMessage() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> fetchDetailProduct(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      _detailProduct = await productService
          .getDetailProduct(id)
          .timeout(const Duration(seconds: 10));
    } on TimeoutException {
      _errorMessage = 'Request timeout';
    } catch (e) {
      _errorMessage = 'Error : $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  void addToCart(Product product, int qty) {
    _cart.add(
      CartModel(
        name: product.title,
        price: product.price.toString(),
        imagePath: product.images![0].toString(),
        //product.images![0].toString(),
        quantity: qty.toString(),
      ),
    );
    notifyListeners();
  }

  void removeProductCart(CartModel item) {
    _cart.remove(item);
    notifyListeners();
  }

  //final List<FavoritePlaceItem> _favPlaceItem = [];
  final _favPlaceItem =
      FavoritePlaceItem(name: '', image: '', location: '', lat: 0.0, lng: 0.0);

  // List<FavoritePlaceItem> get favPlaceItem => _favPlaceItem;
  FavoritePlaceItem get favPlaceItem => _favPlaceItem;

  void addPlace(FavoritePlaceItem item) {
    // _favPlaceItem.add(
    //   FavoritePlaceItem(
    //     name: item.name,
    //     image: item.image,
    //     location: item.location,
    //     lat: item.lat,
    //     lng: item.lng,
    //   ),
    // );

    _favPlaceItem.name = item.name;
    _favPlaceItem.image = item.image;
    _favPlaceItem.location = item.location;
    _favPlaceItem.lat = item.lat;
    _favPlaceItem.lng = item.lng;

    notifyListeners();
  }
}
