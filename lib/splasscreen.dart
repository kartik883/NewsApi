import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/view.dart';

class Splasscreen extends StatefulWidget {
  const Splasscreen({super.key});

  @override
  State<Splasscreen> createState() => _SplasscreenState();
}

class _SplasscreenState extends State<Splasscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ViewScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Image.asset(
              'images/splash_pic.jpg',
              fit: BoxFit.cover,
              height: height * .4,
              width: width * .2,
            ),
            SizedBox(
              height: height * .1,
            ),
            Center(
              child: Text(
                'Top Headline',
                style: GoogleFonts.anton(
                    letterSpacing: .6, color: Colors.grey.shade700),
              ),
            ),
            SizedBox(
              height: height * .1,
            ),
            SpinKitChasingDots(
              color: Colors.blueAccent,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
