part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class PostFetched extends PostEvent {}


//  sealed keyword means that the class can only be extended by classes in the same file. This is a useful feature to ensure that all possible states are handled in the same file.

//  our PostBloc will be receiving PostEvents and converting them to PostStates. 

/*At a high level, it will be responding to user input (scrolling) and fetching more posts in order for the presentation layer to display them. Let’s start by creating our Event.

Our PostBloc will only be responding to a single event; PostFetched which will be added by the presentation layer whenever it needs more Posts to present. Since our PostFetched event is a type of PostEvent we can create bloc/post_event.dart and implement the event like so.
*/