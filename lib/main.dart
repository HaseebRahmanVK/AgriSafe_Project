// import 'package:flutter/material.dart';
// import 'package:splashscreen/splashscreen.dart';

// import 'home.dart';

// void main() {
//   runApp(new MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: new MySplash(),
//     theme: new ThemeData(
//       primarySwatch: Colors.green,
//     ),
//   ));
// }

// class MySplash extends StatefulWidget {
//   @override
//   _MySplashState createState() => _MySplashState();
// }

// class _MySplashState extends State<MySplash> {
//   @override
//   Widget build(BuildContext context) {
//     return SplashScreen(
//       seconds: 5,
//       backgroundColor: Colors.white,
//       image: Image.asset("images/logo.jpeg"),
//       photoSize: 150.0,
//       loaderColor: Colors.green,
//       navigateAfterSeconds: HomePage(),
//       loadingText: Text(
//         "Welcome to plant Health",
//         style: new TextStyle(color: Colors.green, fontSize: 20.0),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:ml_classifier/history.dart';

import 'package:scoped_model/scoped_model.dart';
// import 'package:flutter/rendering.dart';

// import 'package:map_view/map_view.dart';

import './auth.dart';
import './potato/potato_detection.dart';
import './pepper/pepper_detection.dart';
import './tomato/tomato_detection.dart';
import './home.dart';
import './scoped-models/main.dart';
import './history.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
// import './pepper/pepper_detection.dart';
// import './potato/potato_detection.dart';
// import './models/product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  // MapView.setApiKey('AIzaSyAR-B2kgHg_ji4OVZqs0rjkwh6Rq3VxOIE');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  bool _isAuthenticated = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  //  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.of(context).pushReplacementNamed('/history');
    });

//  _firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         print("onMessage: $message");
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         print("onLaunch: $message");
//       },
//       onResume: (Map<String, dynamic> message) async {
//         print("onResume: $message");
//       },
//     );
//     Firebase.initializeApp().whenComplete(() {
//       print("completed");
//       setState(() {});
//     });
    _firebaseMessaging.getToken().then((String token) async {
      assert(token != null);
      print('Registration Id: $token');
    });

    _model.autoAuthenticate();
    _model.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        // debugShowMaterialGrid: true,
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepOrange,
            accentColor: Colors.deepPurple,
            buttonColor: Colors.deepPurple),
        home: !_isAuthenticated ? AuthPage() : HomePage(),
        routes: {
          // '/': (BuildContext context) =>
          //     !_isAuthenticated ? AuthPage() : HomePage(),
          '/history': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : AnimalHistory(_model),
          '/potato': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : PotatoDetection(),
          '/pepper': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : PepperDetection(),
          '/tomato': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : TomatoDetection(),
        },
        onGenerateRoute: (RouteSettings settings) {
          if (!_isAuthenticated) {
            return MaterialPageRoute<bool>(
                builder: (BuildContext context) => AuthPage());
          }
          if (_isAuthenticated) {
            return MaterialPageRoute<bool>(
                builder: (BuildContext context) => HomePage());
          }
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          // if (pathElements[1] == 'animal') {
          //   //   final String productId = pathElements[2];
          //   //   final Product product =
          //   //       _model.allProducts.firstWhere((Product product) {
          //   //     return product.id == productId;
          //   //   });

          //   return MaterialPageRoute<bool>(
          //     builder: (BuildContext context) =>
          //         !_isAuthenticated ? AuthPage() : HomePage(),
          //   );
          // }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) =>
                  !_isAuthenticated ? AuthPage() : HomePage());
        },
      ),
    );
  }
}
