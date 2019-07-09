import 'package:flutter/material.dart';
import 'package:quizzler/quizz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'answer_button.dart';

QuizzBrain quizzBrain = QuizzBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      home: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SafeArea(
          child: QuizPage(),
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
  List<Icon> scoreKeeper = [];

  void onAnswer(bool answer) {
    setState(() {
      bool correctAnswer = quizzBrain.getQuestionAnswer();

      if (answer == correctAnswer) {
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }

      quizzBrain.nextQuestion();

      if (quizzBrain.isFinished()) {
        showFinishedQuizzAlert();
      }
    });
  }

  void resetQuizz() {
    setState(() {
      scoreKeeper.clear();
      quizzBrain.reset();
    });
  }

  void showFinishedQuizzAlert() {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Quizz Finished",
      desc: "Congratulations! you have completed the quizz!",
      closeFunction: resetQuizz,
      buttons: <DialogButton>[
        DialogButton(
          child: Text(
            'START AGAIN',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
            resetQuizz();
          },
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizzBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withAlpha(30),
                blurRadius: 5,
                offset: Offset(0, -1),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    AnswerButton(
                      text: 'TRUE',
                      color: Colors.green,
                      onPressed: () {
                        onAnswer(true);
                      },
                    ),
                    AnswerButton(
                      text: 'FALSE',
                      color: Colors.red,
                      onPressed: () {
                        onAnswer(false);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 3,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: scoreKeeper,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
