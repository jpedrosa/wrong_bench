import "../lib/lang.dart";
import "line_ending.dart";
import 'dart:html' as DH;


main() {
  DH.query('#status').innerHtml = "Hello Line Ending!";
  DH.query('#startButton1').onClick.listen((ev) {
    var out = DH.query('#resultsOutput1'),
      sampleData = generateSampleString();
    pd(z) {
      var e = new DH.DivElement(); 
      e.text = z;
      out.children.add(e);
      return z;
    }
    pd("Sample length: ${sampleData.length} characters.");
    pd(bm("runIndexOf", () => runIndexOf(sampleData)));
    pd(bm("runCodeUnitAt", () => runCodeUnitAt(sampleData)));
    var e = 900001,
      v1 = runIndexOf(sampleData),
      v2 = runCodeUnitAt(sampleData),
      b = e == v1 && e == v2; 
    p(pd("Litmus test: ${b}"));
  });
}


