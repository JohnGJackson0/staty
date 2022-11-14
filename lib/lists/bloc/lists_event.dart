part of 'lists_bloc.dart';

abstract class ListsEvent {}

class NewDataPointInputChangedEvent extends ListsEvent {
  final String point;

  NewDataPointInputChangedEvent({this.point = ''});
}

class ExistingDataPointChangedInputEvent extends ListsEvent {
  final String point;
  final String id;

  ExistingDataPointChangedInputEvent({required this.point, required this.id});
}

class DeleteDataPointSubmitted extends ListsEvent {
  final double point;
  final String id;

  DeleteDataPointSubmitted({required this.point, required this.id});
}

class NewDataPointSubmitted extends ListsEvent {
  final String listId;

  NewDataPointSubmitted({required this.listId});
}

class UpdateDataPointSubmitted extends ListsEvent {
  final String listId;

  UpdateDataPointSubmitted({required this.listId});
}

class StatListCreatedEvent extends ListsEvent {}

class OnErrorEvent extends ListsEvent {}

class SelectedTaskIdEvent extends ListsEvent {
  final String id;

  SelectedTaskIdEvent({required this.id});
}
