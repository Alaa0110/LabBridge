// lib/views/app_bbn.dart

/*
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:navigation_view/item_navigation_view.dart';
import 'package:navigation_view/navigation_view.dart';
import 'package:get/get.dart';

import '../view/admin/drawer/screens/doctor_technical/show_technical_screen.dart';



class AppBBN extends StatelessWidget {
  const AppBBN({
    super.key,
    required bool atBottom,
  }) : _atBottom = atBottom;

  final bool _atBottom;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return NavigationView(
      onChangePage: (index) {
        // Navigate to corresponding page when tapped on the item
        switch (index) {
          case 0:
          // Profile Page

            break;
          case 1:
          // Settings Page

            break;
          case 2:
          // Navigate to ShowTechnical page
            Get.to(() => ShowTechnical());
            break;
          case 3:
          // Category Page

            break;
          case 4:
          // Home Page
           
            break;
        }
      },
      curve: Curves.fastEaseInToSlowEaseOut,
      durationAnimation: const Duration(milliseconds: 400),
      backgroundColor: const Color(0xffffffff),
      color: theme.primaryColorDark,
      items: [
        ItemNavigationView(
            childAfter: Icon(
              IconlyBold.profile,
              color: theme.primaryColorDark,
              size: 35,
            ),
            childBefore: Icon(
              IconlyBroken.profile,
              color: theme.primaryColorDark,
              size: 30,
            )),
        ItemNavigationView(
            childAfter: Icon(
              IconlyBold.setting,
              color: theme.primaryColorDark,
              size: 35,
            ),
            childBefore: Icon(
              IconlyBroken.setting,
              color: theme.primaryColorDark,
              size: 30,
            )),
        ItemNavigationView(
            childAfter: Icon(
              IconlyBold.buy,
              color: theme.primaryColorDark,
              size: 35,
            ),
            childBefore: Icon(
              IconlyBroken.buy,
              color: theme.primaryColorDark,
              size: 30,
            )),
        ItemNavigationView(
            childAfter: Icon(
              IconlyBold.category,
              color: theme.primaryColorDark,
              size: 35,
            ),
            childBefore: Icon(
              IconlyBroken.category,
              color: theme.primaryColorDark,
              size: 30,
            )),
        ItemNavigationView(
            childAfter: Icon(
              IconlyBold.home,
              color: theme.primaryColorDark,
              size: 35,
            ),
            childBefore: Icon(
              IconlyBroken.home,
              color: theme.primaryColorDark,
              size: 30,
            )),
      ],
    );
  }
}*/