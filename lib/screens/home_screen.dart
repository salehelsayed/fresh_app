import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              tabs: [
                Tab(text: 'For you'),
                Tab(text: 'Following'),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            ForYouTab(),
            FollowingTab(),
          ],
        ),
      ),
    );
  }
}

class ForYouTab extends StatelessWidget {
  const ForYouTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('For you content here.'),
    );
  }
}

class FollowingTab extends StatelessWidget {
  const FollowingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Following content here.'),
    );
  }
}
