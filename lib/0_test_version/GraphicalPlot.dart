import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

void main() => runApp(MaterialApp(home: Scaffold(body: Custom3DGraph())));

class Custom3DGraph extends StatefulWidget {
  @override
  _Custom3DGraphState createState() => _Custom3DGraphState();
}

class _Custom3DGraphState extends State<Custom3DGraph> {
  double angleX = 0.0;
  double angleY = 0.0;
  double zoom = 300.0; // Default zoom factor

  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      angleX += details.focalPointDelta.dy * 0.01; // Rotate around X-axis
      angleY += details.focalPointDelta.dx * 0.01; // Rotate around Y-axis
      zoom = (zoom * details.scale).clamp(100.0, 800.0); // Zoom range
    });
  }

  Offset project3DTo2D(Point3D point, double zoom) {
    double x2d = zoom * point.x / (zoom + point.z);
    double y2d = zoom * point.y / (zoom + point.z);
    return Offset(x2d, y2d);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleUpdate: _onScaleUpdate,
      child: CustomPaint(
        painter: _Graph3DPainter(angleX, angleY, zoom),
        size: Size.infinite,
      ),
    );
  }
}

class _Graph3DPainter extends CustomPainter {
  final double angleX;
  final double angleY;
  final double zoom;

  _Graph3DPainter(this.angleX, this.angleY, this.zoom);

  Point3D rotateX(Point3D point, double angle) {
    double cosAngle = cos(angle);
    double sinAngle = sin(angle);
    double y = point.y * cosAngle - point.z * sinAngle;
    double z = point.y * sinAngle + point.z * cosAngle;
    return Point3D(point.x, y, z);
  }

  Point3D rotateY(Point3D point, double angle) {
    double cosAngle = cos(angle);
    double sinAngle = sin(angle);
    double x = point.z * sinAngle + point.x * cosAngle;
    double z = point.z * cosAngle - point.x * sinAngle;
    return Point3D(x, point.y, z);
  }

  Offset project3DTo2D(Point3D point, double zoom) {
    double x2d = zoom * point.x / (zoom + point.z);
    double y2d = zoom * point.y / (zoom + point.z);
    return Offset(x2d, y2d);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    final Paint wavePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0;

    final Paint vectorPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0;

    // Center of the graph
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Draw 3D axes
    List<Point3D> axes = [
      Point3D(200, 0, 0),  // X-axis
      Point3D(0, 200, 0),  // Y-axis
      Point3D(0, 0, 200)   // Z-axis
    ];

    axes = axes.map((point) {
      point = rotateX(point, angleX);
      point = rotateY(point, angleY);
      return point;
    }).toList();

    // Draw axes
    for (Point3D point in axes) {
      Offset projected = project3DTo2D(point, zoom);
      canvas.drawLine(center, center + projected, axisPaint);
    }

    // Calculate projected positions for axis labels
    Offset xLabelPosition = center + project3DTo2D(Point3D(20, 0, 0), zoom);
    Offset yLabelPosition = center + project3DTo2D(Point3D(0, 20, 0), zoom);
    Offset zLabelPosition = center + project3DTo2D(Point3D(0, 0, 20), zoom);

    // Label axes at the tips
    _drawText(canvas, "X", xLabelPosition, axisPaint);
    _drawText(canvas, "Y", yLabelPosition, axisPaint);
    _drawText(canvas, "Z", zLabelPosition, axisPaint);

    // Draw E-Field vector
    Point3D eField = Point3D(80, 0, 0); // Example E-Field vector
    eField = rotateX(eField, angleX);
    eField = rotateY(eField, angleY);
    canvas.drawLine(center, center + project3DTo2D(eField, zoom), vectorPaint);
    _drawText(canvas, "E-Field", center + project3DTo2D(eField, zoom) + Offset(10, 10), vectorPaint);

    // Draw H-Field vector
    Point3D hField = Point3D(0, 80, 0); // Example H-Field vector
    hField = rotateX(hField, angleX);
    hField = rotateY(hField, angleY);
    canvas.drawLine(center, center + project3DTo2D(hField, zoom), vectorPaint);
    _drawText(canvas, "H-Field", center + project3DTo2D(hField, zoom) + Offset(10, 10), vectorPaint);

    // Draw EM wave (sine wave example along X-axis)
    const int pointsCount = 500; // Increase the number of points
    List<Point3D> emWavePoints = List.generate(pointsCount, (i) {
      double t = i / 10.0; // time-like value
      return Point3D(50 * sin(t), 20 * cos(t), t * 5); // Example wave equation
    });

    emWavePoints = emWavePoints.map((point) {
      point = rotateX(point, angleX);
      point = rotateY(point, angleY);
      return point;
    }).toList();

    for (int i = 1; i < emWavePoints.length; i++) {
      Offset p1 = project3DTo2D(emWavePoints[i - 1], zoom);
      Offset p2 = project3DTo2D(emWavePoints[i], zoom);

      canvas.drawLine(center + p1, center + p2, wavePaint);
    }

    // Draw pi labels on the axes
    // for (int i = -5; i <= 5; i++) {
    //   double piInterval = i * pi; // Pi intervals
    //   Offset piPointX = project3DTo2D(Point3D(piInterval, 0, 0), zoom);
    //   Offset piPointY = project3DTo2D(Point3D(0, piInterval, 0), zoom);
    //   Offset piPointZ = project3DTo2D(Point3D(0, 0, piInterval), zoom);

    //   _drawText(canvas, "${i}π", center + piPointX, axisPaint);
    //   _drawText(canvas, "${i}π", center + piPointY, axisPaint);
    //   _drawText(canvas, "${i}π", center + piPointZ, axisPaint);
    // }
  }

  void _drawText(Canvas canvas, String text, Offset position, Paint paint) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: TextStyle(color: paint.color, fontSize: 12)),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Point3D {
  double x;
  double y;
  double z;

  Point3D(this.x, this.y, this.z);
}
