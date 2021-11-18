import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/themes/app_theme.dart';
import 'features/favorites/presentation/cubit/cubit/cubit/moviesfavoriteslist_cubit.dart';
import 'features/favorites/presentation/cubit/cubit/moviefavorites_cubit.dart';
import 'features/home/presentation/cubit/get_cast_people/get_cast_people_cubit.dart';
import 'features/home/presentation/cubit/get_trailer_id/cubit/gettrailerid_cubit.dart';
import 'features/home/presentation/cubit/movies_in_theaters/movies_in_theaters_cubit.dart';
import 'features/home/presentation/cubit/movies_popular/movies_popular_cubit.dart';
import 'features/home/presentation/widgets/navigation.dart';
import 'features/search/presenter/cubit/search/cubit/search_movie_cubit.dart';
import 'injection_container.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<MoviesPopularCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<MoviesInTheatersCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<ManagerFavoritesMoviesCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<MoviesFavoritesListCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<GetTrailerIdCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<GetCastPeopleCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<SearchMovieCubit>(),
        ),
      ],
      child: MaterialApp(
        theme: appTheme(context),
        debugShowCheckedModeBanner: false,
        home: Navigation(),
      ),
    );
  }
}
