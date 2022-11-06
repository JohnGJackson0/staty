part of 'lists_bloc.dart';

class ListsState extends Equatable {
  final List<double> lists;
  final String newDataPoint;
  final FormSubmissionStatus formStatus;

  bool isValidDatapointInput() {
    try {
      double.parse(newDataPoint);
      return true;
    } catch (e) {
      return false;
    }
  }



  const ListsState(
      {this.lists = const [],
      this.newDataPoint = '',
      this.formStatus = const InitialFormStatus()});

  @override
  List<Object?> get props => [lists, newDataPoint, formStatus];
}
