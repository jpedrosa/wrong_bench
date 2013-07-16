import "../../../reluzir/lang/lib/lang.dart";
import "dart:math" as DM;


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
  return {"SampleClassA": {
      "field1": randString(),
      "field2": randInt(),
      "field3": randDouble(),
      "field4": randDateTime(),
      "field5": randString(),
      "field6": randInt(),
      "field7": randDouble(),
      "field8": randDateTime(),
      "field9": randString(),
      "field10": randInt(),
      "field11": randDouble(),
      "field12": randDateTime(),
    },
    "SampleClassB": {
      "field1": randString(),
      "field2": randInt(),
      "field3": randDouble(),
      "field4": randDateTime(),
      "field5": randString(),
      "field6": randInt(),
      "field7": randDouble(),
      "field8": randDateTime(),
      "field9": randString(),
      "field10": randInt(),
      "field11": randDouble(),
      "field12": randDateTime(),
      "field13": randString(),
      "field14": randInt(),
      "field15": randDouble(),
      "field16": randDateTime(),
    }};
}

loadSampleClassAFields(data) {
  var k, o = new SampleClassA();
  for (k in data.keys) {
    switch (k) {
      case "field1":
        o.field1 = data["field1"];
        break;
      case "field2":
        o.field2 = data["field2"];
        break;
      case "field3":
        o.field3 = data["field3"];
        break;
      case "field4":
        o.field4 = data["field4"];
        break;
      case "field5":
        o.field5 = data["field5"];
        break;
      case "field6":
        o.field6 = data["field6"];
        break;
      case "field7":
        o.field7 = data["field7"];
        break;
      case "field8":
        o.field8 = data["field8"];
        break;
      case "field9":
        o.field9 = data["field9"];
        break;
      case "field10":
        o.field10 = data["field10"];
        break;
      case "field11":
        o.field11 = data["field11"];
        break;
      case "field12":
        o.field12 = data["field12"];
        break;
    }
  }
  return o;
}

loadSampleClassBFields(data) {
  var k, o = new SampleClassB();
  for (k in data.keys) {
    switch (k) {
      case "field1":
        o.field1 = data["field1"];
        break;
      case "field2":
        o.field2 = data["field2"];
        break;
      case "field3":
        o.field3 = data["field3"];
        break;
      case "field4":
        o.field4 = data["field4"];
        break;
      case "field5":
        o.field5 = data["field5"];
        break;
      case "field6":
        o.field6 = data["field6"];
        break;
      case "field7":
        o.field7 = data["field7"];
        break;
      case "field8":
        o.field8 = data["field8"];
        break;
      case "field9":
        o.field9 = data["field9"];
        break;
      case "field10":
        o.field10 = data["field10"];
        break;
      case "field11":
        o.field11 = data["field11"];
        break;
      case "field12":
        o.field12 = data["field12"];
        break;
      case "field13":
        o.field13 = data["field13"];
        break;
      case "field14":
        o.field14 = data["field14"];
        break;
      case "field15":
        o.field15 = data["field15"];
        break;
      case "field16":
        o.field16 = data["field16"];
        break;
    }
  }
  return o;
}
  
loadData(data) {
  var k, o, r = [], fields, fk;
  for (k in data.keys) {
    switch (k) {
      case "SampleClassA":
        o = loadSampleClassAFields(data[k]);
        break;
      case "SampleClassB":
        o = loadSampleClassBFields(data[k]);
        break;
      default:
        throw "Unexpected data key: ${k}";
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
}


