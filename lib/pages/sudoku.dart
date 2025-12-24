import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku_flutter/constants.dart';
import 'package:sudoku_flutter/models/sudoku_state.dart';
import 'package:sudoku_flutter/providers/sudoku_provider.dart';
import 'package:sudoku_flutter/widgets/sudoku_grid.dart';
import 'package:sudoku_flutter/widgets/timer.dart';

class SudokuPage extends ConsumerStatefulWidget {
  const SudokuPage({super.key});

  @override
  ConsumerState<SudokuPage> createState() => _SudokuPageState();
}

class _SudokuPageState extends ConsumerState<SudokuPage> {
  late SudokuState sudokuState;
  @override
  void initState() {
    super.initState();
    sudokuState = ref.read(sudokuProvider);
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    sudokuState = ref.watch(sudokuProvider);
    ref.listen(sudokuNotifierProvider, (previous, next) {
      if (next.correct != null) {
        if (next.correct!) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Correct!')));
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Incorrect!')));
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Sudoku'),
        backgroundColor: themeColors.inversePrimary,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 5.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColors.inversePrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        ref
                            .read(sudokuNotifierProvider.notifier)
                            .generateSudoku();
                      },
                      child: Text('New Game'),
                    ),
                    TimerWidget(),
                  ],
                ),
              ),
              SudokuGrid(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 2.0,
                  horizontal: 5.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 5,
                  children: [
                    for (int i = 0; i < 9; i++)
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          key: ValueKey('sudoku_number_${i + 1}'),
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            ref
                                .read(sudokuNotifierProvider.notifier)
                                .setSelectedCell(x: null, y: null);
                            if (sudokuState.selectedNumber == (i + 1)) {
                              ref
                                  .read(sudokuNotifierProvider.notifier)
                                  .setSelectedNumber(number: 0);
                              return;
                            }
                            ref
                                .read(sudokuNotifierProvider.notifier)
                                .setSelectedNumber(number: i + 1);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: sudokuState.selectedNumber == i + 1
                                  ? themeColors.inversePrimary.withAlpha(200)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 0.5,
                                color: themeColors.inversePrimary,
                              ),
                              boxShadow: sudokuState.selectedNumber == (i + 1)
                                  ? [
                                      BoxShadow(
                                        color: themeColors.inversePrimary,
                                        blurRadius: 3,
                                        offset: Offset(0, 0.5),
                                      ),
                                    ]
                                  : [],
                            ),
                            width: width > 600 ? 450 / 9 : (width - 100) / 9,
                            height: width > 600
                                ? 500 / 9
                                : ((width - 100) + 50) / 9,

                            child: Center(
                              child: Text(
                                (i + 1).toString(),
                                style: sudokuNumFont.copyWith(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              sudokuState.solved
                  ? ElevatedButton(
                      onPressed: () {
                        ref
                            .read(sudokuNotifierProvider.notifier)
                            .checkSolution();
                      },
                      child: Text('Check solution'),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
