import "../lib/lang.dart";
import "string_index_of.dart";
import 'dart:html' as DH;


main() {
  DH.query('#status').innerHtml = "Hello String Index Of!";
  DH.query('#startButton1').onClick.listen((ev) {
    var out = DH.query('#resultsOutput1'),
      sampleData = generateSampleString();
    pd(z) {
      var e = new DH.DivElement(); 
      e.text = z;
      out.children.add(e);
      return z;
    }
    pd(bm("runIndexOf", () => runIndexOf(sampleData)));
    pd(bm("runCodeUnitAt", () => runCodeUnitAt(sampleData)));
    var e = 250, 
      v1 = runIndexOf(sampleData),
      v2 = runCodeUnitAt(sampleData),
      b = e == v1 && e == v2; 
    p(pd("Litmus test: ${b}"));
  });
}


