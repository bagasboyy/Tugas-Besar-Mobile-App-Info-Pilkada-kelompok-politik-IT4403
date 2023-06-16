import 'package:flutter/material.dart';
import 'package:main/pages/AboutApps.dart';
import 'package:main/pages/RekapVoting.dart';
import 'package:main/pages/lokasi.dart';
import 'package:main/pages/partai.dart';
import 'package:carousel_slider/carousel_slider.dart';


void main() {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> images = [
    'https://cdn-1.timesmedia.co.id/images/2022/07/29/Pemilu-2024-e.jpg',
    'https://ichef.bbci.co.uk/news/640/cpsprodpb/131A/production/_105909840_antarafoto-simulasi-pemungutan-dan-penghitungan-suara-030319-aws-4.jpg',
    'https://t-2.tstatic.net/medan/foto/bank/images/pemungutan-suara-ulang.jpg',
    'https://tribratanews.gorontalo.polri.go.id/wp-content/uploads/2019/04/IMG-20190416-WA0090.jpg',
    'https://asset.kompas.com/crops/sn8BaVlaFNksUHaQpGvu7af_buw=/0x176:1443x1138/750x500/data/photo/2017/02/15/1443107tmp-cam-19078519792.jpg',
    'https://kpu-tangerangkab.go.id/images/simulasi1.jpg',
    'https://infopublik.id/assets/upload/headline//simulasi1.jpg',
  ];
  
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      images.forEach((imageUrl) {
        precacheImage(NetworkImage(imageUrl), context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          centerTitle: true,
          backgroundColor: Colors.red,
          actions: [
            Padding(
              padding: EdgeInsets.all(7),
              child: Image.asset(
                    "assets/logo_kpu.png",
                  ),
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              CarouselSlider.builder(
                itemCount: images.length,
                options: CarouselOptions(
                  height: 200,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                ),
                itemBuilder: (context, index, realIdx) {
                  return Image.network(
                    images[index],
                    fit: BoxFit.cover, 
                    width: 1000
                  );
                },
              ),
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                          height: 90,
                        ),
                    Container(
                      width: double.infinity,
                      height: 205,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text("Info Pilkada", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Card(
                                  margin: EdgeInsets.all(8),
                                  color: Colors.transparent,
                                  elevation: 0.0,
                                  child: SizedBox(
                                    width: 200,
                                    height: 130,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                                          return PartaiPage() ;
                                        }));
                                        print("tapped");
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/logopartai.png', height: 100, width: 230, 
                                          ),
                                          const Text("Partai", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.all(8),
                                  color: Colors.transparent,
                                  elevation: 0.0,
                                  child: SizedBox(
                                    width: 200,
                                    height: 130,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                                          return RekapVotingPage() ;
                                        }));
                                        print("tapped");
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/hasilvote.png', height: 100, width: 230,  
                                          ),
                                          const Text("Hasil Vote", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.all(8),
                                  color: Colors.transparent,
                                  elevation: 0.0,
                                  child: SizedBox(
                                    width: 200,
                                    height: 130,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                                          return LokasiKPUPage() ;
                                        }));
                                        print("tapped");
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/map.png', height: 100, width: 230,  
                                          ),
                                          const Text("Lokasi KPU", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.all(8),
                                  color: Colors.transparent,
                                  elevation: 0.0,
                                  child: SizedBox(
                                    width: 200,
                                    height: 130,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                                          return AboutAppsPage() ;
                                        }));
                                        print("tapped");
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/infopemilu.jpeg', height: 100, width: 230,  
                                          ),
                                          const Text("Tentang Aplikasi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

