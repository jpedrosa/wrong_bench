library LineEnding;

import "../lib/lang.dart";
import "dart:math" as DM;


runMultipleTimes(fn(), [len = 10000]) {
  for (var i = 0; i < len; i++) {
    fn();
  }
}

bm(desc, fn()) {
  runMultipleTimes(fn, 10); // Warm up some.
  runMultipleTimes(fn, 10); // Warm up some.
  runMultipleTimes(fn, 10); // Warm up some.
  var z, sw = new Stopwatch();
  sw.start();
  runMultipleTimes(fn, 1);
  sw.stop();
  z = "${desc}: ${sw.elapsedMilliseconds}ms";
  print(z);
  return z;
}

generateSampleString() {
  var sb = new StringBuffer(), i, rand = new DM.Random(), j;
  for (i = 0; i < 900000; i++) {
    for (j = rand.nextInt(30); j >= 0; j--) {
      sb.write("a1b2c");
    }
    sb.write("\n");
  }
  return sb.toString();
}

runIndexOf(s) {
  var n = 1, i = s.indexOf("\n");
  while (i >= 0) {
    n++;
    i = s.indexOf("\n", i + 1);
  }
  return n;
}

runCodeUnitAt(s) {
  var n = 1, i, len = s.length;
  for (i = 0; i < len; i++) {
    if (s.codeUnitAt(i) == 10) {
      n++;
    }
  }
  return n;
}

indexOfCodeUnit(data, char, pos) {
  for (int lim = data.length - 2; pos < lim; pos += 3) {
    if (data.codeUnitAt(pos) == char || data.codeUnitAt(pos + 1) == char ||
        data.codeUnitAt(pos + 2) == char) break;
  }
  for (; pos < data.length; pos++) {
    if (data.codeUnitAt(pos) == char) return pos;
  }
  return -1;
}

runIndexOfCodeUnit(s) {
  var n = 1, i = indexOfCodeUnit(s, 10, 0);
  while (i >= 0) {
    n++;
    i = indexOfCodeUnit(s, 10, i + 1);
  }
  return n;
}

main() {
  var data = generateSampleString(); 
  p("Sample length: ${data.length} characters.");
  bm("runIndexOf", () => runIndexOf(data));
  bm("runCodeUnitAt", () => runCodeUnitAt(data));
  bm("runIndexOfCodeUnit", () => runIndexOfCodeUnit(data));
  var e = 900001,
    v1 = runIndexOf(data),
    v2 = runCodeUnitAt(data),
    v3 = runIndexOfCodeUnit(data),
    b = e == v1 && e == v2 && e == v3;
  p("Litmus test: ${b}");
}







