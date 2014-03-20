
import "dart:isolate" as DI;
import "dart_synergy_calculator.dart";


var _sendPort;

main(args, sendPort) {
  _sendPort = sendPort;
  var receivePort = new DI.ReceivePort(), sc = new SynergyCalculator();
  sendPort.send(receivePort.sendPort);
  receivePort.listen((msg) {
    var orders = sc.findBest(msg);
    sendPort.send([sc.bestSum, orders]);
  });
}

