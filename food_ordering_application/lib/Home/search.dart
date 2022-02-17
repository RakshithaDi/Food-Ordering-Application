import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  static String id = 'search';
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: AnimSearchBar(
            rtl: true,
            width: 300,
            textController: textController,
            helpText: 'Search for food...',
            onSuffixTap: () {
              setState(() {
                textController.clear();
              });
            },
          ),
        ),
      ],
    );
  }
}
