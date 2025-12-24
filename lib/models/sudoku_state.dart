import 'package:sudoku_core/sudoku_core.dart';

class SudokuState {
  late bool loading, solved;
  bool? correct;
  late int? selectedX, selectedY, selectedNumber;
  late Sudoku sudoku;

  SudokuState({
    Sudoku? sudoku,
    this.loading = false,
    this.solved = false,
    this.correct,
    this.selectedNumber,
    this.selectedX,
    this.selectedY,
  }) {
    if (sudoku != null) {
      this.sudoku = sudoku;
    }
  }

  SudokuState copyWith({
    bool? loading,
    bool? solved,
    bool? correct,
    int? selectedX,
    int? selectedY,
    int? selectedNumber,
    Sudoku? sudoku,
  }) {
    return SudokuState(
      loading: loading ?? this.loading,
      solved: solved ?? this.solved,
      correct: correct ?? this.correct,
      selectedX: selectedX ?? this.selectedX,
      selectedY: selectedY ?? this.selectedY,
      selectedNumber: selectedNumber ?? this.selectedNumber,
      sudoku: sudoku ?? this.sudoku,
    );
  }
}
