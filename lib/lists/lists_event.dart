part of 'lists_bloc.dart';

abstract class ListsEvent {}

class DataPointAddedEvent extends ListsEvent {
  final double point;

  DataPointAddedEvent(this.point);
}

class DataPointChangedEvent extends ListsEvent {
  final String point;

  DataPointChangedEvent({this.point = '0'});
}
