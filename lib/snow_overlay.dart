import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math';

class SNOWFLAKESETTINGS {
  static const PERIODIC_UPDATE_DURATION = 25;
  static const MIN_SIZE = 20;
  static const MAX_SIZE = 50;
  static const SNOW_FLAKE_COUNT = 100;
}

class SnowOverlay extends StatefulWidget {
  final Size size;
  const SnowOverlay({Key? key, required this.size}) : super(key: key);

  @override
  _SnowOverlayState createState() => _SnowOverlayState();
}

class _SnowOverlayState extends State<SnowOverlay> {
  List<SnowFlake> snowflakes = [];
  var random = new Random();

  void initSnowFlakes() {
    for (var i = 0; i < SNOWFLAKESETTINGS.SNOW_FLAKE_COUNT; i++) {
      var s = SnowFlake();
      s.posX = random.nextDouble() * widget.size.width;
      s.posY = random.nextDouble() * widget.size.height;
      s.size = random.nextDouble() * 20 + 5;
      snowflakes.add(s);
    }
  }

  void updateSnowflakes() {
    for (var s in snowflakes) {
      s.posY += 3;
    }
  }

  @override
  void initState() {
    super.initState();
    initSnowFlakes();
    Timer.periodic(
        Duration(milliseconds: SNOWFLAKESETTINGS.PERIODIC_UPDATE_DURATION),
        (timer) {
      setState(() {
        updateSnowflakes();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(snowflakes);
    return SizedBox.expand(
        child: CustomPaint(
            size: widget.size, painter: SnowPainter(snowflakes: snowflakes)));
  }
}

class SnowPainter extends CustomPainter {
  List<SnowFlake> snowflakes;

  SnowPainter({required this.snowflakes}) : super();

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final p = Paint();
    p.color = Color.fromARGB(120, 255, 0, 0);

    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), p);

    p.color = Colors.amber;
    for (var s in snowflakes) {
      canvas.drawCircle(Offset(s.posX, s.posY), s.size, p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class SnowFlake {
  double posX = 0, posY = 0;
  double size = 10;
  SnowFlake() {}
}
