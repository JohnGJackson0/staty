part of 'lists_bloc.dart';

abstract class ListsEvent {}

class DataPointChangedEvent extends ListsEvent {
  final String point;

  DataPointChangedEvent({this.point = ''});
}

class DatapointSubmitted extends ListsEvent {}
