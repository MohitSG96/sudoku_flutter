import 'package:flutter/material.dart';
import 'package:sudoku_core/sudoku_core.dart';

final sudokuColors = {
  "PRIMARY": const Color.fromARGB(255, 187, 224, 255),
  "ALTERNATIVE": const Color.fromARGB(255, 176, 220, 255),
  "CENTER": const Color.fromARGB(255, 155, 210, 255),
};

final TextStyle sudokuNumFont = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w700,
);

class SudokuGrid extends StatelessWidget {
  const SudokuGrid({
    super.key,
    required this.sudoku,
    this.rowCount = 9,
    this.colCount = 9,
  });
  final Sudoku sudoku;
  final int rowCount;
  final int colCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(5),
      child: SizedBox.square(
        // aspectRatio: 1,
        dimension: 500,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: rowCount * colCount,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: colCount,
          ),
          itemBuilder: (builderContext, i) {
            int x, y = 0;
            y = i % colCount;
            x = i ~/ colCount;
            bool isEmpty = sudoku.grid[x][y] == 0;

            return Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    // Conditionally set the border thickness
                    top: BorderSide(
                      color: Colors.black,
                      width: x > 0 && x % 3 == 0 ? 1.0 : 0.5,
                    ),
                    right: BorderSide(
                      color: Colors.black,
                      width: y > 0 && y % 3 == 2 ? 1.0 : 0.5,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                      width: x < 8 && x % 3 == 2 ? 1.0 : 0.5,
                    ),
                    left: BorderSide(
                      color: Colors.black,
                      width: y < 8 && y % 3 == 0 ? 1.0 : 0.5,
                    ),
                  ),
                ),
                child: InkWell(
                  highlightColor: Colors.blue,
                  splashColor: Colors.blue,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Center(
                        child: Text(
                          isEmpty ? '' : sudoku.grid[x][y].toString(),
                          style: sudokuNumFont.copyWith(
                            fontSize: constraints.maxWidth * 0.5,
                          ),
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    print(' tapped on $x, $y');
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
