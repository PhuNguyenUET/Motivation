class UserCategory {
  String? category;

  UserCategory({this.category});

  factory UserCategory.fromJson(Map<String, dynamic> data) => UserCategory(
    category: data['category'],
  );

  Map<String, dynamic> toMap() => {
    'category': category,
  };
}