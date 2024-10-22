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
            return Text("Error: ${snapshot.error}");
          }

          // Handle null data safely
          Map<String, dynamic>? data =
              snapshot.data?.data() as Map<String, dynamic>?;
          String? photoURL = data?['photoURL'];
          String? displayName = data?['displayName'];

          return Scaffold(
            appBar: SAppBar(title: "Профиль", page: "Profile"),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  if (photoURL != null && photoURL.isNotEmpty)
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(photoURL),
                    ),
                  const SizedBox(height: 20),
                  if (displayName != null && displayName.isNotEmpty)
                    Text(
                      displayName,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: 10),
                  if (user.email != null)
                    Text(
                      user.email!,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  const Spacer(),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: ElevatedButton(
                        onPressed: () => _confirmDeleteAccount(),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 3.0),
                          child: Text(
                            'Удалить аккаунт',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
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
            body: Center(
                child: CircularProgressIndicator()), // Add loading spinner
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

  /// Confirmation dialog for account deletion
  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Подтвердите удаление'),
          content: const Text(
              'Вы уверены, что хотите удалить свой аккаунт? Это действие необратимо.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _deleteAccount(); // Proceed with deletion
              },
              child: const Text('Удалить'),
            ),
          ],
        );
      },
    );
  }

  /// Function to delete user account
  void _deleteAccount() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Delete user data from Firestore
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .delete();

        // Delete user from Firebase Auth
        await user.delete();

        // Sign out and redirect to login screen
        await FirebaseAuth.instance.signOut();
        Get.offAll(LoginScreen());

        Get.snackbar('Успех', 'Аккаунт успешно удален.');
      } catch (e) {
        Get.snackbar('Ошибка', 'Не удалось удалить аккаунт: $e');
      }
    }
  }
}
