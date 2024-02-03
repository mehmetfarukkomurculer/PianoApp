import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const XylophoneApp());
}

class XylophoneApp extends StatefulWidget {
  const XylophoneApp({super.key});

  @override
  State<XylophoneApp> createState() => _XylophoneAppState();
}

class _XylophoneAppState extends State<XylophoneApp> {
  List<bool> isPressedList = List.generate(12, (index) => false);
  void playSound(int soundNumber) {
    final player = AudioPlayer();
    player.play(AssetSource('note$soundNumber.mp3'));
  }

  Expanded pianoNote(int soundNumber) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          playSound(soundNumber);
          setState(() {
            isPressedList[soundNumber - 1] = true;
          });
          Future.delayed(const Duration(milliseconds: 200), () {
            setState(() {
              isPressedList[soundNumber - 1] = false;
            });
          });
        },
        child: Row(
          children: [
            Expanded(
              flex: 20,
              child: Container(
                transform: isPressedList[soundNumber - 1] == true
                    ? Matrix4.skewY(0.03)
                    : Matrix4.skewY(0.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: const Border(
                    top: BorderSide(color: Colors.black),
                    bottom: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            isPressedList[soundNumber - 1] == false
                ? Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: const Border(
                            top: BorderSide(color: Colors.black),
                            bottom: BorderSide(color: Colors.black)),
                      ),
                      transform: Matrix4.skewY(0.5),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
      ),
    );
    return MaterialApp(
      color: Colors.grey[300],
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              pianoNote(1),
              pianoNote(2),
              pianoNote(3),
              pianoNote(4),
              pianoNote(5),
              pianoNote(6),
              pianoNote(7),
              pianoNote(8),
              pianoNote(9),
              pianoNote(10),
              pianoNote(11),
              pianoNote(12),
            ],
          ),
        ),
      ),
    );
  }
}
