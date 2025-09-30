import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathsgames/presentation/viewmodels/calculator_viewmodel.dart';
import 'package:mathsgames/core/di/injection_container.dart';

/// Example screen showing how to use the new Clean Architecture
/// This is a reference implementation that demonstrates best practices
///
/// Usage:
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => ExampleCalculatorScreen(level: 1)),
/// );
class ExampleCalculatorScreen extends StatelessWidget {
  final int level;

  const ExampleCalculatorScreen({
    Key? key,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Get ViewModel from dependency injection
      create: (_) => sl<CalculatorViewModel>()..loadProblems(level),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Calculator - Level $level'),
          actions: [
            // Clear cache action
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                final vm = context.read<CalculatorViewModel>();
                vm.clearCache();
                vm.loadProblems(level);
              },
            ),
          ],
        ),
        body: Consumer<CalculatorViewModel>(
          builder: (context, viewModel, child) {
            // Show loading state
            if (viewModel.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            // Show error state
            if (viewModel.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, size: 64, color: Colors.red),
                    SizedBox(height: 16),
                    Text(
                      'Error: ${viewModel.error}',
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => viewModel.loadProblems(level),
                      child: Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            // Show empty state
            if (viewModel.problems.isEmpty) {
              return Center(
                child: Text('No problems available'),
              );
            }

            // Show problem
            final problem = viewModel.currentProblem;
            if (problem == null) {
              return Center(
                child: Text('Problem not found'),
              );
            }

            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Progress indicator
                  LinearProgressIndicator(
                    value: (viewModel.currentIndex + 1) / viewModel.problems.length,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Problem ${viewModel.currentIndex + 1} of ${viewModel.problems.length}',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),

                  // Question
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Text(
                        problem.question,
                        style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 32),

                  // Answer input
                  TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Enter your answer',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(16),
                    ),
                    onChanged: (value) => viewModel.updateAnswer(value),
                    onSubmitted: (_) => _checkAnswer(context, viewModel),
                  ),
                  SizedBox(height: 16),

                  // Check answer button
                  ElevatedButton(
                    onPressed: () => _checkAnswer(context, viewModel),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16),
                    ),
                    child: Text(
                      'Check Answer',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 8),

                  // Skip button
                  TextButton(
                    onPressed: () {
                      viewModel.nextProblem();
                    },
                    child: Text('Skip'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _checkAnswer(BuildContext context, CalculatorViewModel viewModel) {
    if (viewModel.checkAnswer()) {
      // Correct answer
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Correct! 🎉'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );

      // Move to next problem after delay
      Future.delayed(Duration(seconds: 1), () {
        if (viewModel.currentIndex < viewModel.problems.length - 1) {
          viewModel.nextProblem();
        } else {
          // All problems completed
          _showCompletionDialog(context);
        }
      });
    } else {
      // Wrong answer
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Wrong answer. Try again!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  void _showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Congratulations! 🎉'),
        content: Text('You completed all problems for level $level!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to previous screen
            },
            child: Text('Done'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              // Reload problems
              context.read<CalculatorViewModel>().loadProblems(level);
            },
            child: Text('Play Again'),
          ),
        ],
      ),
    );
  }
}
