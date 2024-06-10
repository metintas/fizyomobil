import 'package:flutter/material.dart';

class support extends StatelessWidget {
  const support({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Destek ve Yardım",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const[
          SupportItem(
            title: "Hoş Geldiniz!",
            content:
                "FizyoMobil uygulamasına hoş geldiniz! Bu uygulama, lise müfredatında bulunan İnsan Fizyolojisi konusunu etkileşimli bir şekilde öğrencilere sunmayı amaçlamaktadır. Öğrenmenin metin, ses ve görsel olarak gerçekleştiğini düşünerek, uygulamamızda bu üç unsur bir araya getirilmiştir. Ayrıca, 3D modellerle desteklenen içerikler de bulunmaktadır, böylece konular daha anlaşılır hale gelmektedir",
          ),
          SupportItem(
            title: "Nasıl Kullanılır?",
            content:
                "Uygulamayı kullanmak oldukça kolaydır. Ana ekranda, İnsan Fizyolojisi'nin farklı konularını gösteren kartlar bulunmaktadır. İlgilendiğiniz bir konuyu seçerek daha fazla bilgiye ulaşabilirsiniz.",
          ),
          SupportItem(
            title: "Yardım ve Destek",
            content:
                "Eğer herhangi bir sorunla karşılaşırsanız veya uygulama hakkında daha fazla bilgiye ihtiyacınız varsa, lütfen aşağıdaki iletişim bilgilerini kullanarak bize ulaşın:\nE-posta: fizyomobil@bartin.edu.tr\nTelefon: +90 123 456 78 90 ",
          ),
          SupportItem(
            title: "Güncellemeler",
            content:
                "Uygulamamızı sürekli olarak güncelliyoruz ve yeni içerikler ekliyoruz. Lütfen uygulamayı düzenli olarak güncelleyin ve yeni özelliklerden haberdar olun.Teşekkür ederiz ve başarılı bir öğrenme deneyimi geçirmenizi dileriz!",
          ),
        ],
      ),
    );
  }
}

class SupportItem extends StatefulWidget {
  final String title;
  final String content;

  const SupportItem({
    required this.title,
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  _SupportItemState createState() => _SupportItemState();
}

class _SupportItemState extends State<SupportItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: ExpansionTile(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              widget.content,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
        onExpansionChanged: (value) {
          setState(() {
            _isExpanded = value;
          });
        },
        initiallyExpanded: _isExpanded,
      ),
    );
  }
}
