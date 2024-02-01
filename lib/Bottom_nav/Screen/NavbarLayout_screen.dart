import 'package:e_commerce_app_bloc/Bottom_nav/BottomLayout/BottomLayOut.dart';
import 'package:e_commerce_app_bloc/Bottom_nav/Ui/Bottem_navbar.dart';
import 'package:e_commerce_app_bloc/Home/Ui/Home_screen_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class NavbarLayout extends StatefulWidget {
  const NavbarLayout({super.key});

  @override
  State<NavbarLayout> createState() => _NavbarLayoutState();
}

class _NavbarLayoutState extends State<NavbarLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (kIsWeb) {
          return HomeWeb();
        }
        return BottomAdminLAyout();
      },
    );
  }
}
