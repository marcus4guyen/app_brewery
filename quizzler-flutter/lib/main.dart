import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'quiz_brain.dart';

void main() => runApp(Quizzler());

QuizBrain _quizBrain = QuizBrain();

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> _scoreKeeper = [];

  void _addRightAnswer() {
    _scoreKeeper.add(
      Icon(
        Icons.check,
        color: Colors.green,
      ),
    );
  }

  void _addWrongAnswer() {
    _scoreKeeper.add(Icon(
      Icons.close,
      color: Colors.red,
    ));
  }

  void _resetState() {
    setState(() {
      _quizBrain.resetQuestionNumber();
      _scoreKeeper = [];
    });
  }

  int _getUserScore() {
    int userScore = 0;

    for (int i = 0; i < _scoreKeeper.length; i++) {
      Icon score = _scoreKeeper[i];

      if (score.icon == Icons.check) {
        userScore++;
      }
    }

    return userScore;
  }

  void _checkUserAnswer({bool userPickedAnswer}) {
    setState(() {
      if (_quizBrain.isFinished()) {
        Alert(
          context: context,
          type: AlertType.success,
          title: 'Finished!',
          desc:
              'You\'ve reached the end of the quiz.\n Your score is: ${_getUserScore()} / ${_scoreKeeper.length}',
          buttons: [
            DialogButton(
              child: Text(
                'Reset',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                _resetState();
                Navigator.pop(context);
              },
              width: 120.0,
            ),
          ],
        ).show();
      } else {
        _quizBrain.checkUserAnswer(userAnswer: userPickedAnswer) == true
            ? _addRightAnswer()
            : _addWrongAnswer();

        _quizBrain.goToNextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                _quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                _checkUserAnswer(userPickedAnswer: true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                _checkUserAnswer(userPickedAnswer: false);
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: _scoreKeeper,
          ),
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
