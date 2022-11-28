import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/profile_widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
        const SizedBox(height: 50),
        Container(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Perfil en ",
                  style: GoogleFonts.lato(fontSize: 30),
                ),
                Image.asset(
                  'assets/mobile_logo_1.png',
                  scale: 10,
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(
                  1,
                  1,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 24),
                ProfileWidget(
                  imagePath:
                      "https://i0.wp.com/codigoespagueti.com/wp-content/uploads/2022/05/kimetsu-no-yaiba-rengoku-cosplay.jpg?fit=1280%2C720&quality=80&ssl=1",
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                buildName(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        NumbersWidget(),
        const SizedBox(height: 48),
        buildAbout(),
      ],
    );
  }

  Widget buildName() => Column(
        children: [
          Text(
            "Matias",
            style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            "maty.infante@gmail.com",
            style: GoogleFonts.lato(color: Colors.black45),
          )
        ],
      );

  Widget buildAbout() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Insignias ganadas',
              style:
                  GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: Image.network(
                          "https://www.shareicon.net/data/2016/12/19/863777_win_512x512.png",
                          scale: 5,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Insignia $index',
                        style: GoogleFonts.raleway(fontSize: 20),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
}
