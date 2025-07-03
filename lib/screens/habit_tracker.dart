import 'package:flutter/material.dart';

class HabitTrackerPage extends StatefulWidget {
  const HabitTrackerPage({super.key});

  @override
  State<HabitTrackerPage> createState() => _HabitTrackerPageState();
}

class _HabitTrackerPageState extends State<HabitTrackerPage> {
  List<String> habits = [
    '🪥Brush teeth 刷牙',
    '📚Reading 阅读',
    '😴Sleep early 早睡觉',
    '💧Drink water 喝水',
    '🤸‍♀️Exercise 运动'
  ];

  late List<bool> isChecked;
  int stickerCount = 0;

  @override
  void initState() {
    super.initState();
    // 初始化时，生成与 habits 等长的 false 列表
    isChecked = List<bool>.filled(habits.length, false);
  }

  void completeHabit(int index) {
    if (!isChecked[index]) {
      setState(() {
        isChecked[index] = true;
        stickerCount++;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Completed 完成了! "${habits[index]}"！Sticker 贴纸 +1 🎉'),
        backgroundColor: Colors.green[400],
        duration: Duration(seconds: 1),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('每日打卡 Habit Tracker'),
        backgroundColor: Colors.green[400],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Today you have completed $stickerCount tasks 🎁',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          ...List.generate(habits.length, (index) {
            return ListTile(
              title: Text(habits[index], style: TextStyle(fontSize: 22)),
              trailing: isChecked[index]
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : ElevatedButton(
                      onPressed: () => completeHabit(index),
                      child: Text('Completed 完成'),
                    ),
            );
          }),
          SizedBox(height: 30),
          Wrap(
            spacing: 10,
            children: List.generate(stickerCount, (i) {
              return Text('🌟', style: TextStyle(fontSize: 30));
            }),
          )
        ],
      ),
    );
  }
}
