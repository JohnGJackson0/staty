part of 'lists_bloc.dart';

abstract class ListsEvent {}

class SubmitNewListNameEvent extends ListsEvent {
  final String newName;
  SubmitNewListNameEvent({required this.newName});
}

class NewDataPointInputChangedEvent extends ListsEvent {
  final String point;

  NewDataPointInputChangedEvent({this.point = ''});
}

class ExistingDataPointChangedInputEvent extends ListsEvent {
  final String point;
  final String id;

  ExistingDataPointChangedInputEvent({required this.point, required this.id});
}

class DeleteListSubmittedEvent extends ListsEvent {
  DeleteListSubmittedEvent();
}

class DeleteDataPointSubmitted extends ListsEvent {
  final DataPoint deletedDataPoint;

  DeleteDataPointSubmitted({required this.deletedDataPoint});
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

class SelectListOneEvent extends ListsEvent {
  final String id;

  SelectListOneEvent({required this.id});
}

class SelectListTwoEvent extends ListsEvent {
  final String id;

  SelectListTwoEvent({required this.id});
}
