import 'package:flutter/material.dart';
import 'package:sudoku_core/sudoku_core.dart';
import 'package:sudoku_flutter/widgets/sudoku_grid.dart';

class SudokuPage extends StatefulWidget {
  final Level? level;

  const SudokuPage({super.key, this.level});

  @override
  State<SudokuPage> createState() => _SudokuPageState();
}

class _SudokuPageState extends State<SudokuPage> {
  late Level _level;

  @override
  void initState() {
    super.initState();
    _level = widget.level ?? Level.medium;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sudoku')),
      body: SudokuGrid(sudoku: Sudoku.generate(_level)),
    );
  }
}
