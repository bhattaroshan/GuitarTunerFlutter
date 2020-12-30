import 'dart:math';

import 'complex.dart';

class FFT {
  List<Complex> fft(List<Complex> x) {
    int n = x.length;
    if (n == 1) {
      List<Complex> data = List(1);
      data[0] = x[0];
      return data;
    }
    if (n % 2 != 0) {
      //this is empty list
      // print("here is the thing");
      // data.add(new Complex(0, 0));
      return null;
    }

    List<Complex> even = [];

    for (int k = 0; k < n / 2; ++k) {
      even.add(x[2 * k]);
    }

    List<Complex> q = fft(even);
    List<Complex> odd = even;

    for (int k = 0; k < n / 2; ++k) {
      odd[k] = x[2 * k + 1];
    }
    List<Complex> r = fft(odd);
    List<Complex> y = List(n);

    for (int k = 0; k < n / 2; ++k) {
      double kth = -2 * k * pi / n;
      Complex wk = Complex(cos(kth), sin(kth));
      y[k] = q[k].plus(wk.times(r[k]));
      y[(k + n / 2).toInt()] = q[k].minus(wk.times(r[k]));
    }
    return y;
  }

  double calculateDominantFrequency(List<int> buffer) {
    int analyzeSize = 1024;
    List<Complex> data = [];

    for (int i = 0; i < analyzeSize; ++i) {
      Complex cplx = new Complex(buffer[i].toDouble(), 0);
      data.add(cplx);
    }

    List<Complex> fftData = fft(data);
    int startFreq = (50 * analyzeSize) ~/ 44100;
    int endFreq = (15000 * analyzeSize) ~/ 44100;
    int index = startFreq;
    double maxFreq = fftData[index].abs();
    double tmpFreq;

    for (int i = startFreq; i < endFreq; ++i) {
      tmpFreq = fftData[i].abs();
      if (tmpFreq > maxFreq) {
        maxFreq = tmpFreq;
        index = i;
      }
    }
    return (44100 * index) / analyzeSize;
  }

  // double calculate(List<int> buffer) {
  //   int startFrequency = 100;
  //   int endFrequency = 15000;
  //   int numberOfBitsInOneTone = 4;
  //   int padding =
  //       (endFrequency - startFrequency) ~/ (4 + pow(2, numberOfBitsInOneTone));
  //   int halfPad = padding ~/ 2;

  //   int analyzedSize = 1024;
  //   List<Complex> fftTempArray1 = List(analyzedSize);
  //   int tempI = -1;

  //   for (int i = 0; i < analyzedSize; i++) {
  //     tempI++;
  //     fftTempArray1[tempI] = Complex(buffer[i].toDouble(), 0);
  //   }
  //   List<Complex> fftArray1 = fft(fftTempArray1);
  //   int startIndex1 = (((startFrequency - halfPad) * (analyzedSize)) ~/ 44100);
  //   int endIndex1 = ((endFrequency + halfPad) * (analyzedSize)) ~/ 44100;
  //   int maxIndex1 = startIndex1;
  //   print("maximum value $maxIndex1");
  //   double maxMagnitude1 = fftArray1[maxIndex1].abs().toInt().toDouble();
  //   double tempMagnitude;

  //   for (int i = startIndex1; i < endIndex1; ++i) {
  //     tempMagnitude = fftArray1[i].abs();
  //     if (tempMagnitude > maxMagnitude1) {
  //       maxMagnitude1 = tempMagnitude.toInt().toDouble();
  //       maxIndex1 = i;
  //     }
  //   }
  // return 44100 * maxIndex1 / analyzedSize;
  // }
}
