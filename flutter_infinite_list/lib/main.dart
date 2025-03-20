import 'package:bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/app.dart';
import 'package:flutter_infinite_list/simple_bloc_observer.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp(const App());
}



/* One added bonus of using the bloc library is that we can have access to all Transitions in one place.

The change from one state to another is called a Transition.

Note

A Transition consists of the current state, the event, and the next state.*/ */