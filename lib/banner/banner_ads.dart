

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'native_ad.dart';

class BannerAds extends StatefulWidget {
  const BannerAds({Key? key}) : super(key: key);

  @override
  State<BannerAds> createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAds> {
  BannerAd? bannerAds;
  InterstitialAd? interstitialAd;
  bool isLoaded = false;
 bool isAdLoaded = false;
  @override
  void initState() {
    // TODO: implement initState
    loadBannerAd();
    loadInterstitialAd();
    Timer(Duration(seconds: 15), () {
      if (interstitialAd != null) {
        interstitialAd!.dispose();
        Navigator.push(context, MaterialPageRoute(builder: (context) => NativeAdScreen(),));
      }
    });
    super.initState();
  }
  void loadBannerAd() {
    bannerAds = BannerAd(
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isLoaded = true;
          });
          print("Banner Ad Loaded");
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
      request: AdRequest(),
      size: AdSize.banner,
    );
    bannerAds!.load();
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/1033173712",
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) {
              setState((){
                isAdLoaded = true;
              });
              interstitialAd = ad;
              print("Interstitial Ad Loaded");
              interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
                  onAdFailedToShowFullScreenContent: (ad, error) {
                    ad.dispose();
                    interstitialAd!.dispose();
                    print(error.message);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NativeAdScreen(),));
                  },
                  onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
                interstitialAd!.dispose();
              },
              );
            },
            onAdFailedToLoad: (error) {
          print("Error Message ${error.message}");

        }));
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Banner ad")),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {

                if(isAdLoaded == true) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NativeAdScreen(),));
                  loadInterstitialAd();
                  interstitialAd!.show();
                }
              },
              child: Text("Interstitial ad")),
          Spacer(),
          isLoaded
              ? Container(
                  height: 50,
                  child: AdWidget(ad: bannerAds!),
                )
              : Container()
        ],
      ),
    );
  }
}
