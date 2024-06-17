import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:fade_out_particle/fade_out_particle.dart';
import 'package:hive/hive.dart';
import 'package:host_task/core/auth/presentation/login_screen.dart';
import 'package:host_task/core/common/colors.dart';
import 'package:host_task/core/common/label.dart';
import 'package:host_task/core/images/image.dart';
import 'package:host_task/screen/host_screen/host_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogoVisible = true;

  Future<void> checkLoginStatus() async {
    var box = await Hive.openBox('authBox');

    // header["Authorization"]="Bearer ${box.get("authToken")}";
    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        setState(
          () {
            isLogoVisible = false;
          },
        );
      },
    );
    Future.delayed(const Duration(milliseconds: 3000), () {
      try {
        String? authToken = box.get("authToken");
        print("authToken =$authToken");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => (box.get("authToken") == null)
                    ? LoginScreen()
                    : HostScreen()),
            (Route route) => false);
      } catch (e) {
        debugPrint('Error navigating to LoginScreen: $e');
      }
    });
  }

  @override
  void initState() {
    super.initState();

    checkLoginStatus();
  }

  Future<bool> isImageSets() {
    return Future.delayed(
      const Duration(seconds: 2),
      () => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLogoVisible = true;

    Widget getAnimationContainer({bool isImageSet = true}) {
      return LayoutBuilder(
        builder: (context, size) {
          return Stack(
            alignment: Alignment.center,
            children: [
              AnimatedPositioned(
                height:
                    isImageSet ? 550 : MediaQuery.of(context).size.height / 1.5,
                width: isImageSet ? 550 : 250,
                curve: Curves.fastOutSlowIn,
                duration: const Duration(seconds: 1),
                top: isImageSet ? size.maxHeight : 20,
                child: Image.asset(
                  AppImage.logo1,
                  height: 300,
                  width: 500,
                  fit: BoxFit.fitWidth,
                ),
              ),
              const FadeOutParticle(
                curve: Easing.emphasizedAccelerate,
                disappear: true,
                duration: Duration(milliseconds: 4000),
                child: AutoSizeText(
                  'Empowering Your Culinary Journey',
                  minFontSize: 25,
                  maxFontSize: 30,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.black,
                    decorationColor: AppColors.whiteColor,
                    fontSize: 30,
                    fontWeight: CustomLabels.largeFontWeight,
                    fontFamily: CustomLabels.secondaryFont,
                  ),
                  maxLines: 1,
                ),
              ),
                Positioned(
              top: 250,
                child: Image.asset(
                  "assets/image/qd_logo.webp",
                  height: 80,
                  width: 200,
                  fit: BoxFit.fill,
                ),
              )
            ],
          );
        },
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: false,
      extendBody: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/image/Desktop - 46.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Center(
                child: Hero(
                  tag: 'Logo',
                  child: AnimatedOpacity(
                    duration: const Duration(seconds: 2),
                    // ignore: dead_code
                    opacity: isLogoVisible ? 1.0 : 1.0,
                    child: Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: getAnimationContainer(isImageSet: isLogoVisible),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
