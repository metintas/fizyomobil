import 'package:fizyomobil/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:fizyomobil/mysql/mysql.dart';

class favStars extends StatefulWidget {
  final VoidCallback onPressed;
  final String title;
  final String imageArt;

  const favStars({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.imageArt,
  }) : super(key: key);

  @override
  State<favStars> createState() => _favStarsState();
}

class _favStarsState extends State<favStars> {
  bool isStarred = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        MySql mySql = MySql();
        if (isStarred) {
          bool success = await mySql.removeFavoriteFromDatabase(globalUsername.toString(),widget.title, widget.imageArt);
          if (success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Favori kaldırıldı.'),
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Favori kaldırılırken bir hata oluştu.'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        } else {
          bool success = await mySql.addFavoriteToDatabase(globalUsername.toString(),widget.title, widget.imageArt);
          if (success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Favorilere eklendi.'),
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Favorilere eklenirken bir hata oluştu.'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        }
        setState(() {
          isStarred = !isStarred;
        });
        widget.onPressed();
      },
      child: Icon(
        isStarred ? Icons.star : Icons.star_border_rounded,
        size: 35,
        color: Colors.green,
      ),
    );
  }
}
