import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metanoia/models/cart_model.dart';
import 'package:metanoia/models/product_model.dart';
import 'package:metanoia/widgets/cached_image.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ProductItem extends StatelessWidget {
  final BuildContext context;
  final Product product;

  ProductItem({Key key, this.context, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        _cartModel = cart;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(16)),
          ),
          margin: EdgeInsets.all(8),
          height: 210,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedImage(
                imageUrl: product.image,
                height: 140,
                assetFit: BoxFit.fill,
                imageShape: BoxShape.rectangle,
                defaultAssetImage: defaultProductImage,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.name,
                  style: GoogleFonts.cabin(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text('\$ ${product.price}'),
                  ),
                  addToCartBtn()
                ],
              )
            ],
          ),
        );
      },
    );
  }

  CartModel _cartModel;

  Widget addToCartBtn() {
    return InkWell(
      onTap: () => _cartModel.add(product),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Colors.orange,
                Color(0xFFEE0B76),
              ],
            )),
        child: Text(
          _cartModel.items.keys.toList().contains(product) ? 'Add more' : 'Add',
          style: GoogleFonts.cabin(color: Colors.white),
        ),
      ),
    );
  }
}
