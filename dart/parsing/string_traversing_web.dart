import "../lib/lang.dart";
import "string_traversing.dart";
import 'dart:html' as DH;


main() {
  DH.query('#status').innerHtml = "Hello String Traversing!";
  DH.query('#startButton1').onClick.listen((ev) {
    var out = DH.query('#resultsOutput1'),
      sampleData = generateSampleString();
    pd(z) {
      var e = new DH.DivElement(); 
      e.text = z;
      out.children.add(e);
      return z;
    }
    pd(bm("runCodeUnitAt", () => runCodeUnitAt(sampleData)));
    pd(bm("runCodeUnitsArray", () => runCodeUnitsArray(sampleData)));
    pd(bm("runCharSwitch", () => runCharSwitch(sampleData)));
    pd(bm("runSubstringSwitch", () => runSubstringSwitch(sampleData)));
    var e = 1000, 
      v1 = runCodeUnitsArray(sampleData),
      v2 = runCodeUnitAt(sampleData),
      v3 = runCharSwitch(sampleData),
      v4 = runSubstringSwitch(sampleData),
      b = e == v1 && e == v2 && e == v3 && e == v4; 
    p(pd("Litmus test: ${b}"));
  });
}


