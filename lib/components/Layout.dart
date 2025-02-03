import 'package:flutter/material.dart';
import 'package:hi_kod_5proje/cards/card.dart'; // CardWidget
import 'package:hi_kod_5proje/features/profile/screen_page.dart';
import '../features/quiz/screens/main_quiz.dart'; // QuizPage
import 'custom_nav_bar.dart';

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 0;  // Default olarak CardWidget seçili
  final PageController _pageController = PageController(initialPage: 0);

  final List<Widget> _pages = [
    QuizPage(),
    CardWidget(),
    QuizPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);  // Sayfaya yönlendir
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,  // Sayfalar arasında geçişi kontrol ediyor
        children: _pages,  // QuizPage ve CardWidget
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;  // Sayfa değiştiğinde index'i güncelliyoruz
          });
        },
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,  // Seçilen index'i gönder
        onItemTapped: _onItemTapped,  // Tıklanan index'i işlem
      ),
    );
  }
}
