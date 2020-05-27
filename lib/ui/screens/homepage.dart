import 'package:flutter/material.dart';
import 'package:tmdb_app/ui/screens/popular_screen.dart';
import 'package:tmdb_app/utils/methods.dart';
import 'package:tmdb_app/utils/settings.dart';

class Homepage extends StatefulWidget {

  @override
  _HomepageState createState() => _HomepageState();
}

final tabs = [
  {
    "tab": const Tab(text: "Most Popular"),
    "view": PopularScreen(),
  }, {
    "tab": const Tab(text: "Top Rated"),
    "view": Container(),
  }, {
    "tab": const Tab(text: "Upcoming"),
    "view": Container(),
  }
];

class _HomepageState extends State<Homepage> with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TabController(
      length: tabs.length,
      initialIndex: 0,
      vsync: this,
    );

  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_TITLE),
        centerTitle: true,
        bottom: TabBar(
          controller: _controller,
          tabs: tabs.map((t) => t["tab"]).toList()
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: tabs.map((t) => t["view"]).toList()
      ),
    );
  }
}