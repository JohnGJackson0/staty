import 'package:flutter/material.dart';

import 'lists/create_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const id = 'home_page_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Lists'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: const [
              Flexible(
                child: Text(
                    'Inferential statistics (like T-test, Z-test, ect.) can have functions that take a list of data or descriptions of the list of data. We only have the latter currently. Please add a list with + icon.',
                    maxLines: 4),
              ),
            ],
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(CreateList.id);
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
