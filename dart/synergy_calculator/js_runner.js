
var taLog = document.getElementById("sc_bench_log_ta"),
  zodiacList13 = ["ge", "li", "cap", "li", "le", "sa", "pi", "sa", "ar", "can", "sc", "ta", "aq"],
  bRun = document.getElementById("sc_bench_run_js_port_button"),
  bRunWorker = document.getElementById("sc_bench_run_js_port_worker_button"),
  descStatus = document.getElementById("sc_bench_status"),
  selNumberZodiacs = document.getElementById("sc_bench_number_of_zodiacs_select"),
  selNumberRuns = document.getElementById("sc_bench_number_of_runs_select"),
  td11 = document.getElementById("sc_bench_stats_table_js_port_11"),
  td12 = document.getElementById("sc_bench_stats_table_js_port_12"),
  td13 = document.getElementById("sc_bench_stats_table_js_port_13"),
  tdWorker11 = document.getElementById("sc_bench_stats_table_js_port_worker_11"),
  tdWorker12 = document.getElementById("sc_bench_stats_table_js_port_worker_12"),
  tdWorker13 = document.getElementById("sc_bench_stats_table_js_port_worker_13"),
  bClearLogs = document.getElementById("sc_bench_clear_logs_button"),
  sc = new SynergyCalculator(),
  totalRuns11 = 0, accumulatedTime11 = 0,
  totalRuns12 = 0, accumulatedTime12 = 0,
  totalRuns13 = 0, accumulatedTime13 = 0,
  worker = new Worker("js_port_synergy_calculator_worker.js"),
  totalRunsWorker11 = 0, accumulatedTimeWorker11 = 0,
  totalRunsWorker12 = 0, accumulatedTimeWorker12 = 0,
  totalRunsWorker13 = 0, accumulatedTimeWorker13 = 0,
  ms1, ms2, et, nZodiacsWorker, workerRunCounter = 0;

function log(v) {
  taLog.value = "" + v + "\n" + taLog.value;
  console.log(v);
}

function numberOfZodiacs() {
  return parseInt(selNumberZodiacs.value, 10);
}

function numberOfRuns() {
  return parseInt(selNumberRuns.value, 10);
}

function logResults(desc, et, sum, orders, nZodiacs) {
  var i;
  if (taLog.value.length > 0) {
    log("----------------------------------------");
  }
  for (i = 0; i < orders.length; i++) {
    log(orders[i]);
  }
  log("Best Sum: " + sum + "      Number of Orders: " + orders.length);
  log("Elapsed: " + et + " seconds.");
  log(desc + " run with " + nZodiacs + " zodiacs.");
}

function runJavaScriptPort() {
  var orders, nZodiacs = numberOfZodiacs(),
    nRuns =  parseInt(selNumberRuns.value, 10), i;
  //console.log(sc.doSum([1, 2, 4], 3));
  //console.log(sc.sum(["aq", "ar", "can"]));
  //console.log(sc.doSum([8, 4], 2));
  //console.log(sc.doFindBest([1, 2, 4], -1));
  //console.log(sc.findBest(["aq", "ar", "can"]));
  //console.log(sc.sum(["ge", "li", "cap", "li", "le", "sa", "pi", "sa", "ar", "can"]));
  //console.log(sc.findBest(["ge", "li", "cap", "li", "le", "sa", "pi", "sa", "ar", "can"]));
  //orders = sc.findBest(["ge", "li", "cap", "li", "le", "sa", "pi", "sa", "ar", "can", "sc", "ta"]);
  for (i = 0; i < nRuns; i++) {
    ms1 = new Date().getTime();
    orders = sc.findBest(zodiacList13.slice(0, nZodiacs));
    ms2 = new Date().getTime();
    et = (ms2 - ms1) / 1000;
    logResults("JavaScript Port", et, sc.bestSum(), orders, nZodiacs);
    if (nZodiacs == 11) {
      totalRuns11++;
      accumulatedTime11 += et;
    } else if (nZodiacs == 12) {
      totalRuns12++;
      accumulatedTime12 += et;
    } else { // 13
      totalRuns13++;
      accumulatedTime13 += et;
    }
  }
  descStatus.innerHTML = "idle.";
  if (nZodiacs == 11) {
    td11.innerHTML = "" + formatNumber((accumulatedTime11 / totalRuns11)) + 
      " secs (" + totalRuns11 + ")";
  } else if (nZodiacs == 12) {
    td12.innerHTML = "" + formatNumber((accumulatedTime12 / totalRuns12)) + 
      " secs (" + totalRuns12 + ")";
  } else {
    td13.innerHTML = "" + formatNumber((accumulatedTime13 / totalRuns13)) +
      " secs (" + totalRuns13 + ")";
  }
  setTimeout(enableButtons, 100);
}

bRun.onclick = function () {
  disableButtons();
  descStatus.innerHTML = "running...";
  setTimeout(runJavaScriptPort, 100);
};

function formatNumber(n) {
  return Math.round(n * 100) / 100;
}

bClearLogs.onclick = function() {
  taLog.value = "";
};

function runJavaScriptPortWorker() {
  var zodiacs = zodiacList13.slice(0, nZodiacsWorker);
  ms1 = new Date().getTime();
  worker.postMessage(zodiacs);
}

worker.onmessage = function (ev) {
  ms2 = new Date().getTime();
  et = (ms2 - ms1) / 1000;
  var r = ev.data, sum = r[0], orders = r[1];
  logResults("JavaScript Port Worker", et, sum, orders, nZodiacsWorker);
  if (nZodiacsWorker == 11) {
    totalRunsWorker11++;
    accumulatedTimeWorker11 += et;
  } else if (nZodiacsWorker == 12) {
    totalRunsWorker12++;
    accumulatedTimeWorker12 += et;
  } else { // 13
    totalRunsWorker13++;
    accumulatedTimeWorker13 += et;
  }
  workerRunCounter--;
  if (workerRunCounter <= 0) {
    descStatus.innerHTML = "idle.";
    if (nZodiacsWorker == 11) {
      tdWorker11.innerHTML = "" + formatNumber((accumulatedTimeWorker11 / totalRunsWorker11)) + 
        " secs (" + totalRunsWorker11 + ")";
    } else if (nZodiacsWorker == 12) {
      tdWorker12.innerHTML = "" + formatNumber((accumulatedTimeWorker12 / totalRunsWorker12)) + 
        " secs (" + totalRunsWorker12 + ")";
    } else {
      tdWorker13.innerHTML = "" + formatNumber((accumulatedTimeWorker13 / totalRunsWorker13)) +
        " secs (" + totalRunsWorker13 + ")";
    }
    setTimeout(enableButtons, 100);
  } else {
    setTimeout(runJavaScriptPortWorker, 100);
  }
};

bRunWorker.onclick = function () {
  disableButtons();
  descStatus.innerHTML = "running...";
  nZodiacsWorker = numberOfZodiacs();
  workerRunCounter = numberOfRuns();
  setTimeout(runJavaScriptPortWorker, 100);
};

function disableButtons() {
  bRun.disabled = true;
  bRunWorker.disabled = true;
}

function enableButtons() {
  bRun.disabled = false;
  bRunWorker.disabled = false;
}

