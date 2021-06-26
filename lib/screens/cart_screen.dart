import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metanoia/models/cart_model.dart';
import 'package:metanoia/widgets/cached_image.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return Stack(
            children: [
              cart.items.isNotEmpty
                  ? ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 4, right: 4),
                          child: ListTile(
                            tileColor: Colors.white,
                            leading: CachedImage(
                              imageUrl: cart.items.keys.toList()[index].image,
                              height: 50,
                              width: 50,
                              assetFit: BoxFit.fill,
                              imageShape: BoxShape.rectangle,
                              defaultAssetImage: defaultProductImage,
                            ),
                            title: Text(
                              cart.items.keys.toList()[index].name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle:
                                Text('x${cart.items.values.toList()[index]}'),
                          ),
                        );
                      })
                  : Center(
                      child: Text(
                        'Cart is empty',
                        style:
                            GoogleFonts.lato(color: Colors.white, fontSize: 22),
                      ),
                    ),
              cart.items.isNotEmpty
                  ? Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () => cart.clear(),
                          child: Container(
                            margin: EdgeInsets.all(8),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Colors.orange,
                                    Color(0xFFEE0B76),
                                  ],
                                )),
                            child: Center(
                              child: Text(
                                'Clear Cart',
                                style: GoogleFonts.cabin(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }
}
