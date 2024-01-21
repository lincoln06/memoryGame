import 'dart:core';
import 'dart:math';

class MemoryGame {
  final String hiddenCardImage = 'assets/images/uncovered.png';
  List<String>? cardImage;
  List<String> listOfCards = [];
  List<Map<int, String>> checkSelection = [];
  void runGame() {
    fillListOfCards();
    cardImage = List.generate(16, (index) => hiddenCardImage);
  }
  void fillListOfCards() {
    int halfOfTheCards = 8;
    int randomNumber = Random().nextInt(halfOfTheCards) + 1;
    int addedValue = 1;
    for(int i = 0; i < 16; i++) {
      if(i == halfOfTheCards && addedValue == 1) {
        randomNumber = Random().nextInt(halfOfTheCards) + 1;
        addedValue = -1;
      }
      if(addedValue == 1 && randomNumber > halfOfTheCards) randomNumber = 1;
      if(addedValue == -1 && randomNumber < 1) randomNumber = halfOfTheCards;
      listOfCards.add("assets/images/$randomNumber.png");
      randomNumber += addedValue;
    }
  }
}