app.factory('imagoUtils', function() {
  var CURRENCY_MAPPING, KEYS, SYMBOLS, alphanum;
  KEYS = {
    '16': 'onShift',
    '18': 'onAlt',
    '17': 'onCommand',
    '91': 'onCommand',
    '93': 'onCommand',
    '224': 'onCommand',
    '13': 'onEnter',
    '32': 'onSpace',
    '37': 'onLeft',
    '38': 'onUp',
    '39': 'onRight',
    '40': 'onDown',
    '46': 'onDelete',
    '8': 'onBackspace',
    '9': 'onTab',
    '188': 'onComma',
    '190': 'onPeriod',
    '27': 'onEsc',
    '186': 'onColon',
    '65': 'onA',
    '67': 'onC',
    '86': 'onV',
    '88': 'onX',
    '68': 'onD',
    '187': 'onEqual',
    '189': 'onMinus'
  };
  SYMBOLS = {
    EUR: '&#128;',
    USD: '&#36;',
    SEK: 'SEK',
    YEN: '&#165;',
    GBP: '&#163;',
    GENERIC: '&#164;'
  };
  CURRENCY_MAPPING = {
    "United Arab Emirates": "AED",
    "Afghanistan": "AFN",
    "Albania": "ALL",
    "Armenia": "AMD",
    "Angola": "AOA",
    "Argentina": "ARS",
    "Australia": "AUD",
    "Aruba": "AWG",
    "Azerbaijan": "AZN",
    "Bosnia and Herzegovina": "BAM",
    "Barbados": "BBD",
    "Bangladesh": "BDT",
    "Bulgaria": "BGN",
    "Bahrain": "BHD",
    "Burundi": "BIF",
    "Bermuda": "BMD",
    "Brunei": "BND",
    "Bolivia": "BOB",
    "Brazil": "BRL",
    "Bahamas": "BSD",
    "Bhutan": "BTN",
    "Botswana": "BWP",
    "Belarus": "BYR",
    "Belize": "BZD",
    "Canada": "CAD",
    "Switzerland Franc": "CHF",
    "Chile": "CLP",
    "China": "CNY",
    "Colombia": "COP",
    "Costa Rica": "CRC",
    "Cuba Convertible": "CUC",
    "Cuba Peso": "CUP",
    "Cape Verde": "CVE",
    "Czech Republic": "CZK",
    "Djibouti": "DJF",
    "Denmark": "DKK",
    "Dominican Republic": "DOP",
    "Algeria": "DZD",
    "Egypt": "EGP",
    "Eritrea": "ERN",
    "Ethiopia": "ETB",
    "Autria": "EUR",
    "Fiji": "FJD",
    "United Kingdom": "GBP",
    "Georgia": "GEL",
    "Guernsey": "GGP",
    "Ghana": "GHS",
    "Gibraltar": "GIP",
    "Gambia": "GMD",
    "Guinea": "GNF",
    "Guatemala": "GTQ",
    "Guyana": "GYD",
    "Hong Kong": "HKD",
    "Honduras": "HNL",
    "Croatia": "HRK",
    "Haiti": "HTG",
    "Hungary": "HUF",
    "Indonesia": "IDR",
    "Israel": "ILS",
    "Isle of Man": "IMP",
    "India": "INR",
    "Iraq": "IQD",
    "Iran": "IRR",
    "Iceland": "ISK",
    "Jersey": "JEP",
    "Jamaica": "JMD",
    "Jordan": "JOD",
    "Japan": "JPY",
    "Kenya": "KES",
    "Kyrgyzstan": "KGS",
    "Cambodia": "KHR",
    "Comoros": "KMF",
    "North Korea": "KPW",
    "South Korea": "KRW",
    "Kuwait": "KWD",
    "Cayman Islands": "KYD",
    "Kazakhstan": "KZT",
    "Laos": "LAK",
    "Lebanon": "LBP",
    "Sri Lanka": "LKR",
    "Liberia": "LRD",
    "Lesotho": "LSL",
    "Lithuania": "LTL",
    "Latvia": "LVL",
    "Libya": "LYD",
    "Morocco": "MAD",
    "Moldova": "MDL",
    "Madagascar": "MGA",
    "Macedonia": "MKD",
    "Mongolia": "MNT",
    "Macau": "MOP",
    "Mauritania": "MRO",
    "Mauritius": "MUR",
    "Malawi": "MWK",
    "Mexico": "MXN",
    "Malaysia": "MYR",
    "Mozambique": "MZN",
    "Namibia": "NAD",
    "Nigeria": "NGN",
    "Nicaragua": "NIO",
    "Norway": "NOK",
    "Nepal": "NPR",
    "New Zealand": "NZD",
    "Oman": "OMR",
    "Panama": "PAB",
    "Peru": "PEN",
    "Papua New Guinea": "PGK",
    "Philippines": "PHP",
    "Pakistan": "PKR",
    "Poland": "PLN",
    "Paraguay": "PYG",
    "Qatar": "QAR",
    "Romania": "RON",
    "Serbia": "RSD",
    "Russia": "RUB",
    "Rwanda": "RWF",
    "Saudi Arabia": "SAR",
    "Solomon Islands": "SBD",
    "Seychelles": "SCR",
    "Sudan": "SDG",
    "Sweden": "SEK",
    "Singapore": "SGD",
    "Saint Helena": "SHP",
    "Suriname": "SRD",
    "El Salvador": "SVC",
    "Syria": "SYP",
    "Swaziland": "SZL",
    "Thailand": "THB",
    "Tajikistan": "TJS",
    "Turkmenistan": "TMT",
    "Tunisia": "TND",
    "Tonga": "TOP",
    "Turkey": "TRY",
    "Trinidad and Tobago": "TTD",
    "Tuvalu": "TVD",
    "Taiwan": "TWD",
    "Tanzania": "TZS",
    "Ukraine": "UAH",
    "Uganda": "UGX",
    "United States": "USD",
    "Uruguay": "UYU",
    "Uzbekistan": "UZS",
    "Venezuela": "VEF",
    "Vietnam": "VND",
    "Vanuatu": "VUV",
    "Samoa": "WST",
    "Yemen": "YER",
    "South Africa": "ZAR",
    "Zambia": "ZMW",
    "Zimbabwe": "ZWD",
    "Austria": "EUR",
    "Belgium": "EUR",
    "Bulgaria": "EUR",
    "Croatia": "EUR",
    "Cyprus": "EUR",
    "Czech Republic": "EUR",
    "Denmark": "EUR",
    "Estonia": "EUR",
    "Finland": "EUR",
    "France": "EUR",
    "Germany": "EUR",
    "Greece": "EUR",
    "Hungary": "EUR",
    "Ireland": "EUR",
    "Italy": "EUR",
    "Latvia": "EUR",
    "Lithuania": "EUR",
    "Luxembourg": "EUR",
    "Malta": "EUR",
    "Netherlands": "EUR",
    "Poland": "EUR",
    "Portugal": "EUR",
    "Romania": "EUR",
    "Slovakia": "EUR",
    "Slovenia": "EUR",
    "Spain": "EUR"
  };
  return {
    toType: function(obj) {
      return {}.toString.call(obj).match(/\s([a-zA-Z]+)/)[1].toLowerCase();
    },
    requestAnimationFrame: (function() {
      var request;
      request = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function(callback) {
        return window.setTimeout(callback, 1000 / 60);
      };
      return function(callback) {
        return request.call(window, callback);
      };
    })(),
    cookie: function(name, value) {
      var cookie, _i, _len, _ref;
      if (!value) {
        _ref = document.cookie.split(';');
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          cookie = _ref[_i];
          if (cookie.indexOf(name) === 1) {
            return cookie.split('=')[1];
          }
        }
        return false;
      }
      return document.cookie = "" + name + "=" + value + "; path=/";
    },
    sha: function() {
      var i, possible, text, _i;
      text = '';
      possible = 'abcdefghijklmnopqrstuvwxyz0123456789';
      for (i = _i = 0; _i <= 56; i = ++_i) {
        text += possible.charAt(Math.floor(Math.random() * possible.length));
      }
      return text;
    },
    uuid: function() {
      var S4;
      S4 = function() {
        return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
      };
      return S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4();
    },
    urlify: function(query) {
      return console.log('urlify');
    },
    queryfy: function(url) {
      var facet, filter, key, query, value, _i, _len, _ref;
      query = [];
      _ref = url.split('+');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        filter = _ref[_i];
        filter || (filter = 'collection:/');
        facet = filter.split(':');
        key = facet[0].toLowerCase();
        value = decodeURIComponent(facet[1] || '');
        facet = {};
        facet[key] = value;
        query.push(facet);
      }
      return query;
    },
    pluralize: function(str) {
      return str + 's';
    },
    singularize: function(str) {
      return str.replace(/s$/, '');
    },
    normalize: function(s) {
      var mapping, r, str;
      mapping = {
        'ä': 'ae',
        'ö': 'oe',
        'ü': 'ue',
        '&': 'and',
        'é': 'e',
        'ë': 'e',
        'ï': 'i',
        'è': 'e',
        'à': 'a',
        'ù': 'u',
        'ç': 'c',
        'ø': 'o'
      };
      s = s.toLowerCase();
      r = new RegExp(Object.keys(mapping).join('|'), 'g');
      str = s.trim().replace(r, function(s) {
        return mapping[s];
      }).toLowerCase();
      return str.replace(/[',:;#]/g, '').replace(/[^\/\w]+/g, '-').replace(/\W?\/\W?/g, '\/').replace(/^-|-$/g, '');
    },
    alphaNumSort: alphanum = function(a, b) {
      var aa, bb, c, chunkify, d, x;
      chunkify = function(t) {
        var i, j, m, n, tz, x, y;
        tz = [];
        x = 0;
        y = -1;
        n = 0;
        i = void 0;
        j = void 0;
        while (i = (j = t.charAt(x++)).charCodeAt(0)) {
          m = i === 46 || (i >= 48 && i <= 57);
          if (m !== n) {
            tz[++y] = "";
            n = m;
          }
          tz[y] += j;
        }
        return tz;
      };
      aa = chunkify(a);
      bb = chunkify(b);
      x = 0;
      while (aa[x] && bb[x]) {
        if (aa[x] !== bb[x]) {
          c = Number(aa[x]);
          d = Number(bb[x]);
          if (c === aa[x] && d === bb[x]) {
            return c - d;
          } else {
            return (aa[x] > bb[x] ? 1 : -1);
          }
        }
        x++;
      }
      return aa.length - bb.length;
    },
    isiOS: function() {
      return !!navigator.userAgent.match(/iPad|iPhone|iPod/i);
    },
    isiPad: function() {
      return !!navigator.userAgent.match(/iPad/i);
    },
    isiPhone: function() {
      return !!navigator.userAgent.match(/iPhone/i);
    },
    isiPod: function() {
      return !!navigator.userAgent.match(/iPod/i);
    },
    isChrome: function() {
      return !!navigator.userAgent.match(/Chrome/i);
    },
    isIE: function() {
      return !!navigator.userAgent.match(/MSIE/i);
    },
    isFirefox: function() {
      return !!navigator.userAgent.match(/Firefox/i);
    },
    isOpera: function() {
      return !!navigator.userAgent.match(/Presto/i);
    },
    isSafari: function() {
      return !!navigator.userAgent.match(/Safari/i) && !this.isChrome();
    },
    isEven: function(n) {
      return this.isNumber(n) && (n % 2 === 0);
    },
    isOdd: function(n) {
      return this.isNumber(n) && (n % 2 === 1);
    },
    isNumber: function(n) {
      return n === parseFloat(n);
    },
    toFloat: function(value, decimal) {
      var floats, ints;
      if (decimal == null) {
        decimal = 2;
      }
      if (!decimal) {
        return value;
      }
      value = String(value).replace(/\D/g, '');
      floats = value.slice(value.length - decimal);
      while (floats.length < decimal) {
        floats = '0' + floats;
      }
      ints = value.slice(0, value.length - decimal) || '0';
      return "" + ints + "." + floats;
    },
    toPrice: function(value, currency) {
      var price, symbol;
      price = this.toFloat(value).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
      symbol = this.getCurrencySymbol(currency);
      return "" + symbol + " " + price;
    },
    isEmail: function(value) {
      var pattern;
      pattern = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      return !!value.match(pattern);
    },
    getAssetKind: function(id) {
      var kind;
      if (id.indexOf('Collection-') === 0) {
        kind = 'Collection';
      } else if (id.indexOf('Proxy-') === 0) {
        kind = 'Proxy';
      } else if (id.indexOf('Order-') === 0) {
        kind = 'Order';
      } else if (id.indexOf('Generic') === 0) {
        kind = 'Generic';
      } else if (id.match(/[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}/)) {
        kind = 'Image';
      } else if (id.match(/[0-9a-z]{56}/)) {
        kind = 'Video';
      }
      return kind;
    },
    getKeyName: function(e) {
      return KEYS[e.which];
    },
    getURLParameter: function(name) {
      var regex, results;
      name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
      regex = new RegExp("[\\?&]" + name + "=([^&#]*)");
      results = regex.exec(location.search);
      if (results == null) {
        return "";
      } else {
        return decodeURIComponent(results[1].replace(/\+/g, " "));
      }
    },
    inUsa: function(value) {
      var _ref;
      return (_ref = value != null ? value.toLowerCase() : void 0) === 'usa' || _ref === 'united states' || _ref === 'united states of america';
    },
    getCurrencySymbol: function(currency) {
      return SYMBOLS[currency] || SYMBOLS.GENERIC;
    },
    getCurrency: function(country) {
      return CURRENCY_MAPPING[country];
    }
  };
});