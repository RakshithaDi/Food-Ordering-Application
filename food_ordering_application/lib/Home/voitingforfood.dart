import 'dart:async';
import 'package:flutter/material.dart';
import 'package:polls/polls.dart';

import '../constant.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Polls',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PollView(),
    );
  }
}

class PollView extends StatefulWidget {
  @override
  _PollViewState createState() => _PollViewState();
}

class _PollViewState extends State<PollView> {
  double option1 = 1.0;
  double option2 = 0.0;
  double option3 = 1.0;

  String user = "king@mail.com";
  Map usersWhoVoted = {
    'sam@mail.com': 3,
    'mike@mail.com': 4,
    'john@mail.com': 1,
    'kenny@mail.com': 1
  };
  String creator = "eddy@mail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Vote'),
        backgroundColor: Sushi,
      ),
      body: SafeArea(
        child: Container(
          child: Polls(
            children: [
              // This cannot be less than 2, else will throw an exception
              Polls.options(title: 'Chicken Biryani', value: option1),
              Polls.options(title: 'Fried Rice', value: option2),
              Polls.options(title: 'Set Menu', value: option3),
            ],
            question: Text(
              'What would you like to eat tommorrow?',
              style: normalText,
            ),
            currentUser: this.user,
            creatorID: this.creator,
            voteData: usersWhoVoted,
            userChoice: usersWhoVoted[this.user],
            onVoteBackgroundColor: Sushi,
            leadingBackgroundColor: Sushi,
            backgroundColor: Sushi,
            onVote: (choice) {
              print(choice);
              setState(() {
                this.usersWhoVoted[this.user] = choice;
              });
              if (choice == 1) {
                setState(() {
                  option1 += 1.0;
                });
              }
              if (choice == 2) {
                setState(() {
                  option2 += 1.0;
                });
              }
              if (choice == 3) {
                setState(() {
                  option3 += 1.0;
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
