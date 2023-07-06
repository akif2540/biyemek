import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [],
        title: const Text(
          "Bildirimler",
          style: TextStyle(
            color: Colors.green,
          ),
        ),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        iconTheme: const IconThemeData(
          color: Colors.green,
        ),
        backgroundColor: const Color(0xFFEDECF5),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'Cevap Bekleyenler',
              ),
              Tab(text: 'Cevaplananlar'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                Center(child: Text('İçerik 1')),
                Center(child: Text('İçerik 2')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
