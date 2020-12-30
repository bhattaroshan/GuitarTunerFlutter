import 'package:flutter/material.dart';
import 'package:mic_stream/mic_stream.dart';
import 'fft.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'dart:async';

const AUDIO_FORMAT = AudioFormat.ENCODING_PCM_16BIT;

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream<List<int>> stream;
  StreamSubscription<List<int>> listener;
  List<int> currentSamples;

  double percentage = 0;
  double frequency;
  int count = 1;

  FFT fftSystem = new FFT();

  void startListening() {
    stream = microphone(
        audioSource: AudioSource.DEFAULT,
        sampleRate: 44100,
        channelConfig: ChannelConfig.CHANNEL_IN_MONO,
        audioFormat: AUDIO_FORMAT);
    listener = stream.listen((samples) {
      // print(samples);
      currentSamples = samples;
      // if (currentSamples != null) {
      //   FFT fftSystem;
      frequency = fftSystem.calculateDominantFrequency(currentSamples);
      print("the frequency of the system is $frequency");

      // setState(() {
      //   percentage = frequency;
      // });
      // } else {
      //   print("no samples found");
      // }
    });
  }

  void printValue() {
    setState(() {
      percentage = 3000;
      count++;
    });
    // print(currentSamples);
    // for(int i=0;i<currentSamples.length;++i){
    //   print()
    // }
    // List<int> okay = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    // double frequency = fftSystem.calculate(currentSamples);
    // print("the frequency of the system is $frequency");
    // int a = fftSystem.testme();
    // print("the answer is $a");
  }

  @override
  void initState() {
    super.initState();
    startListening();
    Timer.periodic(Duration(seconds: 1), (timer) {
      printValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TUNE YOUR GUITAR',
        ),
      ),
      body: SfRadialGauge(
        title: GaugeTitle(
          text: 'TUNER',
          textStyle: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        axes: [
          RadialAxis(minimum: 0, maximum: 10000, ranges: [
            GaugeRange(startValue: 0, endValue: percentage),
          ])
        ],
      ),
    );
  }
}
