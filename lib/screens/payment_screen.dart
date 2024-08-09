//import 'dart:developer';

//import 'package:shopping_app_jhonny_mustafa/models/user_login.dart';
import 'package:shopping_app_jhonny_mustafa/providers/service_provider.dart';
import 'package:shopping_app_jhonny_mustafa/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_jhonny_mustafa/models/user_login.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    super.key,
    required this.purchasedItems,
    required this.totalAmount,
    required this.shippingAddress,
  });

  final List<String> purchasedItems; // Data barang yang sudah dibeli
  final double totalAmount; // Total harga
  final String shippingAddress; // Alamat pemesanan

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  //String shippingAddress1 = shippingAddress;

  @override
  void initState() {
    // TODO: implement initState
    //Provider.of<ServiceProvider>(context, listen: false)
    //    .fetchDetailProduct(widget.product.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final authProvider = Provider.of<ServiceProvider>(context);
    // final currentUser = authProvider.userInfo;

    return Consumer<ServiceProvider>(
      builder: (context, value, child) {
        return Scaffold(
          //extendBodyBehindAppBar: true,
          //extendBody: true,
          appBar: AppBar(title: const Text('Payment Success')),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Thank You! Your Payment Succed'),
                const SizedBox(height: 16),
                const Text('Items:'),
                for (String item in widget.purchasedItems) Text('- $item'),
                const SizedBox(height: 16),
                //Text('Total Price: USD ${totalAmount.toStringAsFixed(2)}'),
                Text('Total Price: USD ' +
                    widget.totalAmount.toStringAsFixed(2)),
                const SizedBox(height: 16),
                const Text('Shipping Address: '),
                Text(widget.shippingAddress),

                // Image.asset(
                //   'assets/checkmark.png',
                //   color: const Color.fromARGB(102, 233, 156, 156),
                //   width: 200,
                // ),

                //Image(image: AssetImage('assets/check-mark.png'),),
                // Icon: Icon(CupertinoIcons.minus_circle),
              ],
            ),
          ),

          bottomNavigationBar: Container(
            padding: EdgeInsets.all(8),
            width: MediaQuery.sizeOf(context).width,
            // height: 200,
            // color: Colors.blue,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(
                //   margin: const EdgeInsets.only(bottom: 10),
                //   padding: const EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     border: Border.all(
                //       width: 1,
                //       color: Colors.grey,
                //     ),
                //   ),
                //   child: Column(
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text(
                //             'Total Price',
                //             style: TextStyle(
                //               fontSize: 18,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //           Text(
                //             'IDR $totalPayment',
                //             style: TextStyle(
                //               fontSize: 18,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //         ],
                //       )
                //     ],
                //   ),
                // ),
                //Tombol Konfirmasi
                CupertinoButton(
                  color: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.all(20),
                  borderRadius: BorderRadius.circular(30),
                  onPressed: () {
                    //final xxx = value.userInfo;

                    // final authProvider = Provider.of<ServiceProvider>(context);
                    // final currentUser = authProvider.userInfo;
                    //final UserLogin user = value.userInfo;
                    //Remove Cart();
                    for (var cartModel in value.cart) {
                      value.removeProductCart(cartModel);
                    }
                    print(value.userInfo.toString());

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        //builder: (context) => HomeScreen(user: value.userInfo),
                        builder: (context) => HomeScreen(user: value.userInfo),
                      ),
                    );
                    //Navigator.pop(context);

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder:  (context, value, child) =>
                    //         const HomeScreen(user: value),
                    //   ),
                    // );

                    //Navigator.pop(context, value.userInfo);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Back to Home',
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

// void main() {
//   runApp(MaterialApp(
//     home: PaymentScreen(
//       purchasedItems: ['Sepatu', 'Baju', 'Tas'],
//       totalAmount: 250000,
//       shippingAddress: 'Jl. Contoh No. 123, Kota Contoh',
//     ),
//   ));
// }
}
