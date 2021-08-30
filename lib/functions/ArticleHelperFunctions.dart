//? This method is used to check title of news for dashes and removes them
import 'package:date_format/date_format.dart';
import 'package:validators/validators.dart';

String formatTitle({required String title}) => title.substring(
    0, title.contains('-') ? title.lastIndexOf('-') : title.length);

String formatPublishedAt({required String? publishedAt}) {
  if (DateTime.tryParse(publishedAt!) != null) {
    return formatDate(DateTime.tryParse(publishedAt)!, [d, '-', M, '-', yyyy]);
  } else if (publishedAt.contains('Updated')) {
    return publishedAt.replaceAll('Updated', '').toTitleCase();
  }
  {
    return '';
  }
}

//? this method does the formating of desctiption
String formatDescription({String? desc}) => desc == null
    ? 'No description available'
    : desc.contains('<p>')
        ? desc.contains('<a')
            ? desc.replaceAll(
                desc.substring(desc.indexOf('<a'), desc.lastIndexOf('a>') + 2),
                '')
            : desc.replaceAll('<p>', '').replaceAll('</p>', '')
        : desc.contains('<a')
            ? desc.replaceAll(
                desc.substring(desc.indexOf('<a'), desc.lastIndexOf('a>') + 2),
                '')
            : desc.contains('<div')
                ? desc.replaceAll(
                    desc.substring(
                        desc.indexOf('<div'), desc.lastIndexOf('div>') + 2),
                    '')
                : desc.contains('Subscribe')
                    ? ''
                    : desc.toTitleCase();

//? to format contets
String formatContent({String? content}) {
  return content != null
      ? content.contains('caption')
          ? content
              .substring(
                content.length ~/ 2,
                content.indexOf('['),
              )
              .toTitleCase()
          : content.contains('[')
              ? content
                  .substring(
                    0,
                    content.indexOf('['),
                  )
                  .toTitleCase()
              : content.contains('<p>')
                  ? content.replaceAll('<p>', '').replaceAll('</p>', '')
                  : content
      : 'No content available';
}

formatAuthor({String? author, String? sourceName}) {
  return author == null
      ? isURL(sourceName!) && (sourceName.length > 12)
          ? "Unknown"
          : sourceName.toTitleCase()
      : isURL(author) || (author.length > 7)
          ? isURL(sourceName!) && (sourceName.length > 12)
              ? "Unknown"
              : sourceName.toTitleCase()
          : author.toTitleCase();
}
//? String Capital Method Here

extension CapitalizedStringExtension on String {
  String toTitleCase() {
    return convertToTitleCase(this);
  }
}

//? this method changes the text for capital first of every word
String convertToTitleCase(String text) {
  if (text.trim().isEmpty) {
    return '';
  }

  if (text.length <= 1) {
    return text.toUpperCase();
  }

  // Split string into multiple words
  final List<String> words = text.split(' ');

  // Capitalize first letter of each words
  final capitalizedWords = words.map((word) {
    if (word.trim().isNotEmpty) {
      final String firstLetter = word.trim().substring(0, 1).toUpperCase();
      final String remainingLetters = word.trim().substring(1);

      return '$firstLetter$remainingLetters';
    }
    return '';
  });

  // Join/Merge all words back to one String
  return capitalizedWords.join(' ');
}
