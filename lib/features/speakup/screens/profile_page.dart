import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakup/common/widgets/appbar.dart';
import 'package:speakup/features/speakup/screens/home_screen.dart';
import 'package:speakup/features/speakup/screens/converter_screen.dart';
import 'package:speakup/features/speakup/screens/map_screen.dart';
import 'package:speakup/features/authentication/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Get.to(HomeScreen());
        break;
      case 1:
        Get.to(ConverterScreen());
        break;
      case 2:
        Get.to(const MapScreen(text: ""));
        break;
      case 3:
        Get.to(UserProfilePage());
        break;
    }
  }

  Widget _buildNavItem(String asset, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(asset, width: 24, height: 24),
            Text(
              label,
              style: TextStyle(
                color: _selectedIndex == index ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Container();
    }
    return FutureBuilder<DocumentSnapshot>(
      future:
          FirebaseFirestore.instance.collection('Users').doc(user.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // Handle error
            return Text("Error: ${snapshot.error}");
          }

          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          String photoURL = data['photoURL'];
          String displayName = data['displayName'];

          return Scaffold(
            appBar: SAppBar(title: "Профиль", page: "Profile"),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (photoURL != null)
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(photoURL),
                    ),
                  SizedBox(height: 10),
                  if (displayName != null)
                    Text(
                      displayName,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  SizedBox(height: 10),
                  if (user.email != null)
                    Text(
                      user.email!,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _buildNavItem('assets/images/chat.png', 'Спичи', 0),
                  _buildNavItem('assets/images/convert.png', 'Конвертер', 1),
                  _buildNavItem('assets/images/marker.png', 'Центры', 2),
                  _buildNavItem('assets/images/profile.png', 'Профайл', 3),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: SAppBar(title: "Профиль", page: "Profile"),
            bottomNavigationBar: Container(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _buildNavItem('assets/images/chat.png', 'Спичи', 0),
                  _buildNavItem('assets/images/convert.png', 'Конвертер', 1),
                  _buildNavItem('assets/images/marker.png', 'Центры', 2),
                  _buildNavItem('assets/images/profile.png', 'Профайл', 3),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
