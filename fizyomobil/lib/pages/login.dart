import 'package:fizyomobil/components/bottomNavigation.dart';
import 'package:fizyomobil/pages/homepage.dart';
import 'package:fizyomobil/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:fizyomobil/mysql/mysql.dart';

// Global değişkenler
String? globalUsername;
String? globalPassword;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final MySql _mySql = MySql();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(35),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 250,
                  height: 250,
                ),
                const Text(
                  "FizyoMobil",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
                ),
                Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          controller: usernameController,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: "Kullanıcı Adı",
                            prefixIcon: Icon(Icons.person,
                                size: 30, color: Colors.grey[500]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          obscureText: _obscureText,
                          controller: passwordController,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: "Parola",
                            prefixIcon: Icon(Icons.lock_outline_rounded,
                                size: 30, color: Colors.grey[500]),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(
                                _obscureText
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          onPressed: loginUser,
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 59, 171, 114),
                              fixedSize: const Size(350, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          child: const Text(
                            "Giriş Yap",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text("Hesabın yok mu?"),
                            SizedBox(width: 20),
                            TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const register()),
                            );
                          },
                          child: const Text(
                            "Kayıt Ol",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginUser() async {
    String username = usernameController.text;
    String password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      showError("Lütfen Tüm alanları doldurunuz");
      return;
    }
    bool success = await _mySql.loginUser(username, password);

    if (success) {
      globalUsername = username;
      globalPassword = password;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>const Home()),
      );
    } else {
      showError("Kullanıcı adı veya şifre hatalı");
    }
  }

  void showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hata", style: TextStyle(color: Colors.red),),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tamam"),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Login(),
  ));
}
