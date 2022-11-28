import 'dart:convert';

import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api.dart';
import '../theme/colors.dart';

class ComictecaPage extends StatefulWidget {
  const ComictecaPage({Key? key}) : super(key: key);

  @override
  State<ComictecaPage> createState() => _ComictecaPageState();
}

class _ComictecaPageState extends State<ComictecaPage> {
  late Future<List<Comicteca>> comictecaData;

  Future<List<Comicteca>> getComicteca() async {
    final prefs = await SharedPreferences.getInstance();

    var response = await ApiServices.getComicteca(prefs.getInt('user_id') ?? 1);
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List<Comicteca> editionsInComicteca = [];
      for (var u in jsonResponse) {
        Comicteca comicteca = Comicteca(
            id: u['id'],
            volumesOwned: u['volumesOwned'],
            title: u['title'],
            totalVolumes: u['totalVolumes'],
            volumesLeft: List<VolumeFull>.from(
                u['volumesLeft'].map((volume) => VolumeFull.fromJson(volume))),
            coverImage: u['coverImage']);
        editionsInComicteca.add(comicteca);
      }
      return editionsInComicteca;
    } else {
      throw Exception("Failed to fetch!");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 25, top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Mi cómicteca',
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
                    hintText: 'Buscá una edición...',
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
        Padding(
          padding: const EdgeInsets.all(2),
          child: FutureBuilder<List<Comicteca>>(
              future: getComicteca(),
              builder: (context, snapshot) {
                print(snapshot.data);
                List<Comicteca> items = [];
                if (snapshot.hasData) {
                  snapshot.data?.forEach((comicteca) {
                    items.add(comicteca);
                  });
                  return ListView.builder(
                      //EDICIONES
                      padding:
                          const EdgeInsets.only(top: 25, right: 25, left: 25),
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        double percentage = (items[index].volumesOwned /
                            items[index].totalVolumes);
                        return GestureDetector(
                          onTap: () {
                            print('ListView Tapped');
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => VolumeScreen(
                            //         volume: items[index], key: key),
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
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            items[index].coverImage),
                                      ),
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
                                      '${items[index].title}',
                                      style: GoogleFonts.openSans(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: kBlackColor),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      items[index].volumesOwned ==
                                              items[index].totalVolumes
                                          ? "Completada!"
                                          : "Te faltan ${items[index].totalVolumes - items[index].volumesOwned}",
                                      style: GoogleFonts.lato(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 255,
                                      child: CurvedLinearProgressIndicator(
                                        value: percentage,
                                        strokeWidth: 8,
                                        backgroundColor: Colors.grey,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              }),
        )
      ],
    );
  }
}
