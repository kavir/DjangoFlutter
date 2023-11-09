// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:guitar_app/data_service/guitar_service.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:guitar_app/signin.dart';
import 'package:guitar_app/data_service/cart.dart';
import 'addtocart.dart';
import 'package:http/http.dart' as http;


//import 'package:flutter/src/rendering/box.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const home(),
    );
  }
}

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  GuitarService guitarService = GuitarService();
  List<CartItem> cartItems = [];
  late List<Guitar> guitar;
  @override
  void initState() {
    super.initState();
  }
  /////////////////////////
  void addToCart(Guitar guitar)async{
    setState(() {
      CartItem newItem = CartItem(
        productId: guitar.id, // replace with the actual ID property
        productName: guitar.name,
        price: guitar.price_with_discount,
      );

      // Check if the item is already in the cart
      int index = cartItems.indexWhere((item) => item.productId == newItem.productId);

      if (index != -1) {
        // If the item is already in the cart, increase the quantity
        cartItems[index].quantity++;
      } else {
        // If the item is not in the cart, add it
        cartItems.add(newItem);
      }
      
    });
    final response = await http.post(
      'http://192.168.1.68:8000/admin/instrument/cartitem/${guitar.id}' as Uri,
      body: {'quantity': '1'},  // Adjust the quantity as needed
    );
    if (response.statusCode == 200) {
      showDialog(context: context, builder: (context)=>AlertDialog(
        content:const Text("Successfully added to the cart"),
        actions: [IconButton(onPressed: (){
          Navigator.pop(context);
          Navigator.pop(context);
        }, icon: const Icon(Icons.done))],

      ));
    } else {
      print('Failed to post data. Status code: ${response.statusCode}');
    }
   
  }



  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 202, 188, 188),
      appBar: AppBar(
        backgroundColor: Colors.white,
        // ignore: prefer_const_constructors
        leading: InkWell(child: Icon(Icons.menu, color: Colors.black)),
        actions: [
          InkWell(
            child: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
              // Handle the shopping cart action
            },
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                },
                child: Text(
                  "sign in",
                  style: TextStyle(),
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.01,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: size.height * 0.08,
                width: double.infinity,
                child: TextField(
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintText: "Search",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    suffixIcon: InkWell(
                        onTap: () {},
                        child: Material(
                          color: Colors.blue,
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  border: Border.all(color: Colors.black38),
                ),
                height: size.height * 0.05,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    },
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              borderRadius: BorderRadius.circular(8.00)),
                          child: Text("Guitar"),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              borderRadius: BorderRadius.circular(8.00)),
                          child: Text("Electric Guitar"),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              borderRadius: BorderRadius.circular(8.00)),
                          child: Text("Amplifiers"),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              borderRadius: BorderRadius.circular(8.00)),
                          child: Text("Drum Set"),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              borderRadius: BorderRadius.circular(8.00)),
                          child: Text("Uklele"),
                        ),
                      ],
                    ),
                  ),
                )),
            SizedBox(height: size.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage()),
                    );
                  },
                  child: Text(
                    "Guitar",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () {},
                  child: Text(
                    "Electric Guitar",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () {},
                  child: Text(
                    "Amp",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ),
            /////////////////////////////////////////////////
            FutureBuilder<ListOfGuitar>(
              future: guitarService.getGuitar(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While waiting for the future to complete, you can display a loading indicator.
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // Handle errors gracefully.
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  // Handle the case where the future completed without data.
                  return Text('No data available');
                } else {
                  // Data is available, proceed with displaying the list.
                  List<Guitar> guitars = snapshot.data!.guitars;

                  return Container(
                    margin: EdgeInsets.all(20),
                    height: size.height,
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Recently Sold Products",
                              style: TextStyle(fontSize: 22)),
                        ),
                        // if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){

                        // }
                        Expanded(
                          child: Wrap(
                            children: [
                              ...guitars.map((guitar) {
                                return Container(
                                  margin: EdgeInsets.all(10.0),
                                  height: size.height * 0.3,
                                  width: size.width * 0.4,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Image.memory(
                                          guitar.image_memory,
                                          height: 150,
                                          width: double.infinity,
                                          fit: BoxFit.fill,
                                        ),
                                      ),

                                      // Image.memory(guitar.image_memory,
                                      //     height: 150,
                                      //     width: double.infinity,
                                      //     fit: BoxFit.fill),
                                      Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment(0, 0.35),
                                            child: Text(
                                              guitar.name +
                                                  "   " +
                                                  guitar.model,
                                              style: TextStyle(
                                                  fontFamily:
                                                      "Charger Sport Black Extended"),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),

                                          ///////
                                          Align(
                                            alignment: Alignment(-0.9, 0.68),
                                            child: Text(
                                              "Rs.  ${guitar.price_with_discount}",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 5, 170, 41), //
                                                  fontFamily:
                                                      "Charger Sport Black Extended"),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment(0.9, 0.68),
                                            child: Text(
                                              guitar.discount != null &&
                                                      guitar.discount > 0
                                                  ? "Rs. ${guitar.price}"
                                                  : "", // Empty string when there's no discount
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color:
                                                    guitar.discount != null &&
                                                            guitar.discount > 0
                                                        ? Color.fromARGB(
                                                            255, 240, 106, 45)
                                                        : Color.fromARGB(
                                                            255, 0, 0, 0),
                                                fontFamily:
                                                    "Charger Sport Black Extended",
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),

                                          // Text(),
                                          Align(
                                            alignment: Alignment(0, 1.08),
                                            child: OutlinedButton(
                                              onPressed: () {addToCart(guitar);},
                                              child: Text("Add to cart"),
                                              style: ButtonStyle(
                                                minimumSize:
                                                    MaterialStateProperty.all(
                                                        Size(80, 30)),
                                                maximumSize:
                                                    MaterialStateProperty.all(
                                                        Size(120, 40)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
              },
            )

            // FutureBuilder<ListOfGuitar>(
            //     future: guitarService.getGuitar(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         List<Guitar> guitars = snapshot.data!.guitars;
            //         return Container(
            //           margin: EdgeInsets.all(20),
            //           height: size.height,
            //           width: double.infinity,
            //           color: Colors.white,
            //           child: Column(
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Text("Recently Sold Products",
            //                     style: TextStyle(fontSize: 22)),
            //               ),
            //               Wrap(
            //                 children: [
            //                   ...guitars.map((guitar) {
            //                     return Container(
            //                       margin: EdgeInsets.all(10.0),
            //                       height: size.height * 0.2,
            //                       width: size.width * 0.32,
            //                       decoration: BoxDecoration(
            //                           border: Border.all(color: Colors.blue),
            //                           borderRadius: BorderRadius.circular(8)),
            //                       child: Column(
            //                         children: [
            //                           Text(guitar.name),
            //                           Text("${guitar.price}"),
            //                           OutlinedButton(
            //                               onPressed: () {},
            //                               child: Text("Add to cart"))
            //                         ],
            //                       ),
            //                     );
            //                   }).toList(),
            //                 ],
            //               )
            //             ],
            //           ),
            //         );
            //       }
            //       return Container(
            //         margin: EdgeInsets.all(20),
            //         height: size.height,
            //         width: double.infinity,
            //         color: Colors.white,
            //         child: CircularProgressIndicator(),
            //       );
            //     }),
          ],
        ),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  Set<PointerDeviceKind> get dragDevice => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
