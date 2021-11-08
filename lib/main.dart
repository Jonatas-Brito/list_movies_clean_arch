import 'package:flutter/cupertino.dart';
import 'package:movies_list/my_app.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}
