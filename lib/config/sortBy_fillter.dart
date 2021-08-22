const List<String> sortByFilter = [
  'publishedAt',
  'popularity',
  'relevancy',
];
const List<String> sortBy = [
  'Publish Date',
  'Popularity',
  'Similar',
];

//* Language Map used for user selection
Map<String, String> sortByMap =
    Map.fromIterables(sortBy, sortByFilter);

//* getter for country code
String getSortByFilter(String filter) => sortByMap[filter]!;
