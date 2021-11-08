import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list/features/home/presentation/cubit/movies_popular_cubit.dart';
import 'package:movies_list/features/home/presentation/pages/home.dart';

import 'core/themes/app_theme.dart';
import 'features/home/presentation/cubit/movies_in_theaters_cubit.dart';
import 'injection_container.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: appTheme(context),
        debugShowCheckedModeBanner: false,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<MoviesPopularCubit>(),
            ),
            BlocProvider(
              create: (_) => sl<MoviesInTheatersCubit>(),
            ),
          ],
          child: HomePage(),
        ));
  }
}
