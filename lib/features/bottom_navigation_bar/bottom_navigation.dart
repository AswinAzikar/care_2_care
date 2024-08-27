import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:care_to_care/constants.dart';
import 'package:flutter/material.dart';

const List<TabItem> items = [
  TabItem(
    icon: Icons.home,
    // title: 'Home',
  ),
  TabItem(
    icon: Icons.search_sharp,
    title: 'Shop',
  ),
  TabItem(
    icon: Icons.favorite_border,
    title: 'Wishlist',
  ),
  TabItem(
    icon: Icons.shopping_cart_outlined,
    title: 'Cart',
  ),
  TabItem(
    icon: Icons.account_box,
    title: 'profile',
  ),
];

class BottomNavigation extends StatelessWidget {
  static const String path = "/bottom_navigation";

  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomBarFloating(
        items: items,
        backgroundColor: Colors.white,
        color: Colors.grey,
        colorSelected: lightGreen);
  }
}
