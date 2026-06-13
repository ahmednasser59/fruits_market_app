import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/features/home/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:fruits_hub/features/home/presentation/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:fruits_hub/features/home/presentation/views/widgets/custom_home_app_bar.dart';

import 'widgets/main_view_body_bloc_consumer.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  static const routeName = 'home_view';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentViewIndex = 0;
  final GlobalKey<CustomBottomNavigationBarState> _navBarKey =
      GlobalKey<CustomBottomNavigationBarState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: NotificationListener<ProfileTabNotification>(
        onNotification: (notification) {
          setState(() {
            currentViewIndex = 3;
          });
          _navBarKey.currentState?.updateIndex(3);
          return true;
        },
        child: Scaffold(
          bottomNavigationBar: CustomBottomNavigationBar(
            key: _navBarKey,
            onItemTapped: (index) {
              currentViewIndex = index;
              setState(() {});
            },
          ),
          body: SafeArea(
            child:
                MainViewBodyBlocConsumer(currentViewIndex: currentViewIndex),
          ),
        ),
      ),
    );
  }
}
