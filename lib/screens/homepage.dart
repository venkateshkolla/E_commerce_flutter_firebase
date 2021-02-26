import 'package:a_ecommerce/tabs/home_tab.dart';
import 'package:a_ecommerce/tabs/saved_tab.dart';
import 'package:a_ecommerce/tabs/search_tab.dart';
import 'package:a_ecommerce/widgets/bottom_tabs.dart';
import 'package:flutter/material.dart';

class HomeaPage extends StatefulWidget {
  @override
  _HomeaPageState createState() => _HomeaPageState();
}

class _HomeaPageState extends State<HomeaPage> {
  PageController _tabsPageController;

  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: PageView(
          controller: _tabsPageController,
          onPageChanged: (num) {
            setState(() {
              _selectedTab = num;
            });
          },
          children: [
            Hometab(),
            SearchTab(),
            SavedTab(),
          ],
        )),
        BottomTabs(
          selectedTab: _selectedTab,
          tabpressed: (num) {
            _tabsPageController.animateToPage(num,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInCubic);
          },
        ),
      ],
    ));
  }
}
