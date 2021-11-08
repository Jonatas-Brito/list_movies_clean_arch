String dateNumberToAbbreviationMonth(String releaseDate) {
  String day = releaseDate.split('-').removeAt(2);
  String month = releaseDate.split('-').removeAt(1);
  String year = releaseDate.split('-').removeAt(0);

  month = monthName(int.parse(month));

  String converted = "$month $day, $year";

  return converted;
}

monthName(month) {
  List<String> months = [
    'Jan',
    'Fev',
    'Mar',
    'Abr',
    'Maio',
    'Jun',
    'Jul',
    'Ago',
    'Set',
    'Out',
    'Nov',
    'Dez',
  ];

  return months[month - 1];
}
