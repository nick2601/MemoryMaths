// import 'package:flutter/material.dart';
//
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// import 'AdsInfo.dart';
//
// class AdsFile {
//   BuildContext? context;
//   InterstitialAd? _interstitialAd;
//   RewardedAd? _rewardedAd;
//
//   AdsFile(BuildContext c) {
//     context = c;
//     setDefaultData();
//   }
//
//   setDefaultData() async {
//     // isAppPurchased = await PrefData.getIsAppPurchased();
//     // isAdsPermission = await PrefData.getIsAppAdsPermission();
//   }
//
//   BannerAd? _anchoredBanner;
//
//   Future<void> createAnchoredBanner(BuildContext context, var setState,
//       {Function? function}) async {
//     final AnchoredAdaptiveBannerAdSize? size =
//         await AdSize.getAnchoredAdaptiveBannerAdSize(
//       Orientation.portrait,
//       MediaQuery.of(context).size.width.truncate(),
//     );
//
//     if (size == null) {
//       print('Unable to get height of anchored banner.');
//       return;
//     }
//
//     final BannerAd banner = BannerAd(
//       size: size,
//       request: request,
//       adUnitId: getBannerAdUnitId(),
//       listener: BannerAdListener(
//         onAdLoaded: (Ad ad) {
//           print('$BannerAd loaded.');
//           setState(() {
//             _anchoredBanner = ad as BannerAd?;
//           });
//           if (function != null) {
//             function();
//           }
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           print('$BannerAd failedToLoad: $error');
//           ad.dispose();
//         },
//         onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
//         onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
//       ),
//     );
//     return banner.load();
//     // }
//   }
//
//   void disposeInterstitialAd() {
//     if (_interstitialAd != null) {
//       _interstitialAd!.dispose();
//     }
//   }
//
//   void disposeRewardedAd() {
//     if (_rewardedAd != null) {
//       _rewardedAd!.dispose();
//     }
//   }
//
//   void disposeBannerAd() {
//     if (_anchoredBanner != null) {
//       _anchoredBanner!.dispose();
//     }
//   }
//
//   void showInterstitialAd(Function function) {
//     if (_interstitialAd == null) {
//       print('Warning: attempt to show interstitial before loaded.');
//
//       function();
//
//       return;
//     }
//     _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (InterstitialAd ad) =>
//           print('ad onAdShowedFullScreenContent.'),
//       onAdDismissedFullScreenContent: (InterstitialAd ad) {
//         print('$ad onAdDismissedFullScreenContent.');
//         ad.dispose();
//         function();
//       },
//       onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
//         print('$ad onAdFailedToShowFullScreenContent: $error');
//         ad.dispose();
//         createInterstitialAd();
//       },
//     );
//     _interstitialAd!.show();
//     _interstitialAd = null;
//   }
//
//   void showRewardedAd(Function function, Function function1) async {
//     bool _isRewarded = false;
//     if (_rewardedAd == null) {
//       function1();
//       // showToast(S.of(context!).videoError);
//       print('Warning: attempt to show rewarded before loaded.');
//       return;
//     }
//     _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (RewardedAd ad) =>
//           print('ad onAdShowedFullScreenContent.'),
//       onAdDismissedFullScreenContent: (RewardedAd ad) {
//         print('$ad onAdDismissedFullScreenContent.');
//         ad.dispose();
//
//         if (_isRewarded) {
//           function();
//         } else {
//           function1();
//         }
//       },
//       onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
//         print('$ad onAdFailedToShowFullScreenContent: $error');
//         ad.dispose();
//       },
//     );
//
//     // _rewardedAd!.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
//     //   _isRewarded = true;
//     //   print('$ad with reward $RewardItem(${reward.amount}, ${reward.type}');
//     // });
//
//     _rewardedAd!.show(
//         onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
//       _isRewarded = true;
//       _rewardedAd = null;
//       // print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
//     });
//   }
//
//   void createRewardedAd() {
//     // if(!isAppPurchased ) {
//     RewardedAd.load(
//         adUnitId: getRewardBasedVideoAdUnitId(),
//         request: request,
//         rewardedAdLoadCallback: RewardedAdLoadCallback(
//           onAdLoaded: (RewardedAd ad) {
//             print('reward====$ad loaded.');
//             _rewardedAd = ad;
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             print('RewardedAd failed to load: $error');
//             _rewardedAd = null;
//             createRewardedAd();
//           },
//         ));
//   }
//
//   void createInterstitialAd() {
//     // if(!isAppPurchased  ) {
//     // if(!isAppPurchased  && isAdsPermission) {
//     InterstitialAd.load(
//         adUnitId: getInterstitialAdUnitId(),
//         request: request,
//         adLoadCallback: InterstitialAdLoadCallback(
//           onAdLoaded: (InterstitialAd ad) {
//             print('$ad loaded');
//             print('failed==== true');
//
//             _interstitialAd = ad;
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             print('InterstitialAd failed to load: $error.');
//             // _numInterstitialLoadAttempts += 1;
//             _interstitialAd = null;
//             print('failed==== loaded');
//
//             // if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
//             createInterstitialAd();
//             // }
//           },
//         ));
//   }
//   // }
// }
//
// getBanner(BuildContext context, AdsFile? adsFile) {
//   if (adsFile == null) {
//     return Container();
//   } else {
//     return showBanner(context, adsFile);
//   }
// }
//
// showRewardedAd(AdsFile? adsFile, Function function, {Function? function1}) {
//   if (adsFile != null) {
//     adsFile.showRewardedAd(() {
//       function();
//     }, () {
//       if (function1 != null) {
//         function1();
//       }
//     });
//   }
// }
//
// showInterstitialAd(AdsFile? adsFile, Function function) {
//   if (adsFile != null) {
//     adsFile.showInterstitialAd(() {
//       function();
//     });
//   } else {
//     function();
//   }
// }
//
// disposeRewardedAd(AdsFile? adsFile) {
//   if (adsFile != null) {
//     adsFile.disposeRewardedAd();
//   }
// }
//
// disposeInterstitialAd(AdsFile? adsFile) {
//   if (adsFile != null) {
//     adsFile.disposeInterstitialAd();
//   }
// }
//
// disposeBannerAd(AdsFile? adsFile) {
//   if (adsFile != null) {
//     adsFile.disposeBannerAd();
//   }
// }
//
// showBanner(BuildContext context, AdsFile adsFile) {
//   return Container(
//     height: (getBannerAd(adsFile) != null)
//         ? getBannerAd(adsFile)!.size.height.toDouble()
//         : 0,
//     // color: Colors.black,
//     color: Theme.of(context).scaffoldBackgroundColor,
//     child: (getBannerAd(adsFile) != null)
//         ? AdWidget(ad: getBannerAd(adsFile)!)
//         : Container(),
//   );
// }
//
// BannerAd? getBannerAd(AdsFile? adsFile) {
//   BannerAd? _anchoredBanner;
//   if (adsFile != null) {
//     return (adsFile._anchoredBanner == null)
//         ? _anchoredBanner
//         : adsFile._anchoredBanner!;
//   } else {
//     return _anchoredBanner!;
//   }
// }
