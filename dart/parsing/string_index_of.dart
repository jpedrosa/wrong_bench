library StringIndexOf;

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
  for (i = 0; i < 50; i++) {
    sb.write("a1b2c");
  }
  sb.write("\t");
  for (i = 0; i < 50; i++) {
    sb.write("a1b2c");
  }
  return sb.toString();
}

runIndexOf(s) {
  return s.indexOf("\t");
}

runCodeUnitAt(s) {
  var n = -1, i, len = s.length;
  for (i = 0; i < len; i++) {
    if (s.codeUnitAt(i) == 9) {
      n = i;
      break;
    }
  }
  return n;
}

main() {
  var data = generateSampleString(); 
  p(data);
  bm("runIndexOf", () => runIndexOf(data));
  bm("runCodeUnitAt", () => runCodeUnitAt(data));
  var e = 250,
    v1 = runIndexOf(data),
    v2 = runCodeUnitAt(data),
    b = e == v1 && e == v2;
  p("Litmus test: ${b}");
}





