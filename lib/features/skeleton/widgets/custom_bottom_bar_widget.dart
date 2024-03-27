import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/user/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'custom_bottom_bar_icon_widget.dart';
import '../providers/selected_page_provider.dart';

class CustomBottomBarWidget extends StatelessWidget {
  CustomBottomBarWidget({Key? key}) : super(key: key);

  final List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      activeIcon: Icon(Icons.home_rounded),
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      activeIcon: Icon(Icons.book),
      icon: Icon(Icons.book),
      label: 'Kho từ',
    ),
    const BottomNavigationBarItem(
      activeIcon: Icon(Icons.travel_explore),
      icon: Icon(Icons.travel_explore_outlined),
      label: 'Tiện ích',
    ),
    const BottomNavigationBarItem(
      activeIcon: Icon(Icons.person),
      icon: Icon(Icons.person_outline),
      label: 'Tài khoản',
    ),
  ];

  // Provider.of<UserProvider>(context, listen:  false).userEntity.accountType == AccountType.admin ?

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    int selectedPage = Provider.of<SelectedPageProvider>(context).selectedPage;
    if (Provider.of<UserProvider>(context, listen: false)
            .userEntity!
            .accountType ==
        AccountType.admin) {
      items.add(
        const BottomNavigationBarItem(
          activeIcon: Icon(Icons.admin_panel_settings),
          icon: Icon(Icons.admin_panel_settings_outlined),
          label: 'Admin',
        ),
      );
    }
    return SafeArea(
      child: BottomNavigationBar(
        elevation: 10,
        showUnselectedLabels: true,
        items: items,
        currentIndex: selectedPage,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (value) {
          Provider.of<SelectedPageProvider>(context, listen: false)
              .changePage(value);
        },
      ),
    );
  }
}
