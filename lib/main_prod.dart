import 'package:Cocoverde/environment.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'main.mapper.g.dart' show initializeJsonMapper;

  import 'package:intl/intl.dart';
  import 'package:intl/date_symbol_data_local.dart';

void main() {
  Constants.setEnvironment(Environment.PROD);
  initializeJsonMapper();
  Intl.defaultLocale = "en";
  initializeDateFormatting();
  runApp(CocoverdeApp());
}
