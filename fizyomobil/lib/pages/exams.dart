import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:fizyomobil/components/favStars.dart';

class exams extends StatefulWidget {
  exams({super.key});

  @override
  State<exams> createState() => _examsState();
}

class _examsState extends State<exams> {
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

  List<String> urls = [
    "https://ogmmateryal.eba.gov.tr/soru-bankasi/biyoloji/test?s=8&d=7&u=0&k=3506&id=3434,3436,3437,3655,19939,19942,19943,28498,28500,28508&p=1&t=css&ks=0&os=0&zs=0",
    "https://ogmmateryal.eba.gov.tr/soru-bankasi/biyoloji/test?s=8&d=7&u=0&k=3511,3488,3512,3513&id=3278,3280,3282,3293,3297,3302,3303,3304,3305,3306&p=1&t=css&ks=0&os=0&zs=0",
    "https://ogmmateryal.eba.gov.tr/soru-bankasi/biyoloji/test?s=8&d=7&u=0&k=3502,3503,3504,3505&id=3277,3301,3396,3398,3401,3402,3403,3404,3406,3408&p=1&t=css&ks=0&os=0&zs=0",
    "https://ogmmateryal.eba.gov.tr/soru-bankasi/biyoloji/test?s=8&d=7&u=0&k=3493,3494,3495&id=3336,3342,3345,3348,3351,3352,3354,3447,3454,3600&p=1&t=css&ks=0&os=0&zs=0",
    "https://ogmmateryal.eba.gov.tr/soru-bankasi/biyoloji/test?s=8&d=7&u=0&k=3490&id=3266,3270,3305,3330,3332,3333,3334,3338,3355,3361&p=1&t=css&ks=0&os=0&zs=0",
    "https://ogmmateryal.eba.gov.tr/soru-bankasi/biyoloji/test?s=8&d=7&u=0&k=3496,3497,3498&id=3357,3363,3366,3370,3372,3375,3378,3379,3381,3382&p=1&t=css&ks=0&os=0&zs=0",
    "https://ogmmateryal.eba.gov.tr/soru-bankasi/biyoloji/test?s=8&d=7&u=0&k=3499,3500,3501&id=3294,3298,3320,3322,3324,3326,3327,3328,3329,3331&p=1&t=css&ks=0&os=0&zs=0",
    "https://ogmmateryal.eba.gov.tr/soru-bankasi/biyoloji/test?s=8&d=7&u=0&k=3489,3491,3492&id=3280,3308,3309,3310,3311,3312,3313,3314,3315,3319&p=1&t=css&ks=0&os=0&zs=0",
    "https://ogmmateryal.eba.gov.tr/soru-bankasi/biyoloji/test?s=8&d=7&u=0&k=3507,3508,3509,3510&id=3339,3341,3343,3346,3353,3358,3359,3362,3364,3367&p=1&t=css&ks=0&os=0&zs=0",
    "https://ogmmateryal.eba.gov.tr/soru-bankasi/biyoloji/test?s=8&d=7&u=0&k=3514,3515,3516&id=3262,3263,3264,3265,3266,3267,3268,3269,3271,3272&p=1&t=css&ks=0&os=0&zs=0"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: SingleChildScrollView(
              child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const Text(
              "Konu Kavrama Testleri",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          for (int i = 0; i < titles.length; i++)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.amber.shade100,
                            ),
                            child: Image.asset(
                              "assets/images/book.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              "${titles[i]} Konu kavrama testi",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.12,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                          color: Colors.white
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WebViewPage(url: urls[i]),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.amber,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)))),
                                  child: const Text(
                                    "Soru Çöz",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
        ],
      ))),
    );
  }
}

class WebViewPage extends StatelessWidget {
  final String url;
  const WebViewPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
