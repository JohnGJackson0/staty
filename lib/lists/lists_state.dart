part of 'lists_bloc.dart';

class ListsState extends Equatable {
  final List<double> lists;
  final String newDataPoint;

  bool get isValidDatapoint => newDataPoint.isNotEmpty;

  const ListsState({this.lists = const [], this.newDataPoint = ''});

  @override
  List<Object?> get props => [lists, newDataPoint];
}
