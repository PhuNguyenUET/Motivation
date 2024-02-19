import 'package:motivation/constants/constants.dart';
import 'package:motivation/models/quote.dart';

class UserQuote {
  final String quote;
  String? author;

  UserQuote ( {required this.quote, this.author} );

  factory UserQuote.fromJson(Map<String, dynamic> data) => UserQuote(
    quote: data['quote'],
    author: data['author'],
  );

  UserQuote.fromQuote(Quote q) :
      quote = q.quote,
      author = q.author;
}