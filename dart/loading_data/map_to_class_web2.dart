import "../lib/lang.dart";
import "map_to_class2.dart";
import 'dart:html' as DH;


main() {
  DH.query('#status').innerHtml = "Hello Map To Class 2!";
  DH.query('#startButton1').onClick.listen((ev) {
    p("Hey");
    var data = generateSampleData(), klasses = loadData(data),
      out = DH.query('#resultsOutput1'), delta,
      e = new DH.DivElement();
    p(data);
    klasses.forEach((kls) => p(kls));
    delta = bm("loadData", () => loadData(data)).toString();
    e.text = "${delta}ms";
    out.children.add(e);
  });
}


