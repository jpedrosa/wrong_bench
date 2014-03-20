library SynergyCalculator;


class SynergyData {
  
  final zodiacs = ["Aquarius", "Aries", "Cancer", "Capricorn", 
    "Gemini", "Leo", "Libra", "Pisces", "Sagittarius", "Scorpio",
    "Taurus", "Virgo"];
  
  final ids = ["aq", "ar", "can", "cap", "ge", "le", "li", "pi", "sa",
    "sc", "ta", "vi"];

  final keys = [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048];
  
  final aqAffinity = [
    "ar", 10,
    "can", 5,
    "cap", -5,
    "ge", 10,
    "le", 0,
    "li", -10,
    "pi", 5,
    "sa", -10,
    "sc", -15,
    "ta", 15,
    "vi", -5,
    ];

  final arAffinity = [
    "aq", 10,
    "can", 15,
    "cap", -15,
    "ge", -10,
    "le", -10,
    "li", 0,
    "pi", -5,
    "sa", 10,
    "sc", -5,
    "ta", 5,
    "vi", 5,
    ];

  final canAffinity = [
    "aq", 5,
    "ar", 15,
    "cap", 0,
    "ge", 5,
    "le", -5,
    "li", -15,
    "pi", -10,
    "sa", -5,
    "sc", 10,
    "ta", 10,
    "vi", -10,
    ];

  final capAffinity = [
    "aq", -5,
    "ar", -15,
    "can", 0,
    "ge", -5,
    "le", 5,
    "li", 15,
    "pi", 10,
    "sa", 5,
    "sc", -10,
    "ta", -10,
    "vi", 10,
    ];

  final geAffinity = [
    "aq", 10,
    "ar", -10,
    "can", 5,
    "cap", -5,
    "le", -10,
    "li", 10,
    "pi", -15,
    "sa", 0,
    "sc", 5,
    "ta", -5,
    "vi", 15,
    ];

  final leAffinity = [
    "aq", 0,
    "ar", -10,
    "can", -5,
    "cap", 5,
    "ge", -10,
    "li", 10,
    "pi", -5,
    "sa", 10,
    "sc", 15,
    "ta", -15,
    "vi", 5,
    ];

  final liAffinity = [
    "aq", -10,
    "ar", 0,
    "can", -15,
    "cap", 15,
    "ge", 10,
    "le", 10,
    "pi", 5,
    "sa", -10,
    "sc", 5,
    "ta", -5,
    "vi", -5,
    ];

  final piAffinity = [
    "aq", 5,
    "ar", -5,
    "can", -10,
    "cap", 10,
    "ge", -15,
    "le", -5,
    "li", 5,
    "sa", 15,
    "sc", 10,
    "ta", -10,
    "vi", 0,
    ];

  final saAffinity = [
    "aq", -10,
    "ar", 10,
    "can", -5,
    "cap", 5,
    "ge", 0,
    "le", 10,
    "li", -10,
    "pi", 15,
    "sc", -5,
    "ta", 5,
    "vi", -15,
    ];

  final scAffinity = [
    "aq", -15,
    "ar", -5,
    "can", 10,
    "cap", -10,
    "ge", 5,
    "le", 15,
    "li", 5,
    "pi", 10,
    "sa", -5,
    "ta", 0,
    "vi", -10,
    ];

  final taAffinity = [
    "aq", 15,
    "ar", 5,
    "can", 10,
    "cap", -10,
    "ge", -5,
    "le", -15,
    "li", -5,
    "pi", -10,
    "sa", 5,
    "sc", 0,
    "vi", 10,
    ];

  final viAffinity = [
    "aq", -5,
    "ar", 5,
    "can", -10,
    "cap", 10,
    "ge", 15,
    "le", 5,
    "li", -5,
    "pi", 0,
    "sa", -15,
    "sc", -10,
    "ta", 10,
    ];
  
  final affinities = {};

  final nameToIdMap = {};

  final idToNameMap = {};
  
  SynergyData() {
    prepareData();
  }
  
  prepareData() {
    var a = ["aq", aqAffinity, "ar", arAffinity, "can", canAffinity,
      "cap", capAffinity, "ge", geAffinity, "le", leAffinity,
      "li", liAffinity, "pi", piAffinity, "sa", saAffinity,
      "sc", scAffinity, "ta", taAffinity, "vi", viAffinity],
      i, len = a.length, h, b, j, jlen;
    for (i = 0; i < len; i += 2) {
      h = {};
      affinities[a[i]] = h;
      b = a[i + 1];
      jlen = b.length;
      for (j = 0; j < jlen; j += 2) {
        h[b[j]] = b[j + 1];
      }
    }
    for (i = 0; i < 12; i++) {
      idToNameMap[ids[i]] = zodiacs[i];
      nameToIdMap[zodiacs[i]] = ids[i];
    }
  }
  
  static var _one;
  
  static get one {
    if (_one == null) {
      _one = new SynergyData();
    }
    return _one;
  }
  
}


class L {
  
  static unique(list) {
    var a = [], i, len = list.length, e;
    for (i = 0; i < len; i++) {
      e = list[i];
      if (a.indexOf(e) < 0) {
        a.add(e);
      }
    }
    return a;
  }
  
}


class SynergyCalculator {
  
  var _bestSum, _aff, _syn, _hero, _valueTable, _results,
    _endIndex = 0, _len = 1000, _teamLen = 10, _sz = 0, _tz = 0, _zodiacOrder,
    _progressMax = 0, _progressMilestone = 0, _progressCounter = 0,
    _progressPercentage = 0, _onProgress;
  
  SynergyCalculator() {
    _syn = SynergyData.one;
    _aff = _syn.affinities;
    prepareValueTable();
    _results = new List(_len);
    for (var i = 0; i < _len; i++) {
      _results[i] = new List(10);
    }
    //_onProgress = new CustomEvent();
  }
  
  getValue(z1, z2) => z1 != z2 ? _aff[z1][z2] : 0;
  
  fillListValues(list) {
    var len = list.length, r = new List.filled(len, 0), n;
    for (var i = 0; i < len - 1; i++) {
      n = getValue(list[i], list[i + 1]);
      r[i] += n;
      r[i + 1] += n;
    }
    if (len == 10) {
      n = getValue(list[0], list[9]);
      r[0] += n;
      r[9] += n;
    }
    return r;
  }
  
  sum(list) {
    return doSum(idsToKeys(list), list.length);
  }
  
  copyResultAt(i, list) {
    var r = _results[i], j;
    for (j = 0; j < _teamLen; j++) {
      r[j] = list[j];
    }
  }
  
  doPermutate(n, list) {
    if (n == 1) {
      var c = doSum(list, _teamLen), best = _bestSum, 
        progressCounter = ++_progressCounter;
      if (c > best) {
        _endIndex = 1;
        copyResultAt(0, list);
        _bestSum = c;
      } else if (c == best) {
        if (_endIndex >= _len) {
          compact();
        }
        copyResultAt(_endIndex, list);
        _endIndex++;
      }
      if (progressCounter > _progressMilestone) {
        _progressPercentage++;
        _progressCounter = 0;
        //_onProgress.signal();
      }
      //p(list);
    } else {
      var i, t, lasti = n - 1;;
      for (var i = 1; i <= n; i++) {
        doPermutate(n - 1, list);
        t = list[n - 1];
        if (n % 2 == 0) {
          list[lasti] = list[i - 1];
          list[i - 1] = t;
        } else {
          list[lasti] = list[0];
          list[0] = t;
        }
      }
    }
  }

  resultKeysToIds(resultKeys) {
    var r, a = [];
    for (r in resultKeys) {
      a.add(keysToIds(r));
    }
    return a;
  }
  
  findBest(list) {
    return resultKeysToIds(doFindBest(idsToKeys(list)));
  }
  
  prepareZodiacOrder(list) {
    var a = L.unique(list);
    a.sort((b, c) => b.compareTo(c));
    _zodiacOrder = a;
  }
  
  orderList(r) {
    var i, j, c, ar = new List(10), n, ci = 0, zodiacOrder = _zodiacOrder,
      leadZodiac = zodiacOrder[ci], on = r.indexOf(leadZodiac);
    while (on < 0) {
      ci++;
      leadZodiac = zodiacOrder[ci];
      on = r.indexOf(leadZodiac);
    }
    n = r.indexOf(leadZodiac, on + 1);
    while (n > 0) {
      i = on;
      j = n;
      for (c = 0; c < 9; c++) {
        i++;
        j++;
        if (i >= 10) {
          i = 0;
        }
        if (j >= 10) {
          j = 0;
        }
        if (r[j] < r[i]) {
          on = n;
        }
      }
      n = r.indexOf(leadZodiac, n + 1);
    }
    i = on;
    for (c = 0; c < 10; c++) {
      ar[c] = r[i];
      i++;
      if (i >= 10) {
        i = 0;
      }
    }
    return ar;
  }
  
  removeDuplicates(a) {
    var b = [], i, len = a.length, c, r = a[0], nr;
    b.add(r);
    for (i = 1; i < len; i++) {
      nr = a[i];
      if (r[0] != nr[0] || r[1] != nr[1] || r[2] != nr[2] || r[3] != nr[3] ||
          r[4] != nr[4] || r[5] != nr[5] || r[6] != nr[6] || r[7] != nr[7] ||
          r[8] != nr[8] || r[9] != nr[9]) {
        b.add(nr);
        r = nr;
      }
    }
    return b;
  }
  
  compact() {
    var a = compactList(_results, _endIndex), ei = a.length, i,
      tlen = _teamLen;
    _endIndex = ei;
    for (i = ei; i < _len; i++) {
      _results[i] = new List(tlen);
    }
  }

  compactList(rr, ei) {
    var i, a = new List(ei);
    for (i = 0; i < ei; i++) {
      a[i] = orderList(rr[i]);
    }
    a.sort((b, c) {
      var n = b[0].compareTo(c[0]), j = 1;
      while (n == 0 && j < 10) {
        n = b[j].compareTo(c[j]);
        j++;
      }
      return n;
    });
    return removeDuplicates(a);
  }
  
  doFindBest(list, [bestSum = -1]) {
    var tlen = list.length, i, maxProgress = 1;
    _teamLen = tlen >= 10 ? 10 : tlen;
    _endIndex = 0;
    _bestSum = bestSum;
    for (i = 2; i <= tlen; i++) {
      maxProgress *= i;
    }
    _progressMax = maxProgress;
    _progressMilestone = maxProgress ~/ 100;
    _progressCounter = 0;
    _progressPercentage = 0;
    prepareZodiacOrder(list);
    doPermutate(list.length, list);
    var ei = _endIndex, rr = _results, a = new List(ei);
    if (tlen < 10) {
      for (i = 0; i < ei; i++) {
        a[i] = rr[i].sublist(0, tlen);
      }
    } else if (ei > 0) {
      a = compactList(rr, ei);
    }
    _progressPercentage = 100;
    //_onProgress.signal();
    return a;
  }
  
  idToKey(s) {
    var r;
    switch (s) {
      case "aq": r = 1; break;
      case "ar": r = 2; break;
      case "can": r = 4; break;
      case "cap": r = 8; break;
      case "ge": r = 16; break;
      case "le": r = 32; break;
      case "li": r = 64; break;
      case "pi": r = 128; break;
      case "sa": r = 256; break;
      case "sc": r = 512; break;
      case "ta": r = 1024; break;
      case "vi": r = 2048; break;
    }
    return r;
  }
  
  idsToKeys(a) {
    var len = a.length, r = new List(len), i;
    for (i = 0; i < len; i++) {
      r[i] = idToKey(a[i]);
    }
    return r;
  }

  keyToId(id) {
    var r;
    switch (id) {
      case 1: r = "aq"; break;
      case 2: r = "ar"; break;
      case 4: r = "can"; break;
      case 8: r = "cap"; break;
      case 16: r = "ge"; break;
      case 32: r = "le"; break;
      case 64: r = "li"; break;
      case 128: r = "pi"; break;
      case 256: r = "sa"; break;
      case 512: r = "sc"; break;
      case 1024: r = "ta"; break;
      case 2048: r = "vi"; break;
    }
    return r;
  }
  
  keysToIds(a) {
    var len = a.length, r = new List(len), i;
    for (i = 0; i < len; i++) {
      r[i] = keyToId(a[i]);
    }
    return r;
  }
  
  prepareValueTable() {
    var ids = ["aq", "ar", "can", "cap", "ge", "le", "li", "pi", "sa",
       "sc", "ta", "vi"], r = new List(4096), id, k, c, ck;
    for (id in ids) {
      k = idToKey(id);
      for (c in ids) {
        ck = idToKey(c);
        if (k != ck) {
          r[k + ck] = _aff[id][c] * 2;
        }
      }
    }
    _valueTable = r;
  }
  
  doCalculate(k1, k2) => k1 != k2 ? _valueTable[k1 + k2] : 0;

  doSum(list, teamLen) {
    var n = 0;
    if (teamLen == 10) {
      n = doSum10(list);
    } else if (teamLen > 2) {
      for (var i = 0; i < teamLen - 1; i++) {
        n += doCalculate(list[i], list[i + 1]);
      }
    } else {
      n = doCalculate(list[0], list[1]);
    }
    return n;
  }
  
  doSum10(list) {
    var vt = _valueTable, k0 = list[0], k1 = list[1], k2 = list[2],
      k3 = list[3], k4 = list[4], k5 = list[5], k6 = list[6],
      k7 = list[7], k8 = list[8], k9 = list[9], sum = 0;
    if (k0 != k9) { sum = vt[k0 + k9]; }
    if (k0 != k1) { sum += vt[k0 + k1]; }
    if (k1 != k2) { sum += vt[k1 + k2]; }
    if (k2 != k3) { sum += vt[k2 + k3]; }
    if (k3 != k4) { sum += vt[k3 + k4]; }
    if (k4 != k5) { sum += vt[k4 + k5]; }
    if (k5 != k6) { sum += vt[k5 + k6]; }
    if (k6 != k7) { sum += vt[k6 + k7]; }
    if (k7 != k8) { sum += vt[k7 + k8]; }
    if (k8 != k9) { sum += vt[k8 + k9]; }
    return sum;
  }
  
  get valueTable => _valueTable;
  
  get bestSum => _bestSum;
  
  get progressMax => _progressMax;
  
  get progressCounter => _progressCounter;
  
  get progressPercentage => _progressPercentage;
  
  get onProgress => _onProgress;
  
  set onProgress(fn()) {
    _onProgress.listen(fn);
  }

  static var _one;
  
  static get one {
    if (_one == null) {
      _one = new SynergyCalculator();
    }
    return _one;
  }
  
}


