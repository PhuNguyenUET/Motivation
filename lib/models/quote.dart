import 'package:motivation/constants/constants.dart';
import 'package:motivation/models/userQuote.dart';

class Quote {
  final int? id;
  String quote;
  String? author;
  final int? categoryId;
  bool? favourite = false;

  Quote ( {required this.id, required this.quote, this.author, this.categoryId, this.favourite} );

  factory Quote.fromJson(Map<String, dynamic> data) => Quote(
    id: data['id'],
    quote: data['quote'],
    author: data['author'],
    categoryId: data['categoryId'],
    favourite: data['favourite'] == 0 ? false : true,
  );

  Quote.fromUserQuote(UserQuote q, int cateId):
      id = null,
      quote = q.quote,
      author = q.author,
      categoryId = cateId;

  Map<String, dynamic> toMap() => {
    'id': id,
    'quote': quote,
    'author': author,
    'categoryId': categoryId,
    'favourite': favourite! ? 1 : 0,
  };
}