import 'package:comic_ar/services/api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../theme/colors.dart';

class VolumeScreen extends StatefulWidget {
  final VolumeFull volume;

  VolumeScreen({Key? key, required this.volume}) : super(key: key);

  @override
  State<VolumeScreen> createState() => _VolumeScreen(volume);
}

class _VolumeScreen extends State<VolumeScreen> {
  final VolumeFull volume;
  _VolumeScreen(this.volume);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
        height: 49,
        color: Colors.transparent,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(
            Icons.add,
            size: 24,
          ),
          label: Text(
            'Añadir a Comicteca',
            style: GoogleFonts.openSans(
                fontSize: 14, fontWeight: FontWeight.w600, color: kWhiteColor),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.indigoAccent,
                expandedHeight: MediaQuery.of(context).size.height * 0.5,
                flexibleSpace: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 25,
                        top: 35,
                        child: SizedBox.fromSize(
                          size: const Size(50, 50),
                          child: ClipOval(
                            child: Material(
                              color: kBackgroundColor,
                              child: InkWell(
                                splashColor: Colors.deepPurpleAccent,
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, "/home");
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Icon(Icons.arrow_back),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 62),
                          width: 200,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(volume.coverImage ?? "a"),
                                fit: BoxFit.fill),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.only(top: 24, left: 25),
                  child: Text(
                    volume.title ?? "xd",
                    style: GoogleFonts.openSans(
                        fontSize: 27,
                        color: kBlackColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7, left: 25),
                  child: Text(
                    volume.edition?.publisher ?? "Publisher",
                    style: GoogleFonts.openSans(
                        fontSize: 14,
                        color: kGreyColor,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 7, left: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "#${volume.number}",
                          style: GoogleFonts.openSans(
                              fontSize: 32,
                              color: Colors.indigo,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
                Container(
                  height: 35,
                  margin: const EdgeInsets.only(top: 23, bottom: 36),
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: DefaultTabController(
                    length: 3,
                    child: TabBar(
                        labelPadding: const EdgeInsets.all(0),
                        indicatorPadding: const EdgeInsets.all(0),
                        labelColor: kBlackColor,
                        unselectedLabelColor: kGreyColor,
                        labelStyle: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.w700),
                        unselectedLabelStyle: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.w600),
                        indicator: DotIndicator(
                            radius: 3,
                            color: Colors.black,
                            distanceFromCenter: 15),
                        tabs: [
                          Tab(
                            child: Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: const Text('Argumento'),
                            ),
                          ),
                          Tab(
                            child: Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: const Text('Reseñas'),
                            ),
                          ),
                          Tab(
                            child: Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: const Text('Similares'),
                            ),
                          )
                        ]),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                  child: Text(
                    volume.argument ?? "xd",
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black38,
                      letterSpacing: 1,
                      height: 2,
                    ),
                  ),
                )
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
