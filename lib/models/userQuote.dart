import 'package:motivation/constants/constants.dart';
import 'package:motivation/models/quote.dart';

class UserQuote {
  final int? id;
  final String quote;
  bool? favourite = false;

  UserQuote ( {this.id, required this.quote, this.favourite} );

  factory UserQuote.fromJson(Map<String, dynamic> data) => UserQuote(
    id: data['id'],
    quote: data['quote'],
    favourite: data['favourite'],
  );

  UserQuote.fromQuote(Quote q) :
      id = q.id,
      quote = q.quote,
      favourite = q.favourite;

  Map<String, dynamic> toMap() => {
    'id': id,
    'quote': quote,
    'author': 'Anonymous',
    'categoryId': Constants.CATE_USER_CREATED,
    'favourite': favourite,
  };
}