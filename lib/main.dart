import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metanoia/models/cart_model.dart';
import 'package:metanoia/models/product_model.dart';
import 'package:metanoia/screens/cart_screen.dart';
import 'package:metanoia/widgets/product_item.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
      ChangeNotifierProvider(create: (context) => CartModel(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Metanoia'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          productList(),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => CartScreen())),
                child: Container(
                  margin: EdgeInsets.all(8),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Colors.orange,
                          Color(0xFFEE0B76),
                        ],
                      )),
                  child: Center(
                    child: Consumer<CartModel>(
                      builder: (context, cart, child) {
                        return Text(
                          'Checkout - \$${cart.totalPrice}',
                          style: GoogleFonts.cabin(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Product> _products = [];

  Future getProducts() async {
    var products = await Product.getProducts();
    setState(() {
      _products = products;
    });
  }

  Widget productList() {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      itemCount: _products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: .9,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return ProductItem(
          context: context,
          product: _products[index],
        );
      },
    );
  }
}
