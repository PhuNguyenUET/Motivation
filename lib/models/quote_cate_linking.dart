class QuoteCateLinking {
  int? quoteId;
  int? userCategoryId;

  QuoteCateLinking({this.quoteId, this.userCategoryId});

  factory QuoteCateLinking.fromJson(Map<String, dynamic> data) => QuoteCateLinking(
    quoteId: data['quoteId'],
    userCategoryId: data['userCategoryId'],
  );

  Map<String, dynamic> toMap() => {
    'quoteId': quoteId,
    'userCategoryId': userCategoryId,
  };
}