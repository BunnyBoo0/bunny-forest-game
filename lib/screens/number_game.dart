import 'package:flutter/material.dart';

class NumberGamePage extends StatefulWidget {
  const NumberGamePage({super.key});

  @override
  _NumberGamePageState createState() => _NumberGamePageState();
}

class _NumberGamePageState extends State<NumberGamePage> {
  List<List<int?>> grid = List.generate(3, (_) => List.filled(3, null));

  void _showNumberPicker(int row, int col) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Please select a number选择数字"),
        content: Wrap(
          spacing: 10,
          children: List.generate(9, (i) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[100],
                shape: CircleBorder(),
              ),
              onPressed: () {
                setState(() {
                  grid[row][col] = i + 1;
                });
                Navigator.pop(context);
              },
              child: Text('${i + 1}'),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildGridCell(int row, int col) {
    final value = grid[row][col];
    return GestureDetector(
      onTap: () => _showNumberPicker(row, col),
      child: Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            value?.toString() ?? '',
            style: TextStyle(fontSize: 28, color: Colors.green[800]),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('数字碰碰乐 Number Pop'),
        backgroundColor: Colors.green[400],
      ),
      body: Container(
        decoration: BoxDecoration(
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
                'Click the box and fill number 点击格子填数字 🧠',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green[900]),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 300,
                height: 300,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    final row = index ~/ 3;
                    final col = index % 3;
                    return _buildGridCell(row, col);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}