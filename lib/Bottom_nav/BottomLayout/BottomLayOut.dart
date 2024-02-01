import 'package:e_commerce_app_bloc/Bottom_nav/Ui/Bottem_navbar%20_admin.dart';
import 'package:e_commerce_app_bloc/Bottom_nav/Ui/Bottem_navbar.dart';
import 'package:e_commerce_app_bloc/Bottom_nav/bloc/admin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomAdminLAyout extends StatefulWidget {
  const BottomAdminLAyout({super.key});

  @override
  State<BottomAdminLAyout> createState() => _BottomAdminLAyoutState();
}

class _BottomAdminLAyoutState extends State<BottomAdminLAyout> {
  AdminBloc adminBloc = AdminBloc();
  @override
  void initState() {
    adminBloc.add(IsAdminEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminBloc, AdminState>(
      bloc: adminBloc,
      listenWhen: (previous, current) => current is AdminActionState,
      buildWhen: (previous, current) => current is! AdminActionState,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case IsAdminState:
            return BottomNavAdmin();
        }
        return BottomNav();
      },
    );
  }
}
