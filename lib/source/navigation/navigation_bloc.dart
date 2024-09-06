import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class NavigationEvent {
  final String routeName;

  NavigationEvent(this.routeName);
}

class NavigationState {
  final String routeName;
  NavigationState(this.routeName);
}

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState('/'));

  Stream<NavigationState> mapEventToState(
      BuildContext context, NavigationEvent event) async* {
    yield NavigationState(event.routeName);
    Navigator.pushNamed(context, event.routeName);
  }
}
