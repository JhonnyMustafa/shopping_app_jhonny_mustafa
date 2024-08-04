//import 'dart:ffi';
//import 'dart:convert';
//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:shopping_app_jhonny_mustafa/models/user_login.dart';
import 'package:shopping_app_jhonny_mustafa/providers/service_provider.dart';
import 'package:shopping_app_jhonny_mustafa/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    //required this.user,
  });

  //final UserLogin user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ServiceProvider serviceProvider = ServiceProvider();

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ServiceProvider>(context, listen: false).fetchProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Product'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ServiceProvider>(context, listen: false)
                  .fetchProduct();
            },
            icon: const Icon(Icons.download),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            Provider.of<ServiceProvider>(context, listen: false).fetchProduct(),
        child: Consumer<ServiceProvider>(
          builder: (context, value, child) {
            //handle error
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (value.errorMessage != null) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: Text(value.errorMessage.toString()),
                        actions: [
                          TextButton(
                            onPressed: () {
                              serviceProvider.clearErrorMessage();
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    });
              }
            });
            if (value.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                children: List.generate(
                  value.product.length,
                  (index) {
                    final product = value.product[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigasi ke halaman lain di sini
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailScreen(
                                product: product,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              //product.images![0].toString(),
                              product.images![0].toString(),
                            ),
                            fit: BoxFit.cover,
                            onError: (exception, stackTrace) => const SizedBox(
                              height: 100,
                              width: 100,
                              child: FlutterLogo(),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
