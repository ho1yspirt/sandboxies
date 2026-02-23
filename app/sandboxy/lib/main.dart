import 'package:flutter/material.dart';

void main() {
  runApp(
    Directionality(
      textDirection: .ltr,
      child: Overlay(initialEntries: [OverlayEntry(builder: (context) => MaterialApp())]),
    ),
  );
}
