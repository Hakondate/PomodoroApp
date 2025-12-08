import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class Timer extends StatefulWidget {
  const Timer({super.key, required this.title});

  final String title;

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  final CountDownController _controller = CountDownController();
  bool _isRunning = false; // ボタン表示／状態保持用

  void _startPause() {
    setState(() {
      if (_isRunning) {
        _controller.pause();
        _isRunning = false;
      } else {
        // 初回や一時停止からの再開
        _controller.start();
        _isRunning = true;
      }
    });
  }

  void _reset() {
    _controller.restart(duration: 25 * 60); // 再起動して25分に
    setState(() {
      _controller.pause();
      _isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularCountDownTimer(
              duration: 25 * 60,
              initialDuration: 0,
              controller: _controller,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
              ringColor: Colors.grey[300]!,
              ringGradient: null,
              fillColor: Colors.purpleAccent[100]!,
              fillGradient: null,
              backgroundColor: Colors.purple[500],
              backgroundGradient: null,
              strokeWidth: 20.0,
              strokeCap: StrokeCap.round,
              textStyle: const TextStyle(
                  fontSize: 33.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textFormat: CountdownTextFormat.MM_SS,
              isReverse: true,
              isReverseAnimation: true,
              isTimerTextShown: true,
              autoStart: false,
              onStart: () {
                // debugPrint('Countdown Started');
              },
              onComplete: () {
                // debugPrint('Countdown Ended');
              },
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _startPause,
                  icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                  label: Text(_isRunning ? 'Pause' : 'Start'),
                ),
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  onPressed: _reset,
                  icon: const Icon(Icons.replay),
                  label: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
