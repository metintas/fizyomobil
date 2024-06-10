import 'package:fizyomobil/components/bottomNavigation.dart';
import 'package:fizyomobil/mysql/mysql.dart';
import 'package:fizyomobil/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:fizyomobil/components/favStars.dart';
import 'package:fizyomobil/konular/bagisiklik.dart';
import 'package:fizyomobil/konular/bosaltim.dart';
import 'package:fizyomobil/konular/dolasim.dart';
import 'package:fizyomobil/konular/duyu.dart';
import 'package:fizyomobil/konular/endokrin.dart';
import 'package:fizyomobil/konular/iskelet.dart';
import 'package:fizyomobil/konular/sindirim.dart';
import 'package:fizyomobil/konular/sinir.dart';
import 'package:fizyomobil/konular/solunum.dart';
import 'package:fizyomobil/konular/ureme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> images = [
    "assets/images/bağışıklık.jpg",
    "assets/images/boşaltım.jpg",
    "assets/images/dolaşım.jpg",
    "assets/images/duyu.jpg",
    "assets/images/endokrin.jpg",
    "assets/images/iskelet.jpg",
    "assets/images/sindirim.jpg",
    "assets/images/sinir.jpg",
    "assets/images/solunum.jpg",
    "assets/images/üreme.png"
  ];
  List<String> titles = [
    "Bağışıklık Sistemi",
    "Boşaltım Sistemi",
    "Dolaşım Sistemi",
    "Duyu Organları",
    "Endokrin Sistemi",
    "İskelet Sistemi",
    "Sindirim Sistemi",
    "Sinir Sistemi",
    "Solunum Sistemi",
    "Üreme Sistemi"
  ];
  List<String> pages = [
    "bagisiklik()",
    "bosaltim()",
    "dolasim()",
    "duyu()",
    "endokrin()",
    "iskelet()",
    "sindirim()",
    "sinir()",
    "solunum()",
    "ureme()",
  ];

  List<String> filteredTitles = [];

  @override
  void initState() {
    filteredTitles = titles;
    super.initState();
  }

  void filterTitles(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        filteredTitles = titles;
      } else {
        filteredTitles = titles
            .where((title) =>
                title.toLowerCase().contains(searchText.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 234, 234),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                margin: const EdgeInsets.only(top: 20, right: 10, left: 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      title: Text(
                        "Merhaba ${globalUsername ?? ''}",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      subtitle: Text(
                        "Hoşgeldiniz",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.white54,
                            ),
                      ),
                      trailing: const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage("assets/images/pp.jpg"),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                child: TextField(
                  onChanged: filterTitles,
                  decoration: InputDecoration(
                    hintText: 'Konu Ara...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              for (int i = 0; i < filteredTitles.length; i++)
                itemDashboard(filteredTitles[i], images[i], Colors.transparent),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemDashboard(String title, String imageArt, Color backgroundColor) {
    return GestureDetector(
      onTap: () async{
        int index = titles.indexOf(title);
        String page = pages[index];
        switch (page) {
          case "bagisiklik()":
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const bagisiklik(),
              ),
            );
            break;
          case "bosaltim()":
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const bosaltim(),
              ),
            );
            break;
          case "dolasim()":
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const dolasim(),
              ),
            );
            break;
          case "duyu()":
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const duyu(),
              ),
            );
            break;
          case "endokrin()":
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const endokrin(),
              ),
            );
            break;
          case "iskelet()":
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const iskelet(),
              ),
            );
            break;
          case "sindirim()":
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const sindirim(),
              ),
            );
            break;
          case "sinir()":
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const sinir(),
              ),
            );
            break;
          case "solunum()":
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const solunum(),
              ),
            );
            break;
          case "ureme()":
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ureme(),
              ),
            );
            break;
        }
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              color: backgroundColor.withOpacity(0.2),
              blurRadius: 8.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Opacity(
                opacity: 0.6,
                child: Image.asset(
                  imageArt,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: favStars(
                            onPressed: () {
                              MySql mySql = MySql();
                              mySql.addFavoriteToDatabase(globalUsername.toString(),title, imageArt);
                            }, 
                            title: '${title}',
                            imageArt: '${imageArt}',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 95),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    width: double.maxFinite,
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
