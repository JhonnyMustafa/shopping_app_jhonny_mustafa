import 'package:shopping_app_jhonny_mustafa/providers/service_provider.dart';
import 'package:shopping_app_jhonny_mustafa/screens/cart_screen.dart';
import 'package:flutter/cupertino.dart';
//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import '../providers/service_provider.dart';
import 'package:shopping_app_jhonny_mustafa/models/product.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int quantityCount = 0;
  int constPayment = 0;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ServiceProvider>(context, listen: false)
        .fetchDetailProduct(widget.product.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      //extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.brown,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 10,
              child: Icon(Icons.arrow_back),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                );
              },
              icon: Icon(
                CupertinoIcons.cart,
                size: 26,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: widget.product.images!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // return ListTile(
                    //   leading: Image.network(widget.product.images.first),
                    //   title: Text('Gambar $index'),
                    // );

                    return Image.network(widget.product.images![0].toString());

                    // image: DecorationImage(
                    //         image: NetworkImage(
                    //           //product.images![0].toString(),
                    //           product.images![0].toString(),
                    //         ),
                    //         fit: BoxFit.cover,
                    //         onError: (exception, stackTrace) => const SizedBox(
                    //           height: 100,
                    //           width: 100,
                    //           child: FlutterLogo(),
                    //         ),
                    //       ),
                  }

                  // Image.asset(
                  //image: DecorationImage(image: AssetImage(food[]))
                  //widget.product.images[0].toString(),
                  //  fit: BoxFit.cover,
                  //),
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Price',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.product.price} USD',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.favorite_outline),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     // for (int i = 0; i < 5; i++)
                  //     //   Icon(
                  //     //     Icons.star,
                  //     //     color: Colors.yellow,
                  //     //   ),
                  //     // SizedBox(width: 10),
                  //     // Text(
                  //     //   '${widget.product.rating}',
                  //     //   style: TextStyle(),
                  //     // ),
                  //   ],
                  // ),
                  SizedBox(height: 10),
                  Text(
                    '${widget.product.description}',
                    style: TextStyle(),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            )
          ],
        ),
      ),

      //bar utk ambil jumlah barang
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.brown,
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            FloatingActionButton(
              heroTag: 'add',
              backgroundColor: Color.fromARGB(99, 197, 97, 97),
              elevation: 0,
              onPressed: () {
                setState(() {
                  quantityCount++;
                  constPayment = quantityCount *
                      int.parse(widget.product.price.toString());
                });
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            FloatingActionButton(
              heroTag: 'w',
              backgroundColor: Colors.transparent,
              elevation: 0,
              onPressed: () {},
              child: Text(
                quantityCount.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FloatingActionButton(
              heroTag: 'rem',
              backgroundColor: Color.fromARGB(99, 197, 97, 97),
              elevation: 0,
              onPressed: () {
                setState(() {
                  if (quantityCount > 0) {
                    quantityCount--;
                    constPayment = quantityCount *
                        int.parse(
                          widget.product.price.toString(),
                        );
                  }
                });
              },
              child: const Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),

            const SizedBox(width: 10),
            Expanded(
              child: FloatingActionButton(
                heroTag: 't',
                backgroundColor: const Color.fromARGB(109, 140, 94, 91),
                elevation: 0,
                onPressed: () {
                  //addToCart();
                  if (quantityCount > 0) {
                    //penggunaan provider
                    final cart = context.read<ServiceProvider>();
                    cart.addToCart(widget.product, quantityCount);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'USD  $constPayment',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Add to cart ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //),
          ],
        ),
      ),
    );
  }
}
