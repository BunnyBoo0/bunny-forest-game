import 'package:flutter/material.dart';
import 'dart:math';

class CompareGame extends StatefulWidget {
  const CompareGame({super.key});

  @override
  _CompareGameState createState() => _CompareGameState();
}

class _CompareGameState extends State<CompareGame> {
  final Random _random = Random();
  int leftNumber = 0;
  int rightNumber = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    generateNewNumbers();
  }

  void generateNewNumbers() {
    setState(() {
      leftNumber = _random.nextInt(20) + 1;
      rightNumber = _random.nextInt(20) + 1;
    });
  }

  void checkAnswer(String answer) {
    bool isCorrect = false;

    if (answer == 'left' && leftNumber > rightNumber) {
      isCorrect = true;
    } else if (answer == 'right' && rightNumber > leftNumber) {
      isCorrect = true;
    } else if (answer == 'equal' && leftNumber == rightNumber) {
      isCorrect = true;
    }

    if (isCorrect) {
      setState(() {
        score++;
        generateNewNumbers();
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Incorrect答错啦~'),
          content: Text('Think once again再想一想哦 🐰'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Okay知道了'),
            )
          ],
        ),
      );
    }
  }

  void resetGame() {
    setState(() {
      score = 0;
      generateNewNumbers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compare Game 比大小游戏'),
        backgroundColor: Colors.blue[300],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Score分数：$score', style: TextStyle(fontSize: 22)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumberCard(number: leftNumber),
              Text('VS', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              NumberCard(number: rightNumber),
            ],
          ),
          SizedBox(height: 30),
          Wrap(
            spacing: 16,
            children: [
              ElevatedButton(
                onPressed: () => checkAnswer('left'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[100]),
                child: Text('Left is greater左边大', style: TextStyle(fontSize: 20)),
              ),
              ElevatedButton(
                onPressed: () => checkAnswer('equal'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[100]),
                child: Text('same一样大', style: TextStyle(fontSize: 20)),
              ),
              ElevatedButton(
                onPressed: () => checkAnswer('right'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[100]),
                child: Text('Right is greater右边大', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: resetGame,
            child: Text('Restart重新开始'),
          )
        ],
      ),
    );
  }
}

class NumberCard extends StatelessWidget {
  final int number;
  const NumberCard({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        number.toString(),
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      ),
    );
  }
}