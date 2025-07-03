import 'package:flutter/material.dart';

import 'games/sequence_game.dart';
import 'games/find_number_game.dart';
import 'games/compare_game.dart';
import 'games/tap_largest_game.dart';
import 'games/counting_game.dart';

class NumberGameMenu extends StatelessWidget {
  const NumberGameMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green[800]);

    return Scaffold(
      appBar: AppBar(
        title: Text('数字碰碰乐模式选择'),
        backgroundColor: Colors.green[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Hi，小朋友！选择你想玩的数字小游戏吧 🐰', style: titleStyle),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  GameModeCard(
                    icon: Icons.format_list_numbered,
                    label: '顺序填空 Sequence Game',
                    color: Colors.pink[200]!,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => SequenceGame()));
                    },
                  ),
                  GameModeCard(
                    icon: Icons.search,
                    label: '找找数字 Find Number',
                    color: Colors.yellow[200]!,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => FindNumberGame()));
                    },
                  ),
                  GameModeCard(
                    icon: Icons.compare_arrows,
                    label: '比大小 Bigger or Smaller',
                    color: Colors.purple[200]!,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => CompareGame()));
                    },
                  ),
                  GameModeCard(
                    icon: Icons.image,
                    label: '点击最大值 Tap the Largest',
                    color: Colors.orange[200]!,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => TapLargestGame()));
                    },
                  ),
                  GameModeCard(
                    icon: Icons.timer,
                    label: '数一数 Count Them',
                    color: Colors.teal[200]!,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => CountingGame()));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GameModeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const GameModeCard({super.key, 
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, size: 36, color: Colors.white),
        title: Text(label, style: TextStyle(fontSize: 18, color: Colors.white)),
        onTap: onTap,
      ),
    );
  }
}