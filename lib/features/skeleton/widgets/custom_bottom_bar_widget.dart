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

    //   return SafeArea(
    //     child: BottomAppBar(
    //       elevation: 0,
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Align(
    //             alignment: selectedPage == 0
    //                 ? Alignment.centerLeft
    //                 : Alignment.centerRight,
    //             child: LayoutBuilder(
    //               builder: (context, box) => SizedBox(
    //                 width: box.maxWidth / 2,
    //                 child: const Divider(
    //                   height: 0,
    //                   color: Colors.orangeAccent,
    //                   thickness: 2,
    //                 ),
    //               ),
    //             ),
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               CustomBottomBarIconWidget(
    //                 iconDataSelected: Icons.home_outlined,
    //                 iconDataUnselected: Icons.home_rounded,
    //                 callback: () {
    //                   Provider.of<SelectedPageProvider>(context, listen: false)
    //                       .changePage(0);
    //                 },
    //                 isSelected: selectedPage == 0,
    //               ),
    //               CustomBottomBarIconWidget(
    //                 iconDataSelected: Icons.add_circle,
    //                 iconDataUnselected: Icons.add_circle_outline,
    //                 callback: () {
    //                   Provider.of<SelectedPageProvider>(context, listen: false)
    //                       .changePage(1);
    //                 },
    //                 isSelected: selectedPage == 1,
    //               ),
    //               CustomBottomBarIconWidget(
    //                 iconDataSelected: Icons.school,
    //                 iconDataUnselected: Icons.school_outlined,
    //                 callback: () {
    //                   Provider.of<SelectedPageProvider>(context, listen: false)
    //                       .changePage(2);
    //                 },
    //                 isSelected: selectedPage == 2,
    //               ),
    //               CustomBottomBarIconWidget(
    //                 iconDataSelected: Icons.person,
    //                 iconDataUnselected: Icons.person_outlined,
    //                 callback: () {
    //                   Provider.of<SelectedPageProvider>(context, listen: false)
    //                       .changePage(3);
    //                 },
    //                 isSelected: selectedPage == 3,
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }

    return SafeArea(
      child: BottomNavigationBar(
        elevation: 10,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home_rounded),
            icon: Icon(Icons.home_outlined),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.add_circle_outlined),
            icon: Icon(Icons.add_circle_outline_outlined),
            label: 'Contribute',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.school),
            icon: Icon(Icons.school_outlined),
            label: 'Practice',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Profile',
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
