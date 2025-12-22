import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class Timer extends StatefulWidget {
  const Timer({super.key, required this.title});

  final String title;
  static const int workTime = 25 * 60;
  static const int breakTime = 1 * 60;

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  final CountDownController _controller = CountDownController();
  bool _hasStarted = false; // タイマー開始済みかどうかの状態保持用
  bool _isRunning = false; // ボタン表示／状態保持用
  bool _isworking = true; // 作業中か休憩中かの状態保持用

  void _startPause() {
    setState(() {
      if (_isRunning) {
        _controller.pause();
        _isRunning = false;
      } else if (!_hasStarted) {
        // 初回起動
        _controller.start();
        _isRunning = true;
        _hasStarted = true;
      } else {
        // 一時停止からの再開
        _controller.resume();
        _isRunning = true;
      }
    });
  }

  void _working() {
    setState(() {
      if (_isworking) {
        _controller.restart(duration: Timer.breakTime);
        _isworking = false;
        _isRunning = true;
        _hasStarted = false;
      } else {
        _controller.restart(duration: Timer.workTime);
        _isworking = true;
        _isRunning = true;
        _hasStarted = false;
      }
    });
  }

  void _onComplete() {
    setState(() {
      _isworking = !_isworking;
      _isRunning = true;
      _hasStarted = true;
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
              key: ValueKey(_isworking),
              duration: _isworking ? Timer.workTime : Timer.breakTime,
              initialDuration: 0,
              controller: _controller,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
              ringColor: Colors.grey[300]!,
              ringGradient: null,
              fillColor: Color(_isworking ? 0xFFF2856A : 0xFF6A75F2),
              fillGradient: null,
              backgroundColor: Color(_isworking ? 0xFFB42A00 : 0xFF0003B4),
              backgroundGradient: null,
              strokeWidth: 20.0,
              strokeCap: StrokeCap.round,
              textStyle: const TextStyle(
                  fontSize: 33.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textFormat: CountdownTextFormat.MM_SS,
              isReverse: true,
              isReverseAnimation: _isworking,
              isTimerTextShown: true,
              autoStart: _isRunning,
              onStart: () {
                // debugPrint('Countdown Started');
              },
              onComplete: () {
                _onComplete();
              },
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _startPause,
                  icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                  label: Text(_isRunning
                      ? '一時停止'
                      : _hasStarted
                          ? '再開'
                          : '開始'),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: _working,
                  icon: Icon(_isworking ? Icons.coffee : Icons.work),
                  label: Text(_isworking ? '休憩する' : '作業を始める'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
