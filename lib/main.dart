import 'package:flutter/material.dart';
import 'screens/number_game_menu.dart';
import 'screens/habit_tracker.dart';

void main() {
  runApp(BunnyForestApp());
}

class BunnyForestApp extends StatelessWidget {
  const BunnyForestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bunny Forest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'ComicSans',
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFE9F8EF),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final TextStyle titleStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.green[800],
  );

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bunny Forest 兔比兔乐园'),
        backgroundColor: Colors.green[400],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/forest_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hi，我是兔比兔Bunny BOO！\n一起来玩森林游戏吧~ 🐰',
                style: titleStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // 数字碰碰乐菜单按钮
              GameButton(
                label: '数字碰碰乐 Number Pop',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NumberGameMenu()),
                  );
                },
              ),

              // 每日打卡按钮
              GameButton(
                label: '每日打卡 Habit Tracker',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HabitTrackerPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GameButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const GameButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[200],
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: onTap,
        child: Text(label, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
