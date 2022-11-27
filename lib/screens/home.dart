import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:comic_ar/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../theme/colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, required BuildContext parentContext}) : super(key: key);

  late Future<List<VolumeBasic>> futureVolumeLatest;

  Future<List<VolumeBasic>> getCarouselData() async {
    final response = await ApiServices.getLatest();

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      List<VolumeBasic> latest = [];
      for (var u in jsonResponse) {
        VolumeBasic volume =
            VolumeBasic(coverImage: u['coverImage'], id: u['id']);
        latest.add(volume);
      }
      return latest;
    } else {
      throw Exception("Failed to fetch!");
    }
  }

  @override
  Widget build(BuildContext context) {
    var idx = 1;
    return Container(
        child: ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 25, top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Holiwis, Matias',
                  style: GoogleFonts.openSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: kGreyColor),
                ),
                Text(
                  'Encuentra tu próximo cómic',
                  style: GoogleFonts.openSans(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: kBlackColor),
                ),
              ],
            )),
        Container(
          height: 50,
          margin: const EdgeInsets.only(left: 25, right: 25, top: 18),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: kLightGreyColor),
          child: Stack(
            children: <Widget>[
              TextField(
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                style: GoogleFonts.openSans(
                    fontSize: 15,
                    color: kBlackColor,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 19, right: 50),
                    border: InputBorder.none,
                    hintText: 'Buscá un cómic...',
                    hintStyle: GoogleFonts.openSans(
                        fontSize: 15,
                        color: kGreyColor,
                        fontWeight: FontWeight.w600)),
              ),
              Positioned(
                  right: 0,
                  top: 2,
                  child: SizedBox.fromSize(
                    size: const Size(48, 48),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(25)),
                      child: Material(
                        color: Colors.amberAccent,
                        child: InkWell(
                          splashColor: Colors.green,
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(Icons.search_rounded),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
        Container(
          height: 25,
          margin: const EdgeInsets.only(top: 30),
          padding: const EdgeInsets.only(left: 25),
          child: DefaultTabController(
            length: 3,
            child: TabBar(
                labelPadding:
                    const EdgeInsets.only(bottom: 0, right: 0, top: 0),
                isScrollable: true,
                labelColor: kBlackColor,
                unselectedLabelColor: kGreyColor,
                labelStyle: GoogleFonts.openSans(
                    fontSize: 14, fontWeight: FontWeight.w700),
                unselectedLabelStyle: GoogleFonts.openSans(
                    fontSize: 14, fontWeight: FontWeight.w600),
                indicatorColor: Colors.indigo,
                indicator: MaterialIndicator(
                    topLeftRadius: 8,
                    topRightRadius: 8,
                    tabPosition: TabPosition.bottom,
                    horizontalPadding: 15),
                tabs: [
                  Tab(
                    child: Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: const Text('Últimos'),
                    ),
                  ),
                  Tab(
                    child: Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: const Text('En tendencia'),
                    ),
                  ),
                  Tab(
                    child: Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: const Text('Mejor valorados'),
                    ),
                  )
                ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<List<VolumeBasic>>(
              future: getCarouselData(),
              builder: (context, snapshot) {
                List<VolumeBasic> items = [];
                if (snapshot.hasData) {
                  snapshot.data?.forEach((volume) {
                    items.add(volume);
                  });
                  return CarouselSlider(
                      items: items
                          .map((item) => Center(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(item.coverImage)),
                              ))
                          .toList(),
                      options: CarouselOptions(
                          height: 250,
                          aspectRatio: 1,
                          viewportFraction: 0.5,
                          reverse: false,
                          autoPlay: true,
                          enableInfiniteScroll: true,
                          enlargeCenterPage: true,
                          initialPage: 0));
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25, top: 25),
          child: Text(
            'Populares',
            style: GoogleFonts.openSans(
                fontSize: 20, fontWeight: FontWeight.w600, color: kBlackColor),
          ),
        ),
        ListView.builder(
            padding: const EdgeInsets.only(top: 25, right: 25, left: 25),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print('ListView Tapped');
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         SelectedBookScreen(popularBookModel: populars[index]),
                  //   ),
                  // );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 19),
                  height: 81,
                  width: MediaQuery.of(context).size.width - 50,
                  color: kBackgroundColor,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 81,
                        width: 62,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // image: DecorationImage(
                            //   image: AssetImage(populars[index].image),
                            // ),
                            color: kMainColor),
                      ),
                      const SizedBox(
                        width: 21,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "xd",
                            style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: kBlackColor),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "editorial",
                            style: GoogleFonts.openSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: kGreyColor),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            })
      ],
    ));
  }
}
