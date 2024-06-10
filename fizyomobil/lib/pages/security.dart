import 'package:fizyomobil/mysql/mysql.dart';
import 'package:fizyomobil/pages/login.dart'; // `globalPassword`'un tanımlı olduğunu varsayıyoruz.
import 'package:flutter/material.dart';

String glblPassword = "${globalPassword}";

class security extends StatefulWidget {
  const security({super.key});

  @override
  _securityState createState() => _securityState();
}

class _securityState extends State<security> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _obscureTextCurrent = true;
  bool _obscureTextNew = true;
  bool _obscureTextConfirm = true;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController(text: glblPassword);
  }

  @override
  void dispose() {
    passwordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> changePassword() async {
    String currentPassword = passwordController.text;
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (currentPassword != glblPassword) {
      showMessage("Mevcut şifre yanlış.");
      return;
    }

    if (newPassword != confirmPassword) {
      showMessage("Yeni şifreler uyuşmuyor.");
      return;
    }

    bool success = await MySql().updatePassword(globalUsername.toString(), newPassword);

    if (success) {
      showMessage("Şifre başarıyla değiştirildi.");
      setState(() {
        glblPassword = newPassword;
      });
    } else {
      showMessage("Şifre değiştirme işlemi başarısız.");
    }
  }

  void showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Bilgilendirme"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Gizlilik ve Güvenlik",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: const Text(
                  "Şifre İşlemleri",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                alignment: Alignment.topLeft,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        obscureText: _obscureTextCurrent,
                        controller: passwordController,
                        style: const TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Mevcut Şifreniz',
                          prefixIcon: Icon(
                            Icons.lock_outline_rounded,
                            size: 30,
                            color: Colors.grey[500],
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureTextCurrent = !_obscureTextCurrent;
                              });
                            },
                            icon: Icon(
                              _obscureTextCurrent
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        obscureText: _obscureTextNew,
                        controller: newPasswordController,
                        style: const TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Yeni Şifre',
                          prefixIcon: Icon(
                            Icons.lock_outline_rounded,
                            size: 30,
                            color: Colors.grey[500],
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureTextNew = !_obscureTextNew;
                              });
                            },
                            icon: Icon(
                              _obscureTextNew
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        obscureText: _obscureTextConfirm,
                        controller: confirmPasswordController,
                        style: const TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Yeni Şifre Tekrar',
                          prefixIcon: Icon(
                            Icons.lock_outline_rounded,
                            size: 30,
                            color: Colors.grey[500],
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureTextConfirm = !_obscureTextConfirm;
                              });
                            },
                            icon: Icon(
                              _obscureTextConfirm
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
                        onPressed: changePassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 59, 171, 114),
                          fixedSize: const Size(350, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          "Şifre Değiştir",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: security(),
  ));
}
