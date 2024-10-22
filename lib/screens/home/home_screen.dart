import 'package:flutter/material.dart';
import 'package:tv_application/responsive.dart';

import '../player/player_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FocusNode _focusNodeOne;
  late FocusNode _focusNodeTwo;
  FocusNode _focusNode = FocusNode();
  Color _borderColor = Colors.grey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNodeOne = FocusNode();
    _focusNodeTwo = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusNodeOne.dispose();
    _focusNodeTwo.dispose();
  }

  Widget build(BuildContext context) {
    var mob = Responsive.isMobile(context);
    var tab = Responsive.isTablet(context);
    var desktop = Responsive.isDesktop(context);
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var focus = false;

    return Scaffold(
      backgroundColor: const Color(0xff010125),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
        Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 70.0),
        child: Center(
          child: Container(
            height: height * .25,
            width: width/2.2,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/logo.png"),
                  fit: BoxFit.contain,
                )),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20, left: 20,),
        child: Container(
          width: mob ? width / 1.4 : width / 3,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
              children: [
          Expanded(
          child:FocusScope(node: FocusScopeNode(),
          child: Focus(
            onFocusChange: (hasFocus) {
              setState(() {
                _borderColor = hasFocus ? Colors.red: Colors.transparent;
              });
            },
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) {
                      return const PlayScreen(
                        url:
                        "https://5a1178b42cc03.streamlock.net/trsptv/trsptv/chunklist_w1741685577.m3u8",
                      );
                    }));
              },
              child: Container(
                height: mob ? height * .13 : height * .2,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: _borderColor,
                        width: 3),
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage(
                        "assets/tv_one.png",
                      ),
                      fit: BoxFit.fill,
                    )),
              ),
            ),
          ),
        ),
          ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            height: mob ? height * .13 : height * .2,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/tv_two.png",
                  ),
                  fit: BoxFit.fill,
                )),
          ),
        )
        ],
      ),
    ),
    ),
    Padding(
    padding: const EdgeInsets.only(left: 20,right: 20,top: 40.0, bottom: 20),
    child: Container(
    height: height * .15,
    width: width/2.2,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("assets/banner-store.png"),
    fit: BoxFit.fill,
    ),
    ),
    )),
    Text(
    "PER LA PUBBLICITA SU TRSP CHIAMA AL +39 0874438817 SCRIVI A AMMINISTRAZIONE@TRSP.TV",
    style: TextStyle(
    fontSize: mob ? 7 : 14,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    ),
    )
    ],
    ),
    ),
    );
    }
}
