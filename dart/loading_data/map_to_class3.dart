library MapToClass3;

import "../lib/lang.dart";
import "dart:math" as DM;


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
  var delta = sw.elapsedMilliseconds;
  print("${desc}: ${delta}ms");
  return delta;
}


class SampleClassA {
  String field1;
  int field2;
  double field3;
  DateTime field4;
  String field5;
  int field6;
  double field7;
  DateTime field8;
  String field9;
  int field10;
  double field11;
  DateTime field12;
  
  toString() {
    return "SampleClassA("
      "field1: ${field1}, "
      "field2: ${field2}, "
      "field3: ${field3}, "
      "field4: ${field4}, "
      "field5: ${field5}, "
      "field6: ${field6}, "
      "field7: ${field7}, "
      "field8: ${field8}, "
      "field9: ${field9}, "
      "field10: ${field10}, "
      "field11: ${field11}, "
      "field12: ${field12})";
  }
}


class SampleClassB extends SampleClassA {
  String field13;
  int field14;
  double field15;
  DateTime field16;
  
  toString() {
    return "SampleClassB("
      "field1: ${field1}, "
      "field2: ${field2}, "
      "field3: ${field3}, "
      "field4: ${field4}, "
      "field5: ${field5}, "
      "field6: ${field6}, "
      "field7: ${field7}, "
      "field8: ${field8}, "
      "field9: ${field9}, "
      "field10: ${field10}, "
      "field11: ${field11}, "
      "field12: ${field12}, "
      "field13: ${field13}, "
      "field14: ${field14}, "
      "field15: ${field15}, "
      "field16: ${field16})";
  }
}


randInt() {
  return new DM.Random().nextInt(1000);
}

randDouble() {
  return new DM.Random().nextDouble();
}

randString() {
  return "text ${randInt()}";
}

randDateTime() {
  return new DateTime.now().add(new Duration(days: randInt()));
}

generateSampleData() {
  return [1, [
      1, randString(),
      2, randInt(),
      3, randDouble(),
      4, randDateTime(),
      5, randString(),
      6, randInt(),
      7, randDouble(),
      8, randDateTime(),
      9, randString(),
      10, randInt(),
      11, randDouble(),
      12, randDateTime(),
    ], 2, [
      1, randString(),
      2, randInt(),
      3, randDouble(),
      4, randDateTime(),
      5, randString(),
      6, randInt(),
      7, randDouble(),
      8, randDateTime(),
      9, randString(),
      10, randInt(),
      11, randDouble(),
      12, randDateTime(),
      13, randString(),
      14, randInt(),
      15, randDouble(),
      16, randDateTime(),
    ]];
}

loadSampleClassAFields(data) {
  var n, k, len = data.length, o = new SampleClassA();
  for (n = 0; n < len; n += 2) {
    k = n + 1;
    switch (data[n]) {
      case 1:
        o.field1 = data[k];
        break;
      case 2:
        o.field2 = data[k];
        break;
      case 3:
        o.field3 = data[k];
        break;
      case 4:
        o.field4 = data[k];
        break;
      case 5:
        o.field5 = data[k];
        break;
      case 6:
        o.field6 = data[k];
        break;
      case 7:
        o.field7 = data[k];
        break;
      case 8:
        o.field8 = data[k];
        break;
      case 9:
        o.field9 = data[k];
        break;
      case 10:
        o.field10 = data[k];
        break;
      case 11:
        o.field11 = data[k];
        break;
      case 12:
        o.field12 = data[k];
        break;
      default:
        throw "Unexpected data key: ${data[n]}";
    }
  }
  return o;
}

loadSampleClassBFields(data) {
  var n, k, len = data.length, o = new SampleClassB();
  for (n = 0; n < len; n += 2) {
    k = n + 1;
    switch (data[n]) {
      case 1:
        o.field1 = data[k];
        break;
      case 2:
        o.field2 = data[k];
        break;
      case 3:
        o.field3 = data[k];
        break;
      case 4:
        o.field4 = data[k];
        break;
      case 5:
        o.field5 = data[k];
        break;
      case 6:
        o.field6 = data[k];
        break;
      case 7:
        o.field7 = data[k];
        break;
      case 8:
        o.field8 = data[k];
        break;
      case 9:
        o.field9 = data[k];
        break;
      case 10:
        o.field10 = data[k];
        break;
      case 11:
        o.field11 = data[k];
        break;
      case 12:
        o.field12 = data[k];
        break;
      case 13:
        o.field13 = data[k];
        break;
      case 14:
        o.field14 = data[k];
        break;
      case 15:
        o.field15 = data[k];
        break;
      case 16:
        o.field16 = data[k];
        break;
      default:
        throw "Unexpected data key: ${data[n]}";
    }
  }
  return o;
}

loadData(data) {
  var o, r = [], n, len = data.length;
  for (n = 0; n < len; n += 2) {
    switch (data[n]) {
      case 1: // "SampleClassA"
        o = loadSampleClassAFields(data[n + 1]);
        break;
      case 2: // "SampleClassB"
        o = loadSampleClassBFields(data[n + 1]);
        break;
      default:
        throw "Unexpected data key: ${data[n]}";
    }
    r.add(o);
  }
  return r;
}

main() {
  p("Hey");
  var data = generateSampleData(), klasses = loadData(data); 
  p(data);
  klasses.forEach((kls) => p(kls));
  bm("loadData", () => loadData(data));
}





