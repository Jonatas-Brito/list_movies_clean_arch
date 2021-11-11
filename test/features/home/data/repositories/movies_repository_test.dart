import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_list/core/error/exceptions.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/core/network/network_info.dart';
import 'package:movies_list/features/home/data/datasources/movies_remote_data_source.dart';
import 'package:movies_list/features/home/data/models/movies_model.dart';
import 'package:movies_list/features/home/data/repositories/movies_repository.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

import 'movies_repository_test.mocks.dart';

@GenerateMocks([NetworkInfo, MoviesRemoteDataSource])
void main() {
  MockMoviesRemoteDataSource mockRemoteDataSource =
      MockMoviesRemoteDataSource();
  MockNetworkInfo mockNetworkInfo = MockNetworkInfo();
  MoviesRepositoryImpl repositoryImpl = MoviesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource, networkInfo: mockNetworkInfo);

  void runTestsOnline(Function body) {
    group('device in online', () {
      setUp(() async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device in online', () {
      setUp(() async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getPopularMovies', () {
    final tMovieModel = MovieModel(
        id: 1,
        overview: 'as',
        voteCount: 1,
        voteAverage: 0.0,
        bannerPath: 'image2.jpeg',
        title: 'Test Text',
        imagePath: 'image.jpeg',
        popularity: 1.2,
        releaseDate: '2020/05/25');

    final List<Movie> tMoviesModel = [tMovieModel];
    final List<Movie> tMovies = tMoviesModel;

    test('should check if the device is connected', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getMoviesPopular('key'))
          .thenAnswer((invocation) async => <Movie>[]);
      // act
      await repositoryImpl.getMoviesPopular('key');
      final result = await mockNetworkInfo.isConnected;
      // assert
      verify(mockNetworkInfo.isConnected);
      expect(result, true);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getMoviesPopular('key'))
            .thenAnswer((_) async => tMoviesModel);
        // act
        final result = await repositoryImpl.getMoviesPopular('key');
        // assert
        verify(mockRemoteDataSource.getMoviesPopular('key'));
        expect(result, Right(tMovies));
        expect(result.fold(id, id), isA<List<Movie>>());
      });

      test(
          'should return ServerFailure when the call to remote data source is not successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getMoviesPopular('key'))
            .thenThrow(ServerException());
        // act
        final result = await repositoryImpl.getMoviesPopular('key');
        // assert
        verify(mockRemoteDataSource.getMoviesPopular('key'));
        expect(result, equals(Left(ServerFailure())));
        expect(result.fold(id, id), isA<ServerFailure>());
      });
    });

    runTestsOffline(() {
      test('should return UnconnectedDevice when netwokInfo is returned false',
          () async {
        // arrange
        when(mockRemoteDataSource.getMoviesPopular('key'))
            .thenAnswer((invocation) async => tMoviesModel);
        // act
        final result = await repositoryImpl.getMoviesPopular('key');
        // assert
        expect(result.fold(id, id), isA<UnconnectedDevice>());
        expect(result, Left(UnconnectedDevice()));
      });
    });
  });

  group('getMoviesInTheater', () {
    final tMovieModel = MovieModel(
        id: 1,
        overview: 'as',
        voteCount: 1,
        voteAverage: 0.0,
        title: 'Test Text',
        bannerPath: 'image2.jpeg',
        imagePath: 'image.jpeg',
        popularity: 1.2,
        releaseDate: '2020/05/25');

    final List<Movie> tMoviesModel = [tMovieModel];
    final List<Movie> tMovies = tMoviesModel;

    test('should check if the device is connected', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getMoviesInTheaters('key'))
          .thenAnswer((invocation) async => <Movie>[]);
      // act
      await repositoryImpl.getMoviesInTheaters('key');
      final result = await mockNetworkInfo.isConnected;
      // assert
      verify(mockNetworkInfo.isConnected);
      expect(result, true);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getMoviesInTheaters('key'))
            .thenAnswer((_) async => tMoviesModel);
        // act
        final result = await repositoryImpl.getMoviesInTheaters('key');
        // assert
        verify(mockRemoteDataSource.getMoviesInTheaters('key'));
        expect(result, Right(tMovies));
        expect(result.fold(id, id), isA<List<Movie>>());
      });

      test(
          'should return ServerFailure when the call to remote data source is not successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getMoviesInTheaters('key'))
            .thenThrow(ServerException());
        // act
        final result = await repositoryImpl.getMoviesInTheaters('key');
        // assert
        verify(mockRemoteDataSource.getMoviesInTheaters('key'));
        expect(result, equals(Left(ServerFailure())));
        expect(result.fold(id, id), isA<ServerFailure>());
      });
    });

    runTestsOffline(() {
      test('should return UnconnectedDevice when netwokInfo is returned false',
          () async {
        // arrange
        when(mockRemoteDataSource.getMoviesInTheaters('key'))
            .thenAnswer((invocation) async => tMoviesModel);
        // act
        final result = await repositoryImpl.getMoviesInTheaters('key');
        // assert
        expect(result.fold(id, id), isA<UnconnectedDevice>());
        expect(result, Left(UnconnectedDevice()));
      });
    });
  });
}
