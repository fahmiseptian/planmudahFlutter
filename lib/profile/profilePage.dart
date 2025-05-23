import 'package:flutter/material.dart';
import 'package:myapp/api/auth.dart';
import 'package:myapp/notifications/notificationPage.dart';
import 'package:myapp/page/dashboard/dashboardPage.dart';
import 'package:myapp/page/login/loginPage.dart';
import 'package:myapp/page/project/projectPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  bool isLoading = false;
  // int pendingTasks = totalTasks - completedTasks;

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void logout() async {
    setState(() {
      isLoading = true;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == "" || jwtToken == null) {
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Loginpage()),
      );
      return;
    }

    await RefershToken.refershToken();
    String? errorMessage = await Logout.logout();

    setState(() {
      isLoading = false;
    });

    if (errorMessage == null) {
      // Login sukses
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Logout Berhasil!")));

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Loginpage()),
        );
      }
    } else {
      // Login gagal, tampilkan pesan error
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Dashboardpage()),
        );
      }
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Projectpage()),
        );
      }
      if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Notificationpage()),
        );
      }
      _selectedIndex = index;
    });
  }

  void checkToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Loginpage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            width: 80,
            child: Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTABSta4ztO2Z73YCEvZDFgCPesndhqt-seBg&s",
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: Text('Konfirmasi Keluar'),
                        content: Text('Apakah Anda yakin ingin keluar?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text('Keluar'),
                          ),
                        ],
                      ),
                );
                if (confirm == true) logout();
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 20),
              ],
            ),
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.grey.shade500,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Proyek'),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifikasi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Saya',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 70),
          child: FloatingActionButton(
            onPressed: () {
              // Aksi ketika tombol + ditekan
            },
            child: Icon(Icons.add, size: 30, color: Colors.white),
            backgroundColor: Colors.blue, // Warna tombol
            elevation: 5,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}
