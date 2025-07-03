import 'package:flutter/material.dart';
import 'dart:math';

class TapLargestGame extends StatefulWidget {
  const TapLargestGame({super.key});

  @override
  _TapLargestGameState createState() => _TapLargestGameState();
}

class _TapLargestGameState extends State<TapLargestGame> {
  final Random _random = Random();
  List<int> numberList = [];
  int score = 0;

  @override
  void initState() {
    super.initState();
    generateNumbers();
  }

  void generateNumbers() {
    numberList = List.generate(9, (_) => _random.nextInt(50) + 1);
    setState(() {});
  }

  void checkAnswer(int number) {
    int maxNumber = numberList.reduce(max);
    if (number == maxNumber) {
      setState(() {
        score++;
        generateNumbers();
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Incorrect 答错啦~'),
          content: Text('The largest is 最大的是 $maxNumber 🐰'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Please try again 再试试'),
            )
          ],
        ),
      );
    }
  }

  void resetGame() {
    setState(() {
      score = 0;
      generateNumbers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tap the Largest 点击最大值'),
        backgroundColor: Colors.orange[400],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text('Score 分数：$score', style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text(
                'Please click the largest number\n请点击最大的数字 👉',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: numberList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () => checkAnswer(numberList[index]),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[200],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
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
