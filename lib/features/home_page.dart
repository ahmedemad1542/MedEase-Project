import 'package:flutter/material.dart';
import 'package:medease1/calculators/calculators_page.dart';
import 'package:medease1/features/profile/profile_screen.dart';
import 'diseases_page.dart';
import 'advices_page.dart';
import 'home_main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late List<Widget> _pages; // خليها late

  @override
  void initState() {
    super.initState();
    _pages = [
      MedEaseHomeScreen(),
      DiseasesPage(),
      AdvicesPage(),
      CalculatorsPage(),
      ProfileScreen(), // هنا تبعت التوكن صح
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text("تأكيد الخروج"),
                content: Text("هل أنت متأكد أنك تريد الخروج من التطبيق؟"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text("إلغاء"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text("نعم"),
                  ),
                ],
              ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital),
              label: "Diseases",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.health_and_safety),
              label: "Advices",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: "Calculators",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
