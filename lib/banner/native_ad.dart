import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdScreen extends StatefulWidget {
  const NativeAdScreen({Key? key}) : super(key: key);

  @override
  State<NativeAdScreen> createState() => _NativeAdScreenState();
}

class _NativeAdScreenState extends State<NativeAdScreen> {
  NativeAd? nativeAd;
  bool isLoaded = false;
  @override
  void initState() {
    // TODO: implement initState
    loadNativeAd();
    super.initState();
  }

  void loadNativeAd() {
    nativeAd = NativeAd(
        adUnitId: "ca-app-pub-3940256099942544/2247696110",
        factoryId: "listTile",
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            print("Native Ad Loaded");
            setState(() {
              isLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            nativeAd!.dispose();
            print("Error ${error.message}");
          },
        ),
        request: AdRequest());
    nativeAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Native Ad"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Center(child: Text("Hiiiiii! Native Ad here")),

        ],
      ),
      bottomNavigationBar:      isLoaded
          ? Container(
        alignment: Alignment.center,
        child: AdWidget(ad: nativeAd!),
        // width: 200,
        height: 200,
      )
          : Container(
        color: Colors.black26,
      ),
    );
  }
}
