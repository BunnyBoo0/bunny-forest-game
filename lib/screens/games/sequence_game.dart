import 'package:flutter/material.dart';

class SequenceGame extends StatefulWidget {
  const SequenceGame({super.key});

  @override
  _SequenceGameState createState() => _SequenceGameState();
}

class _SequenceGameState extends State<SequenceGame> {
  int currentNumber = 1;
  List<int?> gridNumbers = List.generate(9, (_) => null);

  void fillNext(int index) {
    if (gridNumbers[index] == null) {
      setState(() {
        gridNumbers[index] = currentNumber;
        currentNumber++;

        if (currentNumber > 9) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Great 太棒了！'),
              content: Text('You have completed 你完成了顺序填空 🎉'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    resetGame();
                  },
                  child: Text('Play again 再玩一次'),
                )
              ],
            ),
          );
        }
      });
    }
  }

  void resetGame() {
    setState(() {
      currentNumber = 1;
      gridNumbers = List.generate(9, (_) => null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sequence Game 顺序填空游戏'),
        backgroundColor: Colors.pink[300],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Please fill in the blanks in the order of 1-9\n请按照 1 到 9 的顺序填空 🐰',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => fillNext(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.pink[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        gridNumbers[index]?.toString() ?? '',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: resetGame,
                child: Text('Restart 重新开始'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
