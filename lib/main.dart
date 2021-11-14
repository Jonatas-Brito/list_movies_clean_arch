import 'package:flutter/cupertino.dart';
import 'package:movies_list/my_app.dart';

import 'injection_container.dart' as di;

double mockupWidth = 411;
double mockupHeight = 820;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}
