import 'package:flutter/material.dart';
import 'package:yyutils/yyutils.dart';

class BottomNavBar extends StatefulWidget {
  final List<Widget> tabItems;

  final List<Widget> tabViews;

  final ValueChanged<int> onTabChanged;

  BottomNavBar({
    Key? key,
    required this.tabItems,
    required this.tabViews,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState(
        tabViews,
        onTabChanged,
      );
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  final List<Widget> _tabViews;

  final ValueChanged<int> _onTabChanged;

  _BottomNavBarState(
    this._tabViews,
    this._onTabChanged,
  ) : super();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.tabItems.length);
    _tabController.addListener(() {
      if (_tabController.index.toDouble() == _tabController.animation?.value) {
        _onTabChanged.call(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: TabBarView(
            controller: _tabController,
            children: _tabViews,
          ),
        ),
        bottomNavigationBar: Material(
          color: Colors.white, //底部导航栏主题颜色
          child: SafeArea(
            child: Container(
              height: MyMetrics.bottomBarHeight,
              child: TabBar(
                  controller: _tabController,
                  indicatorWeight: 3.0,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(primaryColor)),
                  // indicator: CustomTabIndicator(
                  //     padding: const EdgeInsets.all(0.0),
                  //     indicatorHeight: MyMetrics.bottomBarHeight,
                  //     indicatorColor: Theme.of(context).primaryColor,
                  //     // tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  //     indicatorRadius: 0),
                  indicatorSize: TabBarIndicatorSize.tab,
                  // labelColor: Theme.of(context).primaryColor,
                  labelColor: Colors.white,
                  unselectedLabelColor: const Color(0xFF8E8E8E),
                  tabs: widget.tabItems),
            ),
          ),
        ));
  }
}
