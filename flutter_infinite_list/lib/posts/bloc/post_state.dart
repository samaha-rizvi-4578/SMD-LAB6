part of 'post_bloc.dart';

enum PostStatus { initial, success, failure }

final class PostState extends Equatable {
  const PostState({
    this.status = PostStatus.initial,
    this.posts = const <Post>[],
    this.hasReachedMax = false,
  });

  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMax;

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    bool? hasReachedMax,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${posts.length} }''';
  }

  @override
  List<Object> get props => [status, posts, hasReachedMax];
}


// We implemented copyWith so that we can copy an instance of PostSuccess and update zero or more properties conveniently 





/*
Our presentation layer will need to have several pieces of information in order to properly lay itself out:

PostInitial- will tell the presentation layer it needs to render a loading indicator while the initial batch of posts are loaded
PostSuccess- will tell the presentation layer it has content to render
posts- will be the List<Post> which will be displayed
hasReachedMax- will tell the presentation layer whether or not it has reached the maximum number of posts
PostFailure- will tell the presentation layer that an error has occurred while fetching posts
*/
