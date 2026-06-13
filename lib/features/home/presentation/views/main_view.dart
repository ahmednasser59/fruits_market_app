import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/services/get_it_service.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
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

  Future<bool> _onWillPop() async {
    // If not on home tab, go back to home tab
    if (currentViewIndex != 0) {
      setState(() {
        currentViewIndex = 0;
      });
      _navBarKey.currentState?.updateIndex(0);
      return false;
    }

    // Already on home tab — show exit dialog
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'الخروج من التطبيق',
          style: TextStyles.bold16,
          textAlign: TextAlign.center,
        ),
        content: const Text(
          'هل تريد الخروج من التطبيق؟',
          style: TextStyles.regular16,
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'البقاء',
              style: TextStyles.semiBold16.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'الخروج',
              style: TextStyles.semiBold16.copyWith(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );

    if (shouldExit == true) {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      }
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CartCubit>(),
      child: NotificationListener<ProfileTabNotification>(
        onNotification: (notification) {
          setState(() {
            currentViewIndex = 3;
          });
          _navBarKey.currentState?.updateIndex(3);
          return true;
        },
        // ignore: deprecated_member_use
        child: WillPopScope(
          onWillPop: _onWillPop,
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
      ),
    );
  }
}
