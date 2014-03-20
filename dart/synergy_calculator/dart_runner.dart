
import "dart:html" as DH;
import "dart:async" as DA;
import "dart:isolate" as DI;
import "dart_synergy_calculator.dart";


class SynergyCalculatorBench {
  
  var _sc, _bRun, _bRunIsolate, _taLog, _selNumberZodiacs, _selNumberRuns,
    _descStatus, _td11, _td12, _td13,
    _tdIsolate11, _tdIsolate12, _tdIsolate13,
    _ms1, _ms2,
    _totalRuns11 = 0, _accumulatedTime11 = 0,
    _totalRuns12 = 0, _accumulatedTime12 = 0,
    _totalRuns13 = 0, _accumulatedTime13 = 0,
    _totalRunsIsolate11 = 0, _accumulatedTimeIsolate11 = 0,
    _totalRunsIsolate12 = 0, _accumulatedTimeIsolate12 = 0,
    _totalRunsIsolate13 = 0, _accumulatedTimeIsolate13 = 0,
    _sendPort, _nZodiacsIsolate = 0, _isolateRunCounter = 0;
  
  final _zodiacList13 = const [
      "ge", "li", "cap", "li", "le", "sa", "pi",
      "sa", "ar", "can", "sc", "ta", "aq"];
  
  SynergyCalculatorBench() {
    _sc = new SynergyCalculator();
    prepare();
    prepareIsolate();
  }
  
  el(id) => DH.document.getElementById(id);
  
  prepare() {
    _taLog = el("sc_bench_log_ta");
    _bRun = el("sc_bench_run_dart_button");
    _bRunIsolate = el("sc_bench_run_dart_isolate_button");
    _selNumberZodiacs = el("sc_bench_number_of_zodiacs_select");
    _selNumberRuns = el("sc_bench_number_of_runs_select");
    _descStatus = el("sc_bench_status");
    _td11 = el("sc_bench_stats_table_dart_11");
    _td12 = el("sc_bench_stats_table_dart_12");
    _td13 = el("sc_bench_stats_table_dart_13");
    _tdIsolate11 = el("sc_bench_stats_table_dart_isolate_11");
    _tdIsolate12 = el("sc_bench_stats_table_dart_isolate_12");
    _tdIsolate13 = el("sc_bench_stats_table_dart_isolate_13");
    _bRun.onClick.listen((ev) {
      disableButtons();
      _descStatus.innerHtml = "running...";
      new DA.Timer(new Duration(milliseconds: 100), runDart);
    });
    _bRunIsolate.onClick.listen((ev) {
      disableButtons();
      _descStatus.innerHtml = "running...";
      _nZodiacsIsolate = numberOfZodiacs;
      _isolateRunCounter = numberOfRuns;
      new DA.Timer(new Duration(milliseconds: 100), runDartIsolate);
    });
  }
  
  log(v) {
    _taLog.value = "${v}\n${_taLog.value}";
    print(v);
  }

  get numberOfZodiacs => int.parse(_selNumberZodiacs.value);

  get numberOfRuns => int.parse(_selNumberRuns.value);
 
  logResults(desc, et, sum, orders, nZodiacs) {
    var i;
    if (_taLog.value.length > 0) {
      log("----------------------------------------");
    }
    for (i = 0; i < orders.length; i++) {
      log(orders[i]);
    }
    log("Best Sum: ${sum}      Number of Orders: ${orders.length}");
    log("Elapsed: ${et} seconds.");
    log("${desc} run with ${nZodiacs} zodiacs.");
  }

  runDart() {
    var orders, nZodiacs = numberOfZodiacs, nRuns =  numberOfRuns, i, et;
    //log(_sc.doSum([1, 2, 4], 3));
    //log(_sc.sum(["aq", "ar", "can"]));
    //log(_sc.doSum([8, 4], 2));
    //log(_sc.doFindBest([1, 2, 4], -1));
    //log(_sc.findBest(["aq", "ar", "can"]));
    //log(_sc.sum(["ge", "li", "cap", "li", "le", "sa", "pi", "sa", "ar", "can"]));
    //log(_sc.findBest(["ge", "li", "cap", "li", "le", "sa", "pi", "sa", "ar", "can"]));
    //orders = _sc.findBest(["ge", "li", "cap", "li", "le", "sa", "pi", "sa", "ar", "can", "sc", "ta"]);
    for (i = 0; i < nRuns; i++) {
      _ms1 = new DateTime.now().millisecondsSinceEpoch;
      orders = _sc.findBest(_zodiacList13.sublist(0, nZodiacs));
      _ms2 = new DateTime.now().millisecondsSinceEpoch;
      et = (_ms2 - _ms1) / 1000;
      logResults("Dart or dart2js", et, _sc.bestSum, orders, nZodiacs);
      if (nZodiacs == 11) {
        _totalRuns11++;
        _accumulatedTime11 += et;
      } else if (nZodiacs == 12) {
        _totalRuns12++;
        _accumulatedTime12 += et;
      } else { // 13
        _totalRuns13++;
        _accumulatedTime13 += et;
      }
    }
    _descStatus.innerHtml = "idle.";
    if (nZodiacs == 11) {
      _td11.innerHtml = "${formatNumber((_accumulatedTime11 / _totalRuns11))}" 
          " secs (${_totalRuns11})";
    } else if (nZodiacs == 12) {
      _td12.innerHtml = "${formatNumber((_accumulatedTime12 / _totalRuns12))}" 
      " secs (${_totalRuns12})";
    } else {
      _td13.innerHtml = "${formatNumber((_accumulatedTime13 / _totalRuns13))}" 
      " secs (${_totalRuns13})";
    }
    new DA.Timer(new Duration(milliseconds: 100), enableButtons);
  }
  
  runDartIsolate() {
    var zodiacs = _zodiacList13.sublist(0, _nZodiacsIsolate);
    _ms1 = new DateTime.now().millisecondsSinceEpoch;
    _sendPort.send(zodiacs);
  }

  formatNumber(n) => (n * 100).round() / 100;
  
  enableButtons() {
    _bRun.disabled = false;
    _bRunIsolate.disabled = false;
  }

  disableButtons() {
    _bRun.disabled = true;
    _bRunIsolate.disabled = true;
  }
  
  takeIsolateResults(sum, orders) {
    _ms2 = new DateTime.now().millisecondsSinceEpoch;
    var et = (_ms2 - _ms1) / 1000;
    logResults("Dart or dart2js Isolate", et, sum, orders, _nZodiacsIsolate);
    if (_nZodiacsIsolate == 11) {
      _totalRunsIsolate11++;
      _accumulatedTimeIsolate11 += et;
    } else if (_nZodiacsIsolate == 12) {
      _totalRunsIsolate12++;
      _accumulatedTimeIsolate12 += et;
    } else { // 13
      _totalRunsIsolate13++;
      _accumulatedTimeIsolate13 += et;
    }
    _isolateRunCounter--;
    if (_isolateRunCounter <= 0) {
      _descStatus.innerHtml = "idle.";
      if (_nZodiacsIsolate == 11) {
        _tdIsolate11.innerHtml = 
            "${formatNumber((_accumulatedTimeIsolate11 / _totalRunsIsolate11))}"
            " secs (${_totalRunsIsolate11})";
      } else if (_nZodiacsIsolate == 12) {
        _tdIsolate12.innerHtml = 
            "${formatNumber((_accumulatedTimeIsolate12 / _totalRunsIsolate12))}"
            " secs (${_totalRunsIsolate12})";
      } else {
        _tdIsolate13.innerHtml = 
            "${formatNumber((_accumulatedTimeIsolate13 / _totalRunsIsolate13))}"
            " secs (${_totalRunsIsolate13})";
      }
      new DA.Timer(new Duration(milliseconds: 100), enableButtons);
    } else {
      new DA.Timer(new Duration(milliseconds: 100), runDartIsolate);
    }
  }
  
  prepareIsolate() {
    var receivePort = new DI.ReceivePort();
    
    receivePort.listen((msg) {
      if (_sendPort == null) {
        // Remember to comment out the following line
        // To avoid the bug of the slow JavaScript code.
        _sendPort = msg;
      } else {
        takeIsolateResults(msg[0], msg[1]);
      }
    });
  
    DI.Isolate.spawnUri(Uri.parse("dart_synergy_calculator_isolate.dart"), [],
        receivePort.sendPort);
  }
  
}


main() {
  var scb = new SynergyCalculatorBench();
}


