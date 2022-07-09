import 'package:flutter/material.dart';

var textInputDeocartion = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue[200]!, width: 2.0)),
  focusedBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue[600]!, width: 2.0)),
);

// make an elevated buttoin look like a raised button
final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: Colors.lightBlue[200],
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

// make a text button look like a flat button
final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  primary: Colors.white,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
);
