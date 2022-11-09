part of 'lists_bloc.dart';

abstract class ListsEvent {}

class DataPointChangedEvent extends ListsEvent {
  final String point;

  DataPointChangedEvent({this.point = ''});
}

class DeleteDataPointSubmitted extends ListsEvent {
  final double point;

  DeleteDataPointSubmitted({required this.point});
}

class DataPointSubmitted extends ListsEvent {
  final String listId;

  DataPointSubmitted({required this.listId});
}

class StatListCreatedEvent extends ListsEvent {}

class OnErrorEvent extends ListsEvent {}

class SelectedTaskIdEvent extends ListsEvent {
  final String id;

  SelectedTaskIdEvent({required this.id});
}
