import 'dart:typed_data';
import 'package:equatable/equatable.dart';

class Picture extends Equatable {
  const Picture({
    this.id,
    required this.data,
    required this.altText,
  });

  final int? id;

  final Uint8List data;

  final String altText;

  @override
  List<Object> get props => [data, altText];

  factory Picture.fromMap(Map<String, Object?> data) {
    return Picture(
      id: data["id"] as int,
      data: data["data"] as Uint8List,
      altText: data["altText"] as String,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "altText": altText,
        "data": data,
      };
}
