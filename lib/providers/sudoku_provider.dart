import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku_core/sudoku_core.dart';
import 'package:sudoku_flutter/models/sudoku_state.dart';

class SudokuNotifier extends Notifier<SudokuState> {
  @override
  SudokuState build() {
    return SudokuState();
  }

  void updatePuzzle(int row, int col, int number) {
    List<List<int>> newPuzzle = List.generate(
      9,
      (i) => List.generate(9, (j) => state.sudoku.puzzle[i][j]),
    );
    bool isSolved = state.solved;
    newPuzzle[row][col] = number;

    // check if all numbers are filled
    isSolved = state.sudoku.puzzle.every(
      (row) => row.every((puzNum) => puzNum != 0),
    );
    state = state.copyWith(
      solved: isSolved,
      sudoku: state.sudoku.copyWith(puzzle: newPuzzle),
    );
  }

  void generateSudoku({Level level = Level.medium}) {
    state = state.copyWith(sudoku: generateGrid(level: level));
  }

  void setLoading(bool loading) {
    state = state.copyWith(loading: loading);
  }

  void setSelectedCell({required int? x, required int? y}) {
    // state = state.copyWith(selectedX: x, selectedY: y);
    state.selectedX = x;
    state.selectedY = y;
    final selectedNum = state.selectedNumber;
    if (selectedNum != null && selectedNum != 0 && x != null && y != null) {
      updatePuzzle(x, y, selectedNum);
    }
  }

  void setSelectedNumber({required int number}) {
    state = state.copyWith(selectedNumber: number);
  }

  void checkSolution() {
    bool solved = state.solved;

    if (!solved) {
      return;
    }

    bool? correct;
    bool checked = false;
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (state.sudoku.puzzle[i][j] == 0) {
          solved = false;
          break;
        }
        if (state.sudoku.puzzle[i][j] != state.sudoku.solution[i][j]) {
          correct = false;
          break;
        } else {
          checked = true;
        }
      }
    }
    if (checked && correct == null) {
      correct = true;
    }
    state = state.copyWith(correct: correct, solved: solved);
  }

  Sudoku get sudoku => state.sudoku;
}

final sudokuNotifierProvider = NotifierProvider<SudokuNotifier, SudokuState>(
  SudokuNotifier.new,
);

final sudokuProvider = Provider<SudokuState>(
  (ref) => ref.watch(sudokuNotifierProvider),
);
