import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/posts/posts.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'post_event.dart';
part 'post_state.dart';

const _postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.httpClient}) : super(const PostState()) {
    on<PostFetched>(
      _onFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;

  Future<void> _onFetched(
    PostFetched event,
    Emitter<PostState> emit,
  ) async {
    if (state.hasReachedMax) return;

    try {
      final posts = await _fetchPosts(startIndex: state.posts.length);

      if (posts.isEmpty) {
        return emit(state.copyWith(hasReachedMax: true));
      }

      emit(
        state.copyWith(
          status: PostStatus.success,
          posts: [...state.posts, ...posts],
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<List<Post>> _fetchPosts({required int startIndex}) async {
    final response = await httpClient.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
        <String, String>{'_start': '$startIndex', '_limit': '$_postLimit'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Post(
          id: map['id'] as int,
          title: map['title'] as String,
          body: map['body'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}
// our PostBloc will be taking PostEvents as input and outputting PostStates.

// PostBloc will have a direct dependency on an http client; however, in a production application we suggest instead you inject an api client and use the repository pattern docs.

// Now every time a PostEvent is added, if it is a PostFetched event and there are more posts to fetch, our PostBloc will fetch the next 20 posts.


// The API will return an empty array if we try to fetch beyond the maximum number of posts (100), so if we get back an empty array, our bloc will emit the currentState except we will set hasReachedMax to true.


/*If we cannot retrieve the posts, we emit PostStatus.failure.

If we can retrieve the posts, we emit PostStatus.success and the entire list of posts.

One optimization we can make is to throttle the PostFetched event in order to prevent spamming our API unnecessarily. We can do this by using the transform parameter when we register the _onFetched event handler.*/