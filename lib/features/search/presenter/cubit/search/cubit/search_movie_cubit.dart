import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/strings/app_strings.dart';
import '../../../../../home/domain/entities/movie.dart';
import '../../../../domain/usecases/search_movie.dart';

part 'search_movie_state.dart';

class SearchMovieCubit extends Cubit<SearchMovieState> {
  SearchMovie searchMovie;
  SearchMovieCubit({required this.searchMovie}) : super(SearchMovieInitial());

  searchInListMovies(String text, List<Movie> movies) async {
    emit(SearchMovieIsLoading());
    final failureOrMovies =
        await searchMovie.call(Params(text: text, movies: movies));
    _eitherSuccessOrErrorState(failureOrMovies);
  }

  _eitherSuccessOrErrorState(
    Either<Failure, List<Movie>> failureOrMovies,
  ) async {
    failureOrMovies.fold(
        (failure) => emit(SearchMovieIsError(
            errorMessage: AppStrings.SEARCH_FAILURE_MESSAGE)), (movies) async {
      if (movies.isEmpty) {
        emit(SearchMovieIsEmpty());
      } else {
        print("Movies: ${movies[0].title}");
        emit(SearchMovieIsSuccess(movies: movies));
        await Future.delayed(Duration(milliseconds: 500));
        emit(SearchMovieInitial());
      }
    });
  }
}
