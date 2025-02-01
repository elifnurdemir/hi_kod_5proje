import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:category_navigator/category_navigator.dart';
import 'card_data.dart'; // Kart verilerini dışarıdan alıyoruz

class CardWidget extends StatefulWidget {
  const CardWidget({super.key});

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final List<String> itemsList = const [
    'Çocuk Hakları',
    'Eğitim Hakkı',
    'Sağlık Hakkı',
    'Eşitlik Hakkı',
    'Sevgi ve Aile Hakkı',
    'Güvende Olma Hakkı',
    'Oyun ve Dinlenme Hakkı',
    'Düşüncelerini Söyleme Hakkı',
    'Temiz Çevrede Yaşama Hakkı'
  ];

  final List<dynamic> icons = const [
    Icons.favorite,
    Icons.school,
    Icons.health_and_safety,
    Icons.balance,
    Icons.family_restroom,
    Icons.security,
    Icons.child_care,
    Icons.star,
    Icons.grass
  ];

  // Başlangıçta tüm kartlar görünsün
  List<int> visibleCards = [0, 1, 2, 3, 4, 5,6,7];

  void onCategoryChange(int index) {
    setState(() {
      if (index == 0) {
        visibleCards = [0, 1, 2, 3, 4, 5,6,7,8,9,10,11,12,13,14,15];
      } else if (index == 1) {
        visibleCards = [0, 8];
      } else if (index == 2) {
        visibleCards = [1, 9];
      } else if (index == 3) {
        visibleCards = [2, 10];
      } else if (index == 4) {
        visibleCards = [3, 11];
      } else if (index == 5) {
        visibleCards = [4, 12];
      } else if (index == 6) {
        visibleCards = [5, 13];
      } else if (index == 7) {
        visibleCards = [6, 14];
      }else if (index == 8) {
        visibleCards = [7, 15];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF575FCC),
      body: Column(
        children: [
          SizedBox(height: 90), // Üstte boşluk bırakıyoruz
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 3.0),
            child: CategoryNavigator(
              labels: itemsList,
              icons: icons,
              highlightBackgroundColor: Colors.white,
              unselectedBackgroundColor: Color(0xFFFABF48),
              navigatorBackgroundColor: Color(0xFFFABF48),
              navigatorController: NavigatorController(),
              scrollController: ScrollController(),
              onChange: (activeItem) {
                onCategoryChange(activeItem); // Kategorilerdeki değişiklikler
              },
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 450, // Slider yüksekliğini artırdım
                child: CarouselSlider.builder(
                  itemCount: visibleCards.length,
                  itemBuilder: (context, index, realIndex) {
                    int visibleIndex = visibleCards[index];

                    // Kartın içeriği dışarıdan geliyor
                    var card = cardData[visibleIndex];

                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 500, // Kartın yüksekliğini artırdım
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: card['color'],
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                          bottom: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            card['title'],
                            style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Image.asset(
                            card['imageUrl'],
                            height: 150, // Resmin yüksekliğini artırdım
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              card['text'], // Kartın metni
                              style: TextStyle(fontSize: 16, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 500, // Slider yüksekliğini artırdım
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
