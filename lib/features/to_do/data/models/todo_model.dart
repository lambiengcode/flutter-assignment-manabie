// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TodoModel {
  final String id;
  final String title;
  final String subTitle;
  final DateTime createdAt;
  bool isDone;
  TodoModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.createdAt,
    this.isDone = false,
  });

  TodoModel copyWith({
    String? id,
    String? title,
    String? subTitle,
    DateTime? createdAt,
    bool? isDone,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      createdAt: createdAt ?? this.createdAt,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'subTitle': subTitle,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'isDone': isDone,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      subTitle: map['subTitle'] as String,
      createdAt: map['createdAt'] == null
          ? DateTime.now()
          : DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      isDone: map['isDone'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TodoModel(id: $id, title: $title, subTitle: $subTitle, createdAt: $createdAt, isDone: $isDone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoModel &&
        other.id == id &&
        other.title == title &&
        other.subTitle == subTitle &&
        other.createdAt == createdAt &&
        other.isDone == isDone;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ subTitle.hashCode ^ createdAt.hashCode ^ isDone.hashCode;
  }
}
