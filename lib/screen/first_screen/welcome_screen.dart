import 'package:flutter/material.dart';
import 'package:new_travel_app/screen/authentication/authentication_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;

        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/image/welcome_image.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.7),
                BlendMode.dstATop,
              ),
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.1,
                  horizontal: screenWidth * 0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(screenWidth * 0.1, 'Enjoy', Colors.white,
                        FontWeight.bold, 1.5),
                    SizedBox(height: screenHeight * 0.005),
                    text(screenWidth * 0.1, 'the world!',
                        Colors.white.withOpacity(0.9), FontWeight.w400, 1.5),
                    SizedBox(height: screenHeight * 0.03),
                    text(
                        screenWidth * 0.045,
                        'Pick your bags, follow your curiosity, and let the adventure unfold one destination at a time.',
                        Colors.white.withOpacity(0.7),
                        null,
                        1.2),
                    SizedBox(height: screenHeight * 0.05),
                    InkWell(
                      onTap: () {
                        _markWelcomeScreenShown();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AuthenticationPage(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black54,
                          size: screenWidth * 0.04,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    text(screenWidth * 0.04, "Let's Start",
                        Colors.white.withOpacity(0.7), null, 1.2),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _markWelcomeScreenShown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('welcomeScreenShown', true);
  }

  Widget text(double screenWidth, String text, Color color,
      FontWeight? fontWeight, double letterSpacing) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: screenWidth,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
