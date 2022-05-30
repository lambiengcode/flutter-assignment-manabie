// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:assignment_manabie/features/to_do/data/models/todo_model.dart';

class AppState {
  List<TodoModel> todos;
  AppState({
    required this.todos,
  });

  AppState copyWith({
    List<TodoModel>? todos,
  }) {
    return AppState(
      todos: todos ?? this.todos,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'todos': todos.map((x) => x.toMap()).toList(),
    };
  }

  factory AppState.fromMap(Map<String, dynamic> map) {
    return AppState(
      todos: List<TodoModel>.from((map['todos'] as List<int>).map<TodoModel>((x) => TodoModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppState.fromJson(String source) => AppState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AppState(todos: $todos)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AppState &&
      listEquals(other.todos, todos);
  }

  @override
  int get hashCode => todos.hashCode;
}
