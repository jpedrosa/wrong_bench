

function SynergyData() {
  
  this.zodiacs = ["Aquarius", "Aries", "Cancer", "Capricorn", 
    "Gemini", "Leo", "Libra", "Pisces", "Sagittarius", "Scorpio",
    "Taurus", "Virgo"];
  
  this.ids = ["aq", "ar", "can", "cap", "ge", "le", "li", "pi", "sa",
    "sc", "ta", "vi"];

  this.keys = [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048];
  
  this.aqAffinity = [
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

  this.arAffinity = [
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

  this.canAffinity = [
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

  this.capAffinity = [
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

  this.geAffinity = [
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

  this.leAffinity = [
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

  this.liAffinity = [
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

  this.piAffinity = [
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

  this.saAffinity = [
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

  this.scAffinity = [
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

  this.taAffinity = [
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

  this.viAffinity = [
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
  
  this.affinities = {};

  this.nameToIdMap = {};

  this.idToNameMap = {};

  var that = this;
  
  function prepareData() {
    var a = ["aq", that.aqAffinity, "ar", that.arAffinity, "can", that.canAffinity,
      "cap", that.capAffinity, "ge", that.geAffinity, "le", that.leAffinity,
      "li", that.liAffinity, "pi", that.piAffinity, "sa", that.saAffinity,
      "sc", that.scAffinity, "ta", that.taAffinity, "vi", that.viAffinity],
      i, len = a.length, h, b, j, jlen;
    for (i = 0; i < len; i += 2) {
      h = {};
      that.affinities[a[i]] = h;
      b = a[i + 1];
      jlen = b.length;
      for (j = 0; j < jlen; j += 2) {
        h[b[j]] = b[j + 1];
      }
    }
    for (i = 0; i < 12; i++) {
      that.idToNameMap[that.ids[i]] = that.zodiacs[i];
      that.nameToIdMap[that.zodiacs[i]] = that.ids[i];
    }
  }

  prepareData();

}



var L = {};

L.unique = function(list) {
  var a = [], i, len = list.length, j, jlen = 0, v, b = false;
  for (i = 0; i < len; i++) {
    v = list[i];
    b = false;
    for (j = 0; j < jlen; j++) {
      if (a[j] === v) {
      	b = true;
      	break;
      }
    }
    if (!b) {
      a.push(v);
      jlen++;
    }
  }
  return a;
};



SynergyData._one = null;

SynergyData.one = function() {
  if (SynergyData._one === null) {
    SynergyData._one = new SynergyData();
  }
  return SynergyData._one;
};



function SynergyCalculator() {
  
  this._bestSum = -1;

  this._syn = SynergyData.one();

  this._aff = this._syn.affinities;

  this._valueTable = null;

  this._results = [];

  this._endIndex = 0;

  this._len = 1000;

  this._teamLen = 10;

  this._sz = 0;

  this._tz = 0;

  this._zodiacOrder = null;

  this._progressMax = 0;

  this._progressMilestone = 0;

  this._progressCounter = 0;

  this._progressPercentage = 0;

  this._onProgress = null;

  var that = this;
  
  //prepareValueTable();
  for (var i = 0; i < that._len; i++) {
    that._results[i] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; // List with 10 items
  }

  //_onProgress = new CustomEvent();
  
  this.getValue = function(z1, z2) {
  	return z1 !== z2 ? that._aff[z1][z2] : 0;
  };
  
  this.fillListValues = function(list) {
    var len = list.length, r = [], n;
    for (var i = 0; i < len; i++) {
      r[i] = 0;
    }
    for (var i = 0; i < len - 1; i++) {
      n = that.getValue(list[i], list[i + 1]);
      r[i] += n;
      r[i + 1] += n;
    }
    if (len === 10) {
      n = that.getValue(list[0], list[9]);
      r[0] += n;
      r[9] += n;
    }
    return r;
  };
  
  this.sum = function(list) {
    return that.doSum(that.idsToKeys(list), list.length);
  };
  
  this.copyResultAt = function(i, list) {
    var r = that._results[i], j;
    for (j = 0; j < that._teamLen; j++) {
      r[j] = list[j];
    }
  };
  
  this.doPermutate = function(n, list) {
    if (n === 1) {
      var c = that.doSum(list, that._teamLen), best = that._bestSum, 
        progressCounter = ++that._progressCounter;
      if (c > best) {
        that._endIndex = 1;
        that.copyResultAt(0, list);
        that._bestSum = c;
      } else if (c === best) {
        if (that._endIndex >= that._len) {
          that.compact();
        }
        that.copyResultAt(that._endIndex, list);
        that._endIndex++;
      }
      if (progressCounter > that._progressMilestone) {
        that._progressPercentage++;
        that._progressCounter = 0;
        //that._onProgress.signal();
      }
      //p(list);
    } else {
      var i, t, lasti = n - 1;;
      for (i = 1; i <= n; i++) {
        that.doPermutate(n - 1, list);
        t = list[n - 1];
        if (n % 2 === 0) {
          list[lasti] = list[i - 1];
          list[i - 1] = t;
        } else {
          list[lasti] = list[0];
          list[0] = t;
        }
      }
    }
  };

  this.resultKeysToIds = function(resultKeys) {
    var r, a = [], i, len = resultKeys.length;
    for (i = 0; i < len; i++) {
      r = resultKeys[i];
      a.push(that.keysToIds(r));
    }
    return a;
  };
  
  this.findBest = function(list) {
    return that.resultKeysToIds(that.doFindBest(that.idsToKeys(list)));
  }
  
  this.prepareZodiacOrder = function(list) {
    var a = L.unique(list);
    a.sort(function(b, c) {
      return b - c;
    });
    that._zodiacOrder = a;
  };
  
  this.orderList = function(r) {
    var i, j, c, ar = [], n, ci = 0, zodiacOrder = that._zodiacOrder,
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
      ar.push(r[i]);
      i++;
      if (i >= 10) {
        i = 0;
      }
    }
    return ar;
  };
  
  this.removeDuplicates = function(a) {
    var b = [], i, len = a.length, c, r = a[0], nr;
    b.push(r);
    for (i = 1; i < len; i++) {
      nr = a[i];
      if (r[0] !== nr[0] || r[1] !== nr[1] || r[2] !== nr[2] || r[3] !== nr[3] ||
          r[4] !== nr[4] || r[5] !== nr[5] || r[6] !== nr[6] || r[7] !== nr[7] ||
          r[8] !== nr[8] || r[9] !== nr[9]) {
        b.push(nr);
        r = nr;
      }
    }
    return b;
  };
  
  this.compact = function() {
    var a = that.compactList(that._results, that._endIndex), ei = a.length, i,
      list10 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], tlen = that._teamLen;
    that._endIndex = ei;
    for (i = ei; i < that._len; i++) {
      that._results[i] = list10.slice(0, tlen);
    }
  };

  this.compactList = function(rr, ei) {
    var i, a = [];
    for (i = 0; i < ei; i++) {
      a.push(that.orderList(rr[i]));
    }
    a.sort(function(b, c) {
      var n = b[0] - c[0], j = 1;
      while (n === 0 && j < 10) {
        n = b[j] - c[j];
        j++;
      }
      return n;
    });
    return that.removeDuplicates(a);
  };
  
  this.doFindBest = function(list, bestSum) {
  	if (!bestSum) {
  	  bestSum = -1;
  	}
    var tlen = list.length, i, maxProgress = 1;
    that._teamLen = tlen >= 10 ? 10 : tlen;
    that._endIndex = 0;
    that._bestSum = bestSum;
    for (i = 2; i <= tlen; i++) {
      maxProgress *= i;
    }
    that._progressMax = maxProgress;
    that._progressMilestone = Math.floor(maxProgress / 100);
    that._progressCounter = 0;
    that._progressPercentage = 0;
    that.prepareZodiacOrder(list);
    that.doPermutate(list.length, list);
    var ei = that._endIndex, rr = that._results, a = [];
    if (tlen < 10) {
      for (i = 0; i < ei; i++) {
        a.push(rr[i].slice(0, tlen));
      }
    } else if (ei > 0) {
      a = that.compactList(rr, ei);
    }
    that._progressPercentage = 100;
    //that._onProgress.signal();
    return a;
  };
  
  this.idToKey = function(s) {
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
  };
  
  this.idsToKeys = function(a) {
    var len = a.length, r = [], i;
    for (i = 0; i < len; i++) {
      r.push(that.idToKey(a[i]));
    }
    return r;
  };

  this.keyToId = function(id) {
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
  };
  
  this.keysToIds = function(a) {
    var len = a.length, r = [], i;
    for (i = 0; i < len; i++) {
      r.push(that.keyToId(a[i]));
    }
    return r;
  }
  
  function prepareValueTable() {
    var ids = ["aq", "ar", "can", "cap", "ge", "le", "li", "pi", "sa",
       "sc", "ta", "vi"], r = [], id, k, c, ck, i, j;
    for (i = 0; i < 4096; i++) {
      r[i] = 0;
    }
    for (i = 0; i < 12; i++) {
      id = ids[i];
      k = that.idToKey(id);
      for (j = 0; j < 12; j++) {
      	c = ids[j];
        ck = that.idToKey(c);
        if (k !== ck) {
          r[k + ck] = that._aff[id][c] * 2;
        }
      }
    }
    that._valueTable = r;
  }

  prepareValueTable();

  this.doCalculate = function(k1, k2) {
  	return k1 !== k2 ? that._valueTable[k1 + k2] : 0;
  };

  this.doSum = function(list, teamLen) {
    var n = 0;
    if (teamLen === 10) {
      n = that.doSum10(list);
    } else if (teamLen > 2) {
      for (var i = 0; i < teamLen - 1; i++) {
        n += that.doCalculate(list[i], list[i + 1]);
      }
    } else {
      n = that.doCalculate(list[0], list[1]);
    }
    return n;
  };
  
  this.doSum10 = function(list) {
    var vt = that._valueTable, k0 = list[0], k1 = list[1], k2 = list[2],
      k3 = list[3], k4 = list[4], k5 = list[5], k6 = list[6],
      k7 = list[7], k8 = list[8], k9 = list[9], sum = 0;
    if (k0 !== k9) { sum = vt[k0 + k9]; }
    if (k0 !== k1) { sum += vt[k0 + k1]; }
    if (k1 !== k2) { sum += vt[k1 + k2]; }
    if (k2 !== k3) { sum += vt[k2 + k3]; }
    if (k3 !== k4) { sum += vt[k3 + k4]; }
    if (k4 !== k5) { sum += vt[k4 + k5]; }
    if (k5 !== k6) { sum += vt[k5 + k6]; }
    if (k6 !== k7) { sum += vt[k6 + k7]; }
    if (k7 !== k8) { sum += vt[k7 + k8]; }
    if (k8 !== k9) { sum += vt[k8 + k9]; }
    return sum;
  };
  
  this.valueTable = function() {
  	return that._valueTable;
  };
  
  this.bestSum = function() {
  	return that._bestSum;
  };
  
  this.progressMax = function() {
  	return that._progressMax;
  };
  
  this.progressCounter = function() {
    return that._progressCounter;
  };
  
  this.progressPercentage = function() {
  	return that._progressPercentage;
  };
  
  this.onProgress = function() {
  	return that._onProgress;
  };
  
  this.setOnProgress = function(fn) {
    //that._onProgress.listen(fn);
  };

}


SynergyCalculator._one = null;

SynergyCalculator.one = function() {
  if (SynergyCalculator._one === null) {
    SynergyCalculator._one = new SynergyCalculator();
  }
  return SynergyCalculator._one;
};




self.onmessage = function (ev) {
  var sc = SynergyCalculator.one(), orders = sc.findBest(ev.data, 0);
  postMessage([sc.bestSum(), orders]);
};






