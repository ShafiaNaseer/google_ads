import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'banner/banner_ads.dart';
import 'dart:io';


AppOpenAd? appOpenAd;
void loadAppOpenAd(){
  AppOpenAd.load(adUnitId: Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/3419835294'
      : 'ca-app-pub-3940256099942544/5662855259',
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(onAdLoaded: (ad){
        appOpenAd = ad;
        appOpenAd!.show();
        print("Open App Ad");
      }, onAdFailedToLoad: (error){
        print("Error: ${error.message}");
      }),
      orientation: AppOpenAd.orientationPortrait);
}


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  loadAppOpenAd();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Ads',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BannerAds(),
    );
  }
}

