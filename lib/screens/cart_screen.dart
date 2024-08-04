import 'package:shopping_app_jhonny_mustafa/providers/service_provider.dart';
import 'package:shopping_app_jhonny_mustafa/screens/add_place.dart';
import 'package:shopping_app_jhonny_mustafa/screens/payment_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:shopping_app_jhonny_mustafa/providers/product_service/product_service.dart';
import 'package:shopping_app_jhonny_mustafa/screens/home_screen.dart';

//import 'package:shopping_app_jhonny_mustafa/screens/payment_screen.dart';

//import 'package:shopping_app_jhonny_mustafa/providers/data_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double price = 0;
    double totalPrice = 0;
    double taxAndService = 0;
    double totalPayment = 0;

    List<String> Belanjaan = [];
    //double totalProduct = 0;
    String defaultAddress = "Jalan Panjang no.123 Jakarta";
    return Consumer<ServiceProvider>(
      builder: (context, value, child) {
        for (var cartModel in value.cart) {
          price = int.parse(cartModel.quantity.toString()) *
              int.parse(cartModel.price.toString()).toDouble();

          totalPrice += double.parse(price.toString());
          taxAndService = (totalPrice * 0.11).toDouble();
          totalPayment = totalPrice + taxAndService.toDouble();

          Belanjaan.add(cartModel.name.toString());
          //totalQuantity =

          defaultAddress = value.favPlaceItem.name.toString();
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cart'),

            // titleTextStyle: TextStyle(

            // ),
            // Tambah Alamat
          ),
          body: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: value.cart.length,
                itemBuilder: (context, index) {
                  final product = value.cart[index];

                  return ListTile(
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child:
                          //Image.network(product.imagePath![0].toString()),
                          Image.network(product.imagePath.toString()),

                      //    image: NetworkImage(
                      //    //product.images![0].toString(),
                      //    product.images![0].toString(),
                      //  ),

                      // child: Image.asset(
                      //   product.imagePath.toString(),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    title: Text(product.name.toString()),
                    subtitle:
                        Text('${product.quantity} x  ${product.price} USD'),
                    trailing: IconButton(
                      onPressed: () {
                        // value.removeFoodCart(food);
                        value.removeProductCart(product);
                        if (value.cart.isEmpty) {
                          price = 0;
                          totalPrice = 0;
                          taxAndService = 0;
                          totalPayment = 0;
                        } else {
                          context.read<ServiceProvider>();
                        }
                      },
                      icon: Icon(CupertinoIcons.minus_circle),
                    ),
                  );
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: Text('add more product'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddPlace(),
                    ),
                  );
                },
                child: Text('add place'),
              ),
              Text(value.favPlaceItem.name.toString()),
            ],

            // actions: [
            //   IconButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const AddPlace(),
            //         ),
            //       );
            //     },
            //     icon: const Icon(Icons.add),
            //   ),
            // ],
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(8),
            width: MediaQuery.sizeOf(context).width,
            // height: 200,
            // color: Colors.blue,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Price'),
                          Text('USD $totalPrice'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Tax and Service'),
                          Text('USD $taxAndService'),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Price',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'USD $totalPayment',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                CupertinoButton(
                  color: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.all(20),
                  borderRadius: BorderRadius.circular(30),
                  onPressed: () {
                    //final product2 = value.cart[index];
                    //addToCart();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(
                            purchasedItems: Belanjaan,
                            totalAmount: totalPayment,
                            shippingAddress: defaultAddress),
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
