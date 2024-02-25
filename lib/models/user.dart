class User {
  int? id;
  String? name;
  int? backgroundId;
  int? fontId;

  User( {this.id, this.name, this.backgroundId, this.fontId} );

  factory User.fromJson(Map<String, dynamic> data) => User(
    id: data['id'],
    name: data['name'],
    backgroundId: data['background_id'],
    fontId: data['font_id'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'background_id': backgroundId,
    'font_id': fontId,
  };
}