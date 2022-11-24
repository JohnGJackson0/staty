import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/hypothesis_equality.dart';
import '../bloc/t_test_data_bloc.dart';

class HypothesisEqualitySelection extends StatefulWidget {
  const HypothesisEqualitySelection({
    Key? key,
  }) : super(key: key);

  @override
  State<HypothesisEqualitySelection> createState() =>
      _HypothesisEqualitySelectionState();
}

class _HypothesisEqualitySelectionState
    extends State<HypothesisEqualitySelection> {
  HypothesisEquality? _equalityChoice = HypothesisEquality.notEqual;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TTestDataBloc, TTestDataBlocState>(
      builder: (context, state) {
        return Row(
          children: [
            Flexible(
              child: ListTile(
                title: const Text('≠'),
                leading: Radio(
                  value: HypothesisEquality.notEqual,
                  groupValue: _equalityChoice,
                  onChanged: (HypothesisEquality? value) {
                    context
                        .read<TTestDataBloc>()
                        .add(OnChangedEqualityValue(equalityValue: value));
                    setState(() {
                      _equalityChoice = value;
                    });
                  },
                ),
              ),
            ),
            Flexible(
              child: ListTile(
                title: const Text('<'),
                leading: Radio<HypothesisEquality>(
                  value: HypothesisEquality.less,
                  groupValue: _equalityChoice,
                  onChanged: (HypothesisEquality? value) {
                    context
                        .read<TTestDataBloc>()
                        .add(OnChangedEqualityValue(equalityValue: value));
                    setState(() {
                      _equalityChoice = value;
                    });
                  },
                ),
              ),
            ),
            Flexible(
              child: ListTile(
                title: const Text('>'),
                leading: Radio<HypothesisEquality>(
                  value: HypothesisEquality.more,
                  groupValue: _equalityChoice,
                  onChanged: (HypothesisEquality? value) {
                    context
                        .read<TTestDataBloc>()
                        .add(OnChangedEqualityValue(equalityValue: value));
                    setState(() {
                      _equalityChoice = value;
                    });
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
