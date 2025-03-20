import 'package:equatable/equatable.dart';

final class Post extends Equatable{
  const Post({
    required this.id,
    required this.title,
    required this.body
  });

  final int id;
  final String title;
  final String body;

  @override
  List<Object> get props => [id, title, body];
}

//  for my revision and understanding
// Equatable is a utility class that helps to implement value based equality
// final keyword is used to make the class immutable
//  required keyword is used to make the parameters required
//  List<Object> get props => [id, title, body]; is used to compare the objects

//  We extend Equatable so that we can compare Posts. Without this, we would need to manually change our class to override equality and hashCode so that we could tell the difference between two Posts objects. See the package for more details

