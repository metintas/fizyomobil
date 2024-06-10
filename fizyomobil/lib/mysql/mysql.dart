import 'package:mysql1/mysql1.dart';

class MySql {
  static String host = '10.57.48.61'; // terminal -ipconfig- for LAN IPv4
  static String user = 'root';
  static String password = '';
  static String db = 'fizyomobil';
  static int port = 3306;

  MySql();

  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db,
    );
    return await MySqlConnection.connect(settings);
  }

  Future<bool> registerUser(String username, String password) async {
    try {
      var conn = await getConnection();
      var result = await conn.query(
        'INSERT INTO users (username, password) VALUES (?, ?)',
        [username, password],
      );
      await conn.close();
      return result.affectedRows! > 0;
    } catch (e) {
      return false;
    }
  }

  Future<bool> loginUser(String username, String password) async {
    try {
      final conn = await getConnection();
      var results = await conn.query(
          'SELECT * FROM users WHERE username = ? AND password = ?',
          [username, password]);
      await conn.close();
      return results.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addFavoriteToDatabase(
      String username, String title, String image) async {
    try {
      var connection = await getConnection();
      // Önce bu favorinin veritabanında olup olmadığını kontrol et
      var existingFavorite = await connection.query(
        'SELECT * FROM favorites WHERE username = ? AND title = ? AND image = ?',
        [username, title, image],
      );
      if (existingFavorite.isNotEmpty) {
        // Eğer zaten varsa eklemeye gerek yok
        await connection.close();
        return true; // Zaten favoride var olarak işaretle
      } else {
        // Favori veritabanında yoksa ekle
        await connection.query(
          'INSERT INTO favorites (username, title, image) VALUES (?, ?, ?)',
          [username, title, image],
        );
        await connection.close();
        return true; // Favori başarıyla eklendi
      }
    } catch (e) {
      return false; // Hata durumunda false dön
    }
  }

  Future<bool> removeFavoriteFromDatabase(
      String username, String title, String image) async {
    try {
      var connection = await getConnection();
      // Favoriyi veritabanından kaldır
      await connection.query(
        'DELETE FROM favorites WHERE username = ? AND title = ? AND image = ?',
        [username, title, image],
      );
      await connection.close();
      return true; // Favori başarıyla kaldırıldı
    } catch (e) {
      return false; // Hata durumunda false dön
    }
  }

  Future<List<Map<String, dynamic>>> getUserFavoritesFromDatabase(
      String username) async {
    try {
      var connection = await getConnection();
      var results = await connection.query(
        'SELECT * FROM favorites WHERE username = ?',
        [username],
      );
      await connection.close();

      List<Map<String, dynamic>> favorites = [];
      for (var row in results) {
        favorites.add({
          'title': row['title'],
          'image': row['image'],
        });
      }
      return favorites;
    } catch (e) {
      print("Favori verileri çekilirken bir hata oluştu: $e");
      return [];
    }
  }

  Future<bool> isFavorite(String username, String title, String imageArt) async {
    // Veritabanına bağlanma ve sorgu işlemleri burada...
    // Örneğin, favori kontrolü için bir SELECT sorgusu çalıştırabilirsiniz
    try {
      // Bu, veritabanı bağlantı kodunu simgeler
      var conn = await getConnection();

      var results = await conn.query(
        'SELECT COUNT(*) FROM favorites WHERE username = ? AND title = ? AND imageArt = ?',
        [username, title, imageArt]
      );

      await conn.close();

      // Eğer sonuç 0'dan büyükse, favori olarak eklenmiş demektir
      if (results.first[0] > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Favori durumu kontrol edilirken bir hata oluştu: $e');
      return false;
    }
  }

  Future<bool> updatePassword(String username, String newPassword) async {
    try {
      var conn = await getConnection();
      var result = await conn.query(
        'UPDATE users SET password = ? WHERE username = ?',
        [newPassword, username],
      );
      await conn.close();
      return result.affectedRows! > 0;
    } catch (e) {
      print("Şifre güncelleme hatası: $e");
      return false;
    }
  }

}
