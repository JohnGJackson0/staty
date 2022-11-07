part of 'lists_bloc.dart';

class ListsState extends Equatable {
  final List<ListModel> listStore;
  final String newDataPoint;
  final FormSubmissionStatus formStatus;
  final String selectedTaskid;

  bool isValidDatapointInput() {
    try {
      double.parse(newDataPoint);
      return true;
    } catch (e) {
      return false;
    }
  }

  const ListsState(
      {this.listStore = const <ListModel>[],
      this.newDataPoint = '',
      this.formStatus = const InitialFormStatus(),
      this.selectedTaskid = ''});

  @override
  List<Object?> get props =>
      [listStore, newDataPoint, formStatus, selectedTaskid];
}
