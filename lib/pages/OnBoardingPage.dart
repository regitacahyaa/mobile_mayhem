import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:projek/utils/Colors.dart';

import 'HomePage.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  // Widget _buildFullscreenImage() {
  //   return Image.asset(
  //     'assets/fullscreen.jpg',
  //     fit: BoxFit.cover,
  //     height: double.infinity,
  //     width: double.infinity,
  //     alignment: Alignment.center,
  //   );
  // }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,
      // globalHeader: Align(
      //   alignment: Alignment.topRight,
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 16, right: 16),
      //       child: _buildImage('flutter.png', 100),
      //     ),
      //   ),
      // ),
      pages: [
        PageViewModel(
          title: "Selamat Datang di FamScreen!",
          body:
              "Temukan film yang aman dan sesuai usia dengan deteksi wajah otomatis.",
          image: _buildImage('img.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Deteksi Usia Real-Time",
          body:
              "Kami mendeteksi usia Anda secara real-time untuk menyesuaikan konten yang ditampilkan.",
          image: _buildImage('img1.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Rekomendasi Film Personal",
          body: "Nikmati film yang direkomendasikan khusus untuk usia Anda.",
          image: _buildImage('img2.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Keamanan untuk Keluarga",
          body:
              "Cegah anak-anak dari konten dewasa dengan peringatan otomatis.",
          image: _buildImage('img3.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Mulai Sekarang",
          body: "Daftar dan nikmati rekomendasi film sesuai usia Anda!",
          image: _buildImage('img4.jpg'),
          footer: Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColor.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 130.0, vertical: 10.0),
              ),
              child: const Text(
                'Daftar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 6,
            imageFlex: 6,
            safeArea: 80,
          ),
        ),
        // PageViewModel(
        //   title: "Title of last page - reversed",
        //   bodyWidget: const Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text("Click on ", style: bodyStyle),
        //       Icon(Icons.edit),
        //       Text(" to edit a post", style: bodyStyle),
        //     ],
        //   ),
        //   decoration: pageDecoration.copyWith(
        //     bodyFlex: 2,
        //     imageFlex: 4,
        //     bodyAlignment: Alignment.bottomCenter,
        //     imageAlignment: Alignment.topCenter,
        //   ),
        //   image: _buildImage('img1.jpg'),
        //   reverse: true,
        // ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
