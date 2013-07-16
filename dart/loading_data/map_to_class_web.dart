import "../lib/lang.dart";
import "map_to_class.dart";
import 'dart:html' as DH;


main() {
  DH.query('#status').innerHtml = "Hello Map To Class!";
  DH.query('#startButton1').onClick.listen((ev) {
    p("Hey");
    var data = generateSampleData(), klasses = loadData(data); 
    p(data);
    klasses.forEach((kls) => p(kls));
    bm("loadData", () => loadData(data));
  });
}


