
runParseLeadingInt(s) {
  var i = 0, negative = false, c, cc = s.codeUnits, len = cc.length, m;
  if (len > 0) {
    if (cc[0] == 45) { // -
      negative = true;
      i++;
    }
    for (; i < len; i++) {
      c = cc[i];
      if (c < 48 || c > 57) { // 0-9
        break;
      }
    }
    if (negative && i == 1) {
    } else if (i == len) {
      m = s;
    } else if (i > 0) {
      m = s.substring(0, i);
    }
  }
  return m;
}

var reCached = new RegExp(r"-?\d+");
runReCached(s) {
  var m = reCached.matchAsPrefix(s);
  return m[0];
}

runReUncached(s) {
  var re = new RegExp(r"-?\d+"), m = re.matchAsPrefix(s);
  return m[0];
}

runMultipleTimes(fn()) {
  for (var i = 0; i < 10000; i++) {
    fn();
  }
}

bm(desc, fn()) {
  runMultipleTimes(fn); // Warm up some.
  var sw = new Stopwatch();
  sw.start();
  runMultipleTimes(fn);
  sw.stop();
  print("${desc}: ${sw.elapsedMilliseconds}ms");
}

main() {
  var s = "97216px", e = "97216";
  //var s = "-98765432187654321px", e = "-98765432187654321px";
  bm("runParseLeadingInt", () => runParseLeadingInt(s));
  bm("runReCached", () => runReCached(s));
  bm("runReUncached", () => runReUncached(s));
  var v1 = runParseLeadingInt(s),
    v2 = runReCached(s),
    v3 = runReUncached(s),
    b = e == v1 && e == v2 && e == v3;
  print("Litmus test: ${b}");
}


