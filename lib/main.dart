import 'package:e_commerce_app_bloc/AddToCart/Ui/AddToCart_screen.dart';

import 'package:e_commerce_app_bloc/PoductDetails/Ui/ProductDetails_screen.dart';
import 'package:e_commerce_app_bloc/Router/Router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Splash_screen/Ui/Splash_screen.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyA1WnwF1O_nmMzMxboipdfDx1_PARRmWRw",
            authDomain: "flutterecommercebloc.firebaseapp.com",
            projectId: "flutterecommercebloc",
            storageBucket: "flutterecommercebloc.appspot.com",
            messagingSenderId: "554631294125",
            appId: "1:554631294125:web:37db40aeba2473ccf02a24"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyAppLayout());
}

class MyAppLayout extends StatelessWidget {
  const MyAppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (constext, constrains) {
        if (kIsWeb) {
          return MyAppWeb();
        }
        return MyApp();
      },
    );
  }
}

class MyAppWeb extends StatelessWidget {
  MyAppWeb({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          routerConfig: MyAppRoute().router,
          theme: ThemeData(
              primarySwatch: Colors.orange,
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.black),
                color: Colors.orange.shade50,
              )),
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          routes: {
            "productDetails_pg": (context) => ProductDetails(),
            "addTocart": (context) => AddToCart()
          },
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.orange,
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.black),
                color: Colors.orange.shade50,
              )),
          home: Splash(),
        );
      },
    );
  }
}
