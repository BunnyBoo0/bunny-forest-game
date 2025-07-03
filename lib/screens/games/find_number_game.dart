import 'package:flutter/material.dart';
import 'dart:math';

class FindNumberGame extends StatefulWidget {
  const FindNumberGame({super.key});

  @override
  _FindNumberGameState createState() => _FindNumberGameState();
}

class _FindNumberGameState extends State<FindNumberGame> {
  final Random _random = Random();
  late int targetNumber;
  late List<int> numberList;
  int score = 0;

  @override
  void initState() {
    super.initState();
    generateNewRound();
  }

  void generateNewRound() {
    numberList = List.generate(9, (_) => _random.nextInt(9) + 1);
    targetNumber = numberList[_random.nextInt(numberList.length)];
  }

  void checkAnswer(int number) {
    if (number == targetNumber) {
      setState(() {
        score++;
        generateNewRound();
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Incorrect 答错啦~'),
          content: Text('Please try again 再试试看 🐰'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Okay 知道了'),
            )
          ],
        ),
      );
    }
  }

  void resetGame() {
    setState(() {
      score = 0;
      generateNewRound();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Number Game 找找数字游戏'),
        backgroundColor: Colors.yellow[600],
      ),
      body: SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text('Score 分数：$score', style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text(
                'Please find the number\n请找出数字 👉 $targetNumber',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), 
                itemCount: numberList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow[200],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => checkAnswer(numberList[index]),
                    child: Text(
                      numberList[index].toString(),
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: resetGame,
                child: Text('Restart 重新开始'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
