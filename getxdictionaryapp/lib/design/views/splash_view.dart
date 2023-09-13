import 'dart:async';

import 'package:flutter/material.dart';
import 'package:getxdictionaryapp/design/views/weather_view.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => WeatherView()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'test',
            child: SizedBox(
                height: s.height * 0.3,
                width: s.width * 0.6,
                child: Lottie.asset('lib/assets/lotties/sun_cloud.json',
                    fit: BoxFit.cover)),
          ),
          const Text(
            '☀️  WhatFeels ☁️',
            style: TextStyle(color: Colors.black, fontSize: 22),
          ),
        ],
      )),
    );
  }
}
