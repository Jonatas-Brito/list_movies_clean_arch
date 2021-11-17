import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:movies_list/core/themes/app_colors.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

class FieldSearchComponent extends StatefulWidget {
  final List<Movie> movies;
  const FieldSearchComponent({
    Key? key,
    required this.movies,
  }) : super(key: key);

  @override
  _FieldSearchComponentState createState() => _FieldSearchComponentState();
}

class _FieldSearchComponentState extends State<FieldSearchComponent> {
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    movies = widget.movies;
  }

  FutureOr<Iterable<Movie>> suggestionsCallback(String text) async {
    List<Movie> suggestionMovies = [];
    String _input = text;

    movies.forEach((movie) {
      if (_input.length >= 4 &&
          movie.title.toLowerCase().contains(_input.toLowerCase())) {
        suggestionMovies.add(movie);
      }
    });

    return suggestionMovies;
  }

  void onSuggestionSelected(Movie service) async {}

  Widget itemBuilder(BuildContext context, Movie? movie) {
    if (movie == null) return CircularProgressIndicator();

    return ListTile();
  }

  Widget noItemsFoundBuilder(BuildContext context) {
    return ListTile(
      title: Text(
        'Nenhum item encontrado',
        textAlign: TextAlign.center,
        style:
            TextStyle(color: Theme.of(context).disabledColor, fontSize: 17.0),
      ),
    );
  }

  Widget loadingBuilder(BuildContext context) {
    return ListTile(
      title: Container(
        height: 50,
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.red),
        ),
      ),
    );
  }

  Widget errorBuilder(BuildContext context, dynamic) {
    return ListTile(
      title: Text(
        'Erro ao carregar lista',
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColors.red, fontSize: 17.0),
      ),
    );
  }

  OutlineInputBorder _defaultOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade100,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(50),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .02,
      child: TypeAheadFormField<Movie>(
        errorBuilder: errorBuilder,
        onSuggestionSelected: onSuggestionSelected,
        noItemsFoundBuilder: noItemsFoundBuilder,
        itemBuilder: itemBuilder,
        suggestionsCallback: suggestionsCallback,
        textFieldConfiguration: TextFieldConfiguration(
            decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 12, top: 12, bottom: 12),
                  child: Image.asset(
                    'assets/icons/search.png',
                    color: Colors.white,
                  ),
                ),
                hintText: 'Buscar',
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.grey.shade100),
                border: _defaultOutlineInputBorder(),
                focusedBorder: _defaultOutlineInputBorder(),
                disabledBorder: _defaultOutlineInputBorder(),
                errorBorder: _defaultOutlineInputBorder(),
                enabledBorder: _defaultOutlineInputBorder())),
        getImmediateSuggestions: true,
        suggestionsBoxDecoration: SuggestionsBoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
