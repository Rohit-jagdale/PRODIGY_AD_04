import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Controller ctrl = Get.put(Controller());
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: const Text("Tic Tac Toe",
            style: TextStyle(color: Colors.yellowAccent, fontSize: 30)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(
                      () => Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    decoration: BoxDecoration(
                        color: ctrl.isX.value == false ? Colors.orangeAccent : Colors.blueGrey[800],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [const BoxShadow(color: Colors.black45, blurRadius: 5, offset: Offset(0, 2))]
                    ),
                    child: const Text("O",
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                Obx(
                      () => Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    decoration: BoxDecoration(
                        color: ctrl.isX.value == true ? Colors.orangeAccent : Colors.blueGrey[800],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [const BoxShadow(color: Colors.black45, blurRadius: 5, offset: Offset(0, 2))]
                    ),
                    child: const Text("X",
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      ctrl.addValue(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: ctrl.gameValue[index] == "X"
                              ? Colors.redAccent
                              : ctrl.gameValue[index] == "O"
                              ? Colors.greenAccent
                              : Colors.cyan,
                          gradient: ctrl.gameValue[index] == ""
                              ? LinearGradient(
                            colors: [Colors.cyan[700]!, Colors.cyan[300]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                              : null,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [const BoxShadow(color: Colors.black45, blurRadius: 5, offset: Offset(0, 2))]
                      ),
                      child: Center(
                        child: Obx(
                              () => Text(
                            ctrl.gameValue[index],
                            style: const TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Creator: Rohit Jagdale",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ctrl.gameValue.value = ["", "", "", "", "", "", "", "", ""];
                ctrl.click.value = 0;
                ctrl.isWinner.value = false;
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: const Text("Restart Game"),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
