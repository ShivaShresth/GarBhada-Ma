import 'package:flutter/material.dart';

class Tab_Bar extends StatefulWidget {
  const Tab_Bar({super.key});

  @override
  State<Tab_Bar> createState() => _Tab_BarState();
}

class _Tab_BarState extends State<Tab_Bar> with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 500,
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              height: 120,
              child: TabBar(
                controller: controller,
                tabs: [
                  Tab(
                    text: 'The process of making tools',
                    icon: Icon(Icons.home),
                  ),
                  Tab(
                    text: 'The world having fun',
                    icon: Icon(Icons.star),
                  ),
                  Tab(
                    text: 'Making the world fun',
                    icon: Icon(Icons.person),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: 500,
                child: TabBarView(
                  controller: controller,
                  children: [
                    Center(
                      child: Text('Tab 1 Content'),
                    ),
                    Center(
                      child: Text("Tab 2 Content"),
                    ),
                    Center(
                      child: Text("Tab 3 Content"),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
