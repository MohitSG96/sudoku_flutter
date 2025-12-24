import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku_flutter/constants.dart';
import 'package:sudoku_flutter/providers/sudoku_provider.dart';

class SudokuGrid extends ConsumerWidget {
  const SudokuGrid({super.key, this.rowCount = 9, this.colCount = 9});
  final int rowCount;
  final int colCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sudokuState = ref.watch(sudokuProvider);
    final sudoku = sudokuState.sudoku;

    final themeColors = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.all(5),
      child: AspectRatio(
        aspectRatio: 1,
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
            bool isEmpty = sudoku.puzzle[x][y] == 0;
            bool isUserNumber = sudoku.grid[x][y] != sudoku.puzzle[x][y];
            bool userSelectedNumber =
                sudokuState.selectedNumber != 0 &&
                sudokuState.selectedNumber == sudoku.puzzle[x][y];

            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  ref
                      .read(sudokuNotifierProvider.notifier)
                      .setSelectedCell(x: x, y: y);
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          sudokuState.selectedX == x &&
                              sudokuState.selectedY == y
                          ? themeColors.inversePrimary.withAlpha(200)
                          : userSelectedNumber
                          ? themeColors.inversePrimary.withAlpha(50)
                          : Colors.transparent,
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
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Center(
                          child: Text(
                            isEmpty ? '' : sudoku.puzzle[x][y].toString(),
                            style: sudokuNumFont.copyWith(
                              color: isUserNumber
                                  ? themeColors.primary.withAlpha(200)
                                  : Colors.black,
                              fontSize: constraints.maxWidth * 0.5,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
