import 'package:atom_cat/screens/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);

  runApp(const AtomApp());
}