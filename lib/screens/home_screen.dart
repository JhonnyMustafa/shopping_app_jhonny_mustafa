//import 'dart:ffi';
//import 'dart:convert';
//import 'package:cached_network_image/cached_network_image.dart';
import 'package:shopping_app_jhonny_mustafa/models/user_login.dart';
import 'package:shopping_app_jhonny_mustafa/providers/service_provider.dart';
import 'package:shopping_app_jhonny_mustafa/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
//import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.user,
  });

  final UserLogin? user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ServiceProvider serviceProvider = ServiceProvider();
  //UserLogin user1 = user;
  //UserLogin user1 = user;

  //TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ServiceProvider>(context, listen: false).fetchProduct();

    Provider.of<ServiceProvider>(context, listen: false).setUser(widget.user!);
    super.initState();
    //_tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: //Text('Hello,  ${user.name;} '),
              Text('Hello,  ${widget.user!.name.toString()}'),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'List Product',
              ),
              Tab(text: 'Favorites'),
              Tab(text: 'Tab 3'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Widget untuk setiap tab
            Center(
              child: Scaffold(
                appBar: AppBar(
                  //title: const Text('List Product'),
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
                      Provider.of<ServiceProvider>(context, listen: false)
                          .fetchProduct(),
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

                              String netimg = product.images![0].toString();

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
                                      // image: NetworkImage(
                                      //   //product.images![0].toString(),
                                      //   product.images![0].toString(),
                                      // ),
                                      image: FadeInImage.memoryNetwork(
                                        //product.images![0].toString(),
                                        placeholder: kTransparentImage,
                                        image: netimg,
                                      ).image,

                                      fit: BoxFit.cover,
                                      onError: (exception, stackTrace) =>
                                          const SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: FlutterLogo(),
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        product.title.toString(),
                                        //'asadasdasdasdasdasdasdas',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white, // Warna teks
                                        ),
                                      ),
                                      Text('USD ' + product.price.toString(),
                                          style: const TextStyle(
                                            fontSize: 24,
                                            color: Colors.white, // Warna teks
                                          )),
                                    ],
                                    // ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),

                  // Penggunaan di halaman lain:
                ),
              ),
            ),
            Center(child: Text('Konten Tab 2')),
            Center(child: Text('Konten Tab 3')),
          ],
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('List Product'),
    //     actions: [
    //       IconButton(
    //         onPressed: () {
    //           Provider.of<ServiceProvider>(context, listen: false)
    //               .fetchProduct();
    //         },
    //         icon: const Icon(Icons.download),
    //       ),
    //     ],
    //   ),
    //   body: RefreshIndicator(
    //     onRefresh: () =>
    //         Provider.of<ServiceProvider>(context, listen: false).fetchProduct(),
    //     child: Consumer<ServiceProvider>(
    //       builder: (context, value, child) {
    //         //handle error
    //         WidgetsBinding.instance.addPostFrameCallback((_) {
    //           if (value.errorMessage != null) {
    //             showDialog(
    //                 context: context,
    //                 builder: (context) {
    //                   return AlertDialog(
    //                     title: const Text('Error'),
    //                     content: Text(value.errorMessage.toString()),
    //                     actions: [
    //                       TextButton(
    //                         onPressed: () {
    //                           serviceProvider.clearErrorMessage();
    //                           Navigator.of(context).pop();
    //                         },
    //                         child: const Text('OK'),
    //                       ),
    //                     ],
    //                   );
    //                 });
    //           }
    //         });
    //         if (value.isLoading) {
    //           return const Center(
    //             child: CircularProgressIndicator(),
    //           );
    //         } else {
    //           return GridView.count(
    //             crossAxisCount: 2,
    //             childAspectRatio: 0.8,
    //             children: List.generate(
    //               value.product.length,
    //               (index) {
    //                 final product = value.product[index];
    //                 return GestureDetector(
    //                   onTap: () {
    //                     // Navigasi ke halaman lain di sini
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                         builder: (context) {
    //                           return DetailScreen(
    //                             product: product,
    //                           );
    //                         },
    //                       ),
    //                     );
    //                   },
    //                   child: Container(
    //                     height: 100,
    //                     width: 100,
    //                     margin: const EdgeInsets.all(8),
    //                     decoration: BoxDecoration(
    //                       image: DecorationImage(
    //                         image: NetworkImage(
    //                           //product.images![0].toString(),
    //                           product.images![0].toString(),
    //                         ),
    //                         fit: BoxFit.cover,
    //                         onError: (exception, stackTrace) => const SizedBox(
    //                           height: 100,
    //                           width: 100,
    //                           child: FlutterLogo(),
    //                         ),
    //                       ),
    //                     ),
    //                     child: Column(
    //                       children: [
    //                         Text(
    //                           product.title.toString(),
    //                           //'asadasdasdasdasdasdasdas',
    //                           style: const TextStyle(
    //                             fontSize: 14,
    //                             color: Colors.white, // Warna teks
    //                           ),
    //                         ),
    //                         Text('USD ' + product.price.toString(),
    //                             style: const TextStyle(
    //                               fontSize: 24,
    //                               color: Colors.white, // Warna teks
    //                             )),
    //                       ],
    //                       // ),
    //                     ),
    //                   ),
    //                 );
    //               },
    //             ),
    //           );
    //         }
    //       },
    //     ),
    //   ),
    // );
  }
}
