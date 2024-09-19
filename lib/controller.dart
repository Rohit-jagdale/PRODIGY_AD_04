import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController {

  @override
  void onInit() {
    super.onInit();
  }

  RxList<String> gameValue = ["", "", "", "", "", "", "", "", ""].obs;
  RxBool isX = true.obs;
  RxInt click = 0.obs;
  RxBool isWinner = false.obs;

  void addValue(index) {
    if (gameValue[index] == "") {
      if (isX.value) {
        gameValue[index] = "X";
        isX.value = !isX.value;
      } else {
        gameValue[index] = "O";
        isX.value = !isX.value;
      }
      click++;
      update();
      checkWinner();
      if (click.value == 9 && !isWinner.value) {
        matchDrawMessage();
      }
    } else {
      Get.snackbar("Invalid Click", "Choose an empty box", snackPosition: SnackPosition.BOTTOM);
    }
  }

  void matchDrawMessage() {
    Get.defaultDialog(
      title: "Match Draw",
      titleStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.sports_soccer, size: 100, color: Colors.grey),
          SizedBox(height: 20),
          Text("The game is a draw!", style: TextStyle(fontSize: 18)),
        ],
      ),
      confirm: TextButton(
        onPressed: () {
          gameValue.value = ["", "", "", "", "", "", "", "", ""];
          click.value = 0;
          Get.back();
        },
        child: Text("Play Again", style: TextStyle(color: Colors.blue)),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text("Cancel", style: TextStyle(color: Colors.red)),
      ),
    );
  }

  void checkWinner() {
    // Check rows, columns, and diagonals for a winner
    List<List<int>> winConditions = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
      [0, 4, 8], [2, 4, 6]  // diagonals
    ];

    for (var condition in winConditions) {
      if (gameValue[condition[0]] == gameValue[condition[1]] &&
          gameValue[condition[1]] == gameValue[condition[2]] &&
          gameValue[condition[0]] != "") {
        winnerDialogBox();
        return;
      }
    }
  }

  void winnerDialogBox() {
    isWinner.value = true;
    Get.defaultDialog(
      title: "Winner",
      titleStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_rounded,
            size: 100,
            color: Colors.orange,
          ),
          SizedBox(height: 20),
          Text(
            "${isX.value ? 'O' : 'X'} is the winner!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      confirm: ElevatedButton.icon(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.close),
        label: Text("Close"),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      ),
      cancel: ElevatedButton.icon(
        onPressed: () {
          isWinner.value = false;
          gameValue.value = ["", "", "", "", "", "", "", "", ""];
          click.value = 0;
          Get.back();
        },
        icon: Icon(Icons.replay),
        label: Text("Play Again"),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      ),
    );
  }
}
