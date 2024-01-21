import 'dart:html';

import 'package:flutter/material.dart';
import 'package:memory_game/widgets/scores.dart';

import 'game/game.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage()
    );

  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MemoryGame _memoryGame = MemoryGame();
  int triesCounter = 0;
  int scoreValue = 0;
  int matchedCounter = 0;

  @override
  void initState() {
    super.initState();
    _memoryGame.runGame();
  }
  @override
  Widget build(BuildContext context) {
    double device_width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 100, 100, 100),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Text(
                    "Memory Game",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                ),
            ),
            SizedBox(
              height: 24.0,

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                scores("Próby", "${triesCounter}"),
                scores("Punkty", "${scoreValue}"),
              ],
            ),
            SizedBox(
                height: device_width,
                width: device_width,

                child: GridView.builder(
                  itemCount: _memoryGame.cardImage!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 14.0,
                      mainAxisSpacing: 14.0,
                    ),
                    padding: EdgeInsets.all(16.0),
                    itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print(matchedCounter);

                        print(_memoryGame.listOfCards[index]);
                        setState(() {
                          _memoryGame.cardImage![index] = _memoryGame.listOfCards[index];
                          _memoryGame.checkSelection
                            .add({index: _memoryGame.listOfCards[index]});
                        });
                        if(_memoryGame.checkSelection.length == 2) {
                          triesCounter++;
                          if(_memoryGame.checkSelection[0].values.first == _memoryGame.checkSelection[1].values.first) {
                            print("true");

                            scoreValue += 100;
                            _memoryGame.checkSelection.clear();
                            matchedCounter++;
                            if(matchedCounter == 8) {
                              _showDialog();
                              _memoryGame.fillListOfCards();
                            }
                          } else {
                            print(false);
                            scoreValue-=5;
                            if(scoreValue < 0) scoreValue = 0;
                            Future.delayed(Duration(milliseconds: 300),() {
                              print(_memoryGame.cardImage);
                              setState(() {
                                _memoryGame.cardImage![_memoryGame.checkSelection[0].keys.first] =
                                    _memoryGame.hiddenCardImage;
                                _memoryGame.cardImage![_memoryGame.checkSelection[1].keys.first] =
                                    _memoryGame.hiddenCardImage;
                                _memoryGame.checkSelection.clear();
                              });
                            });
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 100, 100, 100),
                          image: DecorationImage(image: AssetImage(_memoryGame.cardImage![index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    );
                  }
                  ),
            ),
          ],
      )
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: Colors.white,
            title: Center(
              child: Text(
                "Gratulacje! Udało Ci się znaleźć wszystkie pary przy $triesCounter próbach. Twój wynik to: $scoreValue",
                style: TextStyle(color: Color.fromARGB(255, 100, 100, 100)),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Color.fromARGB(255, 100, 100, 100),
                    child:
                    Center(
                    child: Text(
                      "Nowa gra",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    )
                  ),
                ),
              )
            ],
          );
        });
  }

  void resetGame() {
    setState(() {
      triesCounter = 0;
      scoreValue = 0;
      matchedCounter = 0;
      _memoryGame.runGame();
    });
    Navigator.of(context).pop();
  }
}

