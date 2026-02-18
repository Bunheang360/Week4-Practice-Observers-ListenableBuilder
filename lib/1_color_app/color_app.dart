import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum CardType { red, blue }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0 ? ColorTapsScreen() : StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorService extends ChangeNotifier {
  int _blueTapCount = 0;
  int _redTapCount = 0;

  int get blueTapCount => _blueTapCount;
  int get redTapCount => _redTapCount;

  void tapIncrement(CardType type) {
    if (type == CardType.blue) {
      _blueTapCount++;
    } else {
      _redTapCount++;
    }
    notifyListeners();
  }
}

final ColorService colorService = ColorService();

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: Column(
        children: const [
          ColorTap(type: CardType.blue),
          ColorTap(type: CardType.red),
        ],
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;

  const ColorTap({super.key, required this.type});

  Color get backgroundColor => type == CardType.red ? Colors.red : Colors.blue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => colorService.tapIncrement(type),
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: ListenableBuilder(
          listenable: colorService,
          builder: (context, child) {
            final tapCount = type == CardType.blue
                ? colorService.blueTapCount
                : colorService.redTapCount;
            return Padding(
              padding: const EdgeInsets.only(left: 16, top: 5),
              child: Text(
                'Taps: $tapCount',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Blue Taps: ${colorService.blueTapCount}',
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              'Red Taps: ${colorService.redTapCount}',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
