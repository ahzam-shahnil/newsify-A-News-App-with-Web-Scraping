const List<String> languageFilter = [
  'en',
  'ur',
  'hi',
];
const List<String> languages = [
  'English',
  'Urdu',
  'Hindi',
];

//* Language Map used for user selection
Map<String, String> languageMap =
    Map.fromIterables(languages, languageFilter);

//* getter for country code
String getLanguageFilter(String filter) => languageMap[filter]!;
