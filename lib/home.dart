// import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:ml_classifier/disease.dart';
// import 'package:ml_classifier/tomato/tomato_detection.dart';
// import './history.dart';
// import './tomato/tomato_detection.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// ignore: unused_import
import 'package:ml_classifier/widgets/ui_elements/title_default.dart';
// import 'package:ml_classifier/history.dart';
// import 'package:tflite/tflite.dart';
import './widgets/ui_elements/logout_list_tile.dart';
// import './pepper/pepper_detection.dart';
// import './tomato/tomato_detection.dart';
// import './potato/potato_detection.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.greenAccent[700],
            automaticallyImplyLeading: false,
            title: Text('Choose'),
            // backgroundColor: Color(0xFF558B2F),
          ),
          ListTile(
            // leading: Icon(Icons.edit),
            title: Text('Animal Intrusion History'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/history');
            },
          ),
          ListTile(
            // leading: Icon(Icons.edit),
            title: Text('Potato'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/potato');
            },
          ),
          ListTile(
            // leading: Icon(Icons.edit),
            title: Text('Tomato'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/tomato');
            },
          ),
          ListTile(
            // leading: Icon(Icons.edit),
            title: Text('Pepper'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/pepper');
            },
          ),
          Divider(),
          LogoutListTile()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return MaterialApp(
        theme: new ThemeData(scaffoldBackgroundColor: Colors.green[50]),
//        theme: ThemeData.light().copyWith(
//          platform: _platform ?? Theme.of(context).platform,
//        ),
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
//                appBar: AppBar(
//                  title: Text(title),
//                ),

              drawer: _buildSideDrawer(context),
              appBar: AppBar(
                title: Text(
                  'AgriSafe',
                  style: GoogleFonts.roboto(),
                ),
                backgroundColor: Colors.greenAccent[700],
                // Color(0xFF558B2F),
                // leading: IconButton(
                //   icon: Icon(Icons.arrow_back),
                //   onPressed: () => Navigator.pop(context),
                // ),
              ),
              body: SafeArea(
                child: Column(children: <Widget>[
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeInImage(
                            alignment: Alignment.center,
                            image: NetworkImage(
                              'https://thefederal.com/file/2019/04/Elephant.jpg',
                            ),
                            fit: BoxFit.cover,

                            // fit: EdgeInsets.all(10.0),
                            height: 100.0,
                            // width: 250,
                            placeholder: AssetImage('assets/lion.jpeg'),
                            // alignment: Alignment.center,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        // Container(
                        //   padding: EdgeInsets.all(10.0),
                        //   child: TitleDefault("Tom"),
                        // ),
                        // _buildAddressPriceRow(product.price),
                        // ignore: deprecated_member_use
                        RaisedButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.white)),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/history');
                          },
                          color: Colors.green[50],
                          child: Text('Animal Intrusion History',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ],
                    ),
                    // color: Colors.green[50],
                    height: MediaQuery.of(context).size.height /
                        2.2, // Also Including Tab-bar height.
                    //  child: Chewie(
                    //    controller: _chewieController,
                    //  ),
                  ),
                  // ignore: missing_required_param
                  PreferredSize(
                    preferredSize: Size.fromHeight(50.0),
                    child: Container(
                      color: Colors.white,
                      child: TabBar(
                        // indicatorColor: Colors.black,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),

                            // Creates border
                            color: Colors.greenAccent),
                        tabs: [
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            width: 100,
                            height: 40,
                            child: Tab(
                              text: 'Tomato',
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            width: 100,
                            height: 40,
                            child: Tab(
                              text: 'Pepper',
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.all(10.0),
                              width: 100,
                              height: 40,
                              child: Tab(
                                text: 'Potato',
                              ))
                        ], // list of tabs
                      ),
                    ),
                  ),

                  //TabBarView(children: [ImageList(),])
                  Expanded(
                    child: TabBarView(
                        // controller: _controller,
                        children: [
                          Column(children: [
                            SizedBox(
                              height: 30,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: FadeInImage(
                                image: NetworkImage(
                                    'https://upload.wikimedia.org/wikipedia/commons/8/89/Tomato_je.jpg'),
                                fit: BoxFit.cover,
                                // fit: EdgeInsets.all(10.0),
                                height: 100.0,
                                // width: 250,
                                placeholder: AssetImage('assets/tom.jpeg'),
                                alignment: Alignment.center,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.all(10.0),
                              child: TitleDefault("Tomato"),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            // _buildAddressPriceRow(product.price),
                            // ignore: deprecated_member_use
                            RaisedButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.white)),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/tomato');
                              },
                              color: Colors.green[50],
                              // child: Container(
                              //   decoration: const BoxDecoration(
                              //     gradient: LinearGradient(
                              //       colors: <Color>[
                              //         Color(0xFF69F0AE),
                              //         Color(0xFFB9F6CA),
                              //         Color(0xFFA5D6A7),
                              //       ],
                              //     ),
                              //   ),
                              child: Text('Tomato Desease Detection',
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ]),
                          Column(children: [
                            SizedBox(
                              height: 30,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: FadeInImage(
                                image: NetworkImage(
                                    'https://i.ndtvimg.com/i/2015-11/black-pepper_625x350_51446463042.jpg'),
                                fit: BoxFit.cover,
                                // fit: EdgeInsets.all(10.0),
                                height: 100.0,
                                // width: 250,
                                placeholder: AssetImage('assets/pep.jpeg'),
                                alignment: Alignment.center,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.all(10.0),
                              child: TitleDefault("Pepper"),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            // _buildAddressPriceRow(product.price),
                            // ignore: deprecated_member_use
                            RaisedButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.white)),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/pepper');
                              },
                              color: Colors.green[50],
                              child: Text('Pepper Disease Detection',
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ]),
                          Column(children: [
                            SizedBox(
                              height: 30,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: FadeInImage(
                                image: NetworkImage(
                                    'https://img.etimg.com/thumb/width-1200,height-900,imgsize-1075623,resizemode-1,msid-79369073/news/economy/agriculture/potatoes-could-get-costlier-in-kolkata-price-may-hit-nearly-50/kg-in-retail-markets.jpg'),
                                fit: BoxFit.cover,
                                // fit: EdgeInsets.all(10.0),
                                height: 100.0,
                                // width: 250,
                                placeholder: AssetImage('assets/pot.jpeg'),
                                alignment: Alignment.topCenter,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            Container(
                              padding: EdgeInsets.all(10.0),
                              child: TitleDefault("Potato"),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            // _buildAddressPriceRow(product.price),
                            // ignore: deprecated_member_use
                            RaisedButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.white)),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/potato');
                              },
                              color: Colors.green[50],
                              child: Text('Potato Disease Detection',
                                  style: TextStyle(fontSize: 20)),
                            )
                          ]),
                        ]),
                  ),
                ]),
              )),
        ));
  }
}
