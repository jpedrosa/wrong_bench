library StringTraversing;

import "../lib/lang.dart";
import "dart:math" as DM;


runMultipleTimes(fn()) {
  for (var i = 0; i < 10000; i++) {
    fn();
  }
}

bm(desc, fn()) {
  runMultipleTimes(fn); // Warm up some.
  var z, sw = new Stopwatch();
  sw.start();
  runMultipleTimes(fn);
  sw.stop();
  z = "${desc}: ${sw.elapsedMilliseconds}ms";
  print(z);
  return z;
}

generateSampleString() {
  var sb = new StringBuffer(), i;
  for (i = 0; i < 1000; i++) {
    sb.write("a0b1c");
  }
  return sb.toString();
}

runCodeUnitsArray(s) {
  var r = 0, mirror = s.codeUnits, len = mirror.length, i, c;
  for (i = 0; i < len; i++) {
    c = mirror[i];
    if (c >= 49 && c <= 57) { // 1-9
      r += c - 48;
    }
  }
  return r;
}

runCodeUnitAt(s) {
  var r = 0, len = s.length, i, c;
  for (i = 0; i < len; i++) {
    c = s.codeUnitAt(i);
    if (c >= 49 && c <= 57) { // 1-9
      r += c - 48;
    }
  }
  return r;
}

runCharSwitch(s) {
  var r = 0, len = s.length, i;
  for (i = 0; i < len; i++) {
    switch (s[i]) {
      case "1":
        r++;
        break;
      case "2":
        r += 2;
        break;
      case "3":
        r += 3;
        break;
      case "4":
        r += 4;
        break;
      case "5":
        r += 5;
        break;
      case "6":
        r += 6;
        break;
      case "7":
        r += 7;
        break;
      case "8":
        r += 8;
        break;
      case "9":
        r += 9;
        break;
    }
  }
  return r;
}

runSubstringSwitch(s) {
  var r = 0, len = s.length, i;
  for (i = 0; i < len; i++) {
    switch (s.substring(i, i + 1)) {
      case "1":
        r++;
        break;
      case "2":
        r += 2;
        break;
      case "3":
        r += 3;
        break;
      case "4":
        r += 4;
        break;
      case "5":
        r += 5;
        break;
      case "6":
        r += 6;
        break;
      case "7":
        r += 7;
        break;
      case "8":
        r += 8;
        break;
      case "9":
        r += 9;
        break;
    }
  }
  return r;
}

main() {
  var sampleData = generateSampleString();
  bm("runCodeUnitAt", () => runCodeUnitAt(sampleData));
  bm("runCodeUnitsArray", () => runCodeUnitsArray(sampleData));
  bm("runCharSwitch", () => runCharSwitch(sampleData));
  bm("runSubstringSwitch", () => runSubstringSwitch(sampleData));
  var e = 1000, 
    v1 = runCodeUnitsArray(sampleData),
    v2 = runCodeUnitAt(sampleData),
    v3 = runCharSwitch(sampleData),
    v4 = runSubstringSwitch(sampleData),
    b = e == v1 && e == v2 && e == v3 && e == v4; 
  p("Litmus test: ${b}");
}


