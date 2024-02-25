class NotificationSetting {
  int? id;
  bool? notiAllowed = false;
  int? categoryId;
  bool? isGeneral = true;
  String? startTime;
  String? endTime;
  int? timeRepeated;
  String? daysRepeated;
  int? notiSoundId;

  NotificationSetting( {this.id, this.notiAllowed, this.categoryId, this.isGeneral, this.startTime, this.endTime, this.timeRepeated, this.daysRepeated, this.notiSoundId} );

  factory NotificationSetting.fromJson(Map<String, dynamic> data) => NotificationSetting(
    id: data['id'],
    notiAllowed: data['notiAllowed'] == 0 ? false : true,
    categoryId: data['categoryId'],
    isGeneral: data['isGeneral'] == 0 ? false : true,
    startTime: data['startTime'],
    endTime: data['endTime'],
    timeRepeated: data['timeRepeated'],
    daysRepeated: data['daysRepeated'],
    notiSoundId: data['notiSoundId'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'notiAllowed': notiAllowed! ? 1 : 0,
    'categoryId': categoryId,
    'isGeneral': isGeneral! ? 1 : 0,
    'startTime': startTime,
    'endTime': endTime,
    'timeRepeated': timeRepeated,
    'daysRepeated': daysRepeated,
    'notiSoundId' : notiSoundId,
  };
}