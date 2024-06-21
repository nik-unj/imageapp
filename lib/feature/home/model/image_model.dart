// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ImageModel {
  String name;
  String url;
  String date;
  ImageModel({
    required this.name,
    required this.url,
    required this.date,
  });

  ImageModel copyWith({
    String? name,
    String? url,
    String? date,
  }) {
    return ImageModel(
      name: name ?? this.name,
      url: url ?? this.url,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
      'date': date,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      name: map['name'] as String,
      url: map['url'] as String,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) =>
      ImageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ImageModel(name: $name, url: $url, date: $date)';
}
