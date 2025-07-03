import 'package:flutter/material.dart';
import 'dart:math';

class CountingGame extends StatefulWidget {
  const CountingGame({super.key});

  @override
  _CountingGameState createState() => _CountingGameState();
}

class _CountingGameState extends State<CountingGame> {
  final Random _random = Random();
  int itemCount = 1;
  int correctAnswer = 1;

  @override
  void initState() {
    super.initState();
    generateNewQuestion();
  }

  void generateNewQuestion() {
    itemCount = _random.nextInt(6) + 1; // 1~6
    correctAnswer = itemCount;
    setState(() {});
  }

  void checkAnswer(int selected) {
    if (selected == correctAnswer) {
      setState(() {
        generateNewQuestion();
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Incorrect答错啦！'),
          content: Text('Please count again再数一数有几只兔兔 🐰'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Let me think again我再想想'),
            )
          ],
        ),
      );
    }
  }

  Widget buildItemRow() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      children: List.generate(itemCount, (_) {
        return Image.asset(
          'assets/icons/bunny.png',
          width: 50,
          height: 50,
        );
      }),
    );
  }

  Widget buildOptions() {
    List<int> options = [correctAnswer];
    while (options.length < 3) {
      int random = _random.nextInt(6) + 1;
      if (!options.contains(random)) options.add(random);
    }
    options.shuffle();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: options.map((num) {
        return ElevatedButton(
          onPressed: () => checkAnswer(num),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink[100],
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text('$num', style: TextStyle(fontSize: 24, color: Colors.black)),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('数一数 Count Them'),
        backgroundColor: Colors.pink[300],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text('How many rabbits are there有几只兔兔？🐰', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            buildItemRow(),
            SizedBox(height: 40),
            buildOptions(),
          ],
        ),
      ),
    );
  }
}
