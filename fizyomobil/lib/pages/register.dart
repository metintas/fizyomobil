import 'package:fizyomobil/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:fizyomobil/mysql/mysql.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  _registerState createState() => _registerState();
}

// ignore: camel_case_types
class _registerState extends State<register> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final MySql _mySql = MySql();

  bool _obscurePassword = true; // Şifre gösterme/gizleme için boolean
  bool _obscureConfirmPassword = true; // Onay şifresi gösterme/gizleme için boolean

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
                          obscureText: _obscurePassword,
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
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          obscureText: _obscureConfirmPassword,
                          controller: confirmPasswordController,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: "Parola Tekrar",
                            prefixIcon: Icon(Icons.lock_outline_rounded,
                                size: 30, color: Colors.grey[500]),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                              icon: Icon(
                                _obscureConfirmPassword
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
                          onPressed: registerUser,
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 59, 171, 114),
                              fixedSize: const Size(350, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          child: const Text(
                            "Kayıt Ol",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Text("Hesabın var mı?"),
                            const SizedBox(width: 20),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()),
                                );
                              },
                              child: const Text(
                                "Giriş Yap",
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

  void registerUser() async {
    String username = usernameController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      showError("Lütfen tüm alanları doldurunuz.");
      return;
    }

    if (password != confirmPassword) {
      showError("Şifreler uyuşmuyor.");
      return;
    }

    bool success = await _mySql.registerUser(username, password);

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()), // Assuming BottomNavigation is your home screen
      );
    } else {
      showError("Kayıt başarısız. Lütfen tekrar deneyiniz.");
    }
  }

  void showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hata",style: TextStyle(color: Colors.red),),
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
