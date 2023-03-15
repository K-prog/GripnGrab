enum SessionType {
  morning,
  evening,
}

extension ConvertMessage on String {
  SessionType toEnum() {
    switch (this) {
      case 'morning':
        return SessionType.morning;
      case 'evening':
        return SessionType.evening;
      default:
        return SessionType.morning;
    }
  }
}

class SessionsModel {
  String id;
  int available;
  String timeFrame;
  SessionType sessionType;
  SessionsModel({
    required this.available,
    required this.timeFrame,
    required this.id,
    required this.sessionType,
  });

  // from json
  factory SessionsModel.fromJson(Map<String, dynamic> json) {
    return SessionsModel(
      id: json['id'],
      available: json['available'],
      timeFrame: json['timeFrame'],
      sessionType: (json['sessionType'] as String).toEnum(),
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'available': available,
      'timeFrame': timeFrame,
      'sessionType': sessionType.name,
    };
  }
}

class SessionBooked {
  String bookedBy;
  String timeFrameId;
  DateTime bookedAt;
  SessionBooked({
    required this.bookedAt,
    required this.bookedBy,
    required this.timeFrameId,
  });

  // from json
  factory SessionBooked.fromJson(Map<String, dynamic> json) {
    return SessionBooked(
      timeFrameId: json['timeFrameId'],
      bookedBy: json['bookedBy'],
      bookedAt: DateTime.fromMillisecondsSinceEpoch(json['bookedAt']),
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'bookedBy': bookedBy,
      'bookedAt': bookedAt.millisecondsSinceEpoch,
      'timeFrameId': timeFrameId,
    };
  }
}
