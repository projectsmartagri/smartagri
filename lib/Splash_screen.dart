import 'package:flutter/material.dart';
import 'package:smartagri/modules/choose_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool showTagline = false; // Controls the visibility of the tagline

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    // Show tagline after animation completes
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        showTagline = true;
      });
    });

    // Navigate to the next screen after a delay
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChooseScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE8F5E9), // Light pista green
                  Color(0xFFC8E6C9), // Slightly darker green
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),


          // Main Content with Circular Reveal Animation
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Circular Reveal Animation for "Smart Agri"
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return ClipPath(
                      clipper: CircularRevealClipper(_controller.value),
                      child: child,
                    );
                  },
                  child: Text(
                    'Smart Agri',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Dancing Script',
                      color: Color.fromRGBO(4, 75, 4, 0.961),
                    ),
                  ),
                ),

                // Tagline (visible after animation)
                AnimatedOpacity(
                  opacity: showTagline ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    'Farm to Fork, Fresh Everyday',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(228, 76, 175, 79),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Clipper for Circular Reveal Animation
class CircularRevealClipper extends CustomClipper<Path> {
  final double revealPercent;

  CircularRevealClipper(this.revealPercent);

  @override
  Path getClip(Size size) {
    final path = Path();
    final circleCenter = Offset(0, size.height / 2); // Center reveal
    final radius = size.width * revealPercent;

    path.addOval(Rect.fromCircle(center: circleCenter, radius: radius));
    return path;
  }

  @override
  bool shouldReclip(CircularRevealClipper oldClipper) {
    return oldClipper.revealPercent != revealPercent;
  }
}
