import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'dart:ui' as ui;

class Graph3DPainter extends CustomPainter {
  final double angleX;
  final double angleY;
  final double zoom;
  final double labeloffset;
  final double eFieldMagnitude1;
  final double hFieldMagnitude1;
  final double eFieldMagnitude2;
  final double hFieldMagnitude2;
  final double waveNumber;
  final double phasorAngle1;
  final double phasorAngle2;
  final Point3D eFieldDirection1;
  final Point3D hFieldDirection1;
  final Point3D eFieldDirection2;
  final Point3D hFieldDirection2;
  final Point3D wavePropagationDirection;

  Graph3DPainter(
    {required this.angleX, required this.angleY, required this.zoom,required this.labeloffset, 
    required this.eFieldMagnitude1, required this.hFieldMagnitude1, 
    required this.eFieldMagnitude2, required this.hFieldMagnitude2, 
    required this.waveNumber, required this.phasorAngle1, required this.phasorAngle2,
    required this.eFieldDirection1, required this.hFieldDirection1, 
    required this.eFieldDirection2, required this.hFieldDirection2, 
    required this.wavePropagationDirection}
  );

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

  void drawArrow(Canvas canvas, Offset start, Offset end, Paint paint) {
    canvas.drawLine(start, end, paint);
    const double arrowSize = 10.0;
    double angle = atan2(end.dy - start.dy, end.dx - start.dx);
    Offset arrowPoint1 = end.translate(-arrowSize * cos(angle - pi / 6), -arrowSize * sin(angle - pi / 6));
    Offset arrowPoint2 = end.translate(-arrowSize * cos(angle + pi / 6), -arrowSize * sin(angle + pi / 6));
    canvas.drawLine(end, arrowPoint1, paint);
    canvas.drawLine(end, arrowPoint2, paint);
  }

  void drawGrid(Canvas canvas, Size size, Paint paint) {
    const int gridSize = 20;
    for (int i = 0; i <= size.width / gridSize; i++) {
      double x = i * gridSize.toDouble();
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (int i = 0; i <= size.height / gridSize; i++) {
      double y = i * gridSize.toDouble();
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()..color = Color(0xFFF3FFF1);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    final Paint gridPaint = Paint()..color = Colors.grey[300]!..strokeWidth = 0.5;
    drawGrid(canvas, size, gridPaint);

    final Paint axisPaint = Paint()..color = Colors.black..strokeWidth = 2.0;

    final Paint haxisPaint = Paint()..color = Colors.blue..strokeWidth = 3.0;
    final Paint eaxisPaint = Paint()..color = Colors.red..strokeWidth = 3.0;

    final Paint hfieldPaint = Paint()..color = Colors.blue..strokeWidth = 2.0;
    final Paint efieldPaint = Paint()..color = Colors.red..strokeWidth = 2.0;
    final Paint wavepropPaint = Paint()..color = Colors.orange..strokeWidth = 3.0;

    final Offset center = Offset(size.width / 2, size.height / 2);

    List<Point3D> axes = [Point3D(110, 0, 0), Point3D(0, 110, 0), Point3D(0, 0, 110)];

    List<Point3D> rotatedAxes = axes.map((point) {
      Point3D rotatedPoint = rotateX(point, angleX);
      rotatedPoint = rotateY(rotatedPoint, angleY);
      return rotatedPoint;
    }).toList();

    for (Point3D point in rotatedAxes) {
      Offset projected = project3DTo2D(point, zoom);
      drawArrow(canvas, center - projected, center + projected, axisPaint);
    }

    Offset xLabelPosition = center + project3DTo2D(rotateY(rotateX(Point3D(120, labeloffset, labeloffset), angleX), angleY), zoom);
    Offset yLabelPosition = center + project3DTo2D(rotateY(rotateX(Point3D(labeloffset, 120, labeloffset), angleX), angleY), zoom);
    Offset zLabelPosition = center + project3DTo2D(rotateY(rotateX(Point3D(labeloffset, labeloffset, 120), angleX), angleY), zoom);

    _drawText(canvas, "X", xLabelPosition, axisPaint);
    _drawText(canvas, "Y", yLabelPosition, axisPaint);
    _drawText(canvas, "Z", zLabelPosition, axisPaint);

    // Calculate resultant vectors
    Point3D resultantEField = Point3D(
      eFieldDirection1.x * eFieldMagnitude1 * cos(phasorAngle1) + eFieldDirection2.x * eFieldMagnitude2 * cos(phasorAngle2),
      eFieldDirection1.y * eFieldMagnitude1 * cos(phasorAngle1) + eFieldDirection2.y * eFieldMagnitude2 * cos(phasorAngle2),
      eFieldDirection1.z * eFieldMagnitude1 * cos(phasorAngle1) + eFieldDirection2.z * eFieldMagnitude2 * cos(phasorAngle2),
    );

    Point3D resultantHField = Point3D(
      hFieldDirection1.x * hFieldMagnitude1 * cos(phasorAngle1) + hFieldDirection2.x * hFieldMagnitude2 * cos(phasorAngle2),
      hFieldDirection1.y * hFieldMagnitude1 * cos(phasorAngle1) + hFieldDirection2.y * hFieldMagnitude2 * cos(phasorAngle2),
      hFieldDirection1.z * hFieldMagnitude1 * cos(phasorAngle1) + hFieldDirection2.z * hFieldMagnitude2 * cos(phasorAngle2),
    );

    // Drawing resultant vectors if magnitudes are not zero
    if (eFieldMagnitude1 != 0 || eFieldMagnitude2 != 0) {
      drawVector(canvas, center, resultantEField, 1, "E-Field", eaxisPaint);
    }
    if (hFieldMagnitude1 != 0 || hFieldMagnitude2 != 0) {
      drawVector(canvas, center, resultantHField, 1, "H-Field", haxisPaint);
    }
    if (eFieldMagnitude1 != 0 || eFieldMagnitude2 != 0 || hFieldMagnitude1 != 0 || hFieldMagnitude2 != 0) {
      drawVector(canvas, center, wavePropagationDirection,150, "Wave Propagation", wavepropPaint);
      //drawResultantEMWave(canvas, center, wavePaint);
      drawEWave(canvas, center, efieldPaint);
      drawHWave(canvas, center, hfieldPaint);
    }
  }

  void drawVector(Canvas canvas, Offset center, Point3D direction, double magnitude, String label, Paint paint) {
    Point3D field = Point3D(direction.x * magnitude, direction.y * magnitude, direction.z * magnitude);
    field = rotateX(field, angleX);
    field = rotateY(field, angleY);
    drawArrow(canvas, center, center + project3DTo2D(field, zoom), paint);
    _drawText(canvas, label, center + project3DTo2D(field, zoom) + Offset(10, 10), paint);
  }
  
  void drawResultantEMWave(Canvas canvas, Offset center, Paint wavePaint) {
    const int pointsCount = 200;
    List<Point3D> emWavePoints = List.generate(pointsCount, (i) {
      double t = i / 10.0;
      
      // Apply phasorAngle1 to the first field components and phasorAngle2 to the second components
      double eFieldX = eFieldMagnitude1 * eFieldDirection1.x * sin(waveNumber * t + phasorAngle1) + 
                      eFieldMagnitude2 * eFieldDirection2.x * sin(waveNumber * t + phasorAngle2);
      double eFieldY = eFieldMagnitude1 * eFieldDirection1.y * sin(waveNumber * t + phasorAngle1) + 
                      eFieldMagnitude2 * eFieldDirection2.y * sin(waveNumber * t + phasorAngle2);
      double eFieldZ = eFieldMagnitude1 * eFieldDirection1.z * sin(waveNumber * t + phasorAngle1) + 
                      eFieldMagnitude2 * eFieldDirection2.z * sin(waveNumber * t + phasorAngle2);
      
      double hFieldX = hFieldMagnitude1 * hFieldDirection1.x * cos(waveNumber * t + phasorAngle1) + 
                      hFieldMagnitude2 * hFieldDirection2.x * cos(waveNumber * t + phasorAngle2);
      double hFieldY = hFieldMagnitude1 * hFieldDirection1.y * cos(waveNumber * t + phasorAngle1) + 
                      hFieldMagnitude2 * hFieldDirection2.y * cos(waveNumber * t + phasorAngle2);
      double hFieldZ = hFieldMagnitude1 * hFieldDirection1.z * cos(waveNumber * t + phasorAngle1) + 
                      hFieldMagnitude2 * hFieldDirection2.z * cos(waveNumber * t + phasorAngle2);

      // Wave propagation along the specified direction
      double waveX = wavePropagationDirection.x * t * 5;
      double waveY = wavePropagationDirection.y * t * 5;
      double waveZ = wavePropagationDirection.z * t * 5;

      return Point3D(eFieldX + hFieldX + waveX, eFieldY + hFieldY + waveY, eFieldZ + hFieldZ + waveZ);
    });

    // Rotate and draw the points as before
    emWavePoints = emWavePoints.map((point) {
      point = rotateX(point, angleX);
      point = rotateY(point, angleY);
      return point;
    }).toList();

    for (int i = 0; i < emWavePoints.length - 1; i++) {
      Offset start = project3DTo2D(emWavePoints[i], zoom) + center;
      Offset end = project3DTo2D(emWavePoints[i + 1], zoom) + center;
      canvas.drawLine(start, end, wavePaint);
    }
  }

  void drawHWave(Canvas canvas, Offset center, Paint wavePaint) {
    const int pointsCount = 200;
    List<Point3D> eFieldPoints = List.generate(pointsCount, (i) {
      double t = i / 10.0;
      
      // Apply phasorAngle1 to the first field components and phasorAngle2 to the second components
      double hFieldX = hFieldMagnitude1 * hFieldDirection1.x * cos(waveNumber * t + phasorAngle1) + 
                      hFieldMagnitude2 * hFieldDirection2.x * cos(waveNumber * t + phasorAngle2);
      double hFieldY = hFieldMagnitude1 * hFieldDirection1.y * cos(waveNumber * t + phasorAngle1) + 
                      hFieldMagnitude2 * hFieldDirection2.y * cos(waveNumber * t + phasorAngle2);
      double hFieldZ = hFieldMagnitude1 * hFieldDirection1.z * cos(waveNumber * t + phasorAngle1) + 
                      hFieldMagnitude2 * hFieldDirection2.z * cos(waveNumber * t + phasorAngle2);

      // Wave propagation along the specified direction
      double waveX = wavePropagationDirection.x * t * 5;
      double waveY = wavePropagationDirection.y * t * 5;
      double waveZ = wavePropagationDirection.z * t * 5;

      return Point3D(hFieldX + waveX, hFieldY + waveY, hFieldZ + waveZ);
    });

    // Rotate and draw the points as before
    eFieldPoints = eFieldPoints.map((point) {
      point = rotateX(point, angleX);
      point = rotateY(point, angleY);
      return point;
    }).toList();

    for (int i = 0; i < eFieldPoints.length - 1; i++) {
      Offset start = project3DTo2D(eFieldPoints[i], zoom) + center;
      Offset end = project3DTo2D(eFieldPoints[i + 1], zoom) + center;
      canvas.drawLine(start, end, wavePaint);
    }
  }

  void drawEWave(Canvas canvas, Offset center, Paint wavePaint) {
    print("Drawing E-Field Wave");
    print("E-Field Magnitude 1: $eFieldMagnitude1");
    print("E-Field Magnitude 2: $eFieldMagnitude2");
    print("Phasor Angle 1: $phasorAngle1");
    print("Phasor Angle 2: $phasorAngle2");

    const int pointsCount = 200;
    List<Point3D> eFieldPoints = List.generate(pointsCount, (i) {
      double t = i / 10.0;
      
      // Apply phasorAngle1 to the first field components and phasorAngle2 to the second components
      double eFieldX = eFieldMagnitude1 * eFieldDirection1.x * cos(waveNumber * t + phasorAngle1) + 
                      eFieldMagnitude2 * eFieldDirection2.x * cos(waveNumber * t + phasorAngle2);
      double eFieldY = eFieldMagnitude1 * eFieldDirection1.y * cos(waveNumber * t + phasorAngle1) + 
                      eFieldMagnitude2 * eFieldDirection2.y * cos(waveNumber * t + phasorAngle2);
      double eFieldZ = eFieldMagnitude1 * eFieldDirection1.z * cos(waveNumber * t + phasorAngle1) + 
                      eFieldMagnitude2 * eFieldDirection2.z * cos(waveNumber * t + phasorAngle2);

      // Wave propagation along the specified direction
      double waveX = wavePropagationDirection.x * t * 5;
      double waveY = wavePropagationDirection.y * t * 5;
      double waveZ = wavePropagationDirection.z * t * 5;

      return Point3D(eFieldX + waveX, eFieldY + waveY, eFieldZ + waveZ);
    });

    // Rotate and draw the points as before
    eFieldPoints = eFieldPoints.map((point) {
      point = rotateX(point, angleX);
      point = rotateY(point, angleY);
      return point;
    }).toList();

    for (int i = 0; i < eFieldPoints.length - 1; i++) {
      Offset start = project3DTo2D(eFieldPoints[i], zoom) + center;
      Offset end = project3DTo2D(eFieldPoints[i + 1], zoom) + center;
      canvas.drawLine(start, end, wavePaint);
    }
  }

  void _drawText(Canvas canvas, String text, Offset position, Paint paint) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: TextStyle(color: paint.color, fontSize: 18, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    );

    // Layout the text with the specified width constraints
    textPainter.layout(minWidth: 0, maxWidth: double.infinity);
    
    // Paint the text on the canvas at the specified position
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Point3D {
  double x, y, z;
  Point3D(this.x, this.y, this.z);

  Offset toOffset() => Offset(x, y);
  
  Point3D add(Point3D other) {
    return Point3D(x + other.x, y + other.y, z + other.z);
  }
}