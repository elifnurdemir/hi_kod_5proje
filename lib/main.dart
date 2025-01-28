import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AppBar & Curved NavBar',
      theme: ThemeData(
        brightness: Brightness.light,

      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text('🏠 Home Page', style: TextStyle(fontSize: 22))),
    const Center(child: Text('🔍 Learn Page', style: TextStyle(fontSize: 22))),
    const Center(child: Text('📝 Quiz Page', style: TextStyle(fontSize: 22))),
    const Center(child: Text('👤 Profile Page', style: TextStyle(fontSize: 22))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 280,
        elevation: 10,
        child: Container(
          color: Colors.black87,
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blueGrey),
                child: Text('Kullanıcı Paneli', style: TextStyle(color: Colors.white)),
              ),
              const ListTile(
                leading: Icon(Icons.settings, color: Colors.white),
                title: Text('Ayarlar', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),

      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage('https://i.pinimg.com/originals/af/89/3e/af893ef77c62353ce8590e418a94783a.gif'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              "Minipoly",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),

      body: _pages[_selectedIndex],

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.deepOrangeAccent,
        buttonBackgroundColor: Colors.black45,
        height: 65,
        animationDuration: const Duration(milliseconds: 300),
        items: [
          Icon(Icons.home, size: 30, color: _selectedIndex == 0 ? Colors.white : Colors.black54),
          Icon(Icons.search, size: 30, color: _selectedIndex == 1 ? Colors.white : Colors.black54),
          Icon(Icons.quiz, size: 30, color: _selectedIndex == 2 ? Colors.white : Colors.black54),
          Icon(Icons.person, size: 30, color: _selectedIndex == 3 ? Colors.white : Colors.black54),
        ],
        onTap: _onItemTapped,
      ),

    );
  }
}
