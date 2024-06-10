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
import 'package:fizyomobil/mysql/mysql.dart';
import 'package:fizyomobil/pages/login.dart';
import 'package:flutter/material.dart';

class favs extends StatefulWidget {
  const favs({Key? key}) : super(key: key);

  @override
  _favsState createState() => _favsState();
}

class _favsState extends State<favs> {
  List<Map<String, dynamic>> favorites = [];


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


  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> loadFavorites() async {
    try {
      MySql mySql = MySql();
      List<Map<String, dynamic>> userFavorites = await mySql.getUserFavoritesFromDatabase(globalUsername.toString());
      if (mounted) {
        setState(() {
          favorites = userFavorites;
        });
      }
      print("Favori verileri: $favorites");
    } catch (e) {
      print("Favori verileri çekilirken bir hata oluştu: $e");
    }
  }

  Widget itemDashboard(String title, String imageArt) {
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
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 4.0,
              spreadRadius: 1.0,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child:const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [],
                  ),
                ),
                const SizedBox(height: 160),
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
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Favoriler'),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return itemDashboard(
            favorites[index]['title'],
            favorites[index]['image'],
          );
        },
      ),
    );
  }
}
