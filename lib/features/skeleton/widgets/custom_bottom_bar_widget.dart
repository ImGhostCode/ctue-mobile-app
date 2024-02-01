import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'custom_bottom_bar_icon_widget.dart';
import '../providers/selected_page_provider.dart';

class CustomBottomBarWidget extends StatelessWidget {
  const CustomBottomBarWidget({Key? key}) : super(key: key);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    int selectedPage = Provider.of<SelectedPageProvider>(context).selectedPage;

    return SafeArea(
      child: BottomNavigationBar(
        elevation: 10,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home_rounded),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.book),
            icon: Icon(Icons.book),
            label: 'Kho từ',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.travel_explore),
            icon: Icon(Icons.travel_explore_outlined),
            label: 'Khám phá',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Tài khoản',
          ),
        ],
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
