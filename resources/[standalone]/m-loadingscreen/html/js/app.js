(function() {
    var e = {
            9662: function(e, t, n) {
                var r = n(614),
                    o = n(6330),
                    i = TypeError;
                e.exports = function(e) {
                    if (r(e)) return e;
                    throw i(o(e) + " is not a function")
                }
            },
            6077: function(e, t, n) {
                var r = n(614),
                    o = String,
                    i = TypeError;
                e.exports = function(e) {
                    if ("object" == typeof e || r(e)) return e;
                    throw i("Can't set " + o(e) + " as a prototype")
                }
            },
            5787: function(e, t, n) {
                var r = n(7976),
                    o = TypeError;
                e.exports = function(e, t) {
                    if (r(t, e)) return e;
                    throw o("Incorrect invocation")
                }
            },
            9670: function(e, t, n) {
                var r = n(111),
                    o = String,
                    i = TypeError;
                e.exports = function(e) {
                    if (r(e)) return e;
                    throw i(o(e) + " is not an object")
                }
            },
            1318: function(e, t, n) {
                var r = n(5656),
                    o = n(1400),
                    i = n(6244),
                    a = function(e) {
                        return function(t, n, a) {
                            var s, l = r(t),
                                c = i(l),
                                d = o(a, c);
                            if (e && n != n) {
                                while (c > d)
                                    if (s = l[d++], s != s) return !0
                            } else
                                for (; c > d; d++)
                                    if ((e || d in l) && l[d] === n) return e || d || 0;
                            return !e && -1
                        }
                    };
                e.exports = {
                    includes: a(!0),
                    indexOf: a(!1)
                }
            },
            3658: function(e, t, n) {
                "use strict";
                var r = n(9781),
                    o = n(3157),
                    i = TypeError,
                    a = Object.getOwnPropertyDescriptor,
                    s = r && ! function() {
                        if (void 0 !== this) return !0;
                        try {
                            Object.defineProperty([], "length", {
                                writable: !1
                            }).length = 1
                        } catch (e) {
                            return e instanceof TypeError
                        }
                    }();
                e.exports = s ? function(e, t) {
                    if (o(e) && !a(e, "length").writable) throw i("Cannot set read only .length");
                    return e.length = t
                } : function(e, t) {
                    return e.length = t
                }
            },
            4326: function(e, t, n) {
                var r = n(1702),
                    o = r({}.toString),
                    i = r("".slice);
                e.exports = function(e) {
                    return i(o(e), 8, -1)
                }
            },
            648: function(e, t, n) {
                var r = n(1694),
                    o = n(614),
                    i = n(4326),
                    a = n(5112),
                    s = a("toStringTag"),
                    l = Object,
                    c = "Arguments" == i(function() {
                        return arguments
                    }()),
                    d = function(e, t) {
                        try {
                            return e[t]
                        } catch (n) {}
                    };
                e.exports = r ? i : function(e) {
                    var t, n, r;
                    return void 0 === e ? "Undefined" : null === e ? "Null" : "string" == typeof(n = d(t = l(e), s)) ? n : c ? i(t) : "Object" == (r = i(t)) && o(t.callee) ? "Arguments" : r
                }
            },
            9920: function(e, t, n) {
                var r = n(2597),
                    o = n(3887),
                    i = n(1236),
                    a = n(3070);
                e.exports = function(e, t, n) {
                    for (var s = o(t), l = a.f, c = i.f, d = 0; d < s.length; d++) {
                        var u = s[d];
                        r(e, u) || n && r(n, u) || l(e, u, c(t, u))
                    }
                }
            },
            8880: function(e, t, n) {
                var r = n(9781),
                    o = n(3070),
                    i = n(9114);
                e.exports = r ? function(e, t, n) {
                    return o.f(e, t, i(1, n))
                } : function(e, t, n) {
                    return e[t] = n, e
                }
            },
            9114: function(e) {
                e.exports = function(e, t) {
                    return {
                        enumerable: !(1 & e),
                        configurable: !(2 & e),
                        writable: !(4 & e),
                        value: t
                    }
                }
            },
            8052: function(e, t, n) {
                var r = n(614),
                    o = n(3070),
                    i = n(6339),
                    a = n(3072);
                e.exports = function(e, t, n, s) {
                    s || (s = {});
                    var l = s.enumerable,
                        c = void 0 !== s.name ? s.name : t;
                    if (r(n) && i(n, c, s), s.global) l ? e[t] = n : a(t, n);
                    else {
                        try {
                            s.unsafe ? e[t] && (l = !0) : delete e[t]
                        } catch (d) {}
                        l ? e[t] = n : o.f(e, t, {
                            value: n,
                            enumerable: !1,
                            configurable: !s.nonConfigurable,
                            writable: !s.nonWritable
                        })
                    }
                    return e
                }
            },
            3072: function(e, t, n) {
                var r = n(7854),
                    o = Object.defineProperty;
                e.exports = function(e, t) {
                    try {
                        o(r, e, {
                            value: t,
                            configurable: !0,
                            writable: !0
                        })
                    } catch (n) {
                        r[e] = t
                    }
                    return t
                }
            },
            5117: function(e, t, n) {
                "use strict";
                var r = n(6330),
                    o = TypeError;
                e.exports = function(e, t) {
                    if (!delete e[t]) throw o("Cannot delete property " + r(t) + " of " + r(e))
                }
            },
            9781: function(e, t, n) {
                var r = n(7293);
                e.exports = !r((function() {
                    return 7 != Object.defineProperty({}, 1, {
                        get: function() {
                            return 7
                        }
                    })[1]
                }))
            },
            4154: function(e) {
                var t = "object" == typeof document && document.all,
                    n = "undefined" == typeof t && void 0 !== t;
                e.exports = {
                    all: t,
                    IS_HTMLDDA: n
                }
            },
            317: function(e, t, n) {
                var r = n(7854),
                    o = n(111),
                    i = r.document,
                    a = o(i) && o(i.createElement);
                e.exports = function(e) {
                    return a ? i.createElement(e) : {}
                }
            },
            7207: function(e) {
                var t = TypeError,
                    n = 9007199254740991;
                e.exports = function(e) {
                    if (e > n) throw t("Maximum allowed index exceeded");
                    return e
                }
            },
            3678: function(e) {
                e.exports = {
                    IndexSizeError: {
                        s: "INDEX_SIZE_ERR",
                        c: 1,
                        m: 1
                    },
                    DOMStringSizeError: {
                        s: "DOMSTRING_SIZE_ERR",
                        c: 2,
                        m: 0
                    },
                    HierarchyRequestError: {
                        s: "HIERARCHY_REQUEST_ERR",
                        c: 3,
                        m: 1
                    },
                    WrongDocumentError: {
                        s: "WRONG_DOCUMENT_ERR",
                        c: 4,
                        m: 1
                    },
                    InvalidCharacterError: {
                        s: "INVALID_CHARACTER_ERR",
                        c: 5,
                        m: 1
                    },
                    NoDataAllowedError: {
                        s: "NO_DATA_ALLOWED_ERR",
                        c: 6,
                        m: 0
                    },
                    NoModificationAllowedError: {
                        s: "NO_MODIFICATION_ALLOWED_ERR",
                        c: 7,
                        m: 1
                    },
                    NotFoundError: {
                        s: "NOT_FOUND_ERR",
                        c: 8,
                        m: 1
                    },
                    NotSupportedError: {
                        s: "NOT_SUPPORTED_ERR",
                        c: 9,
                        m: 1
                    },
                    InUseAttributeError: {
                        s: "INUSE_ATTRIBUTE_ERR",
                        c: 10,
                        m: 1
                    },
                    InvalidStateError: {
                        s: "INVALID_STATE_ERR",
                        c: 11,
                        m: 1
                    },
                    SyntaxError: {
                        s: "SYNTAX_ERR",
                        c: 12,
                        m: 1
                    },
                    InvalidModificationError: {
                        s: "INVALID_MODIFICATION_ERR",
                        c: 13,
                        m: 1
                    },
                    NamespaceError: {
                        s: "NAMESPACE_ERR",
                        c: 14,
                        m: 1
                    },
                    InvalidAccessError: {
                        s: "INVALID_ACCESS_ERR",
                        c: 15,
                        m: 1
                    },
                    ValidationError: {
                        s: "VALIDATION_ERR",
                        c: 16,
                        m: 0
                    },
                    TypeMismatchError: {
                        s: "TYPE_MISMATCH_ERR",
                        c: 17,
                        m: 1
                    },
                    SecurityError: {
                        s: "SECURITY_ERR",
                        c: 18,
                        m: 1
                    },
                    NetworkError: {
                        s: "NETWORK_ERR",
                        c: 19,
                        m: 1
                    },
                    AbortError: {
                        s: "ABORT_ERR",
                        c: 20,
                        m: 1
                    },
                    URLMismatchError: {
                        s: "URL_MISMATCH_ERR",
                        c: 21,
                        m: 1
                    },
                    QuotaExceededError: {
                        s: "QUOTA_EXCEEDED_ERR",
                        c: 22,
                        m: 1
                    },
                    TimeoutError: {
                        s: "TIMEOUT_ERR",
                        c: 23,
                        m: 1
                    },
                    InvalidNodeTypeError: {
                        s: "INVALID_NODE_TYPE_ERR",
                        c: 24,
                        m: 1
                    },
                    DataCloneError: {
                        s: "DATA_CLONE_ERR",
                        c: 25,
                        m: 1
                    }
                }
            },
            8113: function(e, t, n) {
                var r = n(5005);
                e.exports = r("navigator", "userAgent") || ""
            },
            7392: function(e, t, n) {
                var r, o, i = n(7854),
                    a = n(8113),
                    s = i.process,
                    l = i.Deno,
                    c = s && s.versions || l && l.version,
                    d = c && c.v8;
                d && (r = d.split("."), o = r[0] > 0 && r[0] < 4 ? 1 : +(r[0] + r[1])), !o && a && (r = a.match(/Edge\/(\d+)/), (!r || r[1] >= 74) && (r = a.match(/Chrome\/(\d+)/), r && (o = +r[1]))), e.exports = o
            },
            748: function(e) {
                e.exports = ["constructor", "hasOwnProperty", "isPrototypeOf", "propertyIsEnumerable", "toLocaleString", "toString", "valueOf"]
            },
            1060: function(e, t, n) {
                var r = n(1702),
                    o = Error,
                    i = r("".replace),
                    a = function(e) {
                        return String(o(e).stack)
                    }("zxcasd"),
                    s = /\n\s*at [^:]*:[^\n]*/,
                    l = s.test(a);
                e.exports = function(e, t) {
                    if (l && "string" == typeof e && !o.prepareStackTrace)
                        while (t--) e = i(e, s, "");
                    return e
                }
            },
            2109: function(e, t, n) {
                var r = n(7854),
                    o = n(1236).f,
                    i = n(8880),
                    a = n(8052),
                    s = n(3072),
                    l = n(9920),
                    c = n(4705);
                e.exports = function(e, t) {
                    var n, d, u, p, f, h, g = e.target,
                        v = e.global,
                        m = e.stat;
                    if (d = v ? r : m ? r[g] || s(g, {}) : (r[g] || {}).prototype, d)
                        for (u in t) {
                            if (f = t[u], e.dontCallGetSet ? (h = o(d, u), p = h && h.value) : p = d[u], n = c(v ? u : g + (m ? "." : "#") + u, e.forced), !n && void 0 !== p) {
                                if (typeof f == typeof p) continue;
                                l(f, p)
                            }(e.sham || p && p.sham) && i(f, "sham", !0), a(d, u, f, e)
                        }
                }
            },
            7293: function(e) {
                e.exports = function(e) {
                    try {
                        return !!e()
                    } catch (t) {
                        return !0
                    }
                }
            },
            4374: function(e, t, n) {
                var r = n(7293);
                e.exports = !r((function() {
                    var e = function() {}.bind();
                    return "function" != typeof e || e.hasOwnProperty("prototype")
                }))
            },
            6916: function(e, t, n) {
                var r = n(4374),
                    o = Function.prototype.call;
                e.exports = r ? o.bind(o) : function() {
                    return o.apply(o, arguments)
                }
            },
            6530: function(e, t, n) {
                var r = n(9781),
                    o = n(2597),
                    i = Function.prototype,
                    a = r && Object.getOwnPropertyDescriptor,
                    s = o(i, "name"),
                    l = s && "something" === function() {}.name,
                    c = s && (!r || r && a(i, "name").configurable);
                e.exports = {
                    EXISTS: s,
                    PROPER: l,
                    CONFIGURABLE: c
                }
            },
            1702: function(e, t, n) {
                var r = n(4374),
                    o = Function.prototype,
                    i = o.call,
                    a = r && o.bind.bind(i, i);
                e.exports = r ? a : function(e) {
                    return function() {
                        return i.apply(e, arguments)
                    }
                }
            },
            5005: function(e, t, n) {
                var r = n(7854),
                    o = n(614),
                    i = function(e) {
                        return o(e) ? e : void 0
                    };
                e.exports = function(e, t) {
                    return arguments.length < 2 ? i(r[e]) : r[e] && r[e][t]
                }
            },
            8173: function(e, t, n) {
                var r = n(9662),
                    o = n(8554);
                e.exports = function(e, t) {
                    var n = e[t];
                    return o(n) ? void 0 : r(n)
                }
            },
            7854: function(e, t, n) {
                var r = function(e) {
                    return e && e.Math == Math && e
                };
                e.exports = r("object" == typeof globalThis && globalThis) || r("object" == typeof window && window) || r("object" == typeof self && self) || r("object" == typeof n.g && n.g) || function() {
                    return this
                }() || Function("return this")()
            },
            2597: function(e, t, n) {
                var r = n(1702),
                    o = n(7908),
                    i = r({}.hasOwnProperty);
                e.exports = Object.hasOwn || function(e, t) {
                    return i(o(e), t)
                }
            },
            3501: function(e) {
                e.exports = {}
            },
            4664: function(e, t, n) {
                var r = n(9781),
                    o = n(7293),
                    i = n(317);
                e.exports = !r && !o((function() {
                    return 7 != Object.defineProperty(i("div"), "a", {
                        get: function() {
                            return 7
                        }
                    }).a
                }))
            },
            8361: function(e, t, n) {
                var r = n(1702),
                    o = n(7293),
                    i = n(4326),
                    a = Object,
                    s = r("".split);
                e.exports = o((function() {
                    return !a("z").propertyIsEnumerable(0)
                })) ? function(e) {
                    return "String" == i(e) ? s(e, "") : a(e)
                } : a
            },
            9587: function(e, t, n) {
                var r = n(614),
                    o = n(111),
                    i = n(7674);
                e.exports = function(e, t, n) {
                    var a, s;
                    return i && r(a = t.constructor) && a !== n && o(s = a.prototype) && s !== n.prototype && i(e, s), e
                }
            },
            2788: function(e, t, n) {
                var r = n(1702),
                    o = n(614),
                    i = n(5465),
                    a = r(Function.toString);
                o(i.inspectSource) || (i.inspectSource = function(e) {
                    return a(e)
                }), e.exports = i.inspectSource
            },
            9909: function(e, t, n) {
                var r, o, i, a = n(4811),
                    s = n(7854),
                    l = n(111),
                    c = n(8880),
                    d = n(2597),
                    u = n(5465),
                    p = n(6200),
                    f = n(3501),
                    h = "Object already initialized",
                    g = s.TypeError,
                    v = s.WeakMap,
                    m = function(e) {
                        return i(e) ? o(e) : r(e, {})
                    },
                    y = function(e) {
                        return function(t) {
                            var n;
                            if (!l(t) || (n = o(t)).type !== e) throw g("Incompatible receiver, " + e + " required");
                            return n
                        }
                    };
                if (a || u.state) {
                    var b = u.state || (u.state = new v);
                    b.get = b.get, b.has = b.has, b.set = b.set, r = function(e, t) {
                        if (b.has(e)) throw g(h);
                        return t.facade = e, b.set(e, t), t
                    }, o = function(e) {
                        return b.get(e) || {}
                    }, i = function(e) {
                        return b.has(e)
                    }
                } else {
                    var w = p("state");
                    f[w] = !0, r = function(e, t) {
                        if (d(e, w)) throw g(h);
                        return t.facade = e, c(e, w, t), t
                    }, o = function(e) {
                        return d(e, w) ? e[w] : {}
                    }, i = function(e) {
                        return d(e, w)
                    }
                }
                e.exports = {
                    set: r,
                    get: o,
                    has: i,
                    enforce: m,
                    getterFor: y
                }
            },
            3157: function(e, t, n) {
                var r = n(4326);
                e.exports = Array.isArray || function(e) {
                    return "Array" == r(e)
                }
            },
            614: function(e, t, n) {
                var r = n(4154),
                    o = r.all;
                e.exports = r.IS_HTMLDDA ? function(e) {
                    return "function" == typeof e || e === o
                } : function(e) {
                    return "function" == typeof e
                }
            },
            4705: function(e, t, n) {
                var r = n(7293),
                    o = n(614),
                    i = /#|\.prototype\./,
                    a = function(e, t) {
                        var n = l[s(e)];
                        return n == d || n != c && (o(t) ? r(t) : !!t)
                    },
                    s = a.normalize = function(e) {
                        return String(e).replace(i, ".").toLowerCase()
                    },
                    l = a.data = {},
                    c = a.NATIVE = "N",
                    d = a.POLYFILL = "P";
                e.exports = a
            },
            8554: function(e) {
                e.exports = function(e) {
                    return null === e || void 0 === e
                }
            },
            111: function(e, t, n) {
                var r = n(614),
                    o = n(4154),
                    i = o.all;
                e.exports = o.IS_HTMLDDA ? function(e) {
                    return "object" == typeof e ? null !== e : r(e) || e === i
                } : function(e) {
                    return "object" == typeof e ? null !== e : r(e)
                }
            },
            1913: function(e) {
                e.exports = !1
            },
            2190: function(e, t, n) {
                var r = n(5005),
                    o = n(614),
                    i = n(7976),
                    a = n(3307),
                    s = Object;
                e.exports = a ? function(e) {
                    return "symbol" == typeof e
                } : function(e) {
                    var t = r("Symbol");
                    return o(t) && i(t.prototype, s(e))
                }
            },
            6244: function(e, t, n) {
                var r = n(7466);
                e.exports = function(e) {
                    return r(e.length)
                }
            },
            6339: function(e, t, n) {
                var r = n(7293),
                    o = n(614),
                    i = n(2597),
                    a = n(9781),
                    s = n(6530).CONFIGURABLE,
                    l = n(2788),
                    c = n(9909),
                    d = c.enforce,
                    u = c.get,
                    p = Object.defineProperty,
                    f = a && !r((function() {
                        return 8 !== p((function() {}), "length", {
                            value: 8
                        }).length
                    })),
                    h = String(String).split("String"),
                    g = e.exports = function(e, t, n) {
                        "Symbol(" === String(t).slice(0, 7) && (t = "[" + String(t).replace(/^Symbol\(([^)]*)\)/, "$1") + "]"), n && n.getter && (t = "get " + t), n && n.setter && (t = "set " + t), (!i(e, "name") || s && e.name !== t) && (a ? p(e, "name", {
                            value: t,
                            configurable: !0
                        }) : e.name = t), f && n && i(n, "arity") && e.length !== n.arity && p(e, "length", {
                            value: n.arity
                        });
                        try {
                            n && i(n, "constructor") && n.constructor ? a && p(e, "prototype", {
                                writable: !1
                            }) : e.prototype && (e.prototype = void 0)
                        } catch (o) {}
                        var r = d(e);
                        return i(r, "source") || (r.source = h.join("string" == typeof t ? t : "")), e
                    };
                Function.prototype.toString = g((function() {
                    return o(this) && u(this).source || l(this)
                }), "toString")
            },
            4758: function(e) {
                var t = Math.ceil,
                    n = Math.floor;
                e.exports = Math.trunc || function(e) {
                    var r = +e;
                    return (r > 0 ? n : t)(r)
                }
            },
            6277: function(e, t, n) {
                var r = n(1340);
                e.exports = function(e, t) {
                    return void 0 === e ? arguments.length < 2 ? "" : t : r(e)
                }
            },
            3070: function(e, t, n) {
                var r = n(9781),
                    o = n(4664),
                    i = n(3353),
                    a = n(9670),
                    s = n(4948),
                    l = TypeError,
                    c = Object.defineProperty,
                    d = Object.getOwnPropertyDescriptor,
                    u = "enumerable",
                    p = "configurable",
                    f = "writable";
                t.f = r ? i ? function(e, t, n) {
                    if (a(e), t = s(t), a(n), "function" === typeof e && "prototype" === t && "value" in n && f in n && !n[f]) {
                        var r = d(e, t);
                        r && r[f] && (e[t] = n.value, n = {
                            configurable: p in n ? n[p] : r[p],
                            enumerable: u in n ? n[u] : r[u],
                            writable: !1
                        })
                    }
                    return c(e, t, n)
                } : c : function(e, t, n) {
                    if (a(e), t = s(t), a(n), o) try {
                        return c(e, t, n)
                    } catch (r) {}
                    if ("get" in n || "set" in n) throw l("Accessors not supported");
                    return "value" in n && (e[t] = n.value), e
                }
            },
            1236: function(e, t, n) {
                var r = n(9781),
                    o = n(6916),
                    i = n(5296),
                    a = n(9114),
                    s = n(5656),
                    l = n(4948),
                    c = n(2597),
                    d = n(4664),
                    u = Object.getOwnPropertyDescriptor;
                t.f = r ? u : function(e, t) {
                    if (e = s(e), t = l(t), d) try {
                        return u(e, t)
                    } catch (n) {}
                    if (c(e, t)) return a(!o(i.f, e, t), e[t])
                }
            },
            8006: function(e, t, n) {
                var r = n(6324),
                    o = n(748),
                    i = o.concat("length", "prototype");
                t.f = Object.getOwnPropertyNames || function(e) {
                    return r(e, i)
                }
            },
            5181: function(e, t) {
                t.f = Object.getOwnPropertySymbols
            },
            7976: function(e, t, n) {
                var r = n(1702);
                e.exports = r({}.isPrototypeOf)
            },
            6324: function(e, t, n) {
                var r = n(1702),
                    o = n(2597),
                    i = n(5656),
                    a = n(1318).indexOf,
                    s = n(3501),
                    l = r([].push);
                e.exports = function(e, t) {
                    var n, r = i(e),
                        c = 0,
                        d = [];
                    for (n in r) !o(s, n) && o(r, n) && l(d, n);
                    while (t.length > c) o(r, n = t[c++]) && (~a(d, n) || l(d, n));
                    return d
                }
            },
            5296: function(e, t) {
                "use strict";
                var n = {}.propertyIsEnumerable,
                    r = Object.getOwnPropertyDescriptor,
                    o = r && !n.call({
                        1: 2
                    }, 1);
                t.f = o ? function(e) {
                    var t = r(this, e);
                    return !!t && t.enumerable
                } : n
            },
            7674: function(e, t, n) {
                var r = n(1702),
                    o = n(9670),
                    i = n(6077);
                e.exports = Object.setPrototypeOf || ("__proto__" in {} ? function() {
                    var e, t = !1,
                        n = {};
                    try {
                        e = r(Object.getOwnPropertyDescriptor(Object.prototype, "__proto__").set), e(n, []), t = n instanceof Array
                    } catch (a) {}
                    return function(n, r) {
                        return o(n), i(r), t ? e(n, r) : n.__proto__ = r, n
                    }
                }() : void 0)
            },
            2140: function(e, t, n) {
                var r = n(6916),
                    o = n(614),
                    i = n(111),
                    a = TypeError;
                e.exports = function(e, t) {
                    var n, s;
                    if ("string" === t && o(n = e.toString) && !i(s = r(n, e))) return s;
                    if (o(n = e.valueOf) && !i(s = r(n, e))) return s;
                    if ("string" !== t && o(n = e.toString) && !i(s = r(n, e))) return s;
                    throw a("Can't convert object to primitive value")
                }
            },
            3887: function(e, t, n) {
                var r = n(5005),
                    o = n(1702),
                    i = n(8006),
                    a = n(5181),
                    s = n(9670),
                    l = o([].concat);
                e.exports = r("Reflect", "ownKeys") || function(e) {
                    var t = i.f(s(e)),
                        n = a.f;
                    return n ? l(t, n(e)) : t
                }
            },
            4488: function(e, t, n) {
                var r = n(8554),
                    o = TypeError;
                e.exports = function(e) {
                    if (r(e)) throw o("Can't call method on " + e);
                    return e
                }
            },
            6200: function(e, t, n) {
                var r = n(2309),
                    o = n(9711),
                    i = r("keys");
                e.exports = function(e) {
                    return i[e] || (i[e] = o(e))
                }
            },
            5465: function(e, t, n) {
                var r = n(7854),
                    o = n(3072),
                    i = "__core-js_shared__",
                    a = r[i] || o(i, {});
                e.exports = a
            },
            2309: function(e, t, n) {
                var r = n(1913),
                    o = n(5465);
                (e.exports = function(e, t) {
                    return o[e] || (o[e] = void 0 !== t ? t : {})
                })("versions", []).push({
                    version: "3.26.1",
                    mode: r ? "pure" : "global",
                    copyright: "© 2014-2022 Denis Pushkarev (zloirock.ru)",
                    license: "https://github.com/zloirock/core-js/blob/v3.26.1/LICENSE",
                    source: "https://github.com/zloirock/core-js"
                })
            },
            6293: function(e, t, n) {
                var r = n(7392),
                    o = n(7293);
                e.exports = !!Object.getOwnPropertySymbols && !o((function() {
                    var e = Symbol();
                    return !String(e) || !(Object(e) instanceof Symbol) || !Symbol.sham && r && r < 41
                }))
            },
            1400: function(e, t, n) {
                var r = n(9303),
                    o = Math.max,
                    i = Math.min;
                e.exports = function(e, t) {
                    var n = r(e);
                    return n < 0 ? o(n + t, 0) : i(n, t)
                }
            },
            5656: function(e, t, n) {
                var r = n(8361),
                    o = n(4488);
                e.exports = function(e) {
                    return r(o(e))
                }
            },
            9303: function(e, t, n) {
                var r = n(4758);
                e.exports = function(e) {
                    var t = +e;
                    return t !== t || 0 === t ? 0 : r(t)
                }
            },
            7466: function(e, t, n) {
                var r = n(9303),
                    o = Math.min;
                e.exports = function(e) {
                    return e > 0 ? o(r(e), 9007199254740991) : 0
                }
            },
            7908: function(e, t, n) {
                var r = n(4488),
                    o = Object;
                e.exports = function(e) {
                    return o(r(e))
                }
            },
            7593: function(e, t, n) {
                var r = n(6916),
                    o = n(111),
                    i = n(2190),
                    a = n(8173),
                    s = n(2140),
                    l = n(5112),
                    c = TypeError,
                    d = l("toPrimitive");
                e.exports = function(e, t) {
                    if (!o(e) || i(e)) return e;
                    var n, l = a(e, d);
                    if (l) {
                        if (void 0 === t && (t = "default"), n = r(l, e, t), !o(n) || i(n)) return n;
                        throw c("Can't convert object to primitive value")
                    }
                    return void 0 === t && (t = "number"), s(e, t)
                }
            },
            4948: function(e, t, n) {
                var r = n(7593),
                    o = n(2190);
                e.exports = function(e) {
                    var t = r(e, "string");
                    return o(t) ? t : t + ""
                }
            },
            1694: function(e, t, n) {
                var r = n(5112),
                    o = r("toStringTag"),
                    i = {};
                i[o] = "z", e.exports = "[object z]" === String(i)
            },
            1340: function(e, t, n) {
                var r = n(648),
                    o = String;
                e.exports = function(e) {
                    if ("Symbol" === r(e)) throw TypeError("Cannot convert a Symbol value to a string");
                    return o(e)
                }
            },
            6330: function(e) {
                var t = String;
                e.exports = function(e) {
                    try {
                        return t(e)
                    } catch (n) {
                        return "Object"
                    }
                }
            },
            9711: function(e, t, n) {
                var r = n(1702),
                    o = 0,
                    i = Math.random(),
                    a = r(1..toString);
                e.exports = function(e) {
                    return "Symbol(" + (void 0 === e ? "" : e) + ")_" + a(++o + i, 36)
                }
            },
            3307: function(e, t, n) {
                var r = n(6293);
                e.exports = r && !Symbol.sham && "symbol" == typeof Symbol.iterator
            },
            3353: function(e, t, n) {
                var r = n(9781),
                    o = n(7293);
                e.exports = r && o((function() {
                    return 42 != Object.defineProperty((function() {}), "prototype", {
                        value: 42,
                        writable: !1
                    }).prototype
                }))
            },
            4811: function(e, t, n) {
                var r = n(7854),
                    o = n(614),
                    i = r.WeakMap;
                e.exports = o(i) && /native code/.test(String(i))
            },
            5112: function(e, t, n) {
                var r = n(7854),
                    o = n(2309),
                    i = n(2597),
                    a = n(9711),
                    s = n(6293),
                    l = n(3307),
                    c = o("wks"),
                    d = r.Symbol,
                    u = d && d["for"],
                    p = l ? d : d && d.withoutSetter || a;
                e.exports = function(e) {
                    if (!i(c, e) || !s && "string" != typeof c[e]) {
                        var t = "Symbol." + e;
                        s && i(d, e) ? c[e] = d[e] : c[e] = l && u ? u(t) : p(t)
                    }
                    return c[e]
                }
            },
            7658: function(e, t, n) {
                "use strict";
                var r = n(2109),
                    o = n(7908),
                    i = n(6244),
                    a = n(3658),
                    s = n(7207),
                    l = n(7293),
                    c = l((function() {
                        return 4294967297 !== [].push.call({
                            length: 4294967296
                        }, 1)
                    })),
                    d = ! function() {
                        try {
                            Object.defineProperty([], "length", {
                                writable: !1
                            }).push()
                        } catch (e) {
                            return e instanceof TypeError
                        }
                    }();
                r({
                    target: "Array",
                    proto: !0,
                    arity: 1,
                    forced: c || d
                }, {
                    push: function(e) {
                        var t = o(this),
                            n = i(t),
                            r = arguments.length;
                        s(n + r);
                        for (var l = 0; l < r; l++) t[n] = arguments[l], n++;
                        return a(t, n), n
                    }
                })
            },
            541: function(e, t, n) {
                "use strict";
                var r = n(2109),
                    o = n(7908),
                    i = n(6244),
                    a = n(3658),
                    s = n(5117),
                    l = n(7207),
                    c = 1 !== [].unshift(0),
                    d = ! function() {
                        try {
                            Object.defineProperty([], "length", {
                                writable: !1
                            }).unshift()
                        } catch (e) {
                            return e instanceof TypeError
                        }
                    }();
                r({
                    target: "Array",
                    proto: !0,
                    arity: 1,
                    forced: c || d
                }, {
                    unshift: function(e) {
                        var t = o(this),
                            n = i(t),
                            r = arguments.length;
                        if (r) {
                            l(n + r);
                            var c = n;
                            while (c--) {
                                var d = c + r;
                                c in t ? t[d] = t[c] : s(t, d)
                            }
                            for (var u = 0; u < r; u++) t[u] = arguments[u]
                        }
                        return a(t, n + r)
                    }
                })
            },
            2801: function(e, t, n) {
                "use strict";
                var r = n(2109),
                    o = n(7854),
                    i = n(5005),
                    a = n(9114),
                    s = n(3070).f,
                    l = n(2597),
                    c = n(5787),
                    d = n(9587),
                    u = n(6277),
                    p = n(3678),
                    f = n(1060),
                    h = n(9781),
                    g = n(1913),
                    v = "DOMException",
                    m = i("Error"),
                    y = i(v),
                    b = function() {
                        c(this, w);
                        var e = arguments.length,
                            t = u(e < 1 ? void 0 : arguments[0]),
                            n = u(e < 2 ? void 0 : arguments[1], "Error"),
                            r = new y(t, n),
                            o = m(t);
                        return o.name = v, s(r, "stack", a(1, f(o.stack, 1))), d(r, this, b), r
                    },
                    w = b.prototype = y.prototype,
                    _ = "stack" in m(v),
                    A = "stack" in new y(1, 2),
                    x = y && h && Object.getOwnPropertyDescriptor(o, v),
                    C = !!x && !(x.writable && x.configurable),
                    k = _ && !C && !A;
                r({
                    global: !0,
                    constructor: !0,
                    forced: g || k
                }, {
                    DOMException: k ? b : y
                });
                var S = i(v),
                    T = S.prototype;
                if (T.constructor !== S)
                    for (var E in g || s(T, "constructor", a(1, S)), p)
                        if (l(p, E)) {
                            var O = p[E],
                                M = O.s;
                            l(S, M) || s(S, M, a(6, O.c))
                        }
            },
            6552: function(e, t, n) {
                "use strict";
                n.r(t);
                var r = n(8081),
                    o = n.n(r),
                    i = n(3645),
                    a = n.n(i),
                    s = a()(o());
                s.push([e.id, "#app{width:100%;height:100%}.bg-image{z-index:-1;width:100%;height:100%}.bg-image,.logo{position:absolute;-o-object-fit:cover;object-fit:cover}.logo{right:5.5vh;z-index:3;top:3vh;width:28vh;height:auto}.container{position:relative;background-size:cover;background-repeat:no-repeat;width:100%;height:100%}.settings-enter-active{animation:slide .75s}.settings-leave-active{animation:slide .75s reverse}.left-menu-enter-active{animation:slide-left .75s}.left-menu-leave-active{animation:slide-left .75s reverse}.hint-enter-active{animation:slide-hint .75s}.hint-leave-active{animation:slide-hint .75s reverse}.bar-enter-active{animation:slide-bar .75s}.bar-leave-active{animation:slide-bar .75s reverse}.logo-enter-active{animation:slide-top .75s}.logo-leave-active{animation:slide-top .75s reverse}.albums-enter-from{opacity:0}.albums-enter-active,.albums-leave-active{transition:all .5s ease}.albums-leave-active{opacity:0}@keyframes slide-top{0%{opacity:0;transform:translateY(-500px)}to{opacity:1;transform:translateY(0)}}@keyframes slide-bar{0%{opacity:0;transform:translateY(500px)}to{opacity:1;transform:translateY(0)}}@keyframes slide-hint{0%{opacity:0;transform:translateY(500px)}to{opacity:1;transform:translateY(0)}}@keyframes slide-left{0%{opacity:0;transform:translateX(-500px)}to{opacity:1;transform:translateX(0)}}@keyframes slide{0%{opacity:0;transform:translateX(500px)}to{opacity:1;transform:translateX(0)}}", ""]), t["default"] = s
            },
            9983: function(e, t, n) {
                "use strict";
                n.r(t);
                var r = n(8081),
                    o = n.n(r),
                    i = n(3645),
                    a = n.n(i),
                    s = a()(o());
                s.push([e.id, ".albums[data-v-5c4d4f3e]{width:100%;height:100%;left:0;top:0;z-index:3;background:rgba(0,0,0,.52)}.albums[data-v-5c4d4f3e],.wrapper[data-v-5c4d4f3e]{position:absolute;display:flex;align-items:center;justify-content:center}.wrapper[data-v-5c4d4f3e]{left:58%;transform:translateX(-50%)}.container[data-v-5c4d4f3e]{width:48vw;height:60vh;background:rgba(0,0,0,.38);border-radius:26px;margin:0 2vh;position:relative;color:#fff;padding:3.5vh}.swiper-slide[data-v-5c4d4f3e]{display:flex!important;align-items:center!important;justify-content:center!important}.img[data-v-5c4d4f3e],.swiper-slide[data-v-5c4d4f3e]{width:100%!important;height:100%!important}.img[data-v-5c4d4f3e]{min-width:100%!important;max-width:100%!important;-o-object-fit:fill;object-fit:fill;overflow:visible;border-radius:26px;outline:none}.button[data-v-5c4d4f3e]{cursor:pointer;transition:all .25s ease}.button[data-v-5c4d4f3e]:hover{transform:translateY(3px);opacity:.8}.icon[data-v-5c4d4f3e]{position:absolute;left:-2vh;top:-2vh}", ""]), t["default"] = s
            },
            356: function(e, t, n) {
                "use strict";
                n.r(t);
                var r = n(8081),
                    o = n.n(r),
                    i = n(3645),
                    a = n.n(i),
                    s = a()(o());
                s.push([e.id, ".header[data-v-5f631893]{align-items:center}.commands[data-v-5f631893],.header[data-v-5f631893]{max-width:77%;display:flex}.commands[data-v-5f631893]{width:77%;height:61vh;max-height:61vh;overflow:auto;margin-top:1.5vh;flex-wrap:wrap;align-content:flex-start;justify-content:space-between}.command[data-v-5f631893]{background:rgba(0,0,0,.58);border:1px solid rgba(0,176,255,.5);border-radius:8px;width:29vh;height:61px;display:flex;margin-bottom:2vh;align-items:center;font-family:Proxima Nova;font-style:normal;font-weight:700;font-size:1.5vh;line-height:99.5%;letter-spacing:.11em;color:#fff;cursor:pointer;transition:all .2s ease;padding-left:2.75vh}.command[data-v-5f631893]:hover{opacity:.8}.command.active[data-v-5f631893]{background:#00b0ff;border:1px solid #fff}.commands[data-v-5f631893]::-webkit-scrollbar{display:none}.command-box-container[data-v-5f631893]{flex-direction:column}.command-box-container[data-v-5f631893],.commandBox[data-v-5f631893]{display:flex;justify-content:center;align-items:center}.commandBox[data-v-5f631893]{width:180px;height:54px;font-family:Proxima Nova;font-style:normal;font-weight:700;font-size:1.25vh;line-height:99.5%;letter-spacing:.11em;color:#fff;background:#00b0ff;border:1px solid #fff;border-radius:5px}.info-container[data-v-5f631893]{flex:1;height:52vh;display:flex;flex-direction:column;padding:3.5vh 0;justify-content:space-between;align-items:center;background:rgba(0,0,0,.58);border-radius:14px}.info[data-v-5f631893]{margin-left:5vh;flex:1;position:relative;top:1.8vh}.back[data-v-5f631893]{margin-bottom:2vh;flex:1;height:5vh;background:#0091d1;border:1px solid rgba(0,176,255,.5);border-radius:8px;display:flex;align-items:center;justify-content:center;font-family:Proxima Nova;font-style:normal;font-weight:700;font-size:1.3vh;line-height:99.5%;cursor:pointer;letter-spacing:.11em;transition:all .2s ease;color:#fff}.back[data-v-5f631893]:hover{opacity:.8}.info-container .clickKey[data-v-5f631893]{font-family:Proxima Nova;font-style:normal;font-size:1.15vh;margin-top:3.5vh;line-height:99.5%;text-align:center;letter-spacing:.11em;color:hsla(0,0%,100%,.51)}.header div[data-v-5f631893]{flex:1}.main-container[data-v-5f631893]{display:flex;max-height:52%}.header h2[data-v-5f631893]{font-family:Proxima Nova;font-style:normal;font-weight:700;font-size:4vh;line-height:99.5%;margin-right:1vh;letter-spacing:.11em;color:#fff;text-shadow:0 0 35px hsla(0,0%,100%,.45)}.information[data-v-5f631893]{max-width:77%;display:flex;align-items:center;margin-top:3vh;margin-bottom:3vh}.information .line[data-v-5f631893]{flex:1}.information-line[data-v-5f631893]{width:4px;height:3.5vh;background:#00b0ff;box-shadow:0 0 23px #00b0ff}.information-content[data-v-5f631893]{margin:0 1.85vw;max-width:85%}.information-content h2[data-v-5f631893]{font-family:Proxima Nova;font-style:normal;font-weight:700;font-size:2.45vh;line-height:99.5%;letter-spacing:.11em;color:#fff;text-shadow:0 0 35px hsla(0,0%,100%,.45)}", ""]), t["default"] = s
            },
            8295: function(e, t, n) {
                "use strict";
                n.r(t);
                var r = n(8081),
                    o = n.n(r),
                    i = n(3645),
                    a = n.n(i),
                    s = a()(o());
                s.push([e.id, ".hint{width:47.5vh;min-height:10vh;background:rgba(0,0,0,.17);-webkit-backdrop-filter:blur(21px);backdrop-filter:blur(21px);position:absolute;left:47%;bottom:13vh;padding:1.8vh;border-bottom-left-radius:21px;border-bottom-right-radius:21px}.hint-progress{position:absolute;left:0;top:0;width:100%;height:1px}.hint-progress-inner{height:100%;width:80%;transition:all .5s ease}.hint-top{display:flex;align-items:center;margin-bottom:2vh}.hint-top img{margin-right:2.25vh}.hint-top p{font-family:Proxima Nova;font-style:normal;font-weight:700;font-size:1.6vh;line-height:99.5%;letter-spacing:.11em;text-shadow:0 0 35px hsla(0,0%,100%,.45)}.hint-bottom{display:flex;align-content:center;align-items:center;position:relative;width:100%}.hint-text{font-family:Proxima Nova;font-style:normal;font-weight:700;font-size:1.1vh;line-height:99.5%;padding-left:3.5vh;letter-spacing:.11em;color:hsla(0,0%,100%,.54);text-shadow:0 0 35px hsla(0,0%,100%,.45)}.hint-line{width:2px;height:120%;left:15px;position:absolute}", ""]), t["default"] = s
            },
            2883: function(e, t, n) {
                "use strict";
                n.r(t);
                var r = n(8081),
                    o = n.n(r),
                    i = n(3645),
                    a = n.n(i),
                    s = a()(o());
                s.push([e.id, ".keybinds[data-v-06d572ae]{z-index:2;-webkit-backdrop-filter:blur(14px);backdrop-filter:blur(14px);overflow:hidden;background-repeat:no-repeat;background-size:100% 100%;position:absolute;left:20%;padding:6vh 11vh;padding-right:3.75vh;padding-bottom:0;top:0;height:100%;width:80%}.combinationsButton[data-v-06d572ae]{width:157px;position:absolute;left:50%;transform:translateX(-50%);bottom:6.5vh;height:41px;display:flex;cursor:pointer;align-items:center;justify-content:center;background:#00b0ff;border-radius:6px;font-family:Proxima Nova;font-style:normal;font-weight:700;font-size:1.1vh;line-height:99.5%;text-align:center;letter-spacing:.11em;color:#fff}.commands-content[data-v-06d572ae]{margin-top:1vh;display:flex;align-items:center}.commands-boxes[data-v-06d572ae]{margin-top:1.5vh;display:flex;align-items:center}.command-box-container[data-v-06d572ae]{display:flex;flex-direction:column;justify-content:center;align-content:center;align-items:center}.commands-box[data-v-06d572ae]{width:36.5vh;margin-right:3vh;height:5.5vh;display:flex;align-items:center;padding:0 2vh;background:rgba(0,0,0,.58);border:1px solid rgba(0,176,255,.5);border-radius:8px;font-family:Proxima Nova;font-style:normal;font-weight:700;font-size:1.75vh;line-height:99.5%;letter-spacing:.11em;cursor:pointer;transition:opacity .25s ease;color:#fff}.commands-box[data-v-06d572ae]:hover{opacity:.8}.commands-box.active[data-v-06d572ae]{justify-content:center;background:#015378;border:1px solid rgba(0,176,255,.5)}.commands-box.activebox[data-v-06d572ae]{background:#00b0ff;border:1px solid #fff}.commands-info[data-v-06d572ae]{display:flex;align-items:center}.commandBox[data-v-06d572ae]{width:180px;height:30px;font-size:1vh;border:1px solid #fff;border-radius:5px}.commandBox[data-v-06d572ae],.currentKey[data-v-06d572ae]{display:flex;align-items:center;justify-content:center;font-family:Proxima Nova;font-style:normal;font-weight:700;line-height:99.5%;letter-spacing:.11em;color:#fff;background:#00b0ff}.currentKey[data-v-06d572ae]{min-width:4vh;padding:0 2.25vh;height:5.25vh;border:1px solid #fff;border-radius:8px;font-size:1.5vh}.commands-infobox[data-v-06d572ae]{width:20%;height:12vh;display:flex;flex-direction:column;align-items:center;justify-content:space-between;padding:1.5vh 0;background:rgba(0,0,0,.58);border-radius:14px}.press[data-v-06d572ae]{color:#fff}.description[data-v-06d572ae],.press[data-v-06d572ae]{font-family:Proxima Nova;font-style:normal;font-weight:700;font-size:15px;line-height:99.5%;text-align:center;letter-spacing:.11em}.description[data-v-06d572ae]{margin-top:.5vh;color:hsla(0,0%,100%,.51)}.keyinfo[data-v-06d572ae]{margin-top:2vh}.combinationKey[data-v-06d572ae],.currentKeyContainer[data-v-06d572ae]{display:flex;flex-direction:column;align-items:center;justify-content:center}.combinationKeyContainer[data-v-06d572ae]{height:70%;overflow:auto;margin-top:1vh}.combinationKeyContainer[data-v-06d572ae]::-webkit-scrollbar{display:none}.combinationKey img[data-v-06d572ae]{margin:1vh 0}.combinationKey p[data-v-06d572ae]{margin-top:1.5vh}.commands-infobox .info-text[data-v-06d572ae]{font-weight:700;font-size:1.4vh;color:hsla(0,0%,100%,.28)}.commandText[data-v-06d572ae],.commands-infobox .info-text[data-v-06d572ae]{font-family:Proxima Nova;font-style:normal;line-height:99.5%;text-align:center;letter-spacing:.11em}.commandText[data-v-06d572ae]{font-size:1vh;margin-top:1vh;color:hsla(0,0%,100%,.51)}.commands-info p[data-v-06d572ae]{font-family:Proxima Nova;font-style:normal;font-weight:700;font-size:2vh;line-height:99.5%;letter-spacing:.11em;color:#fff}.commands-left[data-v-06d572ae]{width:80%;margin-right:2vh}.commands-line[data-v-06d572ae]{width:4px;height:4.5vh;margin-right:1.35vh;background:#00b0ff;box-shadow:0 0 23px #00b0ff}.header[data-v-06d572ae]{max-width:77%;display:flex;align-items:center}.header div[data-v-06d572ae]{flex:1}.header h2[data-v-06d572ae]{font-family:Proxima Nova;font-style:normal;font-weight:700;font-size:4vh;line-height:99.5%;margin-right:1vh;letter-spacing:.11em;color:#fff;text-shadow:0 0 35px hsla(0,0%,100%,.45)}.information[data-v-06d572ae]{max-width:77%;display:flex;align-items:center;margin-top:3vh}.information .line[data-v-06d572ae]{flex:1}.information-line[data-v-06d572ae]{width:4px;height:9.5vh;background:#00b0ff;box-shadow:0 0 23px #00b0ff}.information-content[data-v-06d572ae]{margin:0 1.85vw;max-width:85%}.information-content h2[data-v-06d572ae]{font-size:2.45vh;color:#fff;padding-bottom:1.5vh;text-shadow:0 0 35px hsla(0,0%,100%,.45)}.information-content h2[data-v-06d572ae],.information-content p[data-v-06d572ae]{font-family:Proxima Nova;font-style:normal;font-weight:700;line-height:99.5%;letter-spacing:.11em}.information-content p[data-v-06d572ae]{font-size:1.65vh;color:hsla(0,0%,100%,.58)}.main-container[data-v-06d572ae]{display:flex;max-height:52%}.keyboard[data-v-06d572ae]{margin-top:2.25vh;height:-moz-max-content;height:max-content}.keyboard-container[data-v-06d572ae]{position:relative;margin-top:1.2vh}.key[data-v-06d572ae],.keyboard-container[data-v-06d572ae]{display:flex;align-items:center}.key[data-v-06d572ae]{margin-right:.8vh;width:7.35vh;height:6.25vh;flex-direction:column;cursor:pointer;justify-content:center;font-family:Proxima Nova;font-style:normal;font-weight:700;font-size:2vh;line-height:99.5%;letter-spacing:.11em;color:#fff;background:rgba(0,0,0,.58);border:1px solid rgba(0,176,255,.5);border-radius:8px}.keyboard-enter-container[data-v-06d572ae]{padding-right:7vh}.keyboard-after-enter-container[data-v-06d572ae]{padding-right:13vh;padding-top:.2vh}.keyboard-enter-container .key[data-v-06d572ae]{position:relative}.keyboard-enter-container .enter[data-v-06d572ae]{position:absolute;right:0;top:0;width:12.4vh;height:auto;-o-object-fit:cover;object-fit:cover}.enter[data-v-06d572ae]{cursor:pointer;z-index:2}.enter-wrapper[data-v-06d572ae]{position:relative;width:100%;height:100%;cursor:pointer}.enter-wrapper img[data-v-06d572ae]{pointer-events:none;cursor:pointer}.enter-wrapper p[data-v-06d572ae]{font-family:Proxima Nova;font-style:normal;font-weight:700;font-size:2vh;line-height:99.5%;position:absolute;left:2.75vh;bottom:2.5vh;letter-spacing:.11em;color:#fff}.keyboard-enter-container .enter img[data-v-06d572ae]{width:12.4vh;height:auto;-o-object-fit:cover;object-fit:cover}.key[data-v-06d572ae]:last-child{margin-right:0}.key.esc[data-v-06d572ae]{width:10.75vh}.caps[data-v-06d572ae]{width:14vh}.ctrl[data-v-06d572ae]{width:15vh}.ctrl[data-v-06d572ae]:first-child{margin-right:6vh}.ctrl[data-v-06d572ae]:last-child{margin-left:9vh}.alt[data-v-06d572ae],.altgr[data-v-06d572ae]{width:8.75vh}.altgr[data-v-06d572ae]{font-size:1.5vh}.key.tab[data-v-06d572ae]{width:10.75vh}.key.shift[data-v-06d572ae]{width:17vh}.key.backspace[data-v-06d572ae]{font-size:1.125vh;width:10.75vh}.space[data-v-06d572ae]{margin:0 6vh;width:40vh}.key-space[data-v-06d572ae]{margin-right:3.75vh}.info-container[data-v-06d572ae]{flex:1;height:52vh;display:flex;flex-direction:column;padding:3.5vh 0;justify-content:space-between;align-items:center;position:relative;bottom:5.25vh;margin-left:5vh;background:rgba(0,0,0,.58);border-radius:14px}.info-container .clickKey[data-v-06d572ae]{width:202px;height:30px;font-family:Proxima Nova;font-style:normal;font-weight:700;font-size:1.55vh;line-height:99.5%;text-align:center;letter-spacing:.11em;color:hsla(0,0%,100%,.28)}.keyboard[data-v-06d572ae]{max-width:77%;width:77%}footer[data-v-06d572ae]{margin-top:1.25vh}.footer-header[data-v-06d572ae]{display:flex;align-items:center}.footer-header h2[data-v-06d572ae]{font-family:Proxima Nova;font-style:normal;font-weight:700;font-size:4vh;margin-right:9vh;line-height:99.5%;letter-spacing:.11em;color:#fff;text-shadow:0 0 35px hsla(0,0%,100%,.45)}", ""]), t["default"] = s
            },
            3433: function(e, t, n) {
                "use strict";
                n.r(t);
                var r = n(8081),
                    o = n.n(r),
                    i = n(3645),
                    a = n.n(i),
                    s = a()(o());
                s.push([e.id, ".menu[data-v-a78098e4]{background-size:100% 100%;background-repeat:no-repeat;width:21%;height:100%;padding:5vh 3.5vh;padding-right:0}.header[data-v-a78098e4]{display:flex;align-items:center;margin-bottom:1.5vh}.header p[data-v-a78098e4]{font-family:Gilroy;font-size:1.9vh;margin-right:1.15vh;color:#fff;text-shadow:0 0 35px hsla(0,0%,100%,.45)}.header p[data-v-a78098e4],.server-name[data-v-a78098e4]{font-style:normal;line-height:99.5%;letter-spacing:.25em;text-transform:uppercase}.server-name[data-v-a78098e4]{font-family:Gilroy Extra Bold;font-weight:800;font-size:3.25vh;margin-bottom:2vh;-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text}section[data-v-a78098e4]{margin-top:1.5vh}.section-header[data-v-a78098e4]{font-weight:700;font-size:1.9vh;line-height:190.5%;color:#fff;text-shadow:0 0 35px hsla(0,0%,100%,.45)}.section-desc[data-v-a78098e4],.section-header[data-v-a78098e4]{font-family:Proxima Nova;font-style:normal;letter-spacing:.11em}.section-desc[data-v-a78098e4]{font-weight:400;font-size:1.5vh;line-height:99.5%;color:hsla(0,0%,100%,.24)}.albums[data-v-a78098e4]{width:88%;height:35.5vh;background-size:100% 100%;background-repeat:no-repeat;margin-top:1.75vh;padding:3.5vh;position:relative;cursor:pointer}.albums .icon[data-v-a78098e4]{position:absolute;left:-.5vh;top:-.5vh;width:2.25vh;height:2.25vh}.albums .album[data-v-a78098e4]{border-radius:14px;display:block;-o-object-fit:cover;object-fit:cover;transition:opacity .25s ease}.album[data-v-a78098e4]:hover{opacity:.8}.albums .img-1[data-v-a78098e4]{width:100%;height:14vh;margin-bottom:3vh}.albums .img-2[data-v-a78098e4]{width:100%;height:10vh}.video-wrapper[data-v-a78098e4]{position:relative}.play-icon[data-v-a78098e4]{position:absolute;left:50%;top:50%;transform:translate(-50%,-50%)}.patch-notes[data-v-a78098e4]{width:83%;height:20.5vh;background-size:100% 100%;background-repeat:no-repeat;margin-top:1.75vh;margin-bottom:3vh;padding:3.5vh;position:relative}.patch-notes .icon[data-v-a78098e4]{position:absolute;left:-.5vh;top:-.5vh;width:2.2vh;height:2.75vh}.patch-header[data-v-a78098e4]{font-family:Proxima Nova;font-style:normal;font-weight:700;font-size:1.2vh;line-height:99.5%;letter-spacing:.11em;color:#fff;text-shadow:0 0 35px hsla(0,0%,100%,.45)}.patch-list[data-v-a78098e4]{margin-top:1vh;overflow:auto;height:95%;list-style-type:disc;padding-left:1.75vh}.patch-list[data-v-a78098e4]::-webkit-scrollbar{display:none}.patch-item[data-v-a78098e4]{position:relative;font-weight:400;font-size:1.08vh;margin-bottom:.4vh;color:hsla(0,0%,100%,.24)}.patch-item[data-v-a78098e4],.socials-header[data-v-a78098e4]{font-family:Proxima Nova;font-style:normal;line-height:99.5%;letter-spacing:.11em}.socials-header[data-v-a78098e4]{font-weight:700;font-size:2vh;color:#fff;text-shadow:0 0 35px hsla(0,0%,100%,.45);margin-bottom:1vh}.social-links[data-v-a78098e4]{margin-top:.75vh}.social-link[data-v-a78098e4],.social-links[data-v-a78098e4]{display:flex;align-items:center}.social-link[data-v-a78098e4]{width:4.5vh;height:4.5vh;cursor:pointer;background:rgba(0,0,0,.24);border-radius:9px;justify-content:center;margin-right:.75vh;transition:opacity .25s ease}.social-link[data-v-a78098e4]:hover{opacity:.8}.social-link img[data-v-a78098e4]{width:auto;height:auto;-o-object-fit:cover;object-fit:cover}", ""]), t["default"] = s
            },
            3315: function(e, t, n) {
                "use strict";
                n.r(t);
                var r = n(8081),
                    o = n.n(r),
                    i = n(3645),
                    a = n.n(i),
                    s = a()(o());
                s.push([e.id, ".line{height:.5px;background:hsla(0,0%,100%,.55)}", ""]), t["default"] = s
            },
            7660: function(e, t, n) {
                "use strict";
                n.r(t);
                var r = n(8081),
                    o = n.n(r),
                    i = n(3645),
                    a = n.n(i),
                    s = a()(o());
                s.push([e.id, ".loading-bar{position:absolute;left:22%;z-index:2;bottom:3vh;width:76%}.content{width:100%;display:flex;align-items:center;align-content:flex-end;justify-content:space-between;position:relative;margin-bottom:1vh}.content-header{font-family:Proxima Nova;font-style:normal;font-weight:700;font-size:1.25vh;line-height:99.5%;color:#fff;text-shadow:0 0 35px hsla(0,0%,100%,.45)}.content-icon,.content-icons{display:flex;align-items:center}.content-icon{width:40px;height:40px;padding:1.6vh 1.7vh;margin:0 .2vh;background:rgba(0,0,0,.24);border-radius:6px;cursor:pointer;justify-content:center;transition:all .2s ease}.content-icon.active{background:#fff}.content-icon:hover{opacity:.8}.content-icon img{-o-object-fit:contain;object-fit:contain}.bar{width:100%;max-width:100%;height:11px;background:linear-gradient(90deg,rgba(0,176,255,.2),hsla(0,0%,100%,.2))}.bar-inner{width:50%;transition:all .75s ease;height:100%;background:linear-gradient(90deg,#00b0ff,#fff)}", ""]), t["default"] = s
            },
            468: function(e, t, n) {
                "use strict";
                n.r(t);
                var r = n(8081),
                    o = n.n(r),
                    i = n(3645),
                    a = n.n(i),
                    s = a()(o());
                s.push([e.id, '.menu[data-v-aa404f7c]{position:absolute;right:0;top:0;background-size:100% 100%;background-repeat:no-repeat;width:40vh;height:100%;padding:15vh 6vh;padding-right:0}.header[data-v-aa404f7c]{display:flex;align-items:center}.header p[data-v-aa404f7c]{font-family:Proxima Nova;font-style:normal;font-weight:700;font-size:24px;line-height:99.5%;margin-right:1vh;letter-spacing:.11em;color:#fff;text-shadow:0 0 35px hsla(0,0%,100%,.45)}.options[data-v-aa404f7c]{padding-left:.75vh;margin-top:1.5vh}.option[data-v-aa404f7c]{width:27vh;display:flex;align-items:center;justify-content:space-between;background:rgba(0,0,0,.17);border-radius:8px;min-height:67px;margin:1.75vh 0;padding:1vh 1.5vh}.option p[data-v-aa404f7c]{max-width:8vw;font-family:Proxima Nova;font-style:normal;font-weight:700;font-size:1.3vh;line-height:99.5%;letter-spacing:.11em;color:#fff;text-shadow:0 0 35px hsla(0,0%,100%,.45)}.check[data-v-aa404f7c]{display:inline-block;height:40px;width:80px;position:relative;border-radius:20px;overflow:hidden;cursor:pointer;transform:scale(.7)}.check__check[data-v-aa404f7c]{z-index:2;opacity:0;cursor:pointer}.check__check:checked~.check__indicator[data-v-aa404f7c]{background:rgba(0,176,255,.74)}.check__check:checked~.check__indicator[data-v-aa404f7c]:after{transform:translate(40px)}.check__check[data-v-aa404f7c],.check__indicator[data-v-aa404f7c]{height:100%;width:100%;position:absolute;top:0;right:0;bottom:0;left:0;margin:0}.check__indicator[data-v-aa404f7c]{background:rgba(0,176,255,.15);transition:background .25s ease}.check__indicator[data-v-aa404f7c]:after{height:30px;width:30px;background:#fff;content:"";position:absolute;border-radius:100%;top:5px;left:5px;transition:transform .25s ease}', ""]), t["default"] = s
            },
            5948: function(e, t, n) {
                "use strict";
                n.r(t);
                var r = n(8081),
                    o = n.n(r),
                    i = n(3645),
                    a = n.n(i),
                    s = n(1667),
                    l = n.n(s),
                    c = new URL(n(9954), n.b),
                    d = a()(o()),
                    u = l()(c);
                d.push([e.id, "@font-face{font-family:swiper-icons;src:url(" + u + ');font-weight:400;font-style:normal}:root{--swiper-theme-color:#007aff}.swiper{margin-left:auto;margin-right:auto;position:relative;overflow:hidden;list-style:none;padding:0;z-index:1}.swiper-vertical>.swiper-wrapper{flex-direction:column}.swiper-wrapper{position:relative;width:100%;height:100%;z-index:1;display:flex;transition-property:transform;box-sizing:content-box}.swiper-android .swiper-slide,.swiper-wrapper{transform:translateZ(0)}.swiper-pointer-events{touch-action:pan-y}.swiper-pointer-events.swiper-vertical{touch-action:pan-x}.swiper-slide{flex-shrink:0;width:100%;height:100%;position:relative;transition-property:transform}.swiper-slide-invisible-blank{visibility:hidden}.swiper-autoheight,.swiper-autoheight .swiper-slide{height:auto}.swiper-autoheight .swiper-wrapper{align-items:flex-start;transition-property:transform,height}.swiper-backface-hidden .swiper-slide{transform:translateZ(0);backface-visibility:hidden}.swiper-3d,.swiper-3d.swiper-css-mode .swiper-wrapper{perspective:1200px}.swiper-3d .swiper-cube-shadow,.swiper-3d .swiper-slide,.swiper-3d .swiper-slide-shadow,.swiper-3d .swiper-slide-shadow-bottom,.swiper-3d .swiper-slide-shadow-left,.swiper-3d .swiper-slide-shadow-right,.swiper-3d .swiper-slide-shadow-top,.swiper-3d .swiper-wrapper{transform-style:preserve-3d}.swiper-3d .swiper-slide-shadow,.swiper-3d .swiper-slide-shadow-bottom,.swiper-3d .swiper-slide-shadow-left,.swiper-3d .swiper-slide-shadow-right,.swiper-3d .swiper-slide-shadow-top{position:absolute;left:0;top:0;width:100%;height:100%;pointer-events:none;z-index:10}.swiper-3d .swiper-slide-shadow{background:rgba(0,0,0,.15)}.swiper-3d .swiper-slide-shadow-left{background-image:linear-gradient(270deg,rgba(0,0,0,.5),transparent)}.swiper-3d .swiper-slide-shadow-right{background-image:linear-gradient(90deg,rgba(0,0,0,.5),transparent)}.swiper-3d .swiper-slide-shadow-top{background-image:linear-gradient(0deg,rgba(0,0,0,.5),transparent)}.swiper-3d .swiper-slide-shadow-bottom{background-image:linear-gradient(180deg,rgba(0,0,0,.5),transparent)}.swiper-css-mode>.swiper-wrapper{overflow:auto;scrollbar-width:none;-ms-overflow-style:none}.swiper-css-mode>.swiper-wrapper::-webkit-scrollbar{display:none}.swiper-css-mode>.swiper-wrapper>.swiper-slide{scroll-snap-align:start start}.swiper-horizontal.swiper-css-mode>.swiper-wrapper{scroll-snap-type:x mandatory}.swiper-vertical.swiper-css-mode>.swiper-wrapper{scroll-snap-type:y mandatory}.swiper-centered>.swiper-wrapper:before{content:"";flex-shrink:0;order:9999}.swiper-centered.swiper-horizontal>.swiper-wrapper>.swiper-slide:first-child{-webkit-margin-start:var(--swiper-centered-offset-before);margin-inline-start:var(--swiper-centered-offset-before)}.swiper-centered.swiper-horizontal>.swiper-wrapper:before{height:100%;min-height:1px;width:var(--swiper-centered-offset-after)}.swiper-centered.swiper-vertical>.swiper-wrapper>.swiper-slide:first-child{-webkit-margin-before:var(--swiper-centered-offset-before);margin-block-start:var(--swiper-centered-offset-before)}.swiper-centered.swiper-vertical>.swiper-wrapper:before{width:100%;min-width:1px;height:var(--swiper-centered-offset-after)}.swiper-centered>.swiper-wrapper>.swiper-slide{scroll-snap-align:center center}', ""]), t["default"] = d
            },
            1061: function(e, t, n) {
                "use strict";
                n.r(t);
                var r = n(8081),
                    o = n.n(r),
                    i = n(3645),
                    a = n.n(i),
                    s = n(1667),
                    l = n.n(s),
                    c = new URL(n(60), n.b),
                    d = new URL(n(522), n.b),
                    u = new URL(n(1673), n.b),
                    p = new URL(n(7317), n.b),
                    f = new URL(n(7464), n.b),
                    h = new URL(n(2255), n.b),
                    g = a()(o()),
                    v = l()(c),
                    m = l()(d),
                    y = l()(u),
                    b = l()(p),
                    w = l()(f),
                    _ = l()(h);
                g.push([e.id, "@font-face{font-family:Gilroy;src:url(" + v + ")}@font-face{font-family:Gilroy Bold;src:url(" + m + ")}@font-face{font-family:Gilroy Extra Bold;src:url(" + y + ")}@font-face{font-family:Proxima Nova;src:url(" + b + ")}@font-face{font-family:Gilroy Light;src:url(" + w + ")}@font-face{font-family:Gilroy Medium;src:url(" + _ + ")}*{margin:0;padding:0;box-sizing:border-box}body{font-family:Gilroy;width:100vw;height:100vh;overflow:hidden}", ""]), t["default"] = g
            },
            3645: function(e) {
                "use strict";
                e.exports = function(e) {
                    var t = [];
                    return t.toString = function() {
                        return this.map((function(t) {
                            var n = "",
                                r = "undefined" !== typeof t[5];
                            return t[4] && (n += "@supports (".concat(t[4], ") {")), t[2] && (n += "@media ".concat(t[2], " {")), r && (n += "@layer".concat(t[5].length > 0 ? " ".concat(t[5]) : "", " {")), n += e(t), r && (n += "}"), t[2] && (n += "}"), t[4] && (n += "}"), n
                        })).join("")
                    }, t.i = function(e, n, r, o, i) {
                        "string" === typeof e && (e = [
                            [null, e, void 0]
                        ]);
                        var a = {};
                        if (r)
                            for (var s = 0; s < this.length; s++) {
                                var l = this[s][0];
                                null != l && (a[l] = !0)
                            }
                        for (var c = 0; c < e.length; c++) {
                            var d = [].concat(e[c]);
                            r && a[d[0]] || ("undefined" !== typeof i && ("undefined" === typeof d[5] || (d[1] = "@layer".concat(d[5].length > 0 ? " ".concat(d[5]) : "", " {").concat(d[1], "}")), d[5] = i), n && (d[2] ? (d[1] = "@media ".concat(d[2], " {").concat(d[1], "}"), d[2] = n) : d[2] = n), o && (d[4] ? (d[1] = "@supports (".concat(d[4], ") {").concat(d[1], "}"), d[4] = o) : d[4] = "".concat(o)), t.push(d))
                        }
                    }, t
                }
            },
            1667: function(e) {
                "use strict";
                e.exports = function(e, t) {
                    return t || (t = {}), e ? (e = String(e.__esModule ? e.default : e), /^['"].*['"]$/.test(e) && (e = e.slice(1, -1)), t.hash && (e += t.hash), /["'() \t\n]|(%20)/.test(e) || t.needQuotes ? '"'.concat(e.replace(/"/g, '\\"').replace(/\n/g, "\\n"), '"') : e) : e
                }
            },
            8081: function(e) {
                "use strict";
                e.exports = function(e) {
                    return e[1]
                }
            },
            2005: function(e, t, n) {
                var r, o;
                n(7658), n(2801),
                    /*!
                     *  howler.js v2.2.3
                     *  howlerjs.com
                     *
                     *  (c) 2013-2020, James Simpson of GoldFire Studios
                     *  goldfirestudios.com
                     *
                     *  MIT License
                     */
                    function() {
                        "use strict";
                        var i = function() {
                            this.init()
                        };
                        i.prototype = {
                            init: function() {
                                var e = this || a;
                                return e._counter = 1e3, e._html5AudioPool = [], e.html5PoolSize = 10, e._codecs = {}, e._howls = [], e._muted = !1, e._volume = 1, e._canPlayEvent = "canplaythrough", e._navigator = "undefined" !== typeof window && window.navigator ? window.navigator : null, e.masterGain = null, e.noAudio = !1, e.usingWebAudio = !0, e.autoSuspend = !0, e.ctx = null, e.autoUnlock = !0, e._setup(), e
                            },
                            volume: function(e) {
                                var t = this || a;
                                if (e = parseFloat(e), t.ctx || h(), "undefined" !== typeof e && e >= 0 && e <= 1) {
                                    if (t._volume = e, t._muted) return t;
                                    t.usingWebAudio && t.masterGain.gain.setValueAtTime(e, a.ctx.currentTime);
                                    for (var n = 0; n < t._howls.length; n++)
                                        if (!t._howls[n]._webAudio)
                                            for (var r = t._howls[n]._getSoundIds(), o = 0; o < r.length; o++) {
                                                var i = t._howls[n]._soundById(r[o]);
                                                i && i._node && (i._node.volume = i._volume * e)
                                            }
                                    return t
                                }
                                return t._volume
                            },
                            mute: function(e) {
                                var t = this || a;
                                t.ctx || h(), t._muted = e, t.usingWebAudio && t.masterGain.gain.setValueAtTime(e ? 0 : t._volume, a.ctx.currentTime);
                                for (var n = 0; n < t._howls.length; n++)
                                    if (!t._howls[n]._webAudio)
                                        for (var r = t._howls[n]._getSoundIds(), o = 0; o < r.length; o++) {
                                            var i = t._howls[n]._soundById(r[o]);
                                            i && i._node && (i._node.muted = !!e || i._muted)
                                        }
                                return t
                            },
                            stop: function() {
                                for (var e = this || a, t = 0; t < e._howls.length; t++) e._howls[t].stop();
                                return e
                            },
                            unload: function() {
                                for (var e = this || a, t = e._howls.length - 1; t >= 0; t--) e._howls[t].unload();
                                return e.usingWebAudio && e.ctx && "undefined" !== typeof e.ctx.close && (e.ctx.close(), e.ctx = null, h()), e
                            },
                            codecs: function(e) {
                                return (this || a)._codecs[e.replace(/^x-/, "")]
                            },
                            _setup: function() {
                                var e = this || a;
                                if (e.state = e.ctx && e.ctx.state || "suspended", e._autoSuspend(), !e.usingWebAudio)
                                    if ("undefined" !== typeof Audio) try {
                                        var t = new Audio;
                                        "undefined" === typeof t.oncanplaythrough && (e._canPlayEvent = "canplay")
                                    } catch (n) {
                                        e.noAudio = !0
                                    } else e.noAudio = !0;
                                try {
                                    t = new Audio;
                                    t.muted && (e.noAudio = !0)
                                } catch (n) {}
                                return e.noAudio || e._setupCodecs(), e
                            },
                            _setupCodecs: function() {
                                var e = this || a,
                                    t = null;
                                try {
                                    t = "undefined" !== typeof Audio ? new Audio : null
                                } catch (d) {
                                    return e
                                }
                                if (!t || "function" !== typeof t.canPlayType) return e;
                                var n = t.canPlayType("audio/mpeg;").replace(/^no$/, ""),
                                    r = e._navigator ? e._navigator.userAgent : "",
                                    o = r.match(/OPR\/([0-6].)/g),
                                    i = o && parseInt(o[0].split("/")[1], 10) < 33,
                                    s = -1 !== r.indexOf("Safari") && -1 === r.indexOf("Chrome"),
                                    l = r.match(/Version\/(.*?) /),
                                    c = s && l && parseInt(l[1], 10) < 15;
                                return e._codecs = {
                                    mp3: !(i || !n && !t.canPlayType("audio/mp3;").replace(/^no$/, "")),
                                    mpeg: !!n,
                                    opus: !!t.canPlayType('audio/ogg; codecs="opus"').replace(/^no$/, ""),
                                    ogg: !!t.canPlayType('audio/ogg; codecs="vorbis"').replace(/^no$/, ""),
                                    oga: !!t.canPlayType('audio/ogg; codecs="vorbis"').replace(/^no$/, ""),
                                    wav: !!(t.canPlayType('audio/wav; codecs="1"') || t.canPlayType("audio/wav")).replace(/^no$/, ""),
                                    aac: !!t.canPlayType("audio/aac;").replace(/^no$/, ""),
                                    caf: !!t.canPlayType("audio/x-caf;").replace(/^no$/, ""),
                                    m4a: !!(t.canPlayType("audio/x-m4a;") || t.canPlayType("audio/m4a;") || t.canPlayType("audio/aac;")).replace(/^no$/, ""),
                                    m4b: !!(t.canPlayType("audio/x-m4b;") || t.canPlayType("audio/m4b;") || t.canPlayType("audio/aac;")).replace(/^no$/, ""),
                                    mp4: !!(t.canPlayType("audio/x-mp4;") || t.canPlayType("audio/mp4;") || t.canPlayType("audio/aac;")).replace(/^no$/, ""),
                                    weba: !(c || !t.canPlayType('audio/webm; codecs="vorbis"').replace(/^no$/, "")),
                                    webm: !(c || !t.canPlayType('audio/webm; codecs="vorbis"').replace(/^no$/, "")),
                                    dolby: !!t.canPlayType('audio/mp4; codecs="ec-3"').replace(/^no$/, ""),
                                    flac: !!(t.canPlayType("audio/x-flac;") || t.canPlayType("audio/flac;")).replace(/^no$/, "")
                                }, e
                            },
                            _unlockAudio: function() {
                                var e = this || a;
                                if (!e._audioUnlocked && e.ctx) {
                                    e._audioUnlocked = !1, e.autoUnlock = !1, e._mobileUnloaded || 44100 === e.ctx.sampleRate || (e._mobileUnloaded = !0, e.unload()), e._scratchBuffer = e.ctx.createBuffer(1, 1, 22050);
                                    var t = function(n) {
                                        while (e._html5AudioPool.length < e.html5PoolSize) try {
                                            var r = new Audio;
                                            r._unlocked = !0, e._releaseHtml5Audio(r)
                                        } catch (n) {
                                            e.noAudio = !0;
                                            break
                                        }
                                        for (var o = 0; o < e._howls.length; o++)
                                            if (!e._howls[o]._webAudio)
                                                for (var i = e._howls[o]._getSoundIds(), a = 0; a < i.length; a++) {
                                                    var s = e._howls[o]._soundById(i[a]);
                                                    s && s._node && !s._node._unlocked && (s._node._unlocked = !0, s._node.load())
                                                }
                                        e._autoResume();
                                        var l = e.ctx.createBufferSource();
                                        l.buffer = e._scratchBuffer, l.connect(e.ctx.destination), "undefined" === typeof l.start ? l.noteOn(0) : l.start(0), "function" === typeof e.ctx.resume && e.ctx.resume(), l.onended = function() {
                                            l.disconnect(0), e._audioUnlocked = !0, document.removeEventListener("touchstart", t, !0), document.removeEventListener("touchend", t, !0), document.removeEventListener("click", t, !0), document.removeEventListener("keydown", t, !0);
                                            for (var n = 0; n < e._howls.length; n++) e._howls[n]._emit("unlock")
                                        }
                                    };
                                    return document.addEventListener("touchstart", t, !0), document.addEventListener("touchend", t, !0), document.addEventListener("click", t, !0), document.addEventListener("keydown", t, !0), e
                                }
                            },
                            _obtainHtml5Audio: function() {
                                var e = this || a;
                                if (e._html5AudioPool.length) return e._html5AudioPool.pop();
                                var t = (new Audio).play();
                                return t && "undefined" !== typeof Promise && (t instanceof Promise || "function" === typeof t.then) && t.catch((function() {
                                    console.warn("HTML5 Audio pool exhausted, returning potentially locked audio object.")
                                })), new Audio
                            },
                            _releaseHtml5Audio: function(e) {
                                var t = this || a;
                                return e._unlocked && t._html5AudioPool.push(e), t
                            },
                            _autoSuspend: function() {
                                var e = this;
                                if (e.autoSuspend && e.ctx && "undefined" !== typeof e.ctx.suspend && a.usingWebAudio) {
                                    for (var t = 0; t < e._howls.length; t++)
                                        if (e._howls[t]._webAudio)
                                            for (var n = 0; n < e._howls[t]._sounds.length; n++)
                                                if (!e._howls[t]._sounds[n]._paused) return e;
                                    return e._suspendTimer && clearTimeout(e._suspendTimer), e._suspendTimer = setTimeout((function() {
                                        if (e.autoSuspend) {
                                            e._suspendTimer = null, e.state = "suspending";
                                            var t = function() {
                                                e.state = "suspended", e._resumeAfterSuspend && (delete e._resumeAfterSuspend, e._autoResume())
                                            };
                                            e.ctx.suspend().then(t, t)
                                        }
                                    }), 3e4), e
                                }
                            },
                            _autoResume: function() {
                                var e = this;
                                if (e.ctx && "undefined" !== typeof e.ctx.resume && a.usingWebAudio) return "running" === e.state && "interrupted" !== e.ctx.state && e._suspendTimer ? (clearTimeout(e._suspendTimer), e._suspendTimer = null) : "suspended" === e.state || "running" === e.state && "interrupted" === e.ctx.state ? (e.ctx.resume().then((function() {
                                    e.state = "running";
                                    for (var t = 0; t < e._howls.length; t++) e._howls[t]._emit("resume")
                                })), e._suspendTimer && (clearTimeout(e._suspendTimer), e._suspendTimer = null)) : "suspending" === e.state && (e._resumeAfterSuspend = !0), e
                            }
                        };
                        var a = new i,
                            s = function(e) {
                                var t = this;
                                e.src && 0 !== e.src.length ? t.init(e) : console.error("An array of source files must be passed with any new Howl.")
                            };
                        s.prototype = {
                            init: function(e) {
                                var t = this;
                                return a.ctx || h(), t._autoplay = e.autoplay || !1, t._format = "string" !== typeof e.format ? e.format : [e.format], t._html5 = e.html5 || !1, t._muted = e.mute || !1, t._loop = e.loop || !1, t._pool = e.pool || 5, t._preload = "boolean" !== typeof e.preload && "metadata" !== e.preload || e.preload, t._rate = e.rate || 1, t._sprite = e.sprite || {}, t._src = "string" !== typeof e.src ? e.src : [e.src], t._volume = void 0 !== e.volume ? e.volume : 1, t._xhr = {
                                    method: e.xhr && e.xhr.method ? e.xhr.method : "GET",
                                    headers: e.xhr && e.xhr.headers ? e.xhr.headers : null,
                                    withCredentials: !(!e.xhr || !e.xhr.withCredentials) && e.xhr.withCredentials
                                }, t._duration = 0, t._state = "unloaded", t._sounds = [], t._endTimers = {}, t._queue = [], t._playLock = !1, t._onend = e.onend ? [{
                                    fn: e.onend
                                }] : [], t._onfade = e.onfade ? [{
                                    fn: e.onfade
                                }] : [], t._onload = e.onload ? [{
                                    fn: e.onload
                                }] : [], t._onloaderror = e.onloaderror ? [{
                                    fn: e.onloaderror
                                }] : [], t._onplayerror = e.onplayerror ? [{
                                    fn: e.onplayerror
                                }] : [], t._onpause = e.onpause ? [{
                                    fn: e.onpause
                                }] : [], t._onplay = e.onplay ? [{
                                    fn: e.onplay
                                }] : [], t._onstop = e.onstop ? [{
                                    fn: e.onstop
                                }] : [], t._onmute = e.onmute ? [{
                                    fn: e.onmute
                                }] : [], t._onvolume = e.onvolume ? [{
                                    fn: e.onvolume
                                }] : [], t._onrate = e.onrate ? [{
                                    fn: e.onrate
                                }] : [], t._onseek = e.onseek ? [{
                                    fn: e.onseek
                                }] : [], t._onunlock = e.onunlock ? [{
                                    fn: e.onunlock
                                }] : [], t._onresume = [], t._webAudio = a.usingWebAudio && !t._html5, "undefined" !== typeof a.ctx && a.ctx && a.autoUnlock && a._unlockAudio(), a._howls.push(t), t._autoplay && t._queue.push({
                                    event: "play",
                                    action: function() {
                                        t.play()
                                    }
                                }), t._preload && "none" !== t._preload && t.load(), t
                            },
                            load: function() {
                                var e = this,
                                    t = null;
                                if (a.noAudio) e._emit("loaderror", null, "No audio support.");
                                else {
                                    "string" === typeof e._src && (e._src = [e._src]);
                                    for (var n = 0; n < e._src.length; n++) {
                                        var r, o;
                                        if (e._format && e._format[n]) r = e._format[n];
                                        else {
                                            if (o = e._src[n], "string" !== typeof o) {
                                                e._emit("loaderror", null, "Non-string found in selected audio sources - ignoring.");
                                                continue
                                            }
                                            r = /^data:audio\/([^;,]+);/i.exec(o), r || (r = /\.([^.]+)$/.exec(o.split("?", 1)[0])), r && (r = r[1].toLowerCase())
                                        }
                                        if (r || console.warn('No file extension was found. Consider using the "format" property or specify an extension.'), r && a.codecs(r)) {
                                            t = e._src[n];
                                            break
                                        }
                                    }
                                    if (t) return e._src = t, e._state = "loading", "https:" === window.location.protocol && "http:" === t.slice(0, 5) && (e._html5 = !0, e._webAudio = !1), new l(e), e._webAudio && d(e), e;
                                    e._emit("loaderror", null, "No codec support for selected audio sources.")
                                }
                            },
                            play: function(e, t) {
                                var n = this,
                                    r = null;
                                if ("number" === typeof e) r = e, e = null;
                                else {
                                    if ("string" === typeof e && "loaded" === n._state && !n._sprite[e]) return null;
                                    if ("undefined" === typeof e && (e = "__default", !n._playLock)) {
                                        for (var o = 0, i = 0; i < n._sounds.length; i++) n._sounds[i]._paused && !n._sounds[i]._ended && (o++, r = n._sounds[i]._id);
                                        1 === o ? e = null : r = null
                                    }
                                }
                                var s = r ? n._soundById(r) : n._inactiveSound();
                                if (!s) return null;
                                if (r && !e && (e = s._sprite || "__default"), "loaded" !== n._state) {
                                    s._sprite = e, s._ended = !1;
                                    var l = s._id;
                                    return n._queue.push({
                                        event: "play",
                                        action: function() {
                                            n.play(l)
                                        }
                                    }), l
                                }
                                if (r && !s._paused) return t || n._loadQueue("play"), s._id;
                                n._webAudio && a._autoResume();
                                var c = Math.max(0, s._seek > 0 ? s._seek : n._sprite[e][0] / 1e3),
                                    d = Math.max(0, (n._sprite[e][0] + n._sprite[e][1]) / 1e3 - c),
                                    u = 1e3 * d / Math.abs(s._rate),
                                    p = n._sprite[e][0] / 1e3,
                                    f = (n._sprite[e][0] + n._sprite[e][1]) / 1e3;
                                s._sprite = e, s._ended = !1;
                                var h = function() {
                                    s._paused = !1, s._seek = c, s._start = p, s._stop = f, s._loop = !(!s._loop && !n._sprite[e][2])
                                };
                                if (!(c >= f)) {
                                    var g = s._node;
                                    if (n._webAudio) {
                                        var v = function() {
                                            n._playLock = !1, h(), n._refreshBuffer(s);
                                            var e = s._muted || n._muted ? 0 : s._volume;
                                            g.gain.setValueAtTime(e, a.ctx.currentTime), s._playStart = a.ctx.currentTime, "undefined" === typeof g.bufferSource.start ? s._loop ? g.bufferSource.noteGrainOn(0, c, 86400) : g.bufferSource.noteGrainOn(0, c, d) : s._loop ? g.bufferSource.start(0, c, 86400) : g.bufferSource.start(0, c, d), u !== 1 / 0 && (n._endTimers[s._id] = setTimeout(n._ended.bind(n, s), u)), t || setTimeout((function() {
                                                n._emit("play", s._id), n._loadQueue()
                                            }), 0)
                                        };
                                        "running" === a.state && "interrupted" !== a.ctx.state ? v() : (n._playLock = !0, n.once("resume", v), n._clearTimer(s._id))
                                    } else {
                                        var m = function() {
                                            g.currentTime = c, g.muted = s._muted || n._muted || a._muted || g.muted, g.volume = s._volume * a.volume(), g.playbackRate = s._rate;
                                            try {
                                                var r = g.play();
                                                if (r && "undefined" !== typeof Promise && (r instanceof Promise || "function" === typeof r.then) ? (n._playLock = !0, h(), r.then((function() {
                                                        n._playLock = !1, g._unlocked = !0, t ? n._loadQueue() : n._emit("play", s._id)
                                                    })).catch((function() {
                                                        n._playLock = !1, n._emit("playerror", s._id, "Playback was unable to start. This is most commonly an issue on mobile devices and Chrome where playback was not within a user interaction."), s._ended = !0, s._paused = !0
                                                    }))) : t || (n._playLock = !1, h(), n._emit("play", s._id)), g.playbackRate = s._rate, g.paused) return void n._emit("playerror", s._id, "Playback was unable to start. This is most commonly an issue on mobile devices and Chrome where playback was not within a user interaction.");
                                                "__default" !== e || s._loop ? n._endTimers[s._id] = setTimeout(n._ended.bind(n, s), u) : (n._endTimers[s._id] = function() {
                                                    n._ended(s), g.removeEventListener("ended", n._endTimers[s._id], !1)
                                                }, g.addEventListener("ended", n._endTimers[s._id], !1))
                                            } catch (o) {
                                                n._emit("playerror", s._id, o)
                                            }
                                        };
                                        "data:audio/wav;base64,UklGRigAAABXQVZFZm10IBIAAAABAAEARKwAAIhYAQACABAAAABkYXRhAgAAAAEA" === g.src && (g.src = n._src, g.load());
                                        var y = window && window.ejecta || !g.readyState && a._navigator.isCocoonJS;
                                        if (g.readyState >= 3 || y) m();
                                        else {
                                            n._playLock = !0, n._state = "loading";
                                            var b = function() {
                                                n._state = "loaded", m(), g.removeEventListener(a._canPlayEvent, b, !1)
                                            };
                                            g.addEventListener(a._canPlayEvent, b, !1), n._clearTimer(s._id)
                                        }
                                    }
                                    return s._id
                                }
                                n._ended(s)
                            },
                            pause: function(e) {
                                var t = this;
                                if ("loaded" !== t._state || t._playLock) return t._queue.push({
                                    event: "pause",
                                    action: function() {
                                        t.pause(e)
                                    }
                                }), t;
                                for (var n = t._getSoundIds(e), r = 0; r < n.length; r++) {
                                    t._clearTimer(n[r]);
                                    var o = t._soundById(n[r]);
                                    if (o && !o._paused && (o._seek = t.seek(n[r]), o._rateSeek = 0, o._paused = !0, t._stopFade(n[r]), o._node))
                                        if (t._webAudio) {
                                            if (!o._node.bufferSource) continue;
                                            "undefined" === typeof o._node.bufferSource.stop ? o._node.bufferSource.noteOff(0) : o._node.bufferSource.stop(0), t._cleanBuffer(o._node)
                                        } else isNaN(o._node.duration) && o._node.duration !== 1 / 0 || o._node.pause();
                                    arguments[1] || t._emit("pause", o ? o._id : null)
                                }
                                return t
                            },
                            stop: function(e, t) {
                                var n = this;
                                if ("loaded" !== n._state || n._playLock) return n._queue.push({
                                    event: "stop",
                                    action: function() {
                                        n.stop(e)
                                    }
                                }), n;
                                for (var r = n._getSoundIds(e), o = 0; o < r.length; o++) {
                                    n._clearTimer(r[o]);
                                    var i = n._soundById(r[o]);
                                    i && (i._seek = i._start || 0, i._rateSeek = 0, i._paused = !0, i._ended = !0, n._stopFade(r[o]), i._node && (n._webAudio ? i._node.bufferSource && ("undefined" === typeof i._node.bufferSource.stop ? i._node.bufferSource.noteOff(0) : i._node.bufferSource.stop(0), n._cleanBuffer(i._node)) : isNaN(i._node.duration) && i._node.duration !== 1 / 0 || (i._node.currentTime = i._start || 0, i._node.pause(), i._node.duration === 1 / 0 && n._clearSound(i._node))), t || n._emit("stop", i._id))
                                }
                                return n
                            },
                            mute: function(e, t) {
                                var n = this;
                                if ("loaded" !== n._state || n._playLock) return n._queue.push({
                                    event: "mute",
                                    action: function() {
                                        n.mute(e, t)
                                    }
                                }), n;
                                if ("undefined" === typeof t) {
                                    if ("boolean" !== typeof e) return n._muted;
                                    n._muted = e
                                }
                                for (var r = n._getSoundIds(t), o = 0; o < r.length; o++) {
                                    var i = n._soundById(r[o]);
                                    i && (i._muted = e, i._interval && n._stopFade(i._id), n._webAudio && i._node ? i._node.gain.setValueAtTime(e ? 0 : i._volume, a.ctx.currentTime) : i._node && (i._node.muted = !!a._muted || e), n._emit("mute", i._id))
                                }
                                return n
                            },
                            volume: function() {
                                var e, t, n, r = this,
                                    o = arguments;
                                if (0 === o.length) return r._volume;
                                if (1 === o.length || 2 === o.length && "undefined" === typeof o[1]) {
                                    var i = r._getSoundIds(),
                                        s = i.indexOf(o[0]);
                                    s >= 0 ? t = parseInt(o[0], 10) : e = parseFloat(o[0])
                                } else o.length >= 2 && (e = parseFloat(o[0]), t = parseInt(o[1], 10));
                                if (!("undefined" !== typeof e && e >= 0 && e <= 1)) return n = t ? r._soundById(t) : r._sounds[0], n ? n._volume : 0;
                                if ("loaded" !== r._state || r._playLock) return r._queue.push({
                                    event: "volume",
                                    action: function() {
                                        r.volume.apply(r, o)
                                    }
                                }), r;
                                "undefined" === typeof t && (r._volume = e), t = r._getSoundIds(t);
                                for (var l = 0; l < t.length; l++) n = r._soundById(t[l]), n && (n._volume = e, o[2] || r._stopFade(t[l]), r._webAudio && n._node && !n._muted ? n._node.gain.setValueAtTime(e, a.ctx.currentTime) : n._node && !n._muted && (n._node.volume = e * a.volume()), r._emit("volume", n._id));
                                return r
                            },
                            fade: function(e, t, n, r) {
                                var o = this;
                                if ("loaded" !== o._state || o._playLock) return o._queue.push({
                                    event: "fade",
                                    action: function() {
                                        o.fade(e, t, n, r)
                                    }
                                }), o;
                                e = Math.min(Math.max(0, parseFloat(e)), 1), t = Math.min(Math.max(0, parseFloat(t)), 1), n = parseFloat(n), o.volume(e, r);
                                for (var i = o._getSoundIds(r), s = 0; s < i.length; s++) {
                                    var l = o._soundById(i[s]);
                                    if (l) {
                                        if (r || o._stopFade(i[s]), o._webAudio && !l._muted) {
                                            var c = a.ctx.currentTime,
                                                d = c + n / 1e3;
                                            l._volume = e, l._node.gain.setValueAtTime(e, c), l._node.gain.linearRampToValueAtTime(t, d)
                                        }
                                        o._startFadeInterval(l, e, t, n, i[s], "undefined" === typeof r)
                                    }
                                }
                                return o
                            },
                            _startFadeInterval: function(e, t, n, r, o, i) {
                                var a = this,
                                    s = t,
                                    l = n - t,
                                    c = Math.abs(l / .01),
                                    d = Math.max(4, c > 0 ? r / c : r),
                                    u = Date.now();
                                e._fadeTo = n, e._interval = setInterval((function() {
                                    var o = (Date.now() - u) / r;
                                    u = Date.now(), s += l * o, s = Math.round(100 * s) / 100, s = l < 0 ? Math.max(n, s) : Math.min(n, s), a._webAudio ? e._volume = s : a.volume(s, e._id, !0), i && (a._volume = s), (n < t && s <= n || n > t && s >= n) && (clearInterval(e._interval), e._interval = null, e._fadeTo = null, a.volume(n, e._id), a._emit("fade", e._id))
                                }), d)
                            },
                            _stopFade: function(e) {
                                var t = this,
                                    n = t._soundById(e);
                                return n && n._interval && (t._webAudio && n._node.gain.cancelScheduledValues(a.ctx.currentTime), clearInterval(n._interval), n._interval = null, t.volume(n._fadeTo, e), n._fadeTo = null, t._emit("fade", e)), t
                            },
                            loop: function() {
                                var e, t, n, r = this,
                                    o = arguments;
                                if (0 === o.length) return r._loop;
                                if (1 === o.length) {
                                    if ("boolean" !== typeof o[0]) return n = r._soundById(parseInt(o[0], 10)), !!n && n._loop;
                                    e = o[0], r._loop = e
                                } else 2 === o.length && (e = o[0], t = parseInt(o[1], 10));
                                for (var i = r._getSoundIds(t), a = 0; a < i.length; a++) n = r._soundById(i[a]), n && (n._loop = e, r._webAudio && n._node && n._node.bufferSource && (n._node.bufferSource.loop = e, e && (n._node.bufferSource.loopStart = n._start || 0, n._node.bufferSource.loopEnd = n._stop, r.playing(i[a]) && (r.pause(i[a], !0), r.play(i[a], !0)))));
                                return r
                            },
                            rate: function() {
                                var e, t, n, r = this,
                                    o = arguments;
                                if (0 === o.length) t = r._sounds[0]._id;
                                else if (1 === o.length) {
                                    var i = r._getSoundIds(),
                                        s = i.indexOf(o[0]);
                                    s >= 0 ? t = parseInt(o[0], 10) : e = parseFloat(o[0])
                                } else 2 === o.length && (e = parseFloat(o[0]), t = parseInt(o[1], 10));
                                if ("number" !== typeof e) return n = r._soundById(t), n ? n._rate : r._rate;
                                if ("loaded" !== r._state || r._playLock) return r._queue.push({
                                    event: "rate",
                                    action: function() {
                                        r.rate.apply(r, o)
                                    }
                                }), r;
                                "undefined" === typeof t && (r._rate = e), t = r._getSoundIds(t);
                                for (var l = 0; l < t.length; l++)
                                    if (n = r._soundById(t[l]), n) {
                                        r.playing(t[l]) && (n._rateSeek = r.seek(t[l]), n._playStart = r._webAudio ? a.ctx.currentTime : n._playStart), n._rate = e, r._webAudio && n._node && n._node.bufferSource ? n._node.bufferSource.playbackRate.setValueAtTime(e, a.ctx.currentTime) : n._node && (n._node.playbackRate = e);
                                        var c = r.seek(t[l]),
                                            d = (r._sprite[n._sprite][0] + r._sprite[n._sprite][1]) / 1e3 - c,
                                            u = 1e3 * d / Math.abs(n._rate);
                                        !r._endTimers[t[l]] && n._paused || (r._clearTimer(t[l]), r._endTimers[t[l]] = setTimeout(r._ended.bind(r, n), u)), r._emit("rate", n._id)
                                    } return r
                            },
                            seek: function() {
                                var e, t, n = this,
                                    r = arguments;
                                if (0 === r.length) n._sounds.length && (t = n._sounds[0]._id);
                                else if (1 === r.length) {
                                    var o = n._getSoundIds(),
                                        i = o.indexOf(r[0]);
                                    i >= 0 ? t = parseInt(r[0], 10) : n._sounds.length && (t = n._sounds[0]._id, e = parseFloat(r[0]))
                                } else 2 === r.length && (e = parseFloat(r[0]), t = parseInt(r[1], 10));
                                if ("undefined" === typeof t) return 0;
                                if ("number" === typeof e && ("loaded" !== n._state || n._playLock)) return n._queue.push({
                                    event: "seek",
                                    action: function() {
                                        n.seek.apply(n, r)
                                    }
                                }), n;
                                var s = n._soundById(t);
                                if (s) {
                                    if (!("number" === typeof e && e >= 0)) {
                                        if (n._webAudio) {
                                            var l = n.playing(t) ? a.ctx.currentTime - s._playStart : 0,
                                                c = s._rateSeek ? s._rateSeek - s._seek : 0;
                                            return s._seek + (c + l * Math.abs(s._rate))
                                        }
                                        return s._node.currentTime
                                    }
                                    var d = n.playing(t);
                                    d && n.pause(t, !0), s._seek = e, s._ended = !1, n._clearTimer(t), n._webAudio || !s._node || isNaN(s._node.duration) || (s._node.currentTime = e);
                                    var u = function() {
                                        d && n.play(t, !0), n._emit("seek", t)
                                    };
                                    if (d && !n._webAudio) {
                                        var p = function() {
                                            n._playLock ? setTimeout(p, 0) : u()
                                        };
                                        setTimeout(p, 0)
                                    } else u()
                                }
                                return n
                            },
                            playing: function(e) {
                                var t = this;
                                if ("number" === typeof e) {
                                    var n = t._soundById(e);
                                    return !!n && !n._paused
                                }
                                for (var r = 0; r < t._sounds.length; r++)
                                    if (!t._sounds[r]._paused) return !0;
                                return !1
                            },
                            duration: function(e) {
                                var t = this,
                                    n = t._duration,
                                    r = t._soundById(e);
                                return r && (n = t._sprite[r._sprite][1] / 1e3), n
                            },
                            state: function() {
                                return this._state
                            },
                            unload: function() {
                                for (var e = this, t = e._sounds, n = 0; n < t.length; n++) t[n]._paused || e.stop(t[n]._id), e._webAudio || (e._clearSound(t[n]._node), t[n]._node.removeEventListener("error", t[n]._errorFn, !1), t[n]._node.removeEventListener(a._canPlayEvent, t[n]._loadFn, !1), t[n]._node.removeEventListener("ended", t[n]._endFn, !1), a._releaseHtml5Audio(t[n]._node)), delete t[n]._node, e._clearTimer(t[n]._id);
                                var r = a._howls.indexOf(e);
                                r >= 0 && a._howls.splice(r, 1);
                                var o = !0;
                                for (n = 0; n < a._howls.length; n++)
                                    if (a._howls[n]._src === e._src || e._src.indexOf(a._howls[n]._src) >= 0) {
                                        o = !1;
                                        break
                                    } return c && o && delete c[e._src], a.noAudio = !1, e._state = "unloaded", e._sounds = [], e = null, null
                            },
                            on: function(e, t, n, r) {
                                var o = this,
                                    i = o["_on" + e];
                                return "function" === typeof t && i.push(r ? {
                                    id: n,
                                    fn: t,
                                    once: r
                                } : {
                                    id: n,
                                    fn: t
                                }), o
                            },
                            off: function(e, t, n) {
                                var r = this,
                                    o = r["_on" + e],
                                    i = 0;
                                if ("number" === typeof t && (n = t, t = null), t || n)
                                    for (i = 0; i < o.length; i++) {
                                        var a = n === o[i].id;
                                        if (t === o[i].fn && a || !t && a) {
                                            o.splice(i, 1);
                                            break
                                        }
                                    } else if (e) r["_on" + e] = [];
                                    else {
                                        var s = Object.keys(r);
                                        for (i = 0; i < s.length; i++) 0 === s[i].indexOf("_on") && Array.isArray(r[s[i]]) && (r[s[i]] = [])
                                    } return r
                            },
                            once: function(e, t, n) {
                                var r = this;
                                return r.on(e, t, n, 1), r
                            },
                            _emit: function(e, t, n) {
                                for (var r = this, o = r["_on" + e], i = o.length - 1; i >= 0; i--) o[i].id && o[i].id !== t && "load" !== e || (setTimeout(function(e) {
                                    e.call(this, t, n)
                                }.bind(r, o[i].fn), 0), o[i].once && r.off(e, o[i].fn, o[i].id));
                                return r._loadQueue(e), r
                            },
                            _loadQueue: function(e) {
                                var t = this;
                                if (t._queue.length > 0) {
                                    var n = t._queue[0];
                                    n.event === e && (t._queue.shift(), t._loadQueue()), e || n.action()
                                }
                                return t
                            },
                            _ended: function(e) {
                                var t = this,
                                    n = e._sprite;
                                if (!t._webAudio && e._node && !e._node.paused && !e._node.ended && e._node.currentTime < e._stop) return setTimeout(t._ended.bind(t, e), 100), t;
                                var r = !(!e._loop && !t._sprite[n][2]);
                                if (t._emit("end", e._id), !t._webAudio && r && t.stop(e._id, !0).play(e._id), t._webAudio && r) {
                                    t._emit("play", e._id), e._seek = e._start || 0, e._rateSeek = 0, e._playStart = a.ctx.currentTime;
                                    var o = 1e3 * (e._stop - e._start) / Math.abs(e._rate);
                                    t._endTimers[e._id] = setTimeout(t._ended.bind(t, e), o)
                                }
                                return t._webAudio && !r && (e._paused = !0, e._ended = !0, e._seek = e._start || 0, e._rateSeek = 0, t._clearTimer(e._id), t._cleanBuffer(e._node), a._autoSuspend()), t._webAudio || r || t.stop(e._id, !0), t
                            },
                            _clearTimer: function(e) {
                                var t = this;
                                if (t._endTimers[e]) {
                                    if ("function" !== typeof t._endTimers[e]) clearTimeout(t._endTimers[e]);
                                    else {
                                        var n = t._soundById(e);
                                        n && n._node && n._node.removeEventListener("ended", t._endTimers[e], !1)
                                    }
                                    delete t._endTimers[e]
                                }
                                return t
                            },
                            _soundById: function(e) {
                                for (var t = this, n = 0; n < t._sounds.length; n++)
                                    if (e === t._sounds[n]._id) return t._sounds[n];
                                return null
                            },
                            _inactiveSound: function() {
                                var e = this;
                                e._drain();
                                for (var t = 0; t < e._sounds.length; t++)
                                    if (e._sounds[t]._ended) return e._sounds[t].reset();
                                return new l(e)
                            },
                            _drain: function() {
                                var e = this,
                                    t = e._pool,
                                    n = 0,
                                    r = 0;
                                if (!(e._sounds.length < t)) {
                                    for (r = 0; r < e._sounds.length; r++) e._sounds[r]._ended && n++;
                                    for (r = e._sounds.length - 1; r >= 0; r--) {
                                        if (n <= t) return;
                                        e._sounds[r]._ended && (e._webAudio && e._sounds[r]._node && e._sounds[r]._node.disconnect(0), e._sounds.splice(r, 1), n--)
                                    }
                                }
                            },
                            _getSoundIds: function(e) {
                                var t = this;
                                if ("undefined" === typeof e) {
                                    for (var n = [], r = 0; r < t._sounds.length; r++) n.push(t._sounds[r]._id);
                                    return n
                                }
                                return [e]
                            },
                            _refreshBuffer: function(e) {
                                var t = this;
                                return e._node.bufferSource = a.ctx.createBufferSource(), e._node.bufferSource.buffer = c[t._src], e._panner ? e._node.bufferSource.connect(e._panner) : e._node.bufferSource.connect(e._node), e._node.bufferSource.loop = e._loop, e._loop && (e._node.bufferSource.loopStart = e._start || 0, e._node.bufferSource.loopEnd = e._stop || 0), e._node.bufferSource.playbackRate.setValueAtTime(e._rate, a.ctx.currentTime), t
                            },
                            _cleanBuffer: function(e) {
                                var t = this,
                                    n = a._navigator && a._navigator.vendor.indexOf("Apple") >= 0;
                                if (a._scratchBuffer && e.bufferSource && (e.bufferSource.onended = null, e.bufferSource.disconnect(0), n)) try {
                                    e.bufferSource.buffer = a._scratchBuffer
                                } catch (r) {}
                                return e.bufferSource = null, t
                            },
                            _clearSound: function(e) {
                                var t = /MSIE |Trident\//.test(a._navigator && a._navigator.userAgent);
                                t || (e.src = "data:audio/wav;base64,UklGRigAAABXQVZFZm10IBIAAAABAAEARKwAAIhYAQACABAAAABkYXRhAgAAAAEA")
                            }
                        };
                        var l = function(e) {
                            this._parent = e, this.init()
                        };
                        l.prototype = {
                            init: function() {
                                var e = this,
                                    t = e._parent;
                                return e._muted = t._muted, e._loop = t._loop, e._volume = t._volume, e._rate = t._rate, e._seek = 0, e._paused = !0, e._ended = !0, e._sprite = "__default", e._id = ++a._counter, t._sounds.push(e), e.create(), e
                            },
                            create: function() {
                                var e = this,
                                    t = e._parent,
                                    n = a._muted || e._muted || e._parent._muted ? 0 : e._volume;
                                return t._webAudio ? (e._node = "undefined" === typeof a.ctx.createGain ? a.ctx.createGainNode() : a.ctx.createGain(), e._node.gain.setValueAtTime(n, a.ctx.currentTime), e._node.paused = !0, e._node.connect(a.masterGain)) : a.noAudio || (e._node = a._obtainHtml5Audio(), e._errorFn = e._errorListener.bind(e), e._node.addEventListener("error", e._errorFn, !1), e._loadFn = e._loadListener.bind(e), e._node.addEventListener(a._canPlayEvent, e._loadFn, !1), e._endFn = e._endListener.bind(e), e._node.addEventListener("ended", e._endFn, !1), e._node.src = t._src, e._node.preload = !0 === t._preload ? "auto" : t._preload, e._node.volume = n * a.volume(), e._node.load()), e
                            },
                            reset: function() {
                                var e = this,
                                    t = e._parent;
                                return e._muted = t._muted, e._loop = t._loop, e._volume = t._volume, e._rate = t._rate, e._seek = 0, e._rateSeek = 0, e._paused = !0, e._ended = !0, e._sprite = "__default", e._id = ++a._counter, e
                            },
                            _errorListener: function() {
                                var e = this;
                                e._parent._emit("loaderror", e._id, e._node.error ? e._node.error.code : 0), e._node.removeEventListener("error", e._errorFn, !1)
                            },
                            _loadListener: function() {
                                var e = this,
                                    t = e._parent;
                                t._duration = Math.ceil(10 * e._node.duration) / 10, 0 === Object.keys(t._sprite).length && (t._sprite = {
                                    __default: [0, 1e3 * t._duration]
                                }), "loaded" !== t._state && (t._state = "loaded", t._emit("load"), t._loadQueue()), e._node.removeEventListener(a._canPlayEvent, e._loadFn, !1)
                            },
                            _endListener: function() {
                                var e = this,
                                    t = e._parent;
                                t._duration === 1 / 0 && (t._duration = Math.ceil(10 * e._node.duration) / 10, t._sprite.__default[1] === 1 / 0 && (t._sprite.__default[1] = 1e3 * t._duration), t._ended(e)), e._node.removeEventListener("ended", e._endFn, !1)
                            }
                        };
                        var c = {},
                            d = function(e) {
                                var t = e._src;
                                if (c[t]) return e._duration = c[t].duration, void f(e);
                                if (/^data:[^;]+;base64,/.test(t)) {
                                    for (var n = atob(t.split(",")[1]), r = new Uint8Array(n.length), o = 0; o < n.length; ++o) r[o] = n.charCodeAt(o);
                                    p(r.buffer, e)
                                } else {
                                    var i = new XMLHttpRequest;
                                    i.open(e._xhr.method, t, !0), i.withCredentials = e._xhr.withCredentials, i.responseType = "arraybuffer", e._xhr.headers && Object.keys(e._xhr.headers).forEach((function(t) {
                                        i.setRequestHeader(t, e._xhr.headers[t])
                                    })), i.onload = function() {
                                        var t = (i.status + "")[0];
                                        "0" === t || "2" === t || "3" === t ? p(i.response, e) : e._emit("loaderror", null, "Failed loading audio file with status: " + i.status + ".")
                                    }, i.onerror = function() {
                                        e._webAudio && (e._html5 = !0, e._webAudio = !1, e._sounds = [], delete c[t], e.load())
                                    }, u(i)
                                }
                            },
                            u = function(e) {
                                try {
                                    e.send()
                                } catch (t) {
                                    e.onerror()
                                }
                            },
                            p = function(e, t) {
                                var n = function() {
                                        t._emit("loaderror", null, "Decoding audio data failed.")
                                    },
                                    r = function(e) {
                                        e && t._sounds.length > 0 ? (c[t._src] = e, f(t, e)) : n()
                                    };
                                "undefined" !== typeof Promise && 1 === a.ctx.decodeAudioData.length ? a.ctx.decodeAudioData(e).then(r).catch(n) : a.ctx.decodeAudioData(e, r, n)
                            },
                            f = function(e, t) {
                                t && !e._duration && (e._duration = t.duration), 0 === Object.keys(e._sprite).length && (e._sprite = {
                                    __default: [0, 1e3 * e._duration]
                                }), "loaded" !== e._state && (e._state = "loaded", e._emit("load"), e._loadQueue())
                            },
                            h = function() {
                                if (a.usingWebAudio) {
                                    try {
                                        "undefined" !== typeof AudioContext ? a.ctx = new AudioContext : "undefined" !== typeof webkitAudioContext ? a.ctx = new webkitAudioContext : a.usingWebAudio = !1
                                    } catch (o) {
                                        a.usingWebAudio = !1
                                    }
                                    a.ctx || (a.usingWebAudio = !1);
                                    var e = /iP(hone|od|ad)/.test(a._navigator && a._navigator.platform),
                                        t = a._navigator && a._navigator.appVersion.match(/OS (\d+)_(\d+)_?(\d+)?/),
                                        n = t ? parseInt(t[1], 10) : null;
                                    if (e && n && n < 9) {
                                        var r = /safari/.test(a._navigator && a._navigator.userAgent.toLowerCase());
                                        a._navigator && !r && (a.usingWebAudio = !1)
                                    }
                                    a.usingWebAudio && (a.masterGain = "undefined" === typeof a.ctx.createGain ? a.ctx.createGainNode() : a.ctx.createGain(), a.masterGain.gain.setValueAtTime(a._muted ? 0 : a._volume, a.ctx.currentTime), a.masterGain.connect(a.ctx.destination)), a._setup()
                                }
                            };
                        r = [], o = function() {
                            return {
                                Howler: a,
                                Howl: s
                            }
                        }.apply(t, r), void 0 === o || (e.exports = o), t.Howler = a, t.Howl = s, "undefined" !== typeof n.g ? (n.g.HowlerGlobal = i, n.g.Howler = a, n.g.Howl = s, n.g.Sound = l) : "undefined" !== typeof window && (window.HowlerGlobal = i, window.Howler = a, window.Howl = s, window.Sound = l)
                    }(),
                    /*!
                     *  Spatial Plugin - Adds support for stereo and 3D audio where Web Audio is supported.
                     *  
                     *  howler.js v2.2.3
                     *  howlerjs.com
                     *
                     *  (c) 2013-2020, James Simpson of GoldFire Studios
                     *  goldfirestudios.com
                     *
                     *  MIT License
                     */
                    function() {
                        "use strict";
                        HowlerGlobal.prototype._pos = [0, 0, 0], HowlerGlobal.prototype._orientation = [0, 0, -1, 0, 1, 0], HowlerGlobal.prototype.stereo = function(e) {
                            var t = this;
                            if (!t.ctx || !t.ctx.listener) return t;
                            for (var n = t._howls.length - 1; n >= 0; n--) t._howls[n].stereo(e);
                            return t
                        }, HowlerGlobal.prototype.pos = function(e, t, n) {
                            var r = this;
                            return r.ctx && r.ctx.listener ? (t = "number" !== typeof t ? r._pos[1] : t, n = "number" !== typeof n ? r._pos[2] : n, "number" !== typeof e ? r._pos : (r._pos = [e, t, n], "undefined" !== typeof r.ctx.listener.positionX ? (r.ctx.listener.positionX.setTargetAtTime(r._pos[0], Howler.ctx.currentTime, .1), r.ctx.listener.positionY.setTargetAtTime(r._pos[1], Howler.ctx.currentTime, .1), r.ctx.listener.positionZ.setTargetAtTime(r._pos[2], Howler.ctx.currentTime, .1)) : r.ctx.listener.setPosition(r._pos[0], r._pos[1], r._pos[2]), r)) : r
                        }, HowlerGlobal.prototype.orientation = function(e, t, n, r, o, i) {
                            var a = this;
                            if (!a.ctx || !a.ctx.listener) return a;
                            var s = a._orientation;
                            return t = "number" !== typeof t ? s[1] : t, n = "number" !== typeof n ? s[2] : n, r = "number" !== typeof r ? s[3] : r, o = "number" !== typeof o ? s[4] : o, i = "number" !== typeof i ? s[5] : i, "number" !== typeof e ? s : (a._orientation = [e, t, n, r, o, i], "undefined" !== typeof a.ctx.listener.forwardX ? (a.ctx.listener.forwardX.setTargetAtTime(e, Howler.ctx.currentTime, .1), a.ctx.listener.forwardY.setTargetAtTime(t, Howler.ctx.currentTime, .1), a.ctx.listener.forwardZ.setTargetAtTime(n, Howler.ctx.currentTime, .1), a.ctx.listener.upX.setTargetAtTime(r, Howler.ctx.currentTime, .1), a.ctx.listener.upY.setTargetAtTime(o, Howler.ctx.currentTime, .1), a.ctx.listener.upZ.setTargetAtTime(i, Howler.ctx.currentTime, .1)) : a.ctx.listener.setOrientation(e, t, n, r, o, i), a)
                        }, Howl.prototype.init = function(e) {
                            return function(t) {
                                var n = this;
                                return n._orientation = t.orientation || [1, 0, 0], n._stereo = t.stereo || null, n._pos = t.pos || null, n._pannerAttr = {
                                    coneInnerAngle: "undefined" !== typeof t.coneInnerAngle ? t.coneInnerAngle : 360,
                                    coneOuterAngle: "undefined" !== typeof t.coneOuterAngle ? t.coneOuterAngle : 360,
                                    coneOuterGain: "undefined" !== typeof t.coneOuterGain ? t.coneOuterGain : 0,
                                    distanceModel: "undefined" !== typeof t.distanceModel ? t.distanceModel : "inverse",
                                    maxDistance: "undefined" !== typeof t.maxDistance ? t.maxDistance : 1e4,
                                    panningModel: "undefined" !== typeof t.panningModel ? t.panningModel : "HRTF",
                                    refDistance: "undefined" !== typeof t.refDistance ? t.refDistance : 1,
                                    rolloffFactor: "undefined" !== typeof t.rolloffFactor ? t.rolloffFactor : 1
                                }, n._onstereo = t.onstereo ? [{
                                    fn: t.onstereo
                                }] : [], n._onpos = t.onpos ? [{
                                    fn: t.onpos
                                }] : [], n._onorientation = t.onorientation ? [{
                                    fn: t.onorientation
                                }] : [], e.call(this, t)
                            }
                        }(Howl.prototype.init), Howl.prototype.stereo = function(t, n) {
                            var r = this;
                            if (!r._webAudio) return r;
                            if ("loaded" !== r._state) return r._queue.push({
                                event: "stereo",
                                action: function() {
                                    r.stereo(t, n)
                                }
                            }), r;
                            var o = "undefined" === typeof Howler.ctx.createStereoPanner ? "spatial" : "stereo";
                            if ("undefined" === typeof n) {
                                if ("number" !== typeof t) return r._stereo;
                                r._stereo = t, r._pos = [t, 0, 0]
                            }
                            for (var i = r._getSoundIds(n), a = 0; a < i.length; a++) {
                                var s = r._soundById(i[a]);
                                if (s) {
                                    if ("number" !== typeof t) return s._stereo;
                                    s._stereo = t, s._pos = [t, 0, 0], s._node && (s._pannerAttr.panningModel = "equalpower", s._panner && s._panner.pan || e(s, o), "spatial" === o ? "undefined" !== typeof s._panner.positionX ? (s._panner.positionX.setValueAtTime(t, Howler.ctx.currentTime), s._panner.positionY.setValueAtTime(0, Howler.ctx.currentTime), s._panner.positionZ.setValueAtTime(0, Howler.ctx.currentTime)) : s._panner.setPosition(t, 0, 0) : s._panner.pan.setValueAtTime(t, Howler.ctx.currentTime)), r._emit("stereo", s._id)
                                }
                            }
                            return r
                        }, Howl.prototype.pos = function(t, n, r, o) {
                            var i = this;
                            if (!i._webAudio) return i;
                            if ("loaded" !== i._state) return i._queue.push({
                                event: "pos",
                                action: function() {
                                    i.pos(t, n, r, o)
                                }
                            }), i;
                            if (n = "number" !== typeof n ? 0 : n, r = "number" !== typeof r ? -.5 : r, "undefined" === typeof o) {
                                if ("number" !== typeof t) return i._pos;
                                i._pos = [t, n, r]
                            }
                            for (var a = i._getSoundIds(o), s = 0; s < a.length; s++) {
                                var l = i._soundById(a[s]);
                                if (l) {
                                    if ("number" !== typeof t) return l._pos;
                                    l._pos = [t, n, r], l._node && (l._panner && !l._panner.pan || e(l, "spatial"), "undefined" !== typeof l._panner.positionX ? (l._panner.positionX.setValueAtTime(t, Howler.ctx.currentTime), l._panner.positionY.setValueAtTime(n, Howler.ctx.currentTime), l._panner.positionZ.setValueAtTime(r, Howler.ctx.currentTime)) : l._panner.setPosition(t, n, r)), i._emit("pos", l._id)
                                }
                            }
                            return i
                        }, Howl.prototype.orientation = function(t, n, r, o) {
                            var i = this;
                            if (!i._webAudio) return i;
                            if ("loaded" !== i._state) return i._queue.push({
                                event: "orientation",
                                action: function() {
                                    i.orientation(t, n, r, o)
                                }
                            }), i;
                            if (n = "number" !== typeof n ? i._orientation[1] : n, r = "number" !== typeof r ? i._orientation[2] : r, "undefined" === typeof o) {
                                if ("number" !== typeof t) return i._orientation;
                                i._orientation = [t, n, r]
                            }
                            for (var a = i._getSoundIds(o), s = 0; s < a.length; s++) {
                                var l = i._soundById(a[s]);
                                if (l) {
                                    if ("number" !== typeof t) return l._orientation;
                                    l._orientation = [t, n, r], l._node && (l._panner || (l._pos || (l._pos = i._pos || [0, 0, -.5]), e(l, "spatial")), "undefined" !== typeof l._panner.orientationX ? (l._panner.orientationX.setValueAtTime(t, Howler.ctx.currentTime), l._panner.orientationY.setValueAtTime(n, Howler.ctx.currentTime), l._panner.orientationZ.setValueAtTime(r, Howler.ctx.currentTime)) : l._panner.setOrientation(t, n, r)), i._emit("orientation", l._id)
                                }
                            }
                            return i
                        }, Howl.prototype.pannerAttr = function() {
                            var t, n, r, o = this,
                                i = arguments;
                            if (!o._webAudio) return o;
                            if (0 === i.length) return o._pannerAttr;
                            if (1 === i.length) {
                                if ("object" !== typeof i[0]) return r = o._soundById(parseInt(i[0], 10)), r ? r._pannerAttr : o._pannerAttr;
                                t = i[0], "undefined" === typeof n && (t.pannerAttr || (t.pannerAttr = {
                                    coneInnerAngle: t.coneInnerAngle,
                                    coneOuterAngle: t.coneOuterAngle,
                                    coneOuterGain: t.coneOuterGain,
                                    distanceModel: t.distanceModel,
                                    maxDistance: t.maxDistance,
                                    refDistance: t.refDistance,
                                    rolloffFactor: t.rolloffFactor,
                                    panningModel: t.panningModel
                                }), o._pannerAttr = {
                                    coneInnerAngle: "undefined" !== typeof t.pannerAttr.coneInnerAngle ? t.pannerAttr.coneInnerAngle : o._coneInnerAngle,
                                    coneOuterAngle: "undefined" !== typeof t.pannerAttr.coneOuterAngle ? t.pannerAttr.coneOuterAngle : o._coneOuterAngle,
                                    coneOuterGain: "undefined" !== typeof t.pannerAttr.coneOuterGain ? t.pannerAttr.coneOuterGain : o._coneOuterGain,
                                    distanceModel: "undefined" !== typeof t.pannerAttr.distanceModel ? t.pannerAttr.distanceModel : o._distanceModel,
                                    maxDistance: "undefined" !== typeof t.pannerAttr.maxDistance ? t.pannerAttr.maxDistance : o._maxDistance,
                                    refDistance: "undefined" !== typeof t.pannerAttr.refDistance ? t.pannerAttr.refDistance : o._refDistance,
                                    rolloffFactor: "undefined" !== typeof t.pannerAttr.rolloffFactor ? t.pannerAttr.rolloffFactor : o._rolloffFactor,
                                    panningModel: "undefined" !== typeof t.pannerAttr.panningModel ? t.pannerAttr.panningModel : o._panningModel
                                })
                            } else 2 === i.length && (t = i[0], n = parseInt(i[1], 10));
                            for (var a = o._getSoundIds(n), s = 0; s < a.length; s++)
                                if (r = o._soundById(a[s]), r) {
                                    var l = r._pannerAttr;
                                    l = {
                                        coneInnerAngle: "undefined" !== typeof t.coneInnerAngle ? t.coneInnerAngle : l.coneInnerAngle,
                                        coneOuterAngle: "undefined" !== typeof t.coneOuterAngle ? t.coneOuterAngle : l.coneOuterAngle,
                                        coneOuterGain: "undefined" !== typeof t.coneOuterGain ? t.coneOuterGain : l.coneOuterGain,
                                        distanceModel: "undefined" !== typeof t.distanceModel ? t.distanceModel : l.distanceModel,
                                        maxDistance: "undefined" !== typeof t.maxDistance ? t.maxDistance : l.maxDistance,
                                        refDistance: "undefined" !== typeof t.refDistance ? t.refDistance : l.refDistance,
                                        rolloffFactor: "undefined" !== typeof t.rolloffFactor ? t.rolloffFactor : l.rolloffFactor,
                                        panningModel: "undefined" !== typeof t.panningModel ? t.panningModel : l.panningModel
                                    };
                                    var c = r._panner;
                                    c ? (c.coneInnerAngle = l.coneInnerAngle, c.coneOuterAngle = l.coneOuterAngle, c.coneOuterGain = l.coneOuterGain, c.distanceModel = l.distanceModel, c.maxDistance = l.maxDistance, c.refDistance = l.refDistance, c.rolloffFactor = l.rolloffFactor, c.panningModel = l.panningModel) : (r._pos || (r._pos = o._pos || [0, 0, -.5]), e(r, "spatial"))
                                } return o
                        }, Sound.prototype.init = function(e) {
                            return function() {
                                var t = this,
                                    n = t._parent;
                                t._orientation = n._orientation, t._stereo = n._stereo, t._pos = n._pos, t._pannerAttr = n._pannerAttr, e.call(this), t._stereo ? n.stereo(t._stereo) : t._pos && n.pos(t._pos[0], t._pos[1], t._pos[2], t._id)
                            }
                        }(Sound.prototype.init), Sound.prototype.reset = function(e) {
                            return function() {
                                var t = this,
                                    n = t._parent;
                                return t._orientation = n._orientation, t._stereo = n._stereo, t._pos = n._pos, t._pannerAttr = n._pannerAttr, t._stereo ? n.stereo(t._stereo) : t._pos ? n.pos(t._pos[0], t._pos[1], t._pos[2], t._id) : t._panner && (t._panner.disconnect(0), t._panner = void 0, n._refreshBuffer(t)), e.call(this)
                            }
                        }(Sound.prototype.reset);
                        var e = function(e, t) {
                            t = t || "spatial", "spatial" === t ? (e._panner = Howler.ctx.createPanner(), e._panner.coneInnerAngle = e._pannerAttr.coneInnerAngle, e._panner.coneOuterAngle = e._pannerAttr.coneOuterAngle, e._panner.coneOuterGain = e._pannerAttr.coneOuterGain, e._panner.distanceModel = e._pannerAttr.distanceModel, e._panner.maxDistance = e._pannerAttr.maxDistance, e._panner.refDistance = e._pannerAttr.refDistance, e._panner.rolloffFactor = e._pannerAttr.rolloffFactor, e._panner.panningModel = e._pannerAttr.panningModel, "undefined" !== typeof e._panner.positionX ? (e._panner.positionX.setValueAtTime(e._pos[0], Howler.ctx.currentTime), e._panner.positionY.setValueAtTime(e._pos[1], Howler.ctx.currentTime), e._panner.positionZ.setValueAtTime(e._pos[2], Howler.ctx.currentTime)) : e._panner.setPosition(e._pos[0], e._pos[1], e._pos[2]), "undefined" !== typeof e._panner.orientationX ? (e._panner.orientationX.setValueAtTime(e._orientation[0], Howler.ctx.currentTime), e._panner.orientationY.setValueAtTime(e._orientation[1], Howler.ctx.currentTime), e._panner.orientationZ.setValueAtTime(e._orientation[2], Howler.ctx.currentTime)) : e._panner.setOrientation(e._orientation[0], e._orientation[1], e._orientation[2])) : (e._panner = Howler.ctx.createStereoPanner(), e._panner.pan.setValueAtTime(e._stereo, Howler.ctx.currentTime)), e._panner.connect(e._node), e._paused || e._parent.pause(e._id, !0).play(e._id, !0)
                        }
                    }()
            },
            89: function(e, t) {
                "use strict";
                t.Z = (e, t) => {
                    const n = e.__vccOpts || e;
                    for (const [r, o] of t) n[r] = o;
                    return n
                }
            },
            7062: function(e, t, n) {
                var r = n(6552);
                r.__esModule && (r = r.default), "string" === typeof r && (r = [
                    [e.id, r, ""]
                ]), r.locals && (e.exports = r.locals);
                var o = n(7037).Z;
                o("705b8202", r, !0, {
                    sourceMap: !1,
                    shadowMode: !1
                })
            },
            5328: function(e, t, n) {
                var r = n(9983);
                r.__esModule && (r = r.default), "string" === typeof r && (r = [
                    [e.id, r, ""]
                ]), r.locals && (e.exports = r.locals);
                var o = n(7037).Z;
                o("385961ce", r, !0, {
                    sourceMap: !1,
                    shadowMode: !1
                })
            },
            3865: function(e, t, n) {
                var r = n(356);
                r.__esModule && (r = r.default), "string" === typeof r && (r = [
                    [e.id, r, ""]
                ]), r.locals && (e.exports = r.locals);
                var o = n(7037).Z;
                o("223c34ba", r, !0, {
                    sourceMap: !1,
                    shadowMode: !1
                })
            },
            7867: function(e, t, n) {
                var r = n(8295);
                r.__esModule && (r = r.default), "string" === typeof r && (r = [
                    [e.id, r, ""]
                ]), r.locals && (e.exports = r.locals);
                var o = n(7037).Z;
                o("4f742082", r, !0, {
                    sourceMap: !1,
                    shadowMode: !1
                })
            },
            9667: function(e, t, n) {
                var r = n(2883);
                r.__esModule && (r = r.default), "string" === typeof r && (r = [
                    [e.id, r, ""]
                ]), r.locals && (e.exports = r.locals);
                var o = n(7037).Z;
                o("6b1149f1", r, !0, {
                    sourceMap: !1,
                    shadowMode: !1
                })
            },
            6143: function(e, t, n) {
                var r = n(3433);
                r.__esModule && (r = r.default), "string" === typeof r && (r = [
                    [e.id, r, ""]
                ]), r.locals && (e.exports = r.locals);
                var o = n(7037).Z;
                o("46e88d29", r, !0, {
                    sourceMap: !1,
                    shadowMode: !1
                })
            },
            7837: function(e, t, n) {
                var r = n(3315);
                r.__esModule && (r = r.default), "string" === typeof r && (r = [
                    [e.id, r, ""]
                ]), r.locals && (e.exports = r.locals);
                var o = n(7037).Z;
                o("3a0c7092", r, !0, {
                    sourceMap: !1,
                    shadowMode: !1
                })
            },
            3912: function(e, t, n) {
                var r = n(7660);
                r.__esModule && (r = r.default), "string" === typeof r && (r = [
                    [e.id, r, ""]
                ]), r.locals && (e.exports = r.locals);
                var o = n(7037).Z;
                o("32842b0c", r, !0, {
                    sourceMap: !1,
                    shadowMode: !1
                })
            },
            5225: function(e, t, n) {
                var r = n(468);
                r.__esModule && (r = r.default), "string" === typeof r && (r = [
                    [e.id, r, ""]
                ]), r.locals && (e.exports = r.locals);
                var o = n(7037).Z;
                o("216d469e", r, !0, {
                    sourceMap: !1,
                    shadowMode: !1
                })
            },
            1161: function(e, t, n) {
                var r = n(5948);
                r.__esModule && (r = r.default), "string" === typeof r && (r = [
                    [e.id, r, ""]
                ]), r.locals && (e.exports = r.locals);
                var o = n(7037).Z;
                o("000baf9f", r, !0, {
                    sourceMap: !1,
                    shadowMode: !1
                })
            },
            9998: function(e, t, n) {
                var r = n(1061);
                r.__esModule && (r = r.default), "string" === typeof r && (r = [
                    [e.id, r, ""]
                ]), r.locals && (e.exports = r.locals);
                var o = n(7037).Z;
                o("44985390", r, !0, {
                    sourceMap: !1,
                    shadowMode: !1
                })
            },
            7037: function(e, t, n) {
                "use strict";
                n.d(t, {
                    Z: function() {
                        return h
                    }
                });
                n(7658);

                function r(e, t) {
                    for (var n = [], r = {}, o = 0; o < t.length; o++) {
                        var i = t[o],
                            a = i[0],
                            s = i[1],
                            l = i[2],
                            c = i[3],
                            d = {
                                id: e + ":" + o,
                                css: s,
                                media: l,
                                sourceMap: c
                            };
                        r[a] ? r[a].parts.push(d) : n.push(r[a] = {
                            id: a,
                            parts: [d]
                        })
                    }
                    return n
                }
                var o = "undefined" !== typeof document;
                if ("undefined" !== typeof DEBUG && DEBUG && !o) throw new Error("vue-style-loader cannot be used in a non-browser environment. Use { target: 'node' } in your Webpack config to indicate a server-rendering environment.");
                var i = {},
                    a = o && (document.head || document.getElementsByTagName("head")[0]),
                    s = null,
                    l = 0,
                    c = !1,
                    d = function() {},
                    u = null,
                    p = "data-vue-ssr-id",
                    f = "undefined" !== typeof navigator && /msie [6-9]\b/.test(navigator.userAgent.toLowerCase());

                function h(e, t, n, o) {
                    c = n, u = o || {};
                    var a = r(e, t);
                    return g(a),
                        function(t) {
                            for (var n = [], o = 0; o < a.length; o++) {
                                var s = a[o],
                                    l = i[s.id];
                                l.refs--, n.push(l)
                            }
                            t ? (a = r(e, t), g(a)) : a = [];
                            for (o = 0; o < n.length; o++) {
                                l = n[o];
                                if (0 === l.refs) {
                                    for (var c = 0; c < l.parts.length; c++) l.parts[c]();
                                    delete i[l.id]
                                }
                            }
                        }
                }

                function g(e) {
                    for (var t = 0; t < e.length; t++) {
                        var n = e[t],
                            r = i[n.id];
                        if (r) {
                            r.refs++;
                            for (var o = 0; o < r.parts.length; o++) r.parts[o](n.parts[o]);
                            for (; o < n.parts.length; o++) r.parts.push(m(n.parts[o]));
                            r.parts.length > n.parts.length && (r.parts.length = n.parts.length)
                        } else {
                            var a = [];
                            for (o = 0; o < n.parts.length; o++) a.push(m(n.parts[o]));
                            i[n.id] = {
                                id: n.id,
                                refs: 1,
                                parts: a
                            }
                        }
                    }
                }

                function v() {
                    var e = document.createElement("style");
                    return e.type = "text/css", a.appendChild(e), e
                }

                function m(e) {
                    var t, n, r = document.querySelector("style[" + p + '~="' + e.id + '"]');
                    if (r) {
                        if (c) return d;
                        r.parentNode.removeChild(r)
                    }
                    if (f) {
                        var o = l++;
                        r = s || (s = v()), t = b.bind(null, r, o, !1), n = b.bind(null, r, o, !0)
                    } else r = v(), t = w.bind(null, r), n = function() {
                        r.parentNode.removeChild(r)
                    };
                    return t(e),
                        function(r) {
                            if (r) {
                                if (r.css === e.css && r.media === e.media && r.sourceMap === e.sourceMap) return;
                                t(e = r)
                            } else n()
                        }
                }
                var y = function() {
                    var e = [];
                    return function(t, n) {
                        return e[t] = n, e.filter(Boolean).join("\n")
                    }
                }();

                function b(e, t, n, r) {
                    var o = n ? "" : r.css;
                    if (e.styleSheet) e.styleSheet.cssText = y(t, o);
                    else {
                        var i = document.createTextNode(o),
                            a = e.childNodes;
                        a[t] && e.removeChild(a[t]), a.length ? e.insertBefore(i, a[t]) : e.appendChild(i)
                    }
                }

                function w(e, t) {
                    var n = t.css,
                        r = t.media,
                        o = t.sourceMap;
                    if (r && e.setAttribute("media", r), u.ssrId && e.setAttribute(p, t.id), o && (n += "\n/*# sourceURL=" + o.sources[0] + " */", n += "\n/*# sourceMappingURL=data:application/json;base64," + btoa(unescape(encodeURIComponent(JSON.stringify(o)))) + " */"), e.styleSheet) e.styleSheet.cssText = n;
                    else {
                        while (e.firstChild) e.removeChild(e.firstChild);
                        e.appendChild(document.createTextNode(n))
                    }
                }
            },
            9954: function(e) {
                "use strict";
                e.exports = "data:application/font-woff;charset=utf-8;base64, d09GRgABAAAAAAZgABAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABGRlRNAAAGRAAAABoAAAAci6qHkUdERUYAAAWgAAAAIwAAACQAYABXR1BPUwAABhQAAAAuAAAANuAY7+xHU1VCAAAFxAAAAFAAAABm2fPczU9TLzIAAAHcAAAASgAAAGBP9V5RY21hcAAAAkQAAACIAAABYt6F0cBjdnQgAAACzAAAAAQAAAAEABEBRGdhc3AAAAWYAAAACAAAAAj//wADZ2x5ZgAAAywAAADMAAAD2MHtryVoZWFkAAABbAAAADAAAAA2E2+eoWhoZWEAAAGcAAAAHwAAACQC9gDzaG10eAAAAigAAAAZAAAArgJkABFsb2NhAAAC0AAAAFoAAABaFQAUGG1heHAAAAG8AAAAHwAAACAAcABAbmFtZQAAA/gAAAE5AAACXvFdBwlwb3N0AAAFNAAAAGIAAACE5s74hXjaY2BkYGAAYpf5Hu/j+W2+MnAzMYDAzaX6QjD6/4//Bxj5GA8AuRwMYGkAPywL13jaY2BkYGA88P8Agx4j+/8fQDYfA1AEBWgDAIB2BOoAeNpjYGRgYNBh4GdgYgABEMnIABJzYNADCQAACWgAsQB42mNgYfzCOIGBlYGB0YcxjYGBwR1Kf2WQZGhhYGBiYGVmgAFGBiQQkOaawtDAoMBQxXjg/wEGPcYDDA4wNUA2CCgwsAAAO4EL6gAAeNpj2M0gyAACqxgGNWBkZ2D4/wMA+xkDdgAAAHjaY2BgYGaAYBkGRgYQiAHyGMF8FgYHIM3DwMHABGQrMOgyWDLEM1T9/w8UBfEMgLzE////P/5//f/V/xv+r4eaAAeMbAxwIUYmIMHEgKYAYjUcsDAwsLKxc3BycfPw8jEQA/gZBASFhEVExcQlJKWkZWTl5BUUlZRVVNXUNTQZBgMAAMR+E+gAEQFEAAAAKgAqACoANAA+AEgAUgBcAGYAcAB6AIQAjgCYAKIArAC2AMAAygDUAN4A6ADyAPwBBgEQARoBJAEuATgBQgFMAVYBYAFqAXQBfgGIAZIBnAGmAbIBzgHsAAB42u2NMQ6CUAyGW568x9AneYYgm4MJbhKFaExIOAVX8ApewSt4Bic4AfeAid3VOBixDxfPYEza5O+Xfi04YADggiUIULCuEJK8VhO4bSvpdnktHI5QCYtdi2sl8ZnXaHlqUrNKzdKcT8cjlq+rwZSvIVczNiezsfnP/uznmfPFBNODM2K7MTQ45YEAZqGP81AmGGcF3iPqOop0r1SPTaTbVkfUe4HXj97wYE+yNwWYxwWu4v1ugWHgo3S1XdZEVqWM7ET0cfnLGxWfkgR42o2PvWrDMBSFj/IHLaF0zKjRgdiVMwScNRAoWUoH78Y2icB/yIY09An6AH2Bdu/UB+yxopYshQiEvnvu0dURgDt8QeC8PDw7Fpji3fEA4z/PEJ6YOB5hKh4dj3EvXhxPqH/SKUY3rJ7srZ4FZnh1PMAtPhwP6fl2PMJMPDgeQ4rY8YT6Gzao0eAEA409DuggmTnFnOcSCiEiLMgxCiTI6Cq5DZUd3Qmp10vO0LaLTd2cjN4fOumlc7lUYbSQcZFkutRG7g6JKZKy0RmdLY680CDnEJ+UMkpFFe1RN7nxdVpXrC4aTtnaurOnYercZg2YVmLN/d/gczfEimrE/fs/bOuq29Zmn8tloORaXgZgGa78yO9/cnXm2BpaGvq25Dv9S4E9+5SIc9PqupJKhYFSSl47+Qcr1mYNAAAAeNptw0cKwkAAAMDZJA8Q7OUJvkLsPfZ6zFVERPy8qHh2YER+3i/BP83vIBLLySsoKimrqKqpa2hp6+jq6RsYGhmbmJqZSy0sraxtbO3sHRydnEMU4uR6yx7JJXveP7WrDycAAAAAAAH//wACeNpjYGRgYOABYhkgZgJCZgZNBkYGLQZtIJsFLMYAAAw3ALgAeNolizEKgDAQBCchRbC2sFER0YD6qVQiBCv/H9ezGI6Z5XBAw8CBK/m5iQQVauVbXLnOrMZv2oLdKFa8Pjuru2hJzGabmOSLzNMzvutpB3N42mNgZGBg4GKQYzBhYMxJLMlj4GBgAYow/P/PAJJhLM6sSoWKfWCAAwDAjgbRAAB42mNgYGBkAIIbCZo5IPrmUn0hGA0AO8EFTQAA"
            },
            522: function(e, t, n) {
                "use strict";
                e.exports = n.p + "fonts/Gilroy-Bold.ttf"
            },
            1673: function(e, t, n) {
                "use strict";
                e.exports = n.p + "fonts/Gilroy-ExtraBold.ttf"
            },
            7464: function(e, t, n) {
                "use strict";
                e.exports = n.p + "fonts/Gilroy-Light.ttf"
            },
            2255: function(e, t, n) {
                "use strict";
                e.exports = n.p + "fonts/Gilroy-Medium.ttf"
            },
            60: function(e, t, n) {
                "use strict";
                e.exports = n.p + "fonts/Gilroy-Regular.ttf"
            },
            7317: function(e, t, n) {
                "use strict";
                e.exports = n.p + "fonts/Proxima-Nova-Font.otf"
            }
        },
        t = {};

    function n(r) {
        var o = t[r];
        if (void 0 !== o) return o.exports;
        var i = t[r] = {
            id: r,
            exports: {}
        };
        return e[r](i, i.exports, n), i.exports
    }
    n.m = e,
        function() {
            n.n = function(e) {
                var t = e && e.__esModule ? function() {
                    return e["default"]
                } : function() {
                    return e
                };
                return n.d(t, {
                    a: t
                }), t
            }
        }(),
        function() {
            n.d = function(e, t) {
                for (var r in t) n.o(t, r) && !n.o(e, r) && Object.defineProperty(e, r, {
                    enumerable: !0,
                    get: t[r]
                })
            }
        }(),
        function() {
            n.g = function() {
                if ("object" === typeof globalThis) return globalThis;
                try {
                    return this || new Function("return this")()
                } catch (e) {
                    if ("object" === typeof window) return window
                }
            }()
        }(),
        function() {
            n.o = function(e, t) {
                return Object.prototype.hasOwnProperty.call(e, t)
            }
        }(),
        function() {
            n.r = function(e) {
                "undefined" !== typeof Symbol && Symbol.toStringTag && Object.defineProperty(e, Symbol.toStringTag, {
                    value: "Module"
                }), Object.defineProperty(e, "__esModule", {
                    value: !0
                })
            }
        }(),
        function() {
            n.p = ""
        }(),
        function() {
            n.b = document.baseURI || self.location.href
        }();
    ! function() {
        "use strict";
        n(9998), n(7658);

        function e(e, t) {
            const n = Object.create(null),
                r = e.split(",");
            for (let o = 0; o < r.length; o++) n[r[o]] = !0;
            return t ? e => !!n[e.toLowerCase()] : e => !!n[e]
        }

        function t(e) {
            if (T(e)) {
                const n = {};
                for (let r = 0; r < e.length; r++) {
                    const o = e[r],
                        i = P(o) ? a(o) : t(o);
                    if (i)
                        for (const e in i) n[e] = i[e]
                }
                return n
            }
            return P(e) || L(e) ? e : void 0
        }
        const r = /;(?![^(]*\))/g,
            o = /:([^]+)/,
            i = /\/\*.*?\*\//gs;

        function a(e) {
            const t = {};
            return e.replace(i, "").split(r).forEach((e => {
                if (e) {
                    const n = e.split(o);
                    n.length > 1 && (t[n[0].trim()] = n[1].trim())
                }
            })), t
        }

        function s(e) {
            let t = "";
            if (P(e)) t = e;
            else if (T(e))
                for (let n = 0; n < e.length; n++) {
                    const r = s(e[n]);
                    r && (t += r + " ")
                } else if (L(e))
                    for (const n in e) e[n] && (t += n + " ");
            return t.trim()
        }
        const l = "itemscope,allowfullscreen,formnovalidate,ismap,nomodule,novalidate,readonly",
            c = e(l);

        function d(e) {
            return !!e || "" === e
        }

        function u(e, t) {
            if (e.length !== t.length) return !1;
            let n = !0;
            for (let r = 0; n && r < e.length; r++) n = p(e[r], t[r]);
            return n
        }

        function p(e, t) {
            if (e === t) return !0;
            let n = M(e),
                r = M(t);
            if (n || r) return !(!n || !r) && e.getTime() === t.getTime();
            if (n = B(e), r = B(t), n || r) return e === t;
            if (n = T(e), r = T(t), n || r) return !(!n || !r) && u(e, t);
            if (n = L(e), r = L(t), n || r) {
                if (!n || !r) return !1;
                const o = Object.keys(e).length,
                    i = Object.keys(t).length;
                if (o !== i) return !1;
                for (const n in e) {
                    const r = e.hasOwnProperty(n),
                        o = t.hasOwnProperty(n);
                    if (r && !o || !r && o || !p(e[n], t[n])) return !1
                }
            }
            return String(e) === String(t)
        }

        function f(e, t) {
            return e.findIndex((e => p(e, t)))
        }
        const h = e => P(e) ? e : null == e ? "" : T(e) || L(e) && (e.toString === D || !I(e.toString)) ? JSON.stringify(e, g, 2) : String(e),
            g = (e, t) => t && t.__v_isRef ? g(e, t.value) : E(t) ? {
                [`Map(${t.size})`]: [...t.entries()].reduce(((e, [t, n]) => (e[`${t} =>`] = n, e)), {})
            } : O(t) ? {
                [`Set(${t.size})`]: [...t.values()]
            } : !L(t) || T(t) || j(t) ? t : String(t),
            v = {},
            m = [],
            y = () => {},
            b = () => !1,
            w = /^on[^a-z]/,
            _ = e => w.test(e),
            A = e => e.startsWith("onUpdate:"),
            x = Object.assign,
            C = (e, t) => {
                const n = e.indexOf(t);
                n > -1 && e.splice(n, 1)
            },
            k = Object.prototype.hasOwnProperty,
            S = (e, t) => k.call(e, t),
            T = Array.isArray,
            E = e => "[object Map]" === N(e),
            O = e => "[object Set]" === N(e),
            M = e => "[object Date]" === N(e),
            I = e => "function" === typeof e,
            P = e => "string" === typeof e,
            B = e => "symbol" === typeof e,
            L = e => null !== e && "object" === typeof e,
            F = e => L(e) && I(e.then) && I(e.catch),
            D = Object.prototype.toString,
            N = e => D.call(e),
            R = e => N(e).slice(8, -1),
            j = e => "[object Object]" === N(e),
            H = e => P(e) && "NaN" !== e && "-" !== e[0] && "" + parseInt(e, 10) === e,
            G = e(",key,ref,ref_for,ref_key,onVnodeBeforeMount,onVnodeMounted,onVnodeBeforeUpdate,onVnodeUpdated,onVnodeBeforeUnmount,onVnodeUnmounted"),
            z = e => {
                const t = Object.create(null);
                return n => {
                    const r = t[n];
                    return r || (t[n] = e(n))
                }
            },
            $ = /-(\w)/g,
            V = z((e => e.replace($, ((e, t) => t ? t.toUpperCase() : "")))),
            U = /\B([A-Z])/g,
            K = z((e => e.replace(U, "-$1").toLowerCase())),
            Y = z((e => e.charAt(0).toUpperCase() + e.slice(1))),
            W = z((e => e ? `on${Y(e)}` : "")),
            X = (e, t) => !Object.is(e, t),
            Q = (e, t) => {
                for (let n = 0; n < e.length; n++) e[n](t)
            },
            q = (e, t, n) => {
                Object.defineProperty(e, t, {
                    configurable: !0,
                    enumerable: !1,
                    value: n
                })
            },
            Z = e => {
                const t = parseFloat(e);
                return isNaN(t) ? e : t
            };
        let J;
        const ee = () => J || (J = "undefined" !== typeof globalThis ? globalThis : "undefined" !== typeof self ? self : "undefined" !== typeof window ? window : "undefined" !== typeof n.g ? n.g : {});
        n(541);
        let te;
        class ne {
            constructor(e = !1) {
                this.detached = e, this.active = !0, this.effects = [], this.cleanups = [], this.parent = te, !e && te && (this.index = (te.scopes || (te.scopes = [])).push(this) - 1)
            }
            run(e) {
                if (this.active) {
                    const t = te;
                    try {
                        return te = this, e()
                    } finally {
                        te = t
                    }
                } else 0
            }
            on() {
                te = this
            }
            off() {
                te = this.parent
            }
            stop(e) {
                if (this.active) {
                    let t, n;
                    for (t = 0, n = this.effects.length; t < n; t++) this.effects[t].stop();
                    for (t = 0, n = this.cleanups.length; t < n; t++) this.cleanups[t]();
                    if (this.scopes)
                        for (t = 0, n = this.scopes.length; t < n; t++) this.scopes[t].stop(!0);
                    if (!this.detached && this.parent && !e) {
                        const e = this.parent.scopes.pop();
                        e && e !== this && (this.parent.scopes[this.index] = e, e.index = this.index)
                    }
                    this.parent = void 0, this.active = !1
                }
            }
        }

        function re(e) {
            return new ne(e)
        }

        function oe(e, t = te) {
            t && t.active && t.effects.push(e)
        }

        function ie() {
            return te
        }

        function ae(e) {
            te && te.cleanups.push(e)
        }
        const se = e => {
                const t = new Set(e);
                return t.w = 0, t.n = 0, t
            },
            le = e => (e.w & he) > 0,
            ce = e => (e.n & he) > 0,
            de = ({
                deps: e
            }) => {
                if (e.length)
                    for (let t = 0; t < e.length; t++) e[t].w |= he
            },
            ue = e => {
                const {
                    deps: t
                } = e;
                if (t.length) {
                    let n = 0;
                    for (let r = 0; r < t.length; r++) {
                        const o = t[r];
                        le(o) && !ce(o) ? o.delete(e) : t[n++] = o, o.w &= ~he, o.n &= ~he
                    }
                    t.length = n
                }
            },
            pe = new WeakMap;
        let fe = 0,
            he = 1;
        const ge = 30;
        let ve;
        const me = Symbol(""),
            ye = Symbol("");
        class be {
            constructor(e, t = null, n) {
                this.fn = e, this.scheduler = t, this.active = !0, this.deps = [], this.parent = void 0, oe(this, n)
            }
            run() {
                if (!this.active) return this.fn();
                let e = ve,
                    t = _e;
                while (e) {
                    if (e === this) return;
                    e = e.parent
                }
                try {
                    return this.parent = ve, ve = this, _e = !0, he = 1 << ++fe, fe <= ge ? de(this) : we(this), this.fn()
                } finally {
                    fe <= ge && ue(this), he = 1 << --fe, ve = this.parent, _e = t, this.parent = void 0, this.deferStop && this.stop()
                }
            }
            stop() {
                ve === this ? this.deferStop = !0 : this.active && (we(this), this.onStop && this.onStop(), this.active = !1)
            }
        }

        function we(e) {
            const {
                deps: t
            } = e;
            if (t.length) {
                for (let n = 0; n < t.length; n++) t[n].delete(e);
                t.length = 0
            }
        }
        let _e = !0;
        const Ae = [];

        function xe() {
            Ae.push(_e), _e = !1
        }

        function Ce() {
            const e = Ae.pop();
            _e = void 0 === e || e
        }

        function ke(e, t, n) {
            if (_e && ve) {
                let t = pe.get(e);
                t || pe.set(e, t = new Map);
                let r = t.get(n);
                r || t.set(n, r = se());
                const o = void 0;
                Se(r, o)
            }
        }

        function Se(e, t) {
            let n = !1;
            fe <= ge ? ce(e) || (e.n |= he, n = !le(e)) : n = !e.has(ve), n && (e.add(ve), ve.deps.push(e))
        }

        function Te(e, t, n, r, o, i) {
            const a = pe.get(e);
            if (!a) return;
            let s = [];
            if ("clear" === t) s = [...a.values()];
            else if ("length" === n && T(e)) {
                const e = Z(r);
                a.forEach(((t, n) => {
                    ("length" === n || n >= e) && s.push(t)
                }))
            } else switch (void 0 !== n && s.push(a.get(n)), t) {
                case "add":
                    T(e) ? H(n) && s.push(a.get("length")) : (s.push(a.get(me)), E(e) && s.push(a.get(ye)));
                    break;
                case "delete":
                    T(e) || (s.push(a.get(me)), E(e) && s.push(a.get(ye)));
                    break;
                case "set":
                    E(e) && s.push(a.get(me));
                    break
            }
            if (1 === s.length) s[0] && Ee(s[0]);
            else {
                const e = [];
                for (const t of s) t && e.push(...t);
                Ee(se(e))
            }
        }

        function Ee(e, t) {
            const n = T(e) ? e : [...e];
            for (const r of n) r.computed && Oe(r, t);
            for (const r of n) r.computed || Oe(r, t)
        }

        function Oe(e, t) {
            (e !== ve || e.allowRecurse) && (e.scheduler ? e.scheduler() : e.run())
        }
        const Me = e("__proto__,__v_isRef,__isVue"),
            Ie = new Set(Object.getOwnPropertyNames(Symbol).filter((e => "arguments" !== e && "caller" !== e)).map((e => Symbol[e])).filter(B)),
            Pe = Ne(),
            Be = Ne(!1, !0),
            Le = Ne(!0),
            Fe = De();

        function De() {
            const e = {};
            return ["includes", "indexOf", "lastIndexOf"].forEach((t => {
                e[t] = function(...e) {
                    const n = Et(this);
                    for (let t = 0, o = this.length; t < o; t++) ke(n, "get", t + "");
                    const r = n[t](...e);
                    return -1 === r || !1 === r ? n[t](...e.map(Et)) : r
                }
            })), ["push", "pop", "shift", "unshift", "splice"].forEach((t => {
                e[t] = function(...e) {
                    xe();
                    const n = Et(this)[t].apply(this, e);
                    return Ce(), n
                }
            })), e
        }

        function Ne(e = !1, t = !1) {
            return function(n, r, o) {
                if ("__v_isReactive" === r) return !e;
                if ("__v_isReadonly" === r) return e;
                if ("__v_isShallow" === r) return t;
                if ("__v_raw" === r && o === (e ? t ? mt : vt : t ? gt : ht).get(n)) return n;
                const i = T(n);
                if (!e && i && S(Fe, r)) return Reflect.get(Fe, r, o);
                const a = Reflect.get(n, r, o);
                return (B(r) ? Ie.has(r) : Me(r)) ? a : (e || ke(n, "get", r), t ? a : Lt(a) ? i && H(r) ? a : a.value : L(a) ? e ? At(a) : wt(a) : a)
            }
        }
        const Re = He(),
            je = He(!0);

        function He(e = !1) {
            return function(t, n, r, o) {
                let i = t[n];
                if (kt(i) && Lt(i) && !Lt(r)) return !1;
                if (!e && (St(r) || kt(r) || (i = Et(i), r = Et(r)), !T(t) && Lt(i) && !Lt(r))) return i.value = r, !0;
                const a = T(t) && H(n) ? Number(n) < t.length : S(t, n),
                    s = Reflect.set(t, n, r, o);
                return t === Et(o) && (a ? X(r, i) && Te(t, "set", n, r, i) : Te(t, "add", n, r)), s
            }
        }

        function Ge(e, t) {
            const n = S(e, t),
                r = e[t],
                o = Reflect.deleteProperty(e, t);
            return o && n && Te(e, "delete", t, void 0, r), o
        }

        function ze(e, t) {
            const n = Reflect.has(e, t);
            return B(t) && Ie.has(t) || ke(e, "has", t), n
        }

        function $e(e) {
            return ke(e, "iterate", T(e) ? "length" : me), Reflect.ownKeys(e)
        }
        const Ve = {
                get: Pe,
                set: Re,
                deleteProperty: Ge,
                has: ze,
                ownKeys: $e
            },
            Ue = {
                get: Le,
                set(e, t) {
                    return !0
                },
                deleteProperty(e, t) {
                    return !0
                }
            },
            Ke = x({}, Ve, {
                get: Be,
                set: je
            }),
            Ye = e => e,
            We = e => Reflect.getPrototypeOf(e);

        function Xe(e, t, n = !1, r = !1) {
            e = e["__v_raw"];
            const o = Et(e),
                i = Et(t);
            n || (t !== i && ke(o, "get", t), ke(o, "get", i));
            const {
                has: a
            } = We(o), s = r ? Ye : n ? It : Mt;
            return a.call(o, t) ? s(e.get(t)) : a.call(o, i) ? s(e.get(i)) : void(e !== o && e.get(t))
        }

        function Qe(e, t = !1) {
            const n = this["__v_raw"],
                r = Et(n),
                o = Et(e);
            return t || (e !== o && ke(r, "has", e), ke(r, "has", o)), e === o ? n.has(e) : n.has(e) || n.has(o)
        }

        function qe(e, t = !1) {
            return e = e["__v_raw"], !t && ke(Et(e), "iterate", me), Reflect.get(e, "size", e)
        }

        function Ze(e) {
            e = Et(e);
            const t = Et(this),
                n = We(t),
                r = n.has.call(t, e);
            return r || (t.add(e), Te(t, "add", e, e)), this
        }

        function Je(e, t) {
            t = Et(t);
            const n = Et(this),
                {
                    has: r,
                    get: o
                } = We(n);
            let i = r.call(n, e);
            i || (e = Et(e), i = r.call(n, e));
            const a = o.call(n, e);
            return n.set(e, t), i ? X(t, a) && Te(n, "set", e, t, a) : Te(n, "add", e, t), this
        }

        function et(e) {
            const t = Et(this),
                {
                    has: n,
                    get: r
                } = We(t);
            let o = n.call(t, e);
            o || (e = Et(e), o = n.call(t, e));
            const i = r ? r.call(t, e) : void 0,
                a = t.delete(e);
            return o && Te(t, "delete", e, void 0, i), a
        }

        function tt() {
            const e = Et(this),
                t = 0 !== e.size,
                n = void 0,
                r = e.clear();
            return t && Te(e, "clear", void 0, void 0, n), r
        }

        function nt(e, t) {
            return function(n, r) {
                const o = this,
                    i = o["__v_raw"],
                    a = Et(i),
                    s = t ? Ye : e ? It : Mt;
                return !e && ke(a, "iterate", me), i.forEach(((e, t) => n.call(r, s(e), s(t), o)))
            }
        }

        function rt(e, t, n) {
            return function(...r) {
                const o = this["__v_raw"],
                    i = Et(o),
                    a = E(i),
                    s = "entries" === e || e === Symbol.iterator && a,
                    l = "keys" === e && a,
                    c = o[e](...r),
                    d = n ? Ye : t ? It : Mt;
                return !t && ke(i, "iterate", l ? ye : me), {
                    next() {
                        const {
                            value: e,
                            done: t
                        } = c.next();
                        return t ? {
                            value: e,
                            done: t
                        } : {
                            value: s ? [d(e[0]), d(e[1])] : d(e),
                            done: t
                        }
                    },
                    [Symbol.iterator]() {
                        return this
                    }
                }
            }
        }

        function ot(e) {
            return function(...t) {
                return "delete" !== e && this
            }
        }

        function it() {
            const e = {
                    get(e) {
                        return Xe(this, e)
                    },
                    get size() {
                        return qe(this)
                    },
                    has: Qe,
                    add: Ze,
                    set: Je,
                    delete: et,
                    clear: tt,
                    forEach: nt(!1, !1)
                },
                t = {
                    get(e) {
                        return Xe(this, e, !1, !0)
                    },
                    get size() {
                        return qe(this)
                    },
                    has: Qe,
                    add: Ze,
                    set: Je,
                    delete: et,
                    clear: tt,
                    forEach: nt(!1, !0)
                },
                n = {
                    get(e) {
                        return Xe(this, e, !0)
                    },
                    get size() {
                        return qe(this, !0)
                    },
                    has(e) {
                        return Qe.call(this, e, !0)
                    },
                    add: ot("add"),
                    set: ot("set"),
                    delete: ot("delete"),
                    clear: ot("clear"),
                    forEach: nt(!0, !1)
                },
                r = {
                    get(e) {
                        return Xe(this, e, !0, !0)
                    },
                    get size() {
                        return qe(this, !0)
                    },
                    has(e) {
                        return Qe.call(this, e, !0)
                    },
                    add: ot("add"),
                    set: ot("set"),
                    delete: ot("delete"),
                    clear: ot("clear"),
                    forEach: nt(!0, !0)
                },
                o = ["keys", "values", "entries", Symbol.iterator];
            return o.forEach((o => {
                e[o] = rt(o, !1, !1), n[o] = rt(o, !0, !1), t[o] = rt(o, !1, !0), r[o] = rt(o, !0, !0)
            })), [e, n, t, r]
        }
        const [at, st, lt, ct] = it();

        function dt(e, t) {
            const n = t ? e ? ct : lt : e ? st : at;
            return (t, r, o) => "__v_isReactive" === r ? !e : "__v_isReadonly" === r ? e : "__v_raw" === r ? t : Reflect.get(S(n, r) && r in t ? n : t, r, o)
        }
        const ut = {
                get: dt(!1, !1)
            },
            pt = {
                get: dt(!1, !0)
            },
            ft = {
                get: dt(!0, !1)
            };
        const ht = new WeakMap,
            gt = new WeakMap,
            vt = new WeakMap,
            mt = new WeakMap;

        function yt(e) {
            switch (e) {
                case "Object":
                case "Array":
                    return 1;
                case "Map":
                case "Set":
                case "WeakMap":
                case "WeakSet":
                    return 2;
                default:
                    return 0
            }
        }

        function bt(e) {
            return e["__v_skip"] || !Object.isExtensible(e) ? 0 : yt(R(e))
        }

        function wt(e) {
            return kt(e) ? e : xt(e, !1, Ve, ut, ht)
        }

        function _t(e) {
            return xt(e, !1, Ke, pt, gt)
        }

        function At(e) {
            return xt(e, !0, Ue, ft, vt)
        }

        function xt(e, t, n, r, o) {
            if (!L(e)) return e;
            if (e["__v_raw"] && (!t || !e["__v_isReactive"])) return e;
            const i = o.get(e);
            if (i) return i;
            const a = bt(e);
            if (0 === a) return e;
            const s = new Proxy(e, 2 === a ? r : n);
            return o.set(e, s), s
        }

        function Ct(e) {
            return kt(e) ? Ct(e["__v_raw"]) : !(!e || !e["__v_isReactive"])
        }

        function kt(e) {
            return !(!e || !e["__v_isReadonly"])
        }

        function St(e) {
            return !(!e || !e["__v_isShallow"])
        }

        function Tt(e) {
            return Ct(e) || kt(e)
        }

        function Et(e) {
            const t = e && e["__v_raw"];
            return t ? Et(t) : e
        }

        function Ot(e) {
            return q(e, "__v_skip", !0), e
        }
        const Mt = e => L(e) ? wt(e) : e,
            It = e => L(e) ? At(e) : e;

        function Pt(e) {
            _e && ve && (e = Et(e), Se(e.dep || (e.dep = se())))
        }

        function Bt(e, t) {
            e = Et(e), e.dep && Ee(e.dep)
        }

        function Lt(e) {
            return !(!e || !0 !== e.__v_isRef)
        }

        function Ft(e) {
            return Dt(e, !1)
        }

        function Dt(e, t) {
            return Lt(e) ? e : new Nt(e, t)
        }
        class Nt {
            constructor(e, t) {
                this.__v_isShallow = t, this.dep = void 0, this.__v_isRef = !0, this._rawValue = t ? e : Et(e), this._value = t ? e : Mt(e)
            }
            get value() {
                return Pt(this), this._value
            }
            set value(e) {
                const t = this.__v_isShallow || St(e) || kt(e);
                e = t ? e : Et(e), X(e, this._rawValue) && (this._rawValue = e, this._value = t ? e : Mt(e), Bt(this, e))
            }
        }

        function Rt(e) {
            return Lt(e) ? e.value : e
        }
        const jt = {
            get: (e, t, n) => Rt(Reflect.get(e, t, n)),
            set: (e, t, n, r) => {
                const o = e[t];
                return Lt(o) && !Lt(n) ? (o.value = n, !0) : Reflect.set(e, t, n, r)
            }
        };

        function Ht(e) {
            return Ct(e) ? e : new Proxy(e, jt)
        }

        function Gt(e) {
            const t = T(e) ? new Array(e.length) : {};
            for (const n in e) t[n] = $t(e, n);
            return t
        }
        class zt {
            constructor(e, t, n) {
                this._object = e, this._key = t, this._defaultValue = n, this.__v_isRef = !0
            }
            get value() {
                const e = this._object[this._key];
                return void 0 === e ? this._defaultValue : e
            }
            set value(e) {
                this._object[this._key] = e
            }
        }

        function $t(e, t, n) {
            const r = e[t];
            return Lt(r) ? r : new zt(e, t, n)
        }
        var Vt;
        class Ut {
            constructor(e, t, n, r) {
                this._setter = t, this.dep = void 0, this.__v_isRef = !0, this[Vt] = !1, this._dirty = !0, this.effect = new be(e, (() => {
                    this._dirty || (this._dirty = !0, Bt(this))
                })), this.effect.computed = this, this.effect.active = this._cacheable = !r, this["__v_isReadonly"] = n
            }
            get value() {
                const e = Et(this);
                return Pt(e), !e._dirty && e._cacheable || (e._dirty = !1, e._value = e.effect.run()), e._value
            }
            set value(e) {
                this._setter(e)
            }
        }

        function Kt(e, t, n = !1) {
            let r, o;
            const i = I(e);
            i ? (r = e, o = y) : (r = e.get, o = e.set);
            const a = new Ut(r, o, i || !o, n);
            return a
        }
        Vt = "__v_isReadonly";

        function Yt(e, t, n, r) {
            let o;
            try {
                o = r ? e(...r) : e()
            } catch (i) {
                Xt(i, t, n)
            }
            return o
        }

        function Wt(e, t, n, r) {
            if (I(e)) {
                const o = Yt(e, t, n, r);
                return o && F(o) && o.catch((e => {
                    Xt(e, t, n)
                })), o
            }
            const o = [];
            for (let i = 0; i < e.length; i++) o.push(Wt(e[i], t, n, r));
            return o
        }

        function Xt(e, t, n, r = !0) {
            const o = t ? t.vnode : null;
            if (t) {
                let r = t.parent;
                const o = t.proxy,
                    i = n;
                while (r) {
                    const t = r.ec;
                    if (t)
                        for (let n = 0; n < t.length; n++)
                            if (!1 === t[n](e, o, i)) return;
                    r = r.parent
                }
                const a = t.appContext.config.errorHandler;
                if (a) return void Yt(a, null, 10, [e, o, i])
            }
            Qt(e, n, o, r)
        }

        function Qt(e, t, n, r = !0) {
            console.error(e)
        }
        let qt = !1,
            Zt = !1;
        const Jt = [];
        let en = 0;
        const tn = [];
        let nn = null,
            rn = 0;
        const on = Promise.resolve();
        let an = null;

        function sn(e) {
            const t = an || on;
            return e ? t.then(this ? e.bind(this) : e) : t
        }

        function ln(e) {
            let t = en + 1,
                n = Jt.length;
            while (t < n) {
                const r = t + n >>> 1,
                    o = gn(Jt[r]);
                o < e ? t = r + 1 : n = r
            }
            return t
        }

        function cn(e) {
            Jt.length && Jt.includes(e, qt && e.allowRecurse ? en + 1 : en) || (null == e.id ? Jt.push(e) : Jt.splice(ln(e.id), 0, e), dn())
        }

        function dn() {
            qt || Zt || (Zt = !0, an = on.then(mn))
        }

        function un(e) {
            const t = Jt.indexOf(e);
            t > en && Jt.splice(t, 1)
        }

        function pn(e) {
            T(e) ? tn.push(...e) : nn && nn.includes(e, e.allowRecurse ? rn + 1 : rn) || tn.push(e), dn()
        }

        function fn(e, t = (qt ? en + 1 : 0)) {
            for (0; t < Jt.length; t++) {
                const e = Jt[t];
                e && e.pre && (Jt.splice(t, 1), t--, e())
            }
        }

        function hn(e) {
            if (tn.length) {
                const e = [...new Set(tn)];
                if (tn.length = 0, nn) return void nn.push(...e);
                for (nn = e, nn.sort(((e, t) => gn(e) - gn(t))), rn = 0; rn < nn.length; rn++) nn[rn]();
                nn = null, rn = 0
            }
        }
        const gn = e => null == e.id ? 1 / 0 : e.id,
            vn = (e, t) => {
                const n = gn(e) - gn(t);
                if (0 === n) {
                    if (e.pre && !t.pre) return -1;
                    if (t.pre && !e.pre) return 1
                }
                return n
            };

        function mn(e) {
            Zt = !1, qt = !0, Jt.sort(vn);
            try {
                for (en = 0; en < Jt.length; en++) {
                    const e = Jt[en];
                    e && !1 !== e.active && Yt(e, null, 14)
                }
            } finally {
                en = 0, Jt.length = 0, hn(e), qt = !1, an = null, (Jt.length || tn.length) && mn(e)
            }
        }
        new Set;
        new Map;

        function yn(e, t, ...n) {
            if (e.isUnmounted) return;
            const r = e.vnode.props || v;
            let o = n;
            const i = t.startsWith("update:"),
                a = i && t.slice(7);
            if (a && a in r) {
                const e = `${"modelValue"===a?"model":a}Modifiers`,
                    {
                        number: t,
                        trim: i
                    } = r[e] || v;
                i && (o = n.map((e => P(e) ? e.trim() : e))), t && (o = n.map(Z))
            }
            let s;
            let l = r[s = W(t)] || r[s = W(V(t))];
            !l && i && (l = r[s = W(K(t))]), l && Wt(l, e, 6, o);
            const c = r[s + "Once"];
            if (c) {
                if (e.emitted) {
                    if (e.emitted[s]) return
                } else e.emitted = {};
                e.emitted[s] = !0, Wt(c, e, 6, o)
            }
        }

        function bn(e, t, n = !1) {
            const r = t.emitsCache,
                o = r.get(e);
            if (void 0 !== o) return o;
            const i = e.emits;
            let a = {},
                s = !1;
            if (!I(e)) {
                const r = e => {
                    const n = bn(e, t, !0);
                    n && (s = !0, x(a, n))
                };
                !n && t.mixins.length && t.mixins.forEach(r), e.extends && r(e.extends), e.mixins && e.mixins.forEach(r)
            }
            return i || s ? (T(i) ? i.forEach((e => a[e] = null)) : x(a, i), L(e) && r.set(e, a), a) : (L(e) && r.set(e, null), null)
        }

        function wn(e, t) {
            return !(!e || !_(t)) && (t = t.slice(2).replace(/Once$/, ""), S(e, t[0].toLowerCase() + t.slice(1)) || S(e, K(t)) || S(e, t))
        }
        let _n = null,
            An = null;

        function xn(e) {
            const t = _n;
            return _n = e, An = e && e.type.__scopeId || null, t
        }

        function Cn(e) {
            An = e
        }

        function kn() {
            An = null
        }

        function Sn(e, t = _n, n) {
            if (!t) return e;
            if (e._n) return e;
            const r = (...n) => {
                r._d && Mo(-1);
                const o = xn(t);
                let i;
                try {
                    i = e(...n)
                } finally {
                    xn(o), r._d && Mo(1)
                }
                return i
            };
            return r._n = !0, r._c = !0, r._d = !0, r
        }

        function Tn(e) {
            const {
                type: t,
                vnode: n,
                proxy: r,
                withProxy: o,
                props: i,
                propsOptions: [a],
                slots: s,
                attrs: l,
                emit: c,
                render: d,
                renderCache: u,
                data: p,
                setupState: f,
                ctx: h,
                inheritAttrs: g
            } = e;
            let v, m;
            const y = xn(e);
            try {
                if (4 & n.shapeFlag) {
                    const e = o || r;
                    v = Ko(d.call(e, e, u, i, f, p, h)), m = l
                } else {
                    const e = t;
                    0, v = Ko(e.length > 1 ? e(i, {
                        attrs: l,
                        slots: s,
                        emit: c
                    }) : e(i, null)), m = t.props ? l : En(l)
                }
            } catch (w) {
                ko.length = 0, Xt(w, e, 1), v = Ho(xo)
            }
            let b = v;
            if (m && !1 !== g) {
                const e = Object.keys(m),
                    {
                        shapeFlag: t
                    } = b;
                e.length && 7 & t && (a && e.some(A) && (m = On(m, a)), b = $o(b, m))
            }
            return n.dirs && (b = $o(b), b.dirs = b.dirs ? b.dirs.concat(n.dirs) : n.dirs), n.transition && (b.transition = n.transition), v = b, xn(y), v
        }
        const En = e => {
                let t;
                for (const n in e)("class" === n || "style" === n || _(n)) && ((t || (t = {}))[n] = e[n]);
                return t
            },
            On = (e, t) => {
                const n = {};
                for (const r in e) A(r) && r.slice(9) in t || (n[r] = e[r]);
                return n
            };

        function Mn(e, t, n) {
            const {
                props: r,
                children: o,
                component: i
            } = e, {
                props: a,
                children: s,
                patchFlag: l
            } = t, c = i.emitsOptions;
            if (t.dirs || t.transition) return !0;
            if (!(n && l >= 0)) return !(!o && !s || s && s.$stable) || r !== a && (r ? !a || In(r, a, c) : !!a);
            if (1024 & l) return !0;
            if (16 & l) return r ? In(r, a, c) : !!a;
            if (8 & l) {
                const e = t.dynamicProps;
                for (let t = 0; t < e.length; t++) {
                    const n = e[t];
                    if (a[n] !== r[n] && !wn(c, n)) return !0
                }
            }
            return !1
        }

        function In(e, t, n) {
            const r = Object.keys(t);
            if (r.length !== Object.keys(e).length) return !0;
            for (let o = 0; o < r.length; o++) {
                const i = r[o];
                if (t[i] !== e[i] && !wn(n, i)) return !0
            }
            return !1
        }

        function Pn({
            vnode: e,
            parent: t
        }, n) {
            while (t && t.subTree === e)(e = t.vnode).el = n, t = t.parent
        }
        const Bn = e => e.__isSuspense;

        function Ln(e, t) {
            t && t.pendingBranch ? T(e) ? t.effects.push(...e) : t.effects.push(e) : pn(e)
        }

        function Fn(e, t) {
            if (ei) {
                let n = ei.provides;
                const r = ei.parent && ei.parent.provides;
                r === n && (n = ei.provides = Object.create(r)), n[e] = t
            } else 0
        }

        function Dn(e, t, n = !1) {
            const r = ei || _n;
            if (r) {
                const o = null == r.parent ? r.vnode.appContext && r.vnode.appContext.provides : r.parent.provides;
                if (o && e in o) return o[e];
                if (arguments.length > 1) return n && I(t) ? t.call(r.proxy) : t
            } else 0
        }
        const Nn = {};

        function Rn(e, t, n) {
            return jn(e, t, n)
        }

        function jn(e, t, {
            immediate: n,
            deep: r,
            flush: o,
            onTrack: i,
            onTrigger: a
        } = v) {
            const s = ei;
            let l, c, d = !1,
                u = !1;
            if (Lt(e) ? (l = () => e.value, d = St(e)) : Ct(e) ? (l = () => e, r = !0) : T(e) ? (u = !0, d = e.some((e => Ct(e) || St(e))), l = () => e.map((e => Lt(e) ? e.value : Ct(e) ? zn(e) : I(e) ? Yt(e, s, 2) : void 0))) : l = I(e) ? t ? () => Yt(e, s, 2) : () => {
                    if (!s || !s.isUnmounted) return c && c(), Wt(e, s, 3, [f])
                } : y, t && r) {
                const e = l;
                l = () => zn(e())
            }
            let p, f = e => {
                c = b.onStop = () => {
                    Yt(e, s, 4)
                }
            };
            if (si) {
                if (f = y, t ? n && Wt(t, s, 3, [l(), u ? [] : void 0, f]) : l(), "sync" !== o) return y; {
                    const e = wi();
                    p = e.__watcherHandles || (e.__watcherHandles = [])
                }
            }
            let h = u ? new Array(e.length).fill(Nn) : Nn;
            const g = () => {
                if (b.active)
                    if (t) {
                        const e = b.run();
                        (r || d || (u ? e.some(((e, t) => X(e, h[t]))) : X(e, h))) && (c && c(), Wt(t, s, 3, [e, h === Nn ? void 0 : u && h[0] === Nn ? [] : h, f]), h = e)
                    } else b.run()
            };
            let m;
            g.allowRecurse = !!t, "sync" === o ? m = g : "post" === o ? m = () => ho(g, s && s.suspense) : (g.pre = !0, s && (g.id = s.uid), m = () => cn(g));
            const b = new be(l, m);
            t ? n ? g() : h = b.run() : "post" === o ? ho(b.run.bind(b), s && s.suspense) : b.run();
            const w = () => {
                b.stop(), s && s.scope && C(s.scope.effects, b)
            };
            return p && p.push(w), w
        }

        function Hn(e, t, n) {
            const r = this.proxy,
                o = P(e) ? e.includes(".") ? Gn(r, e) : () => r[e] : e.bind(r, r);
            let i;
            I(t) ? i = t : (i = t.handler, n = t);
            const a = ei;
            ni(this);
            const s = jn(o, i.bind(r), n);
            return a ? ni(a) : ri(), s
        }

        function Gn(e, t) {
            const n = t.split(".");
            return () => {
                let t = e;
                for (let e = 0; e < n.length && t; e++) t = t[n[e]];
                return t
            }
        }

        function zn(e, t) {
            if (!L(e) || e["__v_skip"]) return e;
            if (t = t || new Set, t.has(e)) return e;
            if (t.add(e), Lt(e)) zn(e.value, t);
            else if (T(e))
                for (let n = 0; n < e.length; n++) zn(e[n], t);
            else if (O(e) || E(e)) e.forEach((e => {
                zn(e, t)
            }));
            else if (j(e))
                for (const n in e) zn(e[n], t);
            return e
        }

        function $n() {
            const e = {
                isMounted: !1,
                isLeaving: !1,
                isUnmounting: !1,
                leavingVNodes: new Map
            };
            return ur((() => {
                e.isMounted = !0
            })), hr((() => {
                e.isUnmounting = !0
            })), e
        }
        const Vn = [Function, Array],
            Un = {
                name: "BaseTransition",
                props: {
                    mode: String,
                    appear: Boolean,
                    persisted: Boolean,
                    onBeforeEnter: Vn,
                    onEnter: Vn,
                    onAfterEnter: Vn,
                    onEnterCancelled: Vn,
                    onBeforeLeave: Vn,
                    onLeave: Vn,
                    onAfterLeave: Vn,
                    onLeaveCancelled: Vn,
                    onBeforeAppear: Vn,
                    onAppear: Vn,
                    onAfterAppear: Vn,
                    onAppearCancelled: Vn
                },
                setup(e, {
                    slots: t
                }) {
                    const n = ti(),
                        r = $n();
                    let o;
                    return () => {
                        const i = t.default && Zn(t.default(), !0);
                        if (!i || !i.length) return;
                        let a = i[0];
                        if (i.length > 1) {
                            let e = !1;
                            for (const t of i)
                                if (t.type !== xo) {
                                    0,
                                    a = t,
                                    e = !0;
                                    break
                                }
                        }
                        const s = Et(e),
                            {
                                mode: l
                            } = s;
                        if (r.isLeaving) return Xn(a);
                        const c = Qn(a);
                        if (!c) return Xn(a);
                        const d = Wn(c, s, r, n);
                        qn(c, d);
                        const u = n.subTree,
                            p = u && Qn(u);
                        let f = !1;
                        const {
                            getTransitionKey: h
                        } = c.type;
                        if (h) {
                            const e = h();
                            void 0 === o ? o = e : e !== o && (o = e, f = !0)
                        }
                        if (p && p.type !== xo && (!Fo(c, p) || f)) {
                            const e = Wn(p, s, r, n);
                            if (qn(p, e), "out-in" === l) return r.isLeaving = !0, e.afterLeave = () => {
                                r.isLeaving = !1, !1 !== n.update.active && n.update()
                            }, Xn(a);
                            "in-out" === l && c.type !== xo && (e.delayLeave = (e, t, n) => {
                                const o = Yn(r, p);
                                o[String(p.key)] = p, e._leaveCb = () => {
                                    t(), e._leaveCb = void 0, delete d.delayedLeave
                                }, d.delayedLeave = n
                            })
                        }
                        return a
                    }
                }
            },
            Kn = Un;

        function Yn(e, t) {
            const {
                leavingVNodes: n
            } = e;
            let r = n.get(t.type);
            return r || (r = Object.create(null), n.set(t.type, r)), r
        }

        function Wn(e, t, n, r) {
            const {
                appear: o,
                mode: i,
                persisted: a = !1,
                onBeforeEnter: s,
                onEnter: l,
                onAfterEnter: c,
                onEnterCancelled: d,
                onBeforeLeave: u,
                onLeave: p,
                onAfterLeave: f,
                onLeaveCancelled: h,
                onBeforeAppear: g,
                onAppear: v,
                onAfterAppear: m,
                onAppearCancelled: y
            } = t, b = String(e.key), w = Yn(n, e), _ = (e, t) => {
                e && Wt(e, r, 9, t)
            }, A = (e, t) => {
                const n = t[1];
                _(e, t), T(e) ? e.every((e => e.length <= 1)) && n() : e.length <= 1 && n()
            }, x = {
                mode: i,
                persisted: a,
                beforeEnter(t) {
                    let r = s;
                    if (!n.isMounted) {
                        if (!o) return;
                        r = g || s
                    }
                    t._leaveCb && t._leaveCb(!0);
                    const i = w[b];
                    i && Fo(e, i) && i.el._leaveCb && i.el._leaveCb(), _(r, [t])
                },
                enter(e) {
                    let t = l,
                        r = c,
                        i = d;
                    if (!n.isMounted) {
                        if (!o) return;
                        t = v || l, r = m || c, i = y || d
                    }
                    let a = !1;
                    const s = e._enterCb = t => {
                        a || (a = !0, _(t ? i : r, [e]), x.delayedLeave && x.delayedLeave(), e._enterCb = void 0)
                    };
                    t ? A(t, [e, s]) : s()
                },
                leave(t, r) {
                    const o = String(e.key);
                    if (t._enterCb && t._enterCb(!0), n.isUnmounting) return r();
                    _(u, [t]);
                    let i = !1;
                    const a = t._leaveCb = n => {
                        i || (i = !0, r(), _(n ? h : f, [t]), t._leaveCb = void 0, w[o] === e && delete w[o])
                    };
                    w[o] = e, p ? A(p, [t, a]) : a()
                },
                clone(e) {
                    return Wn(e, t, n, r)
                }
            };
            return x
        }

        function Xn(e) {
            if (er(e)) return e = $o(e), e.children = null, e
        }

        function Qn(e) {
            return er(e) ? e.children ? e.children[0] : void 0 : e
        }

        function qn(e, t) {
            6 & e.shapeFlag && e.component ? qn(e.component.subTree, t) : 128 & e.shapeFlag ? (e.ssContent.transition = t.clone(e.ssContent), e.ssFallback.transition = t.clone(e.ssFallback)) : e.transition = t
        }

        function Zn(e, t = !1, n) {
            let r = [],
                o = 0;
            for (let i = 0; i < e.length; i++) {
                let a = e[i];
                const s = null == n ? a.key : String(n) + String(null != a.key ? a.key : i);
                a.type === _o ? (128 & a.patchFlag && o++, r = r.concat(Zn(a.children, t, s))) : (t || a.type !== xo) && r.push(null != s ? $o(a, {
                    key: s
                }) : a)
            }
            if (o > 1)
                for (let i = 0; i < r.length; i++) r[i].patchFlag = -2;
            return r
        }
        const Jn = e => !!e.type.__asyncLoader;
        const er = e => e.type.__isKeepAlive;
        RegExp, RegExp;

        function tr(e, t) {
            return T(e) ? e.some((e => tr(e, t))) : P(e) ? e.split(",").includes(t) : !!e.test && e.test(t)
        }

        function nr(e, t) {
            or(e, "a", t)
        }

        function rr(e, t) {
            or(e, "da", t)
        }

        function or(e, t, n = ei) {
            const r = e.__wdc || (e.__wdc = () => {
                let t = n;
                while (t) {
                    if (t.isDeactivated) return;
                    t = t.parent
                }
                return e()
            });
            if (lr(t, r, n), n) {
                let e = n.parent;
                while (e && e.parent) er(e.parent.vnode) && ir(r, t, n, e), e = e.parent
            }
        }

        function ir(e, t, n, r) {
            const o = lr(t, e, r, !0);
            gr((() => {
                C(r[t], o)
            }), n)
        }

        function ar(e) {
            e.shapeFlag &= -257, e.shapeFlag &= -513
        }

        function sr(e) {
            return 128 & e.shapeFlag ? e.ssContent : e
        }

        function lr(e, t, n = ei, r = !1) {
            if (n) {
                const o = n[e] || (n[e] = []),
                    i = t.__weh || (t.__weh = (...r) => {
                        if (n.isUnmounted) return;
                        xe(), ni(n);
                        const o = Wt(t, n, e, r);
                        return ri(), Ce(), o
                    });
                return r ? o.unshift(i) : o.push(i), i
            }
        }
        const cr = e => (t, n = ei) => (!si || "sp" === e) && lr(e, ((...e) => t(...e)), n),
            dr = cr("bm"),
            ur = cr("m"),
            pr = cr("bu"),
            fr = cr("u"),
            hr = cr("bum"),
            gr = cr("um"),
            vr = cr("sp"),
            mr = cr("rtg"),
            yr = cr("rtc");

        function br(e, t = ei) {
            lr("ec", e, t)
        }

        function wr(e, t) {
            const n = _n;
            if (null === n) return e;
            const r = hi(n) || n.proxy,
                o = e.dirs || (e.dirs = []);
            for (let i = 0; i < t.length; i++) {
                let [e, n, a, s = v] = t[i];
                e && (I(e) && (e = {
                    mounted: e,
                    updated: e
                }), e.deep && zn(n), o.push({
                    dir: e,
                    instance: r,
                    value: n,
                    oldValue: void 0,
                    arg: a,
                    modifiers: s
                }))
            }
            return e
        }

        function _r(e, t, n, r) {
            const o = e.dirs,
                i = t && t.dirs;
            for (let a = 0; a < o.length; a++) {
                const s = o[a];
                i && (s.oldValue = i[a].value);
                let l = s.dir[r];
                l && (xe(), Wt(l, n, 8, [e.el, s, e, t]), Ce())
            }
        }
        const Ar = "components";

        function xr(e, t) {
            return kr(Ar, e, !0, t) || e
        }
        const Cr = Symbol();

        function kr(e, t, n = !0, r = !1) {
            const o = _n || ei;
            if (o) {
                const n = o.type;
                if (e === Ar) {
                    const e = gi(n, !1);
                    if (e && (e === t || e === V(t) || e === Y(V(t)))) return n
                }
                const i = Sr(o[e] || n[e], t) || Sr(o.appContext[e], t);
                return !i && r ? n : i
            }
        }

        function Sr(e, t) {
            return e && (e[t] || e[V(t)] || e[Y(V(t))])
        }

        function Tr(e, t, n, r) {
            let o;
            const i = n && n[r];
            if (T(e) || P(e)) {
                o = new Array(e.length);
                for (let n = 0, r = e.length; n < r; n++) o[n] = t(e[n], n, void 0, i && i[n])
            } else if ("number" === typeof e) {
                0,
                o = new Array(e);
                for (let n = 0; n < e; n++) o[n] = t(n + 1, n, void 0, i && i[n])
            }
            else if (L(e))
                if (e[Symbol.iterator]) o = Array.from(e, ((e, n) => t(e, n, void 0, i && i[n])));
                else {
                    const n = Object.keys(e);
                    o = new Array(n.length);
                    for (let r = 0, a = n.length; r < a; r++) {
                        const a = n[r];
                        o[r] = t(e[a], a, r, i && i[r])
                    }
                }
            else o = [];
            return n && (n[r] = o), o
        }
        const Er = e => e ? oi(e) ? hi(e) || e.proxy : Er(e.parent) : null,
            Or = x(Object.create(null), {
                $: e => e,
                $el: e => e.vnode.el,
                $data: e => e.data,
                $props: e => e.props,
                $attrs: e => e.attrs,
                $slots: e => e.slots,
                $refs: e => e.refs,
                $parent: e => Er(e.parent),
                $root: e => Er(e.root),
                $emit: e => e.emit,
                $options: e => Nr(e),
                $forceUpdate: e => e.f || (e.f = () => cn(e.update)),
                $nextTick: e => e.n || (e.n = sn.bind(e.proxy)),
                $watch: e => Hn.bind(e)
            }),
            Mr = (e, t) => e !== v && !e.__isScriptSetup && S(e, t),
            Ir = {
                get({
                    _: e
                }, t) {
                    const {
                        ctx: n,
                        setupState: r,
                        data: o,
                        props: i,
                        accessCache: a,
                        type: s,
                        appContext: l
                    } = e;
                    let c;
                    if ("$" !== t[0]) {
                        const s = a[t];
                        if (void 0 !== s) switch (s) {
                            case 1:
                                return r[t];
                            case 2:
                                return o[t];
                            case 4:
                                return n[t];
                            case 3:
                                return i[t]
                        } else {
                            if (Mr(r, t)) return a[t] = 1, r[t];
                            if (o !== v && S(o, t)) return a[t] = 2, o[t];
                            if ((c = e.propsOptions[0]) && S(c, t)) return a[t] = 3, i[t];
                            if (n !== v && S(n, t)) return a[t] = 4, n[t];
                            Pr && (a[t] = 0)
                        }
                    }
                    const d = Or[t];
                    let u, p;
                    return d ? ("$attrs" === t && ke(e, "get", t), d(e)) : (u = s.__cssModules) && (u = u[t]) ? u : n !== v && S(n, t) ? (a[t] = 4, n[t]) : (p = l.config.globalProperties, S(p, t) ? p[t] : void 0)
                },
                set({
                    _: e
                }, t, n) {
                    const {
                        data: r,
                        setupState: o,
                        ctx: i
                    } = e;
                    return Mr(o, t) ? (o[t] = n, !0) : r !== v && S(r, t) ? (r[t] = n, !0) : !S(e.props, t) && (("$" !== t[0] || !(t.slice(1) in e)) && (i[t] = n, !0))
                },
                has({
                    _: {
                        data: e,
                        setupState: t,
                        accessCache: n,
                        ctx: r,
                        appContext: o,
                        propsOptions: i
                    }
                }, a) {
                    let s;
                    return !!n[a] || e !== v && S(e, a) || Mr(t, a) || (s = i[0]) && S(s, a) || S(r, a) || S(Or, a) || S(o.config.globalProperties, a)
                },
                defineProperty(e, t, n) {
                    return null != n.get ? e._.accessCache[t] = 0 : S(n, "value") && this.set(e, t, n.value, null), Reflect.defineProperty(e, t, n)
                }
            };
        let Pr = !0;

        function Br(e) {
            const t = Nr(e),
                n = e.proxy,
                r = e.ctx;
            Pr = !1, t.beforeCreate && Fr(t.beforeCreate, e, "bc");
            const {
                data: o,
                computed: i,
                methods: a,
                watch: s,
                provide: l,
                inject: c,
                created: d,
                beforeMount: u,
                mounted: p,
                beforeUpdate: f,
                updated: h,
                activated: g,
                deactivated: v,
                beforeDestroy: m,
                beforeUnmount: b,
                destroyed: w,
                unmounted: _,
                render: A,
                renderTracked: x,
                renderTriggered: C,
                errorCaptured: k,
                serverPrefetch: S,
                expose: E,
                inheritAttrs: O,
                components: M,
                directives: P,
                filters: B
            } = t, F = null;
            if (c && Lr(c, r, F, e.appContext.config.unwrapInjectedRef), a)
                for (const y in a) {
                    const e = a[y];
                    I(e) && (r[y] = e.bind(n))
                }
            if (o) {
                0;
                const t = o.call(n, n);
                0, L(t) && (e.data = wt(t))
            }
            if (Pr = !0, i)
                for (const T in i) {
                    const e = i[T],
                        t = I(e) ? e.bind(n, n) : I(e.get) ? e.get.bind(n, n) : y;
                    0;
                    const o = !I(e) && I(e.set) ? e.set.bind(n) : y,
                        a = mi({
                            get: t,
                            set: o
                        });
                    Object.defineProperty(r, T, {
                        enumerable: !0,
                        configurable: !0,
                        get: () => a.value,
                        set: e => a.value = e
                    })
                }
            if (s)
                for (const y in s) Dr(s[y], r, n, y);
            if (l) {
                const e = I(l) ? l.call(n) : l;
                Reflect.ownKeys(e).forEach((t => {
                    Fn(t, e[t])
                }))
            }

            function D(e, t) {
                T(t) ? t.forEach((t => e(t.bind(n)))) : t && e(t.bind(n))
            }
            if (d && Fr(d, e, "c"), D(dr, u), D(ur, p), D(pr, f), D(fr, h), D(nr, g), D(rr, v), D(br, k), D(yr, x), D(mr, C), D(hr, b), D(gr, _), D(vr, S), T(E))
                if (E.length) {
                    const t = e.exposed || (e.exposed = {});
                    E.forEach((e => {
                        Object.defineProperty(t, e, {
                            get: () => n[e],
                            set: t => n[e] = t
                        })
                    }))
                } else e.exposed || (e.exposed = {});
            A && e.render === y && (e.render = A), null != O && (e.inheritAttrs = O), M && (e.components = M), P && (e.directives = P)
        }

        function Lr(e, t, n = y, r = !1) {
            T(e) && (e = zr(e));
            for (const o in e) {
                const n = e[o];
                let i;
                i = L(n) ? "default" in n ? Dn(n.from || o, n.default, !0) : Dn(n.from || o) : Dn(n), Lt(i) && r ? Object.defineProperty(t, o, {
                    enumerable: !0,
                    configurable: !0,
                    get: () => i.value,
                    set: e => i.value = e
                }) : t[o] = i
            }
        }

        function Fr(e, t, n) {
            Wt(T(e) ? e.map((e => e.bind(t.proxy))) : e.bind(t.proxy), t, n)
        }

        function Dr(e, t, n, r) {
            const o = r.includes(".") ? Gn(n, r) : () => n[r];
            if (P(e)) {
                const n = t[e];
                I(n) && Rn(o, n)
            } else if (I(e)) Rn(o, e.bind(n));
            else if (L(e))
                if (T(e)) e.forEach((e => Dr(e, t, n, r)));
                else {
                    const r = I(e.handler) ? e.handler.bind(n) : t[e.handler];
                    I(r) && Rn(o, r, e)
                }
            else 0
        }

        function Nr(e) {
            const t = e.type,
                {
                    mixins: n,
                    extends: r
                } = t,
                {
                    mixins: o,
                    optionsCache: i,
                    config: {
                        optionMergeStrategies: a
                    }
                } = e.appContext,
                s = i.get(t);
            let l;
            return s ? l = s : o.length || n || r ? (l = {}, o.length && o.forEach((e => Rr(l, e, a, !0))), Rr(l, t, a)) : l = t, L(t) && i.set(t, l), l
        }

        function Rr(e, t, n, r = !1) {
            const {
                mixins: o,
                extends: i
            } = t;
            i && Rr(e, i, n, !0), o && o.forEach((t => Rr(e, t, n, !0)));
            for (const a in t)
                if (r && "expose" === a);
                else {
                    const r = jr[a] || n && n[a];
                    e[a] = r ? r(e[a], t[a]) : t[a]
                } return e
        }
        const jr = {
            data: Hr,
            props: Vr,
            emits: Vr,
            methods: Vr,
            computed: Vr,
            beforeCreate: $r,
            created: $r,
            beforeMount: $r,
            mounted: $r,
            beforeUpdate: $r,
            updated: $r,
            beforeDestroy: $r,
            beforeUnmount: $r,
            destroyed: $r,
            unmounted: $r,
            activated: $r,
            deactivated: $r,
            errorCaptured: $r,
            serverPrefetch: $r,
            components: Vr,
            directives: Vr,
            watch: Ur,
            provide: Hr,
            inject: Gr
        };

        function Hr(e, t) {
            return t ? e ? function() {
                return x(I(e) ? e.call(this, this) : e, I(t) ? t.call(this, this) : t)
            } : t : e
        }

        function Gr(e, t) {
            return Vr(zr(e), zr(t))
        }

        function zr(e) {
            if (T(e)) {
                const t = {};
                for (let n = 0; n < e.length; n++) t[e[n]] = e[n];
                return t
            }
            return e
        }

        function $r(e, t) {
            return e ? [...new Set([].concat(e, t))] : t
        }

        function Vr(e, t) {
            return e ? x(x(Object.create(null), e), t) : t
        }

        function Ur(e, t) {
            if (!e) return t;
            if (!t) return e;
            const n = x(Object.create(null), e);
            for (const r in t) n[r] = $r(e[r], t[r]);
            return n
        }

        function Kr(e, t, n, r = !1) {
            const o = {},
                i = {};
            q(i, Do, 1), e.propsDefaults = Object.create(null), Wr(e, t, o, i);
            for (const a in e.propsOptions[0]) a in o || (o[a] = void 0);
            n ? e.props = r ? o : _t(o) : e.type.props ? e.props = o : e.props = i, e.attrs = i
        }

        function Yr(e, t, n, r) {
            const {
                props: o,
                attrs: i,
                vnode: {
                    patchFlag: a
                }
            } = e, s = Et(o), [l] = e.propsOptions;
            let c = !1;
            if (!(r || a > 0) || 16 & a) {
                let r;
                Wr(e, t, o, i) && (c = !0);
                for (const i in s) t && (S(t, i) || (r = K(i)) !== i && S(t, r)) || (l ? !n || void 0 === n[i] && void 0 === n[r] || (o[i] = Xr(l, s, i, void 0, e, !0)) : delete o[i]);
                if (i !== s)
                    for (const e in i) t && S(t, e) || (delete i[e], c = !0)
            } else if (8 & a) {
                const n = e.vnode.dynamicProps;
                for (let r = 0; r < n.length; r++) {
                    let a = n[r];
                    if (wn(e.emitsOptions, a)) continue;
                    const d = t[a];
                    if (l)
                        if (S(i, a)) d !== i[a] && (i[a] = d, c = !0);
                        else {
                            const t = V(a);
                            o[t] = Xr(l, s, t, d, e, !1)
                        }
                    else d !== i[a] && (i[a] = d, c = !0)
                }
            }
            c && Te(e, "set", "$attrs")
        }

        function Wr(e, t, n, r) {
            const [o, i] = e.propsOptions;
            let a, s = !1;
            if (t)
                for (let l in t) {
                    if (G(l)) continue;
                    const c = t[l];
                    let d;
                    o && S(o, d = V(l)) ? i && i.includes(d) ? (a || (a = {}))[d] = c : n[d] = c : wn(e.emitsOptions, l) || l in r && c === r[l] || (r[l] = c, s = !0)
                }
            if (i) {
                const t = Et(n),
                    r = a || v;
                for (let a = 0; a < i.length; a++) {
                    const s = i[a];
                    n[s] = Xr(o, t, s, r[s], e, !S(r, s))
                }
            }
            return s
        }

        function Xr(e, t, n, r, o, i) {
            const a = e[n];
            if (null != a) {
                const e = S(a, "default");
                if (e && void 0 === r) {
                    const e = a.default;
                    if (a.type !== Function && I(e)) {
                        const {
                            propsDefaults: i
                        } = o;
                        n in i ? r = i[n] : (ni(o), r = i[n] = e.call(null, t), ri())
                    } else r = e
                }
                a[0] && (i && !e ? r = !1 : !a[1] || "" !== r && r !== K(n) || (r = !0))
            }
            return r
        }

        function Qr(e, t, n = !1) {
            const r = t.propsCache,
                o = r.get(e);
            if (o) return o;
            const i = e.props,
                a = {},
                s = [];
            let l = !1;
            if (!I(e)) {
                const r = e => {
                    l = !0;
                    const [n, r] = Qr(e, t, !0);
                    x(a, n), r && s.push(...r)
                };
                !n && t.mixins.length && t.mixins.forEach(r), e.extends && r(e.extends), e.mixins && e.mixins.forEach(r)
            }
            if (!i && !l) return L(e) && r.set(e, m), m;
            if (T(i))
                for (let d = 0; d < i.length; d++) {
                    0;
                    const e = V(i[d]);
                    qr(e) && (a[e] = v)
                } else if (i) {
                    0;
                    for (const e in i) {
                        const t = V(e);
                        if (qr(t)) {
                            const n = i[e],
                                r = a[t] = T(n) || I(n) ? {
                                    type: n
                                } : Object.assign({}, n);
                            if (r) {
                                const e = eo(Boolean, r.type),
                                    n = eo(String, r.type);
                                r[0] = e > -1, r[1] = n < 0 || e < n, (e > -1 || S(r, "default")) && s.push(t)
                            }
                        }
                    }
                } const c = [a, s];
            return L(e) && r.set(e, c), c
        }

        function qr(e) {
            return "$" !== e[0]
        }

        function Zr(e) {
            const t = e && e.toString().match(/^\s*function (\w+)/);
            return t ? t[1] : null === e ? "null" : ""
        }

        function Jr(e, t) {
            return Zr(e) === Zr(t)
        }

        function eo(e, t) {
            return T(t) ? t.findIndex((t => Jr(t, e))) : I(t) && Jr(t, e) ? 0 : -1
        }
        const to = e => "_" === e[0] || "$stable" === e,
            no = e => T(e) ? e.map(Ko) : [Ko(e)],
            ro = (e, t, n) => {
                if (t._n) return t;
                const r = Sn(((...e) => no(t(...e))), n);
                return r._c = !1, r
            },
            oo = (e, t, n) => {
                const r = e._ctx;
                for (const o in e) {
                    if (to(o)) continue;
                    const n = e[o];
                    if (I(n)) t[o] = ro(o, n, r);
                    else if (null != n) {
                        0;
                        const e = no(n);
                        t[o] = () => e
                    }
                }
            },
            io = (e, t) => {
                const n = no(t);
                e.slots.default = () => n
            },
            ao = (e, t) => {
                if (32 & e.vnode.shapeFlag) {
                    const n = t._;
                    n ? (e.slots = Et(t), q(t, "_", n)) : oo(t, e.slots = {})
                } else e.slots = {}, t && io(e, t);
                q(e.slots, Do, 1)
            },
            so = (e, t, n) => {
                const {
                    vnode: r,
                    slots: o
                } = e;
                let i = !0,
                    a = v;
                if (32 & r.shapeFlag) {
                    const e = t._;
                    e ? n && 1 === e ? i = !1 : (x(o, t), n || 1 !== e || delete o._) : (i = !t.$stable, oo(t, o)), a = t
                } else t && (io(e, t), a = {
                    default: 1
                });
                if (i)
                    for (const s in o) to(s) || s in a || delete o[s]
            };

        function lo() {
            return {
                app: null,
                config: {
                    isNativeTag: b,
                    performance: !1,
                    globalProperties: {},
                    optionMergeStrategies: {},
                    errorHandler: void 0,
                    warnHandler: void 0,
                    compilerOptions: {}
                },
                mixins: [],
                components: {},
                directives: {},
                provides: Object.create(null),
                optionsCache: new WeakMap,
                propsCache: new WeakMap,
                emitsCache: new WeakMap
            }
        }
        let co = 0;

        function uo(e, t) {
            return function(n, r = null) {
                I(n) || (n = Object.assign({}, n)), null == r || L(r) || (r = null);
                const o = lo(),
                    i = new Set;
                let a = !1;
                const s = o.app = {
                    _uid: co++,
                    _component: n,
                    _props: r,
                    _container: null,
                    _context: o,
                    _instance: null,
                    version: _i,
                    get config() {
                        return o.config
                    },
                    set config(e) {
                        0
                    },
                    use(e, ...t) {
                        return i.has(e) || (e && I(e.install) ? (i.add(e), e.install(s, ...t)) : I(e) && (i.add(e), e(s, ...t))), s
                    },
                    mixin(e) {
                        return o.mixins.includes(e) || o.mixins.push(e), s
                    },
                    component(e, t) {
                        return t ? (o.components[e] = t, s) : o.components[e]
                    },
                    directive(e, t) {
                        return t ? (o.directives[e] = t, s) : o.directives[e]
                    },
                    mount(i, l, c) {
                        if (!a) {
                            0;
                            const d = Ho(n, r);
                            return d.appContext = o, l && t ? t(d, i) : e(d, i, c), a = !0, s._container = i, i.__vue_app__ = s, hi(d.component) || d.component.proxy
                        }
                    },
                    unmount() {
                        a && (e(null, s._container), delete s._container.__vue_app__)
                    },
                    provide(e, t) {
                        return o.provides[e] = t, s
                    }
                };
                return s
            }
        }

        function po(e, t, n, r, o = !1) {
            if (T(e)) return void e.forEach(((e, i) => po(e, t && (T(t) ? t[i] : t), n, r, o)));
            if (Jn(r) && !o) return;
            const i = 4 & r.shapeFlag ? hi(r.component) || r.component.proxy : r.el,
                a = o ? null : i,
                {
                    i: s,
                    r: l
                } = e;
            const c = t && t.r,
                d = s.refs === v ? s.refs = {} : s.refs,
                u = s.setupState;
            if (null != c && c !== l && (P(c) ? (d[c] = null, S(u, c) && (u[c] = null)) : Lt(c) && (c.value = null)), I(l)) Yt(l, s, 12, [a, d]);
            else {
                const t = P(l),
                    r = Lt(l);
                if (t || r) {
                    const s = () => {
                        if (e.f) {
                            const n = t ? S(u, l) ? u[l] : d[l] : l.value;
                            o ? T(n) && C(n, i) : T(n) ? n.includes(i) || n.push(i) : t ? (d[l] = [i], S(u, l) && (u[l] = d[l])) : (l.value = [i], e.k && (d[e.k] = l.value))
                        } else t ? (d[l] = a, S(u, l) && (u[l] = a)) : r && (l.value = a, e.k && (d[e.k] = a))
                    };
                    a ? (s.id = -1, ho(s, n)) : s()
                } else 0
            }
        }

        function fo() {}
        const ho = Ln;

        function go(e) {
            return vo(e)
        }

        function vo(e, t) {
            fo();
            const n = ee();
            n.__VUE__ = !0;
            const {
                insert: r,
                remove: o,
                patchProp: i,
                createElement: a,
                createText: s,
                createComment: l,
                setText: c,
                setElementText: d,
                parentNode: u,
                nextSibling: p,
                setScopeId: f = y,
                insertStaticContent: h
            } = e, g = (e, t, n, r = null, o = null, i = null, a = !1, s = null, l = !!t.dynamicChildren) => {
                if (e === t) return;
                e && !Fo(e, t) && (r = Y(e), z(e, o, i, !0), e = null), -2 === t.patchFlag && (l = !1, t.dynamicChildren = null);
                const {
                    type: c,
                    ref: d,
                    shapeFlag: u
                } = t;
                switch (c) {
                    case Ao:
                        b(e, t, n, r);
                        break;
                    case xo:
                        w(e, t, n, r);
                        break;
                    case Co:
                        null == e && _(t, n, r, a);
                        break;
                    case _o:
                        I(e, t, n, r, o, i, a, s, l);
                        break;
                    default:
                        1 & u ? C(e, t, n, r, o, i, a, s, l) : 6 & u ? P(e, t, n, r, o, i, a, s, l) : (64 & u || 128 & u) && c.process(e, t, n, r, o, i, a, s, l, X)
                }
                null != d && o && po(d, e && e.ref, i, t || e, !t)
            }, b = (e, t, n, o) => {
                if (null == e) r(t.el = s(t.children), n, o);
                else {
                    const n = t.el = e.el;
                    t.children !== e.children && c(n, t.children)
                }
            }, w = (e, t, n, o) => {
                null == e ? r(t.el = l(t.children || ""), n, o) : t.el = e.el
            }, _ = (e, t, n, r) => {
                [e.el, e.anchor] = h(e.children, t, n, r, e.el, e.anchor)
            }, A = ({
                el: e,
                anchor: t
            }, n, o) => {
                let i;
                while (e && e !== t) i = p(e), r(e, n, o), e = i;
                r(t, n, o)
            }, x = ({
                el: e,
                anchor: t
            }) => {
                let n;
                while (e && e !== t) n = p(e), o(e), e = n;
                o(t)
            }, C = (e, t, n, r, o, i, a, s, l) => {
                a = a || "svg" === t.type, null == e ? k(t, n, r, o, i, a, s, l) : E(e, t, o, i, a, s, l)
            }, k = (e, t, n, o, s, l, c, u) => {
                let p, f;
                const {
                    type: h,
                    props: g,
                    shapeFlag: v,
                    transition: m,
                    dirs: y
                } = e;
                if (p = e.el = a(e.type, l, g && g.is, g), 8 & v ? d(p, e.children) : 16 & v && T(e.children, p, null, o, s, l && "foreignObject" !== h, c, u), y && _r(e, null, o, "created"), g) {
                    for (const t in g) "value" === t || G(t) || i(p, t, null, g[t], l, e.children, o, s, K);
                    "value" in g && i(p, "value", null, g.value), (f = g.onVnodeBeforeMount) && Qo(f, o, e)
                }
                S(p, e, e.scopeId, c, o), y && _r(e, null, o, "beforeMount");
                const b = (!s || s && !s.pendingBranch) && m && !m.persisted;
                b && m.beforeEnter(p), r(p, t, n), ((f = g && g.onVnodeMounted) || b || y) && ho((() => {
                    f && Qo(f, o, e), b && m.enter(p), y && _r(e, null, o, "mounted")
                }), s)
            }, S = (e, t, n, r, o) => {
                if (n && f(e, n), r)
                    for (let i = 0; i < r.length; i++) f(e, r[i]);
                if (o) {
                    let n = o.subTree;
                    if (t === n) {
                        const t = o.vnode;
                        S(e, t, t.scopeId, t.slotScopeIds, o.parent)
                    }
                }
            }, T = (e, t, n, r, o, i, a, s, l = 0) => {
                for (let c = l; c < e.length; c++) {
                    const l = e[c] = s ? Yo(e[c]) : Ko(e[c]);
                    g(null, l, t, n, r, o, i, a, s)
                }
            }, E = (e, t, n, r, o, a, s) => {
                const l = t.el = e.el;
                let {
                    patchFlag: c,
                    dynamicChildren: u,
                    dirs: p
                } = t;
                c |= 16 & e.patchFlag;
                const f = e.props || v,
                    h = t.props || v;
                let g;
                n && mo(n, !1), (g = h.onVnodeBeforeUpdate) && Qo(g, n, t, e), p && _r(t, e, n, "beforeUpdate"), n && mo(n, !0);
                const m = o && "foreignObject" !== t.type;
                if (u ? O(e.dynamicChildren, u, l, n, r, m, a) : s || N(e, t, l, null, n, r, m, a, !1), c > 0) {
                    if (16 & c) M(l, t, f, h, n, r, o);
                    else if (2 & c && f.class !== h.class && i(l, "class", null, h.class, o), 4 & c && i(l, "style", f.style, h.style, o), 8 & c) {
                        const a = t.dynamicProps;
                        for (let t = 0; t < a.length; t++) {
                            const s = a[t],
                                c = f[s],
                                d = h[s];
                            d === c && "value" !== s || i(l, s, c, d, o, e.children, n, r, K)
                        }
                    }
                    1 & c && e.children !== t.children && d(l, t.children)
                } else s || null != u || M(l, t, f, h, n, r, o);
                ((g = h.onVnodeUpdated) || p) && ho((() => {
                    g && Qo(g, n, t, e), p && _r(t, e, n, "updated")
                }), r)
            }, O = (e, t, n, r, o, i, a) => {
                for (let s = 0; s < t.length; s++) {
                    const l = e[s],
                        c = t[s],
                        d = l.el && (l.type === _o || !Fo(l, c) || 70 & l.shapeFlag) ? u(l.el) : n;
                    g(l, c, d, null, r, o, i, a, !0)
                }
            }, M = (e, t, n, r, o, a, s) => {
                if (n !== r) {
                    if (n !== v)
                        for (const l in n) G(l) || l in r || i(e, l, n[l], null, s, t.children, o, a, K);
                    for (const l in r) {
                        if (G(l)) continue;
                        const c = r[l],
                            d = n[l];
                        c !== d && "value" !== l && i(e, l, d, c, s, t.children, o, a, K)
                    }
                    "value" in r && i(e, "value", n.value, r.value)
                }
            }, I = (e, t, n, o, i, a, l, c, d) => {
                const u = t.el = e ? e.el : s(""),
                    p = t.anchor = e ? e.anchor : s("");
                let {
                    patchFlag: f,
                    dynamicChildren: h,
                    slotScopeIds: g
                } = t;
                g && (c = c ? c.concat(g) : g), null == e ? (r(u, n, o), r(p, n, o), T(t.children, n, p, i, a, l, c, d)) : f > 0 && 64 & f && h && e.dynamicChildren ? (O(e.dynamicChildren, h, n, i, a, l, c), (null != t.key || i && t === i.subTree) && yo(e, t, !0)) : N(e, t, n, p, i, a, l, c, d)
            }, P = (e, t, n, r, o, i, a, s, l) => {
                t.slotScopeIds = s, null == e ? 512 & t.shapeFlag ? o.ctx.activate(t, n, r, a, l) : B(t, n, r, o, i, a, l) : L(e, t, l)
            }, B = (e, t, n, r, o, i, a) => {
                const s = e.component = Jo(e, r, o);
                if (er(e) && (s.ctx.renderer = X), li(s), s.asyncDep) {
                    if (o && o.registerDep(s, F), !e.el) {
                        const e = s.subTree = Ho(xo);
                        w(null, e, t, n)
                    }
                } else F(s, e, t, n, o, i, a)
            }, L = (e, t, n) => {
                const r = t.component = e.component;
                if (Mn(e, t, n)) {
                    if (r.asyncDep && !r.asyncResolved) return void D(r, t, n);
                    r.next = t, un(r.update), r.update()
                } else t.el = e.el, r.vnode = t
            }, F = (e, t, n, r, o, i, a) => {
                const s = () => {
                        if (e.isMounted) {
                            let t, {
                                    next: n,
                                    bu: r,
                                    u: s,
                                    parent: l,
                                    vnode: c
                                } = e,
                                d = n;
                            0, mo(e, !1), n ? (n.el = c.el, D(e, n, a)) : n = c, r && Q(r), (t = n.props && n.props.onVnodeBeforeUpdate) && Qo(t, l, n, c), mo(e, !0);
                            const p = Tn(e);
                            0;
                            const f = e.subTree;
                            e.subTree = p, g(f, p, u(f.el), Y(f), e, o, i), n.el = p.el, null === d && Pn(e, p.el), s && ho(s, o), (t = n.props && n.props.onVnodeUpdated) && ho((() => Qo(t, l, n, c)), o)
                        } else {
                            let a;
                            const {
                                el: s,
                                props: l
                            } = t, {
                                bm: c,
                                m: d,
                                parent: u
                            } = e, p = Jn(t);
                            if (mo(e, !1), c && Q(c), !p && (a = l && l.onVnodeBeforeMount) && Qo(a, u, t), mo(e, !0), s && Z) {
                                const n = () => {
                                    e.subTree = Tn(e), Z(s, e.subTree, e, o, null)
                                };
                                p ? t.type.__asyncLoader().then((() => !e.isUnmounted && n())) : n()
                            } else {
                                0;
                                const a = e.subTree = Tn(e);
                                0, g(null, a, n, r, e, o, i), t.el = a.el
                            }
                            if (d && ho(d, o), !p && (a = l && l.onVnodeMounted)) {
                                const e = t;
                                ho((() => Qo(a, u, e)), o)
                            }(256 & t.shapeFlag || u && Jn(u.vnode) && 256 & u.vnode.shapeFlag) && e.a && ho(e.a, o), e.isMounted = !0, t = n = r = null
                        }
                    },
                    l = e.effect = new be(s, (() => cn(c)), e.scope),
                    c = e.update = () => l.run();
                c.id = e.uid, mo(e, !0), c()
            }, D = (e, t, n) => {
                t.component = e;
                const r = e.vnode.props;
                e.vnode = t, e.next = null, Yr(e, t.props, r, n), so(e, t.children, n), xe(), fn(), Ce()
            }, N = (e, t, n, r, o, i, a, s, l = !1) => {
                const c = e && e.children,
                    u = e ? e.shapeFlag : 0,
                    p = t.children,
                    {
                        patchFlag: f,
                        shapeFlag: h
                    } = t;
                if (f > 0) {
                    if (128 & f) return void j(c, p, n, r, o, i, a, s, l);
                    if (256 & f) return void R(c, p, n, r, o, i, a, s, l)
                }
                8 & h ? (16 & u && K(c, o, i), p !== c && d(n, p)) : 16 & u ? 16 & h ? j(c, p, n, r, o, i, a, s, l) : K(c, o, i, !0) : (8 & u && d(n, ""), 16 & h && T(p, n, r, o, i, a, s, l))
            }, R = (e, t, n, r, o, i, a, s, l) => {
                e = e || m, t = t || m;
                const c = e.length,
                    d = t.length,
                    u = Math.min(c, d);
                let p;
                for (p = 0; p < u; p++) {
                    const r = t[p] = l ? Yo(t[p]) : Ko(t[p]);
                    g(e[p], r, n, null, o, i, a, s, l)
                }
                c > d ? K(e, o, i, !0, !1, u) : T(t, n, r, o, i, a, s, l, u)
            }, j = (e, t, n, r, o, i, a, s, l) => {
                let c = 0;
                const d = t.length;
                let u = e.length - 1,
                    p = d - 1;
                while (c <= u && c <= p) {
                    const r = e[c],
                        d = t[c] = l ? Yo(t[c]) : Ko(t[c]);
                    if (!Fo(r, d)) break;
                    g(r, d, n, null, o, i, a, s, l), c++
                }
                while (c <= u && c <= p) {
                    const r = e[u],
                        c = t[p] = l ? Yo(t[p]) : Ko(t[p]);
                    if (!Fo(r, c)) break;
                    g(r, c, n, null, o, i, a, s, l), u--, p--
                }
                if (c > u) {
                    if (c <= p) {
                        const e = p + 1,
                            u = e < d ? t[e].el : r;
                        while (c <= p) g(null, t[c] = l ? Yo(t[c]) : Ko(t[c]), n, u, o, i, a, s, l), c++
                    }
                } else if (c > p)
                    while (c <= u) z(e[c], o, i, !0), c++;
                else {
                    const f = c,
                        h = c,
                        v = new Map;
                    for (c = h; c <= p; c++) {
                        const e = t[c] = l ? Yo(t[c]) : Ko(t[c]);
                        null != e.key && v.set(e.key, c)
                    }
                    let y, b = 0;
                    const w = p - h + 1;
                    let _ = !1,
                        A = 0;
                    const x = new Array(w);
                    for (c = 0; c < w; c++) x[c] = 0;
                    for (c = f; c <= u; c++) {
                        const r = e[c];
                        if (b >= w) {
                            z(r, o, i, !0);
                            continue
                        }
                        let d;
                        if (null != r.key) d = v.get(r.key);
                        else
                            for (y = h; y <= p; y++)
                                if (0 === x[y - h] && Fo(r, t[y])) {
                                    d = y;
                                    break
                                } void 0 === d ? z(r, o, i, !0) : (x[d - h] = c + 1, d >= A ? A = d : _ = !0, g(r, t[d], n, null, o, i, a, s, l), b++)
                    }
                    const C = _ ? bo(x) : m;
                    for (y = C.length - 1, c = w - 1; c >= 0; c--) {
                        const e = h + c,
                            u = t[e],
                            p = e + 1 < d ? t[e + 1].el : r;
                        0 === x[c] ? g(null, u, n, p, o, i, a, s, l) : _ && (y < 0 || c !== C[y] ? H(u, n, p, 2) : y--)
                    }
                }
            }, H = (e, t, n, o, i = null) => {
                const {
                    el: a,
                    type: s,
                    transition: l,
                    children: c,
                    shapeFlag: d
                } = e;
                if (6 & d) return void H(e.component.subTree, t, n, o);
                if (128 & d) return void e.suspense.move(t, n, o);
                if (64 & d) return void s.move(e, t, n, X);
                if (s === _o) {
                    r(a, t, n);
                    for (let e = 0; e < c.length; e++) H(c[e], t, n, o);
                    return void r(e.anchor, t, n)
                }
                if (s === Co) return void A(e, t, n);
                const u = 2 !== o && 1 & d && l;
                if (u)
                    if (0 === o) l.beforeEnter(a), r(a, t, n), ho((() => l.enter(a)), i);
                    else {
                        const {
                            leave: e,
                            delayLeave: o,
                            afterLeave: i
                        } = l, s = () => r(a, t, n), c = () => {
                            e(a, (() => {
                                s(), i && i()
                            }))
                        };
                        o ? o(a, s, c) : c()
                    }
                else r(a, t, n)
            }, z = (e, t, n, r = !1, o = !1) => {
                const {
                    type: i,
                    props: a,
                    ref: s,
                    children: l,
                    dynamicChildren: c,
                    shapeFlag: d,
                    patchFlag: u,
                    dirs: p
                } = e;
                if (null != s && po(s, null, n, e, !0), 256 & d) return void t.ctx.deactivate(e);
                const f = 1 & d && p,
                    h = !Jn(e);
                let g;
                if (h && (g = a && a.onVnodeBeforeUnmount) && Qo(g, t, e), 6 & d) U(e.component, n, r);
                else {
                    if (128 & d) return void e.suspense.unmount(n, r);
                    f && _r(e, null, t, "beforeUnmount"), 64 & d ? e.type.remove(e, t, n, o, X, r) : c && (i !== _o || u > 0 && 64 & u) ? K(c, t, n, !1, !0) : (i === _o && 384 & u || !o && 16 & d) && K(l, t, n), r && $(e)
                }(h && (g = a && a.onVnodeUnmounted) || f) && ho((() => {
                    g && Qo(g, t, e), f && _r(e, null, t, "unmounted")
                }), n)
            }, $ = e => {
                const {
                    type: t,
                    el: n,
                    anchor: r,
                    transition: i
                } = e;
                if (t === _o) return void V(n, r);
                if (t === Co) return void x(e);
                const a = () => {
                    o(n), i && !i.persisted && i.afterLeave && i.afterLeave()
                };
                if (1 & e.shapeFlag && i && !i.persisted) {
                    const {
                        leave: t,
                        delayLeave: r
                    } = i, o = () => t(n, a);
                    r ? r(e.el, a, o) : o()
                } else a()
            }, V = (e, t) => {
                let n;
                while (e !== t) n = p(e), o(e), e = n;
                o(t)
            }, U = (e, t, n) => {
                const {
                    bum: r,
                    scope: o,
                    update: i,
                    subTree: a,
                    um: s
                } = e;
                r && Q(r), o.stop(), i && (i.active = !1, z(a, e, t, n)), s && ho(s, t), ho((() => {
                    e.isUnmounted = !0
                }), t), t && t.pendingBranch && !t.isUnmounted && e.asyncDep && !e.asyncResolved && e.suspenseId === t.pendingId && (t.deps--, 0 === t.deps && t.resolve())
            }, K = (e, t, n, r = !1, o = !1, i = 0) => {
                for (let a = i; a < e.length; a++) z(e[a], t, n, r, o)
            }, Y = e => 6 & e.shapeFlag ? Y(e.component.subTree) : 128 & e.shapeFlag ? e.suspense.next() : p(e.anchor || e.el), W = (e, t, n) => {
                null == e ? t._vnode && z(t._vnode, null, null, !0) : g(t._vnode || null, e, t, null, null, null, n), fn(), hn(), t._vnode = e
            }, X = {
                p: g,
                um: z,
                m: H,
                r: $,
                mt: B,
                mc: T,
                pc: N,
                pbc: O,
                n: Y,
                o: e
            };
            let q, Z;
            return t && ([q, Z] = t(X)), {
                render: W,
                hydrate: q,
                createApp: uo(W, q)
            }
        }

        function mo({
            effect: e,
            update: t
        }, n) {
            e.allowRecurse = t.allowRecurse = n
        }

        function yo(e, t, n = !1) {
            const r = e.children,
                o = t.children;
            if (T(r) && T(o))
                for (let i = 0; i < r.length; i++) {
                    const e = r[i];
                    let t = o[i];
                    1 & t.shapeFlag && !t.dynamicChildren && ((t.patchFlag <= 0 || 32 === t.patchFlag) && (t = o[i] = Yo(o[i]), t.el = e.el), n || yo(e, t)), t.type === Ao && (t.el = e.el)
                }
        }

        function bo(e) {
            const t = e.slice(),
                n = [0];
            let r, o, i, a, s;
            const l = e.length;
            for (r = 0; r < l; r++) {
                const l = e[r];
                if (0 !== l) {
                    if (o = n[n.length - 1], e[o] < l) {
                        t[r] = o, n.push(r);
                        continue
                    }
                    i = 0, a = n.length - 1;
                    while (i < a) s = i + a >> 1, e[n[s]] < l ? i = s + 1 : a = s;
                    l < e[n[i]] && (i > 0 && (t[r] = n[i - 1]), n[i] = r)
                }
            }
            i = n.length, a = n[i - 1];
            while (i-- > 0) n[i] = a, a = t[a];
            return n
        }
        const wo = e => e.__isTeleport;
        const _o = Symbol(void 0),
            Ao = Symbol(void 0),
            xo = Symbol(void 0),
            Co = Symbol(void 0),
            ko = [];
        let So = null;

        function To(e = !1) {
            ko.push(So = e ? null : [])
        }

        function Eo() {
            ko.pop(), So = ko[ko.length - 1] || null
        }
        let Oo = 1;

        function Mo(e) {
            Oo += e
        }

        function Io(e) {
            return e.dynamicChildren = Oo > 0 ? So || m : null, Eo(), Oo > 0 && So && So.push(e), e
        }

        function Po(e, t, n, r, o, i) {
            return Io(jo(e, t, n, r, o, i, !0))
        }

        function Bo(e, t, n, r, o) {
            return Io(Ho(e, t, n, r, o, !0))
        }

        function Lo(e) {
            return !!e && !0 === e.__v_isVNode
        }

        function Fo(e, t) {
            return e.type === t.type && e.key === t.key
        }
        const Do = "__vInternal",
            No = ({
                key: e
            }) => null != e ? e : null,
            Ro = ({
                ref: e,
                ref_key: t,
                ref_for: n
            }) => null != e ? P(e) || Lt(e) || I(e) ? {
                i: _n,
                r: e,
                k: t,
                f: !!n
            } : e : null;

        function jo(e, t = null, n = null, r = 0, o = null, i = (e === _o ? 0 : 1), a = !1, s = !1) {
            const l = {
                __v_isVNode: !0,
                __v_skip: !0,
                type: e,
                props: t,
                key: t && No(t),
                ref: t && Ro(t),
                scopeId: An,
                slotScopeIds: null,
                children: n,
                component: null,
                suspense: null,
                ssContent: null,
                ssFallback: null,
                dirs: null,
                transition: null,
                el: null,
                anchor: null,
                target: null,
                targetAnchor: null,
                staticCount: 0,
                shapeFlag: i,
                patchFlag: r,
                dynamicProps: o,
                dynamicChildren: null,
                appContext: null,
                ctx: _n
            };
            return s ? (Wo(l, n), 128 & i && e.normalize(l)) : n && (l.shapeFlag |= P(n) ? 8 : 16), Oo > 0 && !a && So && (l.patchFlag > 0 || 6 & i) && 32 !== l.patchFlag && So.push(l), l
        }
        const Ho = Go;

        function Go(e, n = null, r = null, o = 0, i = null, a = !1) {
            if (e && e !== Cr || (e = xo), Lo(e)) {
                const t = $o(e, n, !0);
                return r && Wo(t, r), Oo > 0 && !a && So && (6 & t.shapeFlag ? So[So.indexOf(e)] = t : So.push(t)), t.patchFlag |= -2, t
            }
            if (vi(e) && (e = e.__vccOpts), n) {
                n = zo(n);
                let {
                    class: e,
                    style: r
                } = n;
                e && !P(e) && (n.class = s(e)), L(r) && (Tt(r) && !T(r) && (r = x({}, r)), n.style = t(r))
            }
            const l = P(e) ? 1 : Bn(e) ? 128 : wo(e) ? 64 : L(e) ? 4 : I(e) ? 2 : 0;
            return jo(e, n, r, o, i, l, a, !0)
        }

        function zo(e) {
            return e ? Tt(e) || Do in e ? x({}, e) : e : null
        }

        function $o(e, t, n = !1) {
            const {
                props: r,
                ref: o,
                patchFlag: i,
                children: a
            } = e, s = t ? Xo(r || {}, t) : r, l = {
                __v_isVNode: !0,
                __v_skip: !0,
                type: e.type,
                props: s,
                key: s && No(s),
                ref: t && t.ref ? n && o ? T(o) ? o.concat(Ro(t)) : [o, Ro(t)] : Ro(t) : o,
                scopeId: e.scopeId,
                slotScopeIds: e.slotScopeIds,
                children: a,
                target: e.target,
                targetAnchor: e.targetAnchor,
                staticCount: e.staticCount,
                shapeFlag: e.shapeFlag,
                patchFlag: t && e.type !== _o ? -1 === i ? 16 : 16 | i : i,
                dynamicProps: e.dynamicProps,
                dynamicChildren: e.dynamicChildren,
                appContext: e.appContext,
                dirs: e.dirs,
                transition: e.transition,
                component: e.component,
                suspense: e.suspense,
                ssContent: e.ssContent && $o(e.ssContent),
                ssFallback: e.ssFallback && $o(e.ssFallback),
                el: e.el,
                anchor: e.anchor,
                ctx: e.ctx
            };
            return l
        }

        function Vo(e = " ", t = 0) {
            return Ho(Ao, null, e, t)
        }

        function Uo(e = "", t = !1) {
            return t ? (To(), Bo(xo, null, e)) : Ho(xo, null, e)
        }

        function Ko(e) {
            return null == e || "boolean" === typeof e ? Ho(xo) : T(e) ? Ho(_o, null, e.slice()) : "object" === typeof e ? Yo(e) : Ho(Ao, null, String(e))
        }

        function Yo(e) {
            return null === e.el && -1 !== e.patchFlag || e.memo ? e : $o(e)
        }

        function Wo(e, t) {
            let n = 0;
            const {
                shapeFlag: r
            } = e;
            if (null == t) t = null;
            else if (T(t)) n = 16;
            else if ("object" === typeof t) {
                if (65 & r) {
                    const n = t.default;
                    return void(n && (n._c && (n._d = !1), Wo(e, n()), n._c && (n._d = !0)))
                } {
                    n = 32;
                    const r = t._;
                    r || Do in t ? 3 === r && _n && (1 === _n.slots._ ? t._ = 1 : (t._ = 2, e.patchFlag |= 1024)) : t._ctx = _n
                }
            } else I(t) ? (t = {
                default: t,
                _ctx: _n
            }, n = 32) : (t = String(t), 64 & r ? (n = 16, t = [Vo(t)]) : n = 8);
            e.children = t, e.shapeFlag |= n
        }

        function Xo(...e) {
            const n = {};
            for (let r = 0; r < e.length; r++) {
                const o = e[r];
                for (const e in o)
                    if ("class" === e) n.class !== o.class && (n.class = s([n.class, o.class]));
                    else if ("style" === e) n.style = t([n.style, o.style]);
                else if (_(e)) {
                    const t = n[e],
                        r = o[e];
                    !r || t === r || T(t) && t.includes(r) || (n[e] = t ? [].concat(t, r) : r)
                } else "" !== e && (n[e] = o[e])
            }
            return n
        }

        function Qo(e, t, n, r = null) {
            Wt(e, t, 7, [n, r])
        }
        const qo = lo();
        let Zo = 0;

        function Jo(e, t, n) {
            const r = e.type,
                o = (t ? t.appContext : e.appContext) || qo,
                i = {
                    uid: Zo++,
                    vnode: e,
                    type: r,
                    parent: t,
                    appContext: o,
                    root: null,
                    next: null,
                    subTree: null,
                    effect: null,
                    update: null,
                    scope: new ne(!0),
                    render: null,
                    proxy: null,
                    exposed: null,
                    exposeProxy: null,
                    withProxy: null,
                    provides: t ? t.provides : Object.create(o.provides),
                    accessCache: null,
                    renderCache: [],
                    components: null,
                    directives: null,
                    propsOptions: Qr(r, o),
                    emitsOptions: bn(r, o),
                    emit: null,
                    emitted: null,
                    propsDefaults: v,
                    inheritAttrs: r.inheritAttrs,
                    ctx: v,
                    data: v,
                    props: v,
                    attrs: v,
                    slots: v,
                    refs: v,
                    setupState: v,
                    setupContext: null,
                    suspense: n,
                    suspenseId: n ? n.pendingId : 0,
                    asyncDep: null,
                    asyncResolved: !1,
                    isMounted: !1,
                    isUnmounted: !1,
                    isDeactivated: !1,
                    bc: null,
                    c: null,
                    bm: null,
                    m: null,
                    bu: null,
                    u: null,
                    um: null,
                    bum: null,
                    da: null,
                    a: null,
                    rtg: null,
                    rtc: null,
                    ec: null,
                    sp: null
                };
            return i.ctx = {
                _: i
            }, i.root = t ? t.root : i, i.emit = yn.bind(null, i), e.ce && e.ce(i), i
        }
        let ei = null;
        const ti = () => ei || _n,
            ni = e => {
                ei = e, e.scope.on()
            },
            ri = () => {
                ei && ei.scope.off(), ei = null
            };

        function oi(e) {
            return 4 & e.vnode.shapeFlag
        }
        let ii, ai, si = !1;

        function li(e, t = !1) {
            si = t;
            const {
                props: n,
                children: r
            } = e.vnode, o = oi(e);
            Kr(e, n, o, t), ao(e, r);
            const i = o ? ci(e, t) : void 0;
            return si = !1, i
        }

        function ci(e, t) {
            const n = e.type;
            e.accessCache = Object.create(null), e.proxy = Ot(new Proxy(e.ctx, Ir));
            const {
                setup: r
            } = n;
            if (r) {
                const n = e.setupContext = r.length > 1 ? fi(e) : null;
                ni(e), xe();
                const o = Yt(r, e, 0, [e.props, n]);
                if (Ce(), ri(), F(o)) {
                    if (o.then(ri, ri), t) return o.then((n => {
                        di(e, n, t)
                    })).catch((t => {
                        Xt(t, e, 0)
                    }));
                    e.asyncDep = o
                } else di(e, o, t)
            } else ui(e, t)
        }

        function di(e, t, n) {
            I(t) ? e.type.__ssrInlineRender ? e.ssrRender = t : e.render = t : L(t) && (e.setupState = Ht(t)), ui(e, n)
        }

        function ui(e, t, n) {
            const r = e.type;
            if (!e.render) {
                if (!t && ii && !r.render) {
                    const t = r.template || Nr(e).template;
                    if (t) {
                        0;
                        const {
                            isCustomElement: n,
                            compilerOptions: o
                        } = e.appContext.config, {
                            delimiters: i,
                            compilerOptions: a
                        } = r, s = x(x({
                            isCustomElement: n,
                            delimiters: i
                        }, o), a);
                        r.render = ii(t, s)
                    }
                }
                e.render = r.render || y, ai && ai(e)
            }
            ni(e), xe(), Br(e), Ce(), ri()
        }

        function pi(e) {
            return new Proxy(e.attrs, {
                get(t, n) {
                    return ke(e, "get", "$attrs"), t[n]
                }
            })
        }

        function fi(e) {
            const t = t => {
                e.exposed = t || {}
            };
            let n;
            return {
                get attrs() {
                    return n || (n = pi(e))
                },
                slots: e.slots,
                emit: e.emit,
                expose: t
            }
        }

        function hi(e) {
            if (e.exposed) return e.exposeProxy || (e.exposeProxy = new Proxy(Ht(Ot(e.exposed)), {
                get(t, n) {
                    return n in t ? t[n] : n in Or ? Or[n](e) : void 0
                },
                has(e, t) {
                    return t in e || t in Or
                }
            }))
        }

        function gi(e, t = !0) {
            return I(e) ? e.displayName || e.name : e.name || t && e.__name
        }

        function vi(e) {
            return I(e) && "__vccOpts" in e
        }
        const mi = (e, t) => Kt(e, t, si);

        function yi(e, t, n) {
            const r = arguments.length;
            return 2 === r ? L(t) && !T(t) ? Lo(t) ? Ho(e, null, [t]) : Ho(e, t) : Ho(e, null, t) : (r > 3 ? n = Array.prototype.slice.call(arguments, 2) : 3 === r && Lo(n) && (n = [n]), Ho(e, t, n))
        }
        const bi = Symbol(""),
            wi = () => {
                {
                    const e = Dn(bi);
                    return e
                }
            };
        const _i = "3.2.45",
            Ai = "http://www.w3.org/2000/svg",
            xi = "undefined" !== typeof document ? document : null,
            Ci = xi && xi.createElement("template"),
            ki = {
                insert: (e, t, n) => {
                    t.insertBefore(e, n || null)
                },
                remove: e => {
                    const t = e.parentNode;
                    t && t.removeChild(e)
                },
                createElement: (e, t, n, r) => {
                    const o = t ? xi.createElementNS(Ai, e) : xi.createElement(e, n ? {
                        is: n
                    } : void 0);
                    return "select" === e && r && null != r.multiple && o.setAttribute("multiple", r.multiple), o
                },
                createText: e => xi.createTextNode(e),
                createComment: e => xi.createComment(e),
                setText: (e, t) => {
                    e.nodeValue = t
                },
                setElementText: (e, t) => {
                    e.textContent = t
                },
                parentNode: e => e.parentNode,
                nextSibling: e => e.nextSibling,
                querySelector: e => xi.querySelector(e),
                setScopeId(e, t) {
                    e.setAttribute(t, "")
                },
                insertStaticContent(e, t, n, r, o, i) {
                    const a = n ? n.previousSibling : t.lastChild;
                    if (o && (o === i || o.nextSibling)) {
                        while (1)
                            if (t.insertBefore(o.cloneNode(!0), n), o === i || !(o = o.nextSibling)) break
                    } else {
                        Ci.innerHTML = r ? `<svg>${e}</svg>` : e;
                        const o = Ci.content;
                        if (r) {
                            const e = o.firstChild;
                            while (e.firstChild) o.appendChild(e.firstChild);
                            o.removeChild(e)
                        }
                        t.insertBefore(o, n)
                    }
                    return [a ? a.nextSibling : t.firstChild, n ? n.previousSibling : t.lastChild]
                }
            };

        function Si(e, t, n) {
            const r = e._vtc;
            r && (t = (t ? [t, ...r] : [...r]).join(" ")), null == t ? e.removeAttribute("class") : n ? e.setAttribute("class", t) : e.className = t
        }

        function Ti(e, t, n) {
            const r = e.style,
                o = P(n);
            if (n && !o) {
                for (const e in n) Oi(r, e, n[e]);
                if (t && !P(t))
                    for (const e in t) null == n[e] && Oi(r, e, "")
            } else {
                const i = r.display;
                o ? t !== n && (r.cssText = n) : t && e.removeAttribute("style"), "_vod" in e && (r.display = i)
            }
        }
        const Ei = /\s*!important$/;

        function Oi(e, t, n) {
            if (T(n)) n.forEach((n => Oi(e, t, n)));
            else if (null == n && (n = ""), t.startsWith("--")) e.setProperty(t, n);
            else {
                const r = Pi(e, t);
                Ei.test(n) ? e.setProperty(K(r), n.replace(Ei, ""), "important") : e[r] = n
            }
        }
        const Mi = ["Webkit", "Moz", "ms"],
            Ii = {};

        function Pi(e, t) {
            const n = Ii[t];
            if (n) return n;
            let r = V(t);
            if ("filter" !== r && r in e) return Ii[t] = r;
            r = Y(r);
            for (let o = 0; o < Mi.length; o++) {
                const n = Mi[o] + r;
                if (n in e) return Ii[t] = n
            }
            return t
        }
        const Bi = "http://www.w3.org/1999/xlink";

        function Li(e, t, n, r, o) {
            if (r && t.startsWith("xlink:")) null == n ? e.removeAttributeNS(Bi, t.slice(6, t.length)) : e.setAttributeNS(Bi, t, n);
            else {
                const r = c(t);
                null == n || r && !d(n) ? e.removeAttribute(t) : e.setAttribute(t, r ? "" : n)
            }
        }

        function Fi(e, t, n, r, o, i, a) {
            if ("innerHTML" === t || "textContent" === t) return r && a(r, o, i), void(e[t] = null == n ? "" : n);
            if ("value" === t && "PROGRESS" !== e.tagName && !e.tagName.includes("-")) {
                e._value = n;
                const r = null == n ? "" : n;
                return e.value === r && "OPTION" !== e.tagName || (e.value = r), void(null == n && e.removeAttribute(t))
            }
            let s = !1;
            if ("" === n || null == n) {
                const r = typeof e[t];
                "boolean" === r ? n = d(n) : null == n && "string" === r ? (n = "", s = !0) : "number" === r && (n = 0, s = !0)
            }
            try {
                e[t] = n
            } catch (l) {
                0
            }
            s && e.removeAttribute(t)
        }

        function Di(e, t, n, r) {
            e.addEventListener(t, n, r)
        }

        function Ni(e, t, n, r) {
            e.removeEventListener(t, n, r)
        }

        function Ri(e, t, n, r, o = null) {
            const i = e._vei || (e._vei = {}),
                a = i[t];
            if (r && a) a.value = r;
            else {
                const [n, s] = Hi(t);
                if (r) {
                    const a = i[t] = Vi(r, o);
                    Di(e, n, a, s)
                } else a && (Ni(e, n, a, s), i[t] = void 0)
            }
        }
        const ji = /(?:Once|Passive|Capture)$/;

        function Hi(e) {
            let t;
            if (ji.test(e)) {
                let n;
                t = {};
                while (n = e.match(ji)) e = e.slice(0, e.length - n[0].length), t[n[0].toLowerCase()] = !0
            }
            const n = ":" === e[2] ? e.slice(3) : K(e.slice(2));
            return [n, t]
        }
        let Gi = 0;
        const zi = Promise.resolve(),
            $i = () => Gi || (zi.then((() => Gi = 0)), Gi = Date.now());

        function Vi(e, t) {
            const n = e => {
                if (e._vts) {
                    if (e._vts <= n.attached) return
                } else e._vts = Date.now();
                Wt(Ui(e, n.value), t, 5, [e])
            };
            return n.value = e, n.attached = $i(), n
        }

        function Ui(e, t) {
            if (T(t)) {
                const n = e.stopImmediatePropagation;
                return e.stopImmediatePropagation = () => {
                    n.call(e), e._stopped = !0
                }, t.map((e => t => !t._stopped && e && e(t)))
            }
            return t
        }
        const Ki = /^on[a-z]/,
            Yi = (e, t, n, r, o = !1, i, a, s, l) => {
                "class" === t ? Si(e, r, o) : "style" === t ? Ti(e, n, r) : _(t) ? A(t) || Ri(e, t, n, r, a) : ("." === t[0] ? (t = t.slice(1), 1) : "^" === t[0] ? (t = t.slice(1), 0) : Wi(e, t, r, o)) ? Fi(e, t, r, i, a, s, l) : ("true-value" === t ? e._trueValue = r : "false-value" === t && (e._falseValue = r), Li(e, t, r, o))
            };

        function Wi(e, t, n, r) {
            return r ? "innerHTML" === t || "textContent" === t || !!(t in e && Ki.test(t) && I(n)) : "spellcheck" !== t && "draggable" !== t && "translate" !== t && ("form" !== t && (("list" !== t || "INPUT" !== e.tagName) && (("type" !== t || "TEXTAREA" !== e.tagName) && ((!Ki.test(t) || !P(n)) && t in e))))
        }
        "undefined" !== typeof HTMLElement && HTMLElement;
        const Xi = "transition",
            Qi = "animation",
            qi = (e, {
                slots: t
            }) => yi(Kn, ta(e), t);
        qi.displayName = "Transition";
        const Zi = {
                name: String,
                type: String,
                css: {
                    type: Boolean,
                    default: !0
                },
                duration: [String, Number, Object],
                enterFromClass: String,
                enterActiveClass: String,
                enterToClass: String,
                appearFromClass: String,
                appearActiveClass: String,
                appearToClass: String,
                leaveFromClass: String,
                leaveActiveClass: String,
                leaveToClass: String
            },
            Ji = (qi.props = x({}, Kn.props, Zi), (e, t = []) => {
                T(e) ? e.forEach((e => e(...t))) : e && e(...t)
            }),
            ea = e => !!e && (T(e) ? e.some((e => e.length > 1)) : e.length > 1);

        function ta(e) {
            const t = {};
            for (const x in e) x in Zi || (t[x] = e[x]);
            if (!1 === e.css) return t;
            const {
                name: n = "v",
                type: r,
                duration: o,
                enterFromClass: i = `${n}-enter-from`,
                enterActiveClass: a = `${n}-enter-active`,
                enterToClass: s = `${n}-enter-to`,
                appearFromClass: l = i,
                appearActiveClass: c = a,
                appearToClass: d = s,
                leaveFromClass: u = `${n}-leave-from`,
                leaveActiveClass: p = `${n}-leave-active`,
                leaveToClass: f = `${n}-leave-to`
            } = e, h = na(o), g = h && h[0], v = h && h[1], {
                onBeforeEnter: m,
                onEnter: y,
                onEnterCancelled: b,
                onLeave: w,
                onLeaveCancelled: _,
                onBeforeAppear: A = m,
                onAppear: C = y,
                onAppearCancelled: k = b
            } = t, S = (e, t, n) => {
                ia(e, t ? d : s), ia(e, t ? c : a), n && n()
            }, T = (e, t) => {
                e._isLeaving = !1, ia(e, u), ia(e, f), ia(e, p), t && t()
            }, E = e => (t, n) => {
                const o = e ? C : y,
                    a = () => S(t, e, n);
                Ji(o, [t, a]), aa((() => {
                    ia(t, e ? l : i), oa(t, e ? d : s), ea(o) || la(t, r, g, a)
                }))
            };
            return x(t, {
                onBeforeEnter(e) {
                    Ji(m, [e]), oa(e, i), oa(e, a)
                },
                onBeforeAppear(e) {
                    Ji(A, [e]), oa(e, l), oa(e, c)
                },
                onEnter: E(!1),
                onAppear: E(!0),
                onLeave(e, t) {
                    e._isLeaving = !0;
                    const n = () => T(e, t);
                    oa(e, u), pa(), oa(e, p), aa((() => {
                        e._isLeaving && (ia(e, u), oa(e, f), ea(w) || la(e, r, v, n))
                    })), Ji(w, [e, n])
                },
                onEnterCancelled(e) {
                    S(e, !1), Ji(b, [e])
                },
                onAppearCancelled(e) {
                    S(e, !0), Ji(k, [e])
                },
                onLeaveCancelled(e) {
                    T(e), Ji(_, [e])
                }
            })
        }

        function na(e) {
            if (null == e) return null;
            if (L(e)) return [ra(e.enter), ra(e.leave)]; {
                const t = ra(e);
                return [t, t]
            }
        }

        function ra(e) {
            const t = Z(e);
            return t
        }

        function oa(e, t) {
            t.split(/\s+/).forEach((t => t && e.classList.add(t))), (e._vtc || (e._vtc = new Set)).add(t)
        }

        function ia(e, t) {
            t.split(/\s+/).forEach((t => t && e.classList.remove(t)));
            const {
                _vtc: n
            } = e;
            n && (n.delete(t), n.size || (e._vtc = void 0))
        }

        function aa(e) {
            requestAnimationFrame((() => {
                requestAnimationFrame(e)
            }))
        }
        let sa = 0;

        function la(e, t, n, r) {
            const o = e._endId = ++sa,
                i = () => {
                    o === e._endId && r()
                };
            if (n) return setTimeout(i, n);
            const {
                type: a,
                timeout: s,
                propCount: l
            } = ca(e, t);
            if (!a) return r();
            const c = a + "end";
            let d = 0;
            const u = () => {
                    e.removeEventListener(c, p), i()
                },
                p = t => {
                    t.target === e && ++d >= l && u()
                };
            setTimeout((() => {
                d < l && u()
            }), s + 1), e.addEventListener(c, p)
        }

        function ca(e, t) {
            const n = window.getComputedStyle(e),
                r = e => (n[e] || "").split(", "),
                o = r(`${Xi}Delay`),
                i = r(`${Xi}Duration`),
                a = da(o, i),
                s = r(`${Qi}Delay`),
                l = r(`${Qi}Duration`),
                c = da(s, l);
            let d = null,
                u = 0,
                p = 0;
            t === Xi ? a > 0 && (d = Xi, u = a, p = i.length) : t === Qi ? c > 0 && (d = Qi, u = c, p = l.length) : (u = Math.max(a, c), d = u > 0 ? a > c ? Xi : Qi : null, p = d ? d === Xi ? i.length : l.length : 0);
            const f = d === Xi && /\b(transform|all)(,|$)/.test(r(`${Xi}Property`).toString());
            return {
                type: d,
                timeout: u,
                propCount: p,
                hasTransform: f
            }
        }

        function da(e, t) {
            while (e.length < t.length) e = e.concat(e);
            return Math.max(...t.map(((t, n) => ua(t) + ua(e[n]))))
        }

        function ua(e) {
            return 1e3 * Number(e.slice(0, -1).replace(",", "."))
        }

        function pa() {
            return document.body.offsetHeight
        }
        new WeakMap, new WeakMap;
        const fa = e => {
            const t = e.props["onUpdate:modelValue"] || !1;
            return T(t) ? e => Q(t, e) : t
        };
        const ha = {
            deep: !0,
            created(e, t, n) {
                e._assign = fa(n), Di(e, "change", (() => {
                    const t = e._modelValue,
                        n = va(e),
                        r = e.checked,
                        o = e._assign;
                    if (T(t)) {
                        const e = f(t, n),
                            i = -1 !== e;
                        if (r && !i) o(t.concat(n));
                        else if (!r && i) {
                            const n = [...t];
                            n.splice(e, 1), o(n)
                        }
                    } else if (O(t)) {
                        const e = new Set(t);
                        r ? e.add(n) : e.delete(n), o(e)
                    } else o(ma(e, r))
                }))
            },
            mounted: ga,
            beforeUpdate(e, t, n) {
                e._assign = fa(n), ga(e, t, n)
            }
        };

        function ga(e, {
            value: t,
            oldValue: n
        }, r) {
            e._modelValue = t, T(t) ? e.checked = f(t, r.props.value) > -1 : O(t) ? e.checked = t.has(r.props.value) : t !== n && (e.checked = p(t, ma(e, !0)))
        }

        function va(e) {
            return "_value" in e ? e._value : e.value
        }

        function ma(e, t) {
            const n = t ? "_trueValue" : "_falseValue";
            return n in e ? e[n] : t
        }
        const ya = ["ctrl", "shift", "alt", "meta"],
            ba = {
                stop: e => e.stopPropagation(),
                prevent: e => e.preventDefault(),
                self: e => e.target !== e.currentTarget,
                ctrl: e => !e.ctrlKey,
                shift: e => !e.shiftKey,
                alt: e => !e.altKey,
                meta: e => !e.metaKey,
                left: e => "button" in e && 0 !== e.button,
                middle: e => "button" in e && 1 !== e.button,
                right: e => "button" in e && 2 !== e.button,
                exact: (e, t) => ya.some((n => e[`${n}Key`] && !t.includes(n)))
            },
            wa = (e, t) => (n, ...r) => {
                for (let e = 0; e < t.length; e++) {
                    const r = ba[t[e]];
                    if (r && r(n, t)) return
                }
                return e(n, ...r)
            };
        const _a = x({
            patchProp: Yi
        }, ki);
        let Aa;

        function xa() {
            return Aa || (Aa = go(_a))
        }
        const Ca = (...e) => {
            const t = xa().createApp(...e);
            const {
                mount: n
            } = t;
            return t.mount = e => {
                const r = ka(e);
                if (!r) return;
                const o = t._component;
                I(o) || o.render || o.template || (o.template = r.innerHTML), r.innerHTML = "";
                const i = n(r, !1, r instanceof SVGElement);
                return r instanceof Element && (r.removeAttribute("v-cloak"), r.setAttribute("data-v-app", "")), i
            }, t
        };

        function ka(e) {
            if (P(e)) {
                const t = document.querySelector(e);
                return t
            }
            return e
        }
        var Sa = !1;

        function Ta(e, t, n) {
            return Array.isArray(e) ? (e.length = Math.max(e.length, t), e.splice(t, 1, n), n) : (e[t] = n, n)
        }

        function Ea() {
            return Oa().__VUE_DEVTOOLS_GLOBAL_HOOK__
        }

        function Oa() {
            return "undefined" !== typeof navigator && "undefined" !== typeof window ? window : "undefined" !== typeof n.g ? n.g : {}
        }
        const Ma = "function" === typeof Proxy,
            Ia = "devtools-plugin:setup",
            Pa = "plugin:settings:set";
        let Ba, La, Fa;

        function Da() {
            var e;
            return void 0 !== Ba || ("undefined" !== typeof window && window.performance ? (Ba = !0, La = window.performance) : "undefined" !== typeof n.g && (null === (e = n.g.perf_hooks) || void 0 === e ? void 0 : e.performance) ? (Ba = !0, La = n.g.perf_hooks.performance) : Ba = !1), Ba
        }

        function Na() {
            return Da() ? La.now() : Date.now()
        }
        class Ra {
            constructor(e, t) {
                this.target = null, this.targetQueue = [], this.onQueue = [], this.plugin = e, this.hook = t;
                const n = {};
                if (e.settings)
                    for (const a in e.settings) {
                        const t = e.settings[a];
                        n[a] = t.defaultValue
                    }
                const r = `__vue-devtools-plugin-settings__${e.id}`;
                let o = Object.assign({}, n);
                try {
                    const e = localStorage.getItem(r),
                        t = JSON.parse(e);
                    Object.assign(o, t)
                } catch (i) {}
                this.fallbacks = {
                    getSettings() {
                        return o
                    },
                    setSettings(e) {
                        try {
                            localStorage.setItem(r, JSON.stringify(e))
                        } catch (i) {}
                        o = e
                    },
                    now() {
                        return Na()
                    }
                }, t && t.on(Pa, ((e, t) => {
                    e === this.plugin.id && this.fallbacks.setSettings(t)
                })), this.proxiedOn = new Proxy({}, {
                    get: (e, t) => this.target ? this.target.on[t] : (...e) => {
                        this.onQueue.push({
                            method: t,
                            args: e
                        })
                    }
                }), this.proxiedTarget = new Proxy({}, {
                    get: (e, t) => this.target ? this.target[t] : "on" === t ? this.proxiedOn : Object.keys(this.fallbacks).includes(t) ? (...e) => (this.targetQueue.push({
                        method: t,
                        args: e,
                        resolve: () => {}
                    }), this.fallbacks[t](...e)) : (...e) => new Promise((n => {
                        this.targetQueue.push({
                            method: t,
                            args: e,
                            resolve: n
                        })
                    }))
                })
            }
            async setRealTarget(e) {
                this.target = e;
                for (const t of this.onQueue) this.target.on[t.method](...t.args);
                for (const t of this.targetQueue) t.resolve(await this.target[t.method](...t.args))
            }
        }

        function ja(e, t) {
            const n = e,
                r = Oa(),
                o = Ea(),
                i = Ma && n.enableEarlyProxy;
            if (!o || !r.__VUE_DEVTOOLS_PLUGIN_API_AVAILABLE__ && i) {
                const e = i ? new Ra(n, o) : null,
                    a = r.__VUE_DEVTOOLS_PLUGINS__ = r.__VUE_DEVTOOLS_PLUGINS__ || [];
                a.push({
                    pluginDescriptor: n,
                    setupFn: t,
                    proxy: e
                }), e && t(e.proxiedTarget)
            } else o.emit(Ia, e, t)
        }
        const Ha = e => Fa = e,
            Ga = Symbol();

        function za(e) {
            return e && "object" === typeof e && "[object Object]" === Object.prototype.toString.call(e) && "function" !== typeof e.toJSON
        }
        var $a;
        (function(e) {
            e["direct"] = "direct", e["patchObject"] = "patch object", e["patchFunction"] = "patch function"
        })($a || ($a = {}));
        const Va = "undefined" !== typeof window,
            Ua = !1,
            Ka = (() => "object" === typeof window && window.window === window ? window : "object" === typeof self && self.self === self ? self : "object" === typeof global && global.global === global ? global : "object" === typeof globalThis ? globalThis : {
                HTMLElement: null
            })();

        function Ya(e, {
            autoBom: t = !1
        } = {}) {
            return t && /^\s*(?:text\/\S*|application\/xml|\S*\/\S*\+xml)\s*;.*charset\s*=\s*utf-8/i.test(e.type) ? new Blob([String.fromCharCode(65279), e], {
                type: e.type
            }) : e
        }

        function Wa(e, t, n) {
            const r = new XMLHttpRequest;
            r.open("GET", e), r.responseType = "blob", r.onload = function() {
                Ja(r.response, t, n)
            }, r.onerror = function() {
                console.error("could not download file")
            }, r.send()
        }

        function Xa(e) {
            const t = new XMLHttpRequest;
            t.open("HEAD", e, !1);
            try {
                t.send()
            } catch (n) {}
            return t.status >= 200 && t.status <= 299
        }

        function Qa(e) {
            try {
                e.dispatchEvent(new MouseEvent("click"))
            } catch (t) {
                const n = document.createEvent("MouseEvents");
                n.initMouseEvent("click", !0, !0, window, 0, 0, 0, 80, 20, !1, !1, !1, !1, 0, null), e.dispatchEvent(n)
            }
        }
        const qa = "object" === typeof navigator ? navigator : {
                userAgent: ""
            },
            Za = (() => /Macintosh/.test(qa.userAgent) && /AppleWebKit/.test(qa.userAgent) && !/Safari/.test(qa.userAgent))(),
            Ja = Va ? "undefined" !== typeof HTMLAnchorElement && "download" in HTMLAnchorElement.prototype && !Za ? es : "msSaveOrOpenBlob" in qa ? ts : ns : () => {};

        function es(e, t = "download", n) {
            const r = document.createElement("a");
            r.download = t, r.rel = "noopener", "string" === typeof e ? (r.href = e, r.origin !== location.origin ? Xa(r.href) ? Wa(e, t, n) : (r.target = "_blank", Qa(r)) : Qa(r)) : (r.href = URL.createObjectURL(e), setTimeout((function() {
                URL.revokeObjectURL(r.href)
            }), 4e4), setTimeout((function() {
                Qa(r)
            }), 0))
        }

        function ts(e, t = "download", n) {
            if ("string" === typeof e)
                if (Xa(e)) Wa(e, t, n);
                else {
                    const t = document.createElement("a");
                    t.href = e, t.target = "_blank", setTimeout((function() {
                        Qa(t)
                    }))
                }
            else navigator.msSaveOrOpenBlob(Ya(e, n), t)
        }

        function ns(e, t, n, r) {
            if (r = r || open("", "_blank"), r && (r.document.title = r.document.body.innerText = "downloading..."), "string" === typeof e) return Wa(e, t, n);
            const o = "application/octet-stream" === e.type,
                i = /constructor/i.test(String(Ka.HTMLElement)) || "safari" in Ka,
                a = /CriOS\/[\d]+/.test(navigator.userAgent);
            if ((a || o && i || Za) && "undefined" !== typeof FileReader) {
                const t = new FileReader;
                t.onloadend = function() {
                    let e = t.result;
                    if ("string" !== typeof e) throw r = null, new Error("Wrong reader.result type");
                    e = a ? e : e.replace(/^data:[^;]*;/, "data:attachment/file;"), r ? r.location.href = e : location.assign(e), r = null
                }, t.readAsDataURL(e)
            } else {
                const t = URL.createObjectURL(e);
                r ? r.location.assign(t) : location.href = t, r = null, setTimeout((function() {
                    URL.revokeObjectURL(t)
                }), 4e4)
            }
        }

        function rs(e, t) {
            const n = "🍍 " + e;
            "function" === typeof __VUE_DEVTOOLS_TOAST__ ? __VUE_DEVTOOLS_TOAST__(n, t) : "error" === t ? console.error(n) : "warn" === t ? console.warn(n) : console.log(n)
        }

        function os(e) {
            return "_a" in e && "install" in e
        }

        function is() {
            if (!("clipboard" in navigator)) return rs("Your browser doesn't support the Clipboard API", "error"), !0
        }

        function as(e) {
            return !!(e instanceof Error && e.message.toLowerCase().includes("document is not focused")) && (rs('You need to activate the "Emulate a focused page" setting in the "Rendering" panel of devtools.', "warn"), !0)
        }
        async function ss(e) {
            if (!is()) try {
                await navigator.clipboard.writeText(JSON.stringify(e.state.value)), rs("Global state copied to clipboard.")
            } catch (t) {
                if (as(t)) return;
                rs("Failed to serialize the state. Check the console for more details.", "error"), console.error(t)
            }
        }
        async function ls(e) {
            if (!is()) try {
                e.state.value = JSON.parse(await navigator.clipboard.readText()), rs("Global state pasted from clipboard.")
            } catch (t) {
                if (as(t)) return;
                rs("Failed to deserialize the state from clipboard. Check the console for more details.", "error"), console.error(t)
            }
        }
        async function cs(e) {
            try {
                Ja(new Blob([JSON.stringify(e.state.value)], {
                    type: "text/plain;charset=utf-8"
                }), "pinia-state.json")
            } catch (t) {
                rs("Failed to export the state as JSON. Check the console for more details.", "error"), console.error(t)
            }
        }
        let ds;

        function us() {
            function e() {
                return new Promise(((e, t) => {
                    ds.onchange = async () => {
                        const t = ds.files;
                        if (!t) return e(null);
                        const n = t.item(0);
                        return e(n ? {
                            text: await n.text(),
                            file: n
                        } : null)
                    }, ds.oncancel = () => e(null), ds.onerror = t, ds.click()
                }))
            }
            return ds || (ds = document.createElement("input"), ds.type = "file", ds.accept = ".json"), e
        }
        async function ps(e) {
            try {
                const t = await us(),
                    n = await t();
                if (!n) return;
                const {
                    text: r,
                    file: o
                } = n;
                e.state.value = JSON.parse(r), rs(`Global state imported from "${o.name}".`)
            } catch (t) {
                rs("Failed to export the state as JSON. Check the console for more details.", "error"), console.error(t)
            }
        }

        function fs(e) {
            return {
                _custom: {
                    display: e
                }
            }
        }
        const hs = "🍍 Pinia (root)",
            gs = "_root";

        function vs(e) {
            return os(e) ? {
                id: gs,
                label: hs
            } : {
                id: e.$id,
                label: e.$id
            }
        }

        function ms(e) {
            if (os(e)) {
                const t = Array.from(e._s.keys()),
                    n = e._s,
                    r = {
                        state: t.map((t => ({
                            editable: !0,
                            key: t,
                            value: e.state.value[t]
                        }))),
                        getters: t.filter((e => n.get(e)._getters)).map((e => {
                            const t = n.get(e);
                            return {
                                editable: !1,
                                key: e,
                                value: t._getters.reduce(((e, n) => (e[n] = t[n], e)), {})
                            }
                        }))
                    };
                return r
            }
            const t = {
                state: Object.keys(e.$state).map((t => ({
                    editable: !0,
                    key: t,
                    value: e.$state[t]
                })))
            };
            return e._getters && e._getters.length && (t.getters = e._getters.map((t => ({
                editable: !1,
                key: t,
                value: e[t]
            })))), e._customProperties.size && (t.customProperties = Array.from(e._customProperties).map((t => ({
                editable: !0,
                key: t,
                value: e[t]
            })))), t
        }

        function ys(e) {
            return e ? Array.isArray(e) ? e.reduce(((e, t) => (e.keys.push(t.key), e.operations.push(t.type), e.oldValue[t.key] = t.oldValue, e.newValue[t.key] = t.newValue, e)), {
                oldValue: {},
                keys: [],
                operations: [],
                newValue: {}
            }) : {
                operation: fs(e.type),
                key: fs(e.key),
                oldValue: e.oldValue,
                newValue: e.newValue
            } : {}
        }

        function bs(e) {
            switch (e) {
                case $a.direct:
                    return "mutation";
                case $a.patchFunction:
                    return "$patch";
                case $a.patchObject:
                    return "$patch";
                default:
                    return "unknown"
            }
        }
        let ws = !0;
        const _s = [],
            As = "pinia:mutations",
            xs = "pinia",
            Cs = e => "🍍 " + e;

        function ks(e, t) {
            ja({
                id: "dev.esm.pinia",
                label: "Pinia 🍍",
                logo: "https://pinia.vuejs.org/logo.svg",
                packageName: "pinia",
                homepage: "https://pinia.vuejs.org",
                componentStateTypes: _s,
                app: e
            }, (n => {
                "function" !== typeof n.now && rs("You seem to be using an outdated version of Vue Devtools. Are you still using the Beta release instead of the stable one? You can find the links at https://devtools.vuejs.org/guide/installation.html."), n.addTimelineLayer({
                    id: As,
                    label: "Pinia 🍍",
                    color: 15064968
                }), n.addInspector({
                    id: xs,
                    label: "Pinia 🍍",
                    icon: "storage",
                    treeFilterPlaceholder: "Search stores",
                    actions: [{
                        icon: "content_copy",
                        action: () => {
                            ss(t)
                        },
                        tooltip: "Serialize and copy the state"
                    }, {
                        icon: "content_paste",
                        action: async () => {
                            await ls(t), n.sendInspectorTree(xs), n.sendInspectorState(xs)
                        },
                        tooltip: "Replace the state with the content of your clipboard"
                    }, {
                        icon: "save",
                        action: () => {
                            cs(t)
                        },
                        tooltip: "Save the state as a JSON file"
                    }, {
                        icon: "folder_open",
                        action: async () => {
                            await ps(t), n.sendInspectorTree(xs), n.sendInspectorState(xs)
                        },
                        tooltip: "Import the state from a JSON file"
                    }],
                    nodeActions: [{
                        icon: "restore",
                        tooltip: "Reset the state (option store only)",
                        action: e => {
                            const n = t._s.get(e);
                            n ? n._isOptionsAPI ? (n.$reset(), rs(`Store "${e}" reset.`)) : rs(`Cannot reset "${e}" store because it's a setup store.`, "warn") : rs(`Cannot reset "${e}" store because it wasn't found.`, "warn")
                        }
                    }]
                }), n.on.inspectComponent(((e, t) => {
                    const n = e.componentInstance && e.componentInstance.proxy;
                    if (n && n._pStores) {
                        const t = e.componentInstance.proxy._pStores;
                        Object.values(t).forEach((t => {
                            e.instanceData.state.push({
                                type: Cs(t.$id),
                                key: "state",
                                editable: !0,
                                value: t._isOptionsAPI ? {
                                    _custom: {
                                        value: Et(t.$state),
                                        actions: [{
                                            icon: "restore",
                                            tooltip: "Reset the state of this store",
                                            action: () => t.$reset()
                                        }]
                                    }
                                } : Object.keys(t.$state).reduce(((e, n) => (e[n] = t.$state[n], e)), {})
                            }), t._getters && t._getters.length && e.instanceData.state.push({
                                type: Cs(t.$id),
                                key: "getters",
                                editable: !1,
                                value: t._getters.reduce(((e, n) => {
                                    try {
                                        e[n] = t[n]
                                    } catch (r) {
                                        e[n] = r
                                    }
                                    return e
                                }), {})
                            })
                        }))
                    }
                })), n.on.getInspectorTree((n => {
                    if (n.app === e && n.inspectorId === xs) {
                        let e = [t];
                        e = e.concat(Array.from(t._s.values())), n.rootNodes = (n.filter ? e.filter((e => "$id" in e ? e.$id.toLowerCase().includes(n.filter.toLowerCase()) : hs.toLowerCase().includes(n.filter.toLowerCase()))) : e).map(vs)
                    }
                })), n.on.getInspectorState((n => {
                    if (n.app === e && n.inspectorId === xs) {
                        const e = n.nodeId === gs ? t : t._s.get(n.nodeId);
                        if (!e) return;
                        e && (n.state = ms(e))
                    }
                })), n.on.editInspectorState(((n, r) => {
                    if (n.app === e && n.inspectorId === xs) {
                        const e = n.nodeId === gs ? t : t._s.get(n.nodeId);
                        if (!e) return rs(`store "${n.nodeId}" not found`, "error");
                        const {
                            path: r
                        } = n;
                        os(e) ? r.unshift("state") : 1 === r.length && e._customProperties.has(r[0]) && !(r[0] in e.$state) || r.unshift("$state"), ws = !1, n.set(e, r, n.state.value), ws = !0
                    }
                })), n.on.editComponentState((e => {
                    if (e.type.startsWith("🍍")) {
                        const n = e.type.replace(/^🍍\s*/, ""),
                            r = t._s.get(n);
                        if (!r) return rs(`store "${n}" not found`, "error");
                        const {
                            path: o
                        } = e;
                        if ("state" !== o[0]) return rs(`Invalid path for store "${n}":\n${o}\nOnly state can be modified.`);
                        o[0] = "$state", ws = !1, e.set(r, o, e.state.value), ws = !0
                    }
                }))
            }))
        }

        function Ss(e, t) {
            _s.includes(Cs(t.$id)) || _s.push(Cs(t.$id)), ja({
                id: "dev.esm.pinia",
                label: "Pinia 🍍",
                logo: "https://pinia.vuejs.org/logo.svg",
                packageName: "pinia",
                homepage: "https://pinia.vuejs.org",
                componentStateTypes: _s,
                app: e,
                settings: {
                    logStoreChanges: {
                        label: "Notify about new/deleted stores",
                        type: "boolean",
                        defaultValue: !0
                    }
                }
            }, (e => {
                const n = "function" === typeof e.now ? e.now.bind(e) : Date.now;
                t.$onAction((({
                    after: r,
                    onError: o,
                    name: i,
                    args: a
                }) => {
                    const s = Es++;
                    e.addTimelineEvent({
                        layerId: As,
                        event: {
                            time: n(),
                            title: "🛫 " + i,
                            subtitle: "start",
                            data: {
                                store: fs(t.$id),
                                action: fs(i),
                                args: a
                            },
                            groupId: s
                        }
                    }), r((r => {
                        Ts = void 0, e.addTimelineEvent({
                            layerId: As,
                            event: {
                                time: n(),
                                title: "🛬 " + i,
                                subtitle: "end",
                                data: {
                                    store: fs(t.$id),
                                    action: fs(i),
                                    args: a,
                                    result: r
                                },
                                groupId: s
                            }
                        })
                    })), o((r => {
                        Ts = void 0, e.addTimelineEvent({
                            layerId: As,
                            event: {
                                time: n(),
                                logType: "error",
                                title: "💥 " + i,
                                subtitle: "end",
                                data: {
                                    store: fs(t.$id),
                                    action: fs(i),
                                    args: a,
                                    error: r
                                },
                                groupId: s
                            }
                        })
                    }))
                }), !0), t._customProperties.forEach((r => {
                    Rn((() => Rt(t[r])), ((t, o) => {
                        e.notifyComponentUpdate(), e.sendInspectorState(xs), ws && e.addTimelineEvent({
                            layerId: As,
                            event: {
                                time: n(),
                                title: "Change",
                                subtitle: r,
                                data: {
                                    newValue: t,
                                    oldValue: o
                                },
                                groupId: Ts
                            }
                        })
                    }), {
                        deep: !0
                    })
                })), t.$subscribe((({
                    events: r,
                    type: o
                }, i) => {
                    if (e.notifyComponentUpdate(), e.sendInspectorState(xs), !ws) return;
                    const a = {
                        time: n(),
                        title: bs(o),
                        data: {
                            store: fs(t.$id),
                            ...ys(r)
                        },
                        groupId: Ts
                    };
                    Ts = void 0, o === $a.patchFunction ? a.subtitle = "⤵️" : o === $a.patchObject ? a.subtitle = "🧩" : r && !Array.isArray(r) && (a.subtitle = r.type), r && (a.data["rawEvent(s)"] = {
                        _custom: {
                            display: "DebuggerEvent",
                            type: "object",
                            tooltip: "raw DebuggerEvent[]",
                            value: r
                        }
                    }), e.addTimelineEvent({
                        layerId: As,
                        event: a
                    })
                }), {
                    detached: !0,
                    flush: "sync"
                });
                const r = t._hotUpdate;
                t._hotUpdate = Ot((o => {
                    r(o), e.addTimelineEvent({
                        layerId: As,
                        event: {
                            time: n(),
                            title: "🔥 " + t.$id,
                            subtitle: "HMR update",
                            data: {
                                store: fs(t.$id),
                                info: fs("HMR update")
                            }
                        }
                    }), e.notifyComponentUpdate(), e.sendInspectorTree(xs), e.sendInspectorState(xs)
                }));
                const {
                    $dispose: o
                } = t;
                t.$dispose = () => {
                    o(), e.notifyComponentUpdate(), e.sendInspectorTree(xs), e.sendInspectorState(xs), e.getSettings().logStoreChanges && rs(`Disposed "${t.$id}" store 🗑`)
                }, e.notifyComponentUpdate(), e.sendInspectorTree(xs), e.sendInspectorState(xs), e.getSettings().logStoreChanges && rs(`"${t.$id}" store installed 🆕`)
            }))
        }
        let Ts, Es = 0;

        function Os(e, t) {
            const n = t.reduce(((t, n) => (t[n] = Et(e)[n], t)), {});
            for (const r in n) e[r] = function() {
                const t = Es,
                    o = new Proxy(e, {
                        get(...e) {
                            return Ts = t, Reflect.get(...e)
                        },
                        set(...e) {
                            return Ts = t, Reflect.set(...e)
                        }
                    });
                return n[r].apply(o, arguments)
            }
        }

        function Ms({
            app: e,
            store: t,
            options: n
        }) {
            if (!t.$id.startsWith("__hot:")) {
                if (n.state && (t._isOptionsAPI = !0), "function" === typeof n.state) {
                    Os(t, Object.keys(n.actions));
                    const e = t._hotUpdate;
                    Et(t)._hotUpdate = function(n) {
                        e.apply(this, arguments), Os(t, Object.keys(n._hmrPayload.actions))
                    }
                }
                Ss(e, t)
            }
        }

        function Is() {
            const e = re(!0),
                t = e.run((() => Ft({})));
            let n = [],
                r = [];
            const o = Ot({
                install(e) {
                    Ha(o), Sa || (o._a = e, e.provide(Ga, o), e.config.globalProperties.$pinia = o, Ua && ks(e, o), r.forEach((e => n.push(e))), r = [])
                },
                use(e) {
                    return this._a || Sa ? n.push(e) : r.push(e), this
                },
                _p: n,
                _a: null,
                _e: e,
                _s: new Map,
                state: t
            });
            return Ua && "undefined" !== typeof Proxy && o.use(Ms), o
        }
        const Ps = () => {};

        function Bs(e, t, n, r = Ps) {
            e.push(t);
            const o = () => {
                const n = e.indexOf(t);
                n > -1 && (e.splice(n, 1), r())
            };
            return !n && ie() && ae(o), o
        }

        function Ls(e, ...t) {
            e.slice().forEach((e => {
                e(...t)
            }))
        }

        function Fs(e, t) {
            e instanceof Map && t instanceof Map && t.forEach(((t, n) => e.set(n, t))), e instanceof Set && t instanceof Set && t.forEach(e.add, e);
            for (const n in t) {
                if (!t.hasOwnProperty(n)) continue;
                const r = t[n],
                    o = e[n];
                za(o) && za(r) && e.hasOwnProperty(n) && !Lt(r) && !Ct(r) ? e[n] = Fs(o, r) : e[n] = r
            }
            return e
        }
        const Ds = Symbol(),
            Ns = new WeakMap;

        function Rs(e) {
            return Sa ? !Ns.has(e) : !za(e) || !e.hasOwnProperty(Ds)
        }
        const {
            assign: js
        } = Object;

        function Hs(e) {
            return !(!Lt(e) || !e.effect)
        }

        function Gs(e, t, n, r) {
            const {
                state: o,
                actions: i,
                getters: a
            } = t, s = n.state.value[e];
            let l;

            function c() {
                s || (Sa ? Ta(n.state.value, e, o ? o() : {}) : n.state.value[e] = o ? o() : {});
                const t = Gt(n.state.value[e]);
                return js(t, i, Object.keys(a || {}).reduce(((t, r) => (t[r] = Ot(mi((() => {
                    Ha(n);
                    const t = n._s.get(e);
                    if (!Sa || t._r) return a[r].call(t, t)
                }))), t)), {}))
            }
            return l = zs(e, c, t, n, r, !0), l.$reset = function() {
                const e = o ? o() : {};
                this.$patch((t => {
                    js(t, e)
                }))
            }, l
        }

        function zs(e, t, n = {}, r, o, i) {
            let a;
            const s = js({
                actions: {}
            }, n);
            const l = {
                deep: !0
            };
            let c, d;
            let u, p = Ot([]),
                f = Ot([]);
            const h = r.state.value[e];
            i || h || (Sa ? Ta(r.state.value, e, {}) : r.state.value[e] = {});
            const g = Ft({});
            let v;

            function m(t) {
                let n;
                c = d = !1, "function" === typeof t ? (t(r.state.value[e]), n = {
                    type: $a.patchFunction,
                    storeId: e,
                    events: u
                }) : (Fs(r.state.value[e], t), n = {
                    type: $a.patchObject,
                    payload: t,
                    storeId: e,
                    events: u
                });
                const o = v = Symbol();
                sn().then((() => {
                    v === o && (c = !0)
                })), d = !0, Ls(p, n, r.state.value[e])
            }
            const y = Ps;

            function b() {
                a.stop(), p = [], f = [], r._s.delete(e)
            }

            function w(t, n) {
                return function() {
                    Ha(r);
                    const o = Array.from(arguments),
                        i = [],
                        a = [];

                    function s(e) {
                        i.push(e)
                    }

                    function l(e) {
                        a.push(e)
                    }
                    let c;
                    Ls(f, {
                        args: o,
                        name: t,
                        store: x,
                        after: s,
                        onError: l
                    });
                    try {
                        c = n.apply(this && this.$id === e ? this : x, o)
                    } catch (d) {
                        throw Ls(a, d), d
                    }
                    return c instanceof Promise ? c.then((e => (Ls(i, e), e))).catch((e => (Ls(a, e), Promise.reject(e)))) : (Ls(i, c), c)
                }
            }
            const _ = Ot({
                    actions: {},
                    getters: {},
                    state: [],
                    hotState: g
                }),
                A = {
                    _p: r,
                    $id: e,
                    $onAction: Bs.bind(null, f),
                    $patch: m,
                    $reset: y,
                    $subscribe(t, n = {}) {
                        const o = Bs(p, t, n.detached, (() => i())),
                            i = a.run((() => Rn((() => r.state.value[e]), (r => {
                                ("sync" === n.flush ? d : c) && t({
                                    storeId: e,
                                    type: $a.direct,
                                    events: u
                                }, r)
                            }), js({}, l, n))));
                        return o
                    },
                    $dispose: b
                };
            Sa && (A._r = !1);
            const x = wt(Ua ? js({
                _hmrPayload: _,
                _customProperties: Ot(new Set)
            }, A) : A);
            r._s.set(e, x);
            const C = r._e.run((() => (a = re(), a.run((() => t())))));
            for (const k in C) {
                const t = C[k];
                if (Lt(t) && !Hs(t) || Ct(t)) i || (h && Rs(t) && (Lt(t) ? t.value = h[k] : Fs(t, h[k])), Sa ? Ta(r.state.value[e], k, t) : r.state.value[e][k] = t);
                else if ("function" === typeof t) {
                    const e = w(k, t);
                    Sa ? Ta(C, k, e) : C[k] = e, s.actions[k] = t
                } else 0
            }
            if (Sa ? Object.keys(C).forEach((e => {
                    Ta(x, e, C[e])
                })) : (js(x, C), js(Et(x), C)), Object.defineProperty(x, "$state", {
                    get: () => r.state.value[e],
                    set: e => {
                        m((t => {
                            js(t, e)
                        }))
                    }
                }), Ua) {
                const e = {
                    writable: !0,
                    configurable: !0,
                    enumerable: !1
                };
                ["_p", "_hmrPayload", "_getters", "_customProperties"].forEach((t => {
                    Object.defineProperty(x, t, {
                        value: x[t],
                        ...e
                    })
                }))
            }
            return Sa && (x._r = !0), r._p.forEach((e => {
                if (Ua) {
                    const t = a.run((() => e({
                        store: x,
                        app: r._a,
                        pinia: r,
                        options: s
                    })));
                    Object.keys(t || {}).forEach((e => x._customProperties.add(e))), js(x, t)
                } else js(x, a.run((() => e({
                    store: x,
                    app: r._a,
                    pinia: r,
                    options: s
                }))))
            })), h && i && n.hydrate && n.hydrate(x.$state, h), c = !0, d = !0, x
        }

        function $s(e, t, n) {
            let r, o;
            const i = "function" === typeof t;

            function a(e, n) {
                const a = ti();
                e = e || a && Dn(Ga, null), e && Ha(e), e = Fa, e._s.has(r) || (i ? zs(r, t, o, e) : Gs(r, o, e));
                const s = e._s.get(r);
                return s
            }
            return "string" === typeof e ? (r = e, o = i ? n : t) : (o = e, r = e.id), a.$id = r, a
        }

        function Vs(e) {
            if (Sa) return Gt(e); {
                e = Et(e);
                const t = {};
                for (const n in e) {
                    const r = e[n];
                    (Lt(r) || Ct(r)) && (t[n] = $t(e, n))
                }
                return t
            }
        }
        const Us = {
                key: 0,
                id: "video",
                class: "bg-image",
                autoplay: "",
                muted: "",
                loop: ""
            },
            Ks = ["src"],
            Ys = ["src"],
            Ws = ["src"];

        function Xs(e, n, r, o, i, a) {
            const s = xr("LeftMenu"),
                l = xr("Album"),
                c = xr("RightMenu"),
                d = xr("Keybinds"),
                u = xr("Hint"),
                p = xr("LoadingBar");
            return To(), Po("div", {
                class: "container",
                style: t({
                    backgroundImage: `url(./assets/themes/${o.theme}/overlay.png)`
                })
            }, [o.CheckIsVideo(o.bgImage()) ? (To(), Po("video", Us, [jo("source", {
                type: "video/mp4",
                src: o.bgImage()
            }, null, 8, Ks)])) : (To(), Po("img", {
                key: 1,
                src: o.bgImage(),
                class: "bg-image"
            }, null, 8, Ys)), Ho(qi, {
                name: "logo"
            }, {
                default: Sn((() => [o.showAll ? (To(), Po("img", {
                    key: 0,
                    class: "logo",
                    src: o.GetSrc("logo")
                }, null, 8, Ws)) : Uo("", !0)])),
                _: 1
            }), Ho(qi, {
                name: "left-menu"
            }, {
                default: Sn((() => [o.showLeftMenu && o.showAll ? (To(), Bo(s, {
                    key: 0
                })) : Uo("", !0)])),
                _: 1
            }), Ho(qi, {
                name: "albums"
            }, {
                default: Sn((() => [o.showAlbums && o.showAll ? (To(), Bo(l, {
                    key: 0
                })) : Uo("", !0)])),
                _: 1
            }), Ho(qi, {
                name: "settings"
            }, {
                default: Sn((() => [o.showSettings ? (To(), Bo(c, {
                    key: 0
                })) : Uo("", !0)])),
                _: 1
            }), Ho(qi, {
                name: "settings"
            }, {
                default: Sn((() => [o.showKeyboard && o.showAll ? (To(), Bo(d, {
                    key: 0
                })) : Uo("", !0)])),
                _: 1
            }), Ho(qi, {
                name: "hint"
            }, {
                default: Sn((() => [o.showHint && o.showAll && !o.showKeyboard ? (To(), Bo(u, {
                    key: 0
                })) : Uo("", !0)])),
                _: 1
            }), Ho(qi, {
                name: "bar"
            }, {
                default: Sn((() => [o.showAll ? (To(), Bo(p, {
                    key: 0,
                    loaded: o.loaded,
                    percentage: o.progress
                }, null, 8, ["loaded", "percentage"])) : Uo("", !0)])),
                _: 1
            })], 4)
        }
        const Qs = $s("preferences", (() => {
                const e = Ft(window.nuiHandoverData?.Config.PlayMusicByDefault || !1),
                    t = Ft(!0),
                    n = Ft(!0),
                    r = Ft(!0),
                    o = Ft(window.nuiHandoverData?.Config.Theme || "cherry");
                return {
                    enableSound: e,
                    showAll: t,
                    showLeftMenu: n,
                    showHint: r,
                    theme: o
                }
            })),
            qs = $s("general", (() => {
                const e = Ft(!1),
                    t = Ft(!1),
                    n = Ft(!1),
                    r = Ft(window.nuiHandoverData?.Config.Albums || []),
                    o = Ft(window.nuiHandoverData?.Config.AlbumsThumbnail || []),
                    i = Ft(window.nuiHandoverData?.Config.HintMessages || []);
                return {
                    showSettings: e,
                    showKeyboard: t,
                    showAlbums: n,
                    albums: r,
                    albumsThumbnail: o,
                    hintMessages: i
                }
            }));
        var Zs = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABkAAAAaCAYAAABCfffNAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAA5SURBVHgB7dSxDQAgDANBC1Fm/3UNKwSRKMV/b11nKZntULKlhkBAQEA+tx8OL+5GpfHCICAgA5AD2XcMV32bf6cAAAAASUVORK5CYII=";
        const Js = e => (Cn("data-v-06d572ae"), e = e(), kn(), e),
            el = {
                class: "header"
            },
            tl = Js((() => jo("h2", null, "Keybindings", -1))),
            nl = {
                class: "information"
            },
            rl = {
                class: "information-content"
            },
            ol = {
                class: "main-container"
            },
            il = {
                class: "keyboard"
            },
            al = {
                class: "keyboard-container"
            },
            sl = {
                class: "keyboard-container"
            },
            ll = Js((() => jo("p", null, "_", -1))),
            cl = Js((() => jo("p", null, "-", -1))),
            dl = [ll, cl],
            ul = Js((() => jo("p", null, "+", -1))),
            pl = Js((() => jo("p", null, "=", -1))),
            fl = [ul, pl],
            hl = {
                class: "keyboard-container keyboard-enter-container"
            },
            gl = {
                class: "enter-wrapper"
            },
            vl = ["src"],
            ml = Js((() => jo("p", null, "ENTER", -1))),
            yl = {
                class: "keyboard-container keyboard-after-enter-container"
            },
            bl = Js((() => jo("p", null, ":", -1))),
            wl = Js((() => jo("p", null, ";", -1))),
            _l = [bl, wl],
            Al = {
                class: "keyboard-container"
            },
            xl = {
                class: "keyboard-container"
            },
            Cl = {
                key: 0,
                class: "currentKeyContainer"
            },
            kl = {
                key: 0,
                class: "keyinfo"
            },
            Sl = {
                class: "press"
            },
            Tl = {
                class: "description"
            },
            El = {
                key: 1,
                class: "keyinfo"
            },
            Ol = {
                class: "press"
            },
            Ml = {
                class: "description"
            },
            Il = {
                key: 1,
                class: "currentKeyContainer"
            },
            Pl = {
                class: "combinationKeyContainer"
            },
            Bl = Js((() => jo("img", {
                src: Zs
            }, null, -1))),
            Ll = {
                class: "description"
            },
            Fl = {
                key: 2,
                class: "clickKey"
            },
            Dl = {
                class: "footer-header"
            },
            Nl = {
                class: "commands-content"
            },
            Rl = {
                class: "commands-left"
            },
            jl = {
                class: "commands-info"
            },
            Hl = {
                class: "commands-boxes"
            },
            Gl = ["onClick"],
            zl = {
                key: 0
            },
            $l = {
                class: "info-text"
            },
            Vl = {
                class: "info-text"
            },
            Ul = {
                key: 1,
                class: "command-box-container"
            },
            Kl = {
                class: "commandText"
            };

        function Yl(e, n, r, o, i, a) {
            const l = xr("Commands"),
                c = xr("Line");
            return To(), Po("div", {
                class: "keybinds",
                style: t(o.bgImage)
            }, [o.showAllCommands ? (To(), Bo(l, {
                key: 0,
                onClose: n[0] || (n[0] = e => o.showAllCommands = !1)
            })) : Uo("", !0), o.showAllCommands ? Uo("", !0) : (To(), Po(_o, {
                key: 1
            }, [jo("div", el, [tl, Ho(c, {
                width: "68",
                unit: "%"
            })]), jo("div", nl, [jo("div", {
                class: "information-line",
                style: t({
                    backgroundColor: o.themeData.keybinds.generalColor,
                    boxShadow: " 0px 0px 23px" + o.themeData.keybinds.generalColor
                })
            }, null, 4), jo("div", rl, [jo("h2", null, h(o.language?.["KEYBINDS_INFO"] || " Please click a highlighted key to see binding on the right panel."), 1), jo("p", null, h(o.language?.["KEYBINDS_INFO_2"] || " Please click a highlighted key to see binding on the right panel."), 1), jo("p", null, [Vo(h(o.language?.["GO_TO"] || "go to") + " “ ", 1), jo("span", {
                style: t({
                    color: o.themeData.keybinds.generalColor
                })
            }, h(o.language?.["FIVEM_SETTINGS"] || "ESC>Settings>Keybindings>FiveM"), 5), Vo("”. ")])]), Ho(c, {
                width: "11.25",
                unit: "%"
            })]), jo("div", ol, [jo("div", il, [jo("div", al, [jo("div", {
                class: "key esc key-space",
                style: t(o.keyColor("ESC")),
                onClick: n[1] || (n[1] = e => o.setCurrentKey("ESC"))
            }, " ESC ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("F1")),
                onClick: n[2] || (n[2] = e => o.setCurrentKey("F1"))
            }, " F1 ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("F2")),
                onClick: n[3] || (n[3] = e => o.setCurrentKey("F2"))
            }, " F2 ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("F3")),
                onClick: n[4] || (n[4] = e => o.setCurrentKey("F3"))
            }, " F3 ", 4), jo("div", {
                class: "key key-space",
                style: t(o.keyColor("F4")),
                onClick: n[5] || (n[5] = e => o.setCurrentKey("F4"))
            }, " F4 ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("F5")),
                onClick: n[6] || (n[6] = e => o.setCurrentKey("F5"))
            }, " F5 ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("F6")),
                onClick: n[7] || (n[7] = e => o.setCurrentKey("F6"))
            }, " F6 ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("F7")),
                onClick: n[8] || (n[8] = e => o.setCurrentKey("F7"))
            }, " F7 ", 4), jo("div", {
                class: "key key-space",
                style: t(o.keyColor("F8")),
                onClick: n[9] || (n[9] = e => o.setCurrentKey("F8"))
            }, " F8 ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("F8")),
                onClick: n[10] || (n[10] = e => o.setCurrentKey("F9"))
            }, " F9 ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("F10")),
                onClick: n[11] || (n[11] = e => o.setCurrentKey("F10"))
            }, " F10 ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("F11")),
                onClick: n[12] || (n[12] = e => o.setCurrentKey("F11"))
            }, " F11 ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("F12")),
                onClick: n[13] || (n[13] = e => o.setCurrentKey("F12"))
            }, " F12 ", 4)]), jo("div", sl, [jo("div", {
                class: "key",
                style: t(o.keyColor("“")),
                onClick: n[14] || (n[14] = e => o.setCurrentKey("“"))
            }, " “ ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("1")),
                onClick: n[15] || (n[15] = e => o.setCurrentKey("1"))
            }, " 1 ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("2")),
                onClick: n[16] || (n[16] = e => o.setCurrentKey("2"))
            }, " 2 ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("3")),
                onClick: n[17] || (n[17] = e => o.setCurrentKey("3"))
            }, " 3 ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("4")),
                onClick: n[18] || (n[18] = e => o.setCurrentKey("4"))
            }, " 4 ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("5")),
                onClick: n[19] || (n[19] = e => o.setCurrentKey("5"))
            }, " 5 ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("6")),
                onClick: n[20] || (n[20] = e => o.setCurrentKey("6"))
            }, " 6 ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("7")),
                onClick: n[21] || (n[21] = e => o.setCurrentKey("7"))
            }, " 7 ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("8")),
                onClick: n[22] || (n[22] = e => o.setCurrentKey("8"))
            }, " 8 ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("9")),
                onClick: n[23] || (n[23] = e => o.setCurrentKey("9"))
            }, " 9 ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("0")),
                onClick: n[24] || (n[24] = e => o.setCurrentKey("0"))
            }, " 0 ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("-")),
                onClick: n[25] || (n[25] = e => o.setCurrentKey("-"))
            }, dl, 4), jo("div", {
                class: "key",
                style: t(o.keyColor("+")),
                onClick: n[26] || (n[26] = e => o.setCurrentKey("+"))
            }, fl, 4), jo("div", {
                class: "key backspace",
                style: t(o.keyColor("BACKSPACE")),
                onClick: n[27] || (n[27] = e => o.setCurrentKey("BACKSPACE"))
            }, " BACKSPACE ", 4)]), jo("div", hl, [jo("div", {
                class: "key tab",
                style: t(o.keyColor("TAB")),
                onClick: n[28] || (n[28] = e => o.setCurrentKey("TAB"))
            }, " TAB ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("Q")),
                onClick: n[29] || (n[29] = e => o.setCurrentKey("Q"))
            }, " Q ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("W")),
                onClick: n[30] || (n[30] = e => o.setCurrentKey("W"))
            }, " W ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("E")),
                onClick: n[31] || (n[31] = e => o.setCurrentKey("E"))
            }, " E ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("R")),
                onClick: n[32] || (n[32] = e => o.setCurrentKey("R"))
            }, " R ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("T")),
                onClick: n[33] || (n[33] = e => o.setCurrentKey("T"))
            }, " T ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("Y")),
                onClick: n[34] || (n[34] = e => o.setCurrentKey("Y"))
            }, " Y ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("U")),
                onClick: n[35] || (n[35] = e => o.setCurrentKey("U"))
            }, " U ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("I")),
                onClick: n[36] || (n[36] = e => o.setCurrentKey("I"))
            }, " I ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("O")),
                onClick: n[37] || (n[37] = e => o.setCurrentKey("O"))
            }, " O ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("P")),
                onClick: n[38] || (n[38] = e => o.setCurrentKey("P"))
            }, " P ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("[")),
                onClick: n[39] || (n[39] = e => o.setCurrentKey("["))
            }, " [ ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("]")),
                onClick: n[40] || (n[40] = e => o.setCurrentKey("]"))
            }, " ] ", 4), jo("div", {
                class: "enter",
                onClick: n[41] || (n[41] = e => o.setCurrentKey("ENTER"))
            }, [jo("div", gl, [jo("img", {
                src: o.enterImage()
            }, null, 8, vl), ml])])]), jo("div", yl, [jo("div", {
                class: "key caps",
                style: t(o.keyColor("CAPS")),
                onClick: n[42] || (n[42] = e => o.setCurrentKey("CAPS"))
            }, " CAPS ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("A")),
                onClick: n[43] || (n[43] = e => o.setCurrentKey("A"))
            }, " A ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("S")),
                onClick: n[44] || (n[44] = e => o.setCurrentKey("S"))
            }, " S ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("D")),
                onClick: n[45] || (n[45] = e => o.setCurrentKey("D"))
            }, " D ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("F")),
                onClick: n[46] || (n[46] = e => o.setCurrentKey("F"))
            }, " F ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("G")),
                onClick: n[47] || (n[47] = e => o.setCurrentKey("G"))
            }, " G ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("H")),
                onClick: n[48] || (n[48] = e => o.setCurrentKey("H"))
            }, " H ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("J")),
                onClick: n[49] || (n[49] = e => o.setCurrentKey("J"))
            }, " J ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("K")),
                onClick: n[50] || (n[50] = e => o.setCurrentKey("K"))
            }, " K ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("L")),
                onClick: n[51] || (n[51] = e => o.setCurrentKey("L"))
            }, " L ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor(";")),
                onClick: n[52] || (n[52] = e => {
                    o.setCurrentKey(";")
                })
            }, _l, 4), jo("div", {
                class: "key",
                style: t(o.keyColor("@")),
                onClick: n[53] || (n[53] = e => o.setCurrentKey("@"))
            }, " @ ", 4)]), jo("div", Al, [jo("div", {
                class: "key shift",
                style: t(o.keyColor("LSHIFT")),
                onClick: n[54] || (n[54] = e => o.setCurrentKey("LSHIFT"))
            }, " SHIFT ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("Z")),
                onClick: n[55] || (n[55] = e => o.setCurrentKey("Z"))
            }, " Z ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("X")),
                onClick: n[56] || (n[56] = e => o.setCurrentKey("X"))
            }, " X ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("C")),
                onClick: n[57] || (n[57] = e => o.setCurrentKey("C"))
            }, " C ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("V")),
                onClick: n[58] || (n[58] = e => o.setCurrentKey("V"))
            }, " V ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("B")),
                onClick: n[59] || (n[59] = e => o.setCurrentKey("B"))
            }, " B ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("N")),
                onClick: n[60] || (n[60] = e => o.setCurrentKey("N"))
            }, " N ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("M")),
                onClick: n[61] || (n[61] = e => o.setCurrentKey("M"))
            }, " M ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("<")),
                onClick: n[62] || (n[62] = e => o.setCurrentKey("<"))
            }, " < ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor(">")),
                onClick: n[63] || (n[63] = e => o.setCurrentKey(">"))
            }, " > ", 4), jo("div", {
                class: "key",
                style: t(o.keyColor("?")),
                onClick: n[64] || (n[64] = e => o.setCurrentKey("?"))
            }, " ? ", 4), jo("div", {
                class: "key shift",
                style: t(o.keyColor("RSHIFT")),
                onClick: n[65] || (n[65] = e => o.setCurrentKey("RSHIFT"))
            }, " SHIFT ", 4)]), jo("div", xl, [jo("div", {
                class: "key ctrl",
                style: t(o.keyColor("LCTRL")),
                onClick: n[66] || (n[66] = e => o.setCurrentKey("LCTRL"))
            }, " CTRL ", 4), jo("div", {
                class: "key alt",
                style: t(o.keyColor("ALT")),
                onClick: n[67] || (n[67] = e => o.setCurrentKey("ALT"))
            }, " ALT ", 4), jo("div", {
                class: "key space",
                style: t(o.keyColor("SPACE")),
                onClick: n[68] || (n[68] = e => o.setCurrentKey("SPACE"))
            }, " SPACE ", 4), jo("div", {
                class: "key altgr",
                style: t(o.keyColor("ALTGR")),
                onClick: n[69] || (n[69] = e => o.setCurrentKey("ALTGR"))
            }, " ALTGR ", 4), jo("div", {
                class: "key ctrl",
                style: t(o.keyColor("RCTRL")),
                onClick: n[70] || (n[70] = e => o.setCurrentKey("RCTRL"))
            }, " CTRL ", 4)])]), jo("div", {
                class: "info-container",
                style: t(o.infoContainer)
            }, [Ho(c, {
                width: "85",
                unit: "%"
            }), o.getCurrentKey && !o.combinationsActive ? (To(), Po("div", Cl, [jo("div", {
                class: "currentKey",
                style: t({
                    backgroundColor: o.themeData.keybinds.active,
                    border: "0px solid white",
                    color: o.themeData.keybinds.activeTextColor
                })
            }, h(o.currentKey), 5), o.getCurrentKey.pressInfo ? (To(), Po("div", kl, [jo("p", Sl, h(o.language?.["PRESS"] || "Press"), 1), jo("p", Tl, h(o.getCurrentKey.pressInfo), 1)])) : Uo("", !0), o.getCurrentKey.doublePressInfo ? (To(), Po("div", El, [jo("p", Ol, h(o.language?.["DOUBLE_PRESS"] || "Double Press"), 1), jo("p", Ml, h(o.getCurrentKey.doublePressInfo), 1)])) : Uo("", !0), o.getCurrentKey.combinations && 0 != Object.keys(o.getCurrentKey.combinations).length ? (To(), Po("div", {
                key: 2,
                onClick: n[71] || (n[71] = (...e) => o.OpenCombinations && o.OpenCombinations(...e)),
                style: t({
                    backgroundColor: o.themeData.keybinds.active,
                    color: o.themeData.keybinds.activeTextColor
                }),
                class: "combinationsButton"
            }, h(o.language?.["COMBINATIONS"] || "Combinations"), 5)) : Uo("", !0)])) : o.getCurrentKey && o.getCurrentKey.combinations && o.combinationsActive ? (To(), Po("div", Il, [jo("div", {
                class: "currentKey",
                style: t({
                    backgroundColor: o.themeData.keybinds.active,
                    border: o.themeData.keybinds.activeBorder,
                    color: o.themeData.keybinds.activeTextColor
                })
            }, h(o.currentKey), 5), jo("div", Pl, [(To(!0), Po(_o, null, Tr(o.getCurrentKey.combinations, ((e, n) => (To(), Po("div", {
                class: "combinationKey",
                key: n
            }, [Bl, jo("div", {
                class: "currentKey",
                style: t({
                    backgroundColor: o.themeData.keybinds.active,
                    border: o.themeData.keybinds.activeBorder,
                    color: o.themeData.keybinds.activeTextColor
                })
            }, h(e.key), 5), jo("p", Ll, h(e.info), 1)])))), 128))])])) : (To(), Po("p", Fl, h(o.language?.["KEYBINDS_INFO_3"] || "Please click on a key to display binding."), 1)), Ho(c, {
                width: "85",
                unit: "%"
            })], 4)]), jo("footer", null, [jo("div", Dl, [jo("h2", null, h(o.language?.["COMMANDS"] || "Commands"), 1), Ho(c, {
                width: "100",
                unit: "%"
            })]), jo("div", Nl, [jo("div", Rl, [jo("div", jl, [jo("div", {
                class: "commands-line",
                style: t({
                    backgroundColor: o.themeData.keybinds.generalColor,
                    boxShadow: " 0px 0px 23px" + o.themeData.keybinds.generalColor
                })
            }, null, 4), jo("p", null, h(o.language?.["KEYBINDS_INFO_4"] || "Be aware that those are settings commands and there are many more commands in game."), 1)]), jo("div", Hl, [(To(!0), Po(_o, null, Tr(o.commands, ((e, n, r) => (To(), Po("div", {
                onClick: e => o.setCurrentCommand(n),
                class: s(["commands-box", {
                    activebox: n == o.currentCommand
                }]),
                style: t({
                    border: o.themeData.keybinds.showCommandsButtonBorder,
                    backgroundColor: n == o.currentCommand ? o.themeData.keybinds.active : "rgba(0, 0, 0, 0.58)",
                    color: n == o.currentCommand ? o.themeData.keybinds.activeTextColor : "#ffffff"
                }),
                key: r
            }, " /" + h(n), 15, Gl)))), 128)), jo("div", {
                class: "commands-box active",
                style: t({
                    backgroundColor: o.themeData.keybinds.showCommandsButtonBG,
                    border: o.themeData.keybinds.showCommandsButtonBorder
                }),
                onClick: n[72] || (n[72] = e => o.showAllCommands = !0)
            }, h(o.language?.["SHOW_ALL"] || "Show All Commands"), 5)])]), jo("div", {
                class: "commands-infobox",
                style: t(o.boxContainer)
            }, [Ho(c, {
                width: "85",
                unit: "%"
            }), o.currentCommand ? (To(), Po("div", Ul, [jo("div", {
                class: "commandBox",
                style: t({
                    backgroundColor: o.themeData.keybinds.active,
                    border: o.themeData.keybinds.activeBorder,
                    color: o.themeData.keybinds.activeTextColor
                })
            }, " /" + h(o.currentCommand), 5), jo("p", Kl, h(o.commandText), 1)])) : (To(), Po("div", zl, [jo("p", $l, h(o.language?.["SELECT_COMMAND"] || "Please select a command"), 1), jo("p", Vl, h(o.language?.["DISPLAY_BINDING"] || "display binding"), 1)])), Ho(c, {
                width: "85",
                unit: "%"
            })], 4)])])], 64))], 4)
        }
        const Wl = () => {
                const e = {
                    ["sky"]: {
                        ["left-menu"]: {
                            ["server-name"]: "linear-gradient(90deg, #00B0FF 0%, #FFFFFF 100%)",
                            ["server-name-shadow"]: "0px 0px 35px rgba(255, 255, 255, 0.45)"
                        },
                        ["loading-bar"]: {
                            ["progress"]: "linear-gradient(90deg, rgba(0, 176, 255, 0.2) 0%, rgba(255, 255, 255, 0.2) 100%)",
                            ["progress-active"]: "linear-gradient(90deg, #00B0FF 0%, #FFFFFF 100%)",
                            ["button"]: "rgba(0, 0, 0, 0.24)",
                            ["button-active"]: "#FFFFFF"
                        },
                        ["settings"]: {
                            ["input"]: "rgba(0, 176, 255, 0.15)",
                            ["input-active"]: "rgba(0, 176, 255, 0.74)"
                        },
                        ["hint"]: {
                            ["timer"]: "#00aeffa6",
                            ["line"]: "#00aeffa6",
                            ["header"]: "#00b0ff"
                        },
                        ["keybinds"]: {
                            ["default"]: "#00aeffa6",
                            ["active"]: "#00B0FF",
                            ["defaultBorder"]: " 1px solid rgba(0, 176, 255, 0.5)",
                            ["activeBorder"]: " 1px solid #FFFFFF",
                            ["generalColor"]: "#00B0FF",
                            ["showCommandsButtonBG"]: "#015378",
                            ["showCommandsButtonBorder"]: "1px solid rgba(0, 176, 255, 0.5)",
                            ["activeTextColor"]: "#FFFFFF"
                        }
                    },
                    ["proxima"]: {
                        ["left-menu"]: {
                            ["server-name"]: "linear-gradient(90deg, #CC00FF 0%, #4F0063 100%)"
                        },
                        ["loading-bar"]: {
                            ["progress"]: "linear-gradient(90deg, rgba(94, 0, 117, 0.2) 0%, rgba(204, 0, 255, 0.2) 100%)",
                            ["progress-active"]: "linear-gradient(90deg, #5E0075 0%, #CC00FF 100%)",
                            ["button"]: "rgba(204, 0, 255, 0.24)",
                            ["button-active"]: "#CC00FF"
                        },
                        ["settings"]: {
                            ["input"]: "rgba(255, 255, 255, 0.15)",
                            ["input-active"]: "rgba(204, 0, 255, 0.74)"
                        },
                        ["hint"]: {
                            ["timer"]: "#ffffffa6",
                            ["line"]: "#ffffffa6",
                            ["header"]: "#ffffff"
                        },
                        ["keybinds"]: {
                            ["default"]: "rgba(204, 0, 255, 0.53)",
                            ["active"]: "rgba(204, 0, 255, 1)",
                            ["defaultBorder"]: " 1px solid rgba(204, 0, 255, 0.5)",
                            ["activeBorder"]: "1px solid rgba(204, 0, 255, 0.8)",
                            ["generalColor"]: "#CC00FF",
                            ["showCommandsButtonBG"]: "#520066",
                            ["showCommandsButtonBorder"]: "1px solid rgba(255, 255, 255, 0.5)",
                            ["activeTextColor"]: "#000000"
                        }
                    },
                    ["blvck"]: {
                        ["left-menu"]: {
                            ["server-name"]: "linear-gradient(90deg, #FFFFFF 0%, #FFFFFF 100%)",
                            ["server-name-shadow"]: "0px 0px 35px rgba(255, 255, 255, 0.45)"
                        },
                        ["loading-bar"]: {
                            ["progress"]: " linear-gradient(90deg, rgba(0, 0, 0, 0.2) 0%, rgba(255, 255, 255, 0.2) 100%)",
                            ["progress-active"]: " linear-gradient(90deg, #000000 0%, #FFFFFF 100%)",
                            ["button"]: "rgba(0, 0, 0, 0.24)",
                            ["button-active"]: "#FFFFFF"
                        },
                        ["settings"]: {
                            ["input"]: "rgba(255, 255, 255, 0.15)",
                            ["input-active"]: "rgba(0, 0, 0, 0.74)"
                        },
                        ["hint"]: {
                            ["timer"]: "#ffffffa6",
                            ["line"]: "#ffffffa6",
                            ["header"]: "#ffffff"
                        },
                        ["keybinds"]: {
                            ["default"]: "rgba(255, 255, 255, 0.53)",
                            ["active"]: "rgba(255, 255, 255, 1)",
                            ["defaultBorder"]: " 1px solid rgba(255, 255, 255, 0.5)",
                            ["activeBorder"]: "1px solid rgba(255, 255, 255, 0.8)",
                            ["generalColor"]: "#FFFFFF",
                            ["showCommandsButtonBG"]: "#565656",
                            ["showCommandsButtonBorder"]: "1px solid rgba(255, 255, 255, 0.5)",
                            ["activeTextColor"]: "#000000"
                        }
                    },
                    ["kush"]: {
                        ["left-menu"]: {
                            ["server-name"]: " linear-gradient(90deg, #00FFA3 0%, #005738 100%)"
                        },
                        ["loading-bar"]: {
                            ["progress"]: "linear-gradient(90deg, rgba(0, 102, 65, 0.2) 0%, rgba(0, 255, 163, 0.2) 100%)",
                            ["progress-active"]: " linear-gradient(90deg, #006641 0%, #00FFA3 100%)",
                            ["button"]: "rgba(0, 0, 0, 0.24)",
                            ["button-active"]: "#00FFA3"
                        },
                        ["settings"]: {
                            ["input"]: "rgba(255, 255, 255, 0.15)",
                            ["input-active"]: "rgba(0, 255, 163, 0.74)"
                        },
                        ["hint"]: {
                            ["timer"]: "#ffffffa6",
                            ["line"]: "#ffffffa6",
                            ["header"]: "#ffffff"
                        },
                        ["keybinds"]: {
                            ["default"]: " rgba(0, 255, 163, 0.53)",
                            ["active"]: " rgba(0, 255, 163, 1)",
                            ["defaultBorder"]: " 1px solid rgba(255, 255, 255, 0.5)",
                            ["activeBorder"]: "1px solid rgba(255, 255, 255, 0.8)",
                            ["generalColor"]: "#00FFA3",
                            ["showCommandsButtonBG"]: "#00764B",
                            ["showCommandsButtonBorder"]: "1px solid rgba(255, 255, 255, 0.5)",
                            ["activeTextColor"]: "#000000"
                        }
                    },
                    ["mango"]: {
                        ["left-menu"]: {
                            ["server-name"]: "linear-gradient(90deg, #FF9900 0%, #875100 100%)"
                        },
                        ["loading-bar"]: {
                            ["progress"]: "linear-gradient(90deg, rgba(88, 53, 0, 0.2) 0%, rgba(255, 153, 0, 0.2) 100%)",
                            ["progress-active"]: "linear-gradient(90deg, #583500 0%, #FF9900 100%)",
                            ["button"]: "rgba(0, 0, 0, 0.24)",
                            ["button-active"]: "#FF9900"
                        },
                        ["settings"]: {
                            ["input"]: "rgba(255, 255, 255, 0.15)",
                            ["input-active"]: "rgba(255, 153, 0, 0.74)"
                        },
                        ["hint"]: {
                            ["timer"]: "#ffffffa6",
                            ["line"]: "#ffffffa6",
                            ["header"]: "#ffffff"
                        },
                        ["keybinds"]: {
                            ["default"]: "rgba(255, 153, 0, 0.53)",
                            ["active"]: "rgba(255, 153, 0, 1)",
                            ["defaultBorder"]: " 1px solid rgba(255, 255, 255, 0.5)",
                            ["activeBorder"]: "1px solid rgba(255, 255, 255, 0.8)",
                            ["generalColor"]: "#FF9900",
                            ["showCommandsButtonBG"]: "#663D00",
                            ["showCommandsButtonBorder"]: "1px solid rgba(255, 255, 255, 0.5)",
                            ["activeTextColor"]: "#000000"
                        }
                    },
                    ["cherry"]: {
                        ["left-menu"]: {
                            ["server-name"]: "linear-gradient(90deg, #FF0000 0%, #810000 100%)"
                        },
                        ["loading-bar"]: {
                            ["progress"]: " linear-gradient(90deg, rgba(73, 0, 0, 0.2) 0%, rgba(255, 0, 0, 0.2) 100%)",
                            ["progress-active"]: "linear-gradient(90deg, #490000 0%, #FF0000 100%)",
                            ["button"]: "rgba(0, 0, 0, 0.24)",
                            ["button-active"]: "#FF0000"
                        },
                        ["settings"]: {
                            ["input"]: "rgba(255, 255, 255, 0.15)",
                            ["input-active"]: "rgba(255, 0, 0, 0.74)"
                        },
                        ["hint"]: {
                            ["timer"]: "#ffffffa6",
                            ["line"]: "#ffffffa6",
                            ["header"]: "#ffffff"
                        },
                        ["keybinds"]: {
                            ["default"]: "rgba(255, 0, 0, 0.53)",
                            ["active"]: "rgba(255, 0, 0,1)",
                            ["defaultBorder"]: " 1px solid rgba(255, 255, 255, 0.5)",
                            ["activeBorder"]: "1px solid rgba(255, 255, 255, 0.8)",
                            ["generalColor"]: "#FF0000",
                            ["showCommandsButtonBG"]: "#5F0000",
                            ["showCommandsButtonBorder"]: "1px solid rgba(255, 255, 255, 0.5)",
                            ["activeTextColor"]: "#000000"
                        }
                    }
                };
                return {
                    themes: e
                }
            },
            Xl = e => (Cn("data-v-5f631893"), e = e(), kn(), e),
            Ql = {
                style: {
                    width: "100%",
                    height: "100%"
                }
            },
            ql = {
                class: "header"
            },
            Zl = Xl((() => jo("h2", null, "Commands", -1))),
            Jl = {
                class: "information"
            },
            ec = {
                class: "information-content"
            },
            tc = {
                class: "main-container"
            },
            nc = {
                class: "commands"
            },
            rc = ["onClick"],
            oc = {
                class: "info"
            },
            ic = {
                class: "command-box-container"
            },
            ac = {
                class: "clickKey"
            };

        function sc(e, n, r, o, i, a) {
            const l = xr("Line");
            return To(), Po("div", Ql, [jo("div", ql, [Zl, Ho(l, {
                width: "68",
                unit: "%"
            })]), jo("div", Jl, [jo("div", {
                class: "information-line",
                style: t({
                    backgroundColor: o.themeData.keybinds.generalColor,
                    boxShadow: " 0px 0px 23px" + o.themeData.keybinds.generalColor
                })
            }, null, 4), jo("div", ec, [jo("h2", null, h(o.language?.["COMMANDS_INFO"] || "Please click on a command to see the function on the right panel."), 1)])]), jo("div", tc, [jo("div", nc, [(To(!0), Po(_o, null, Tr(o.commands, ((e, n, r) => (To(), Po("div", {
                class: s(["command", {
                    active: n == o.currentCommand
                }]),
                style: t({
                    backgroundColor: n == o.currentCommand ? o.themeData.keybinds.generalColor : "rgba(0, 0, 0, 0.58)",
                    border: o.themeData.keybinds.defaultBorder,
                    color: n == o.currentCommand ? o.themeData.keybinds.activeTextColor : "#ffffff"
                }),
                onClick: e => o.setCurrentCommand(n),
                key: r
            }, " /" + h(n), 15, rc)))), 128))]), jo("div", oc, [jo("div", {
                class: "back",
                onClick: n[0] || (n[0] = (...e) => o.close && o.close(...e)),
                style: t({
                    backgroundColor: o.themeData.keybinds.generalColor,
                    border: o.themeData.keybinds.defaultBorder,
                    color: o.themeData.keybinds.activeTextColor
                })
            }, " Go Back ", 4), jo("div", {
                class: "info-container",
                style: t(o.infoContainer)
            }, [Ho(l, {
                width: "85",
                unit: "%"
            }), jo("div", ic, [jo("div", {
                class: "commandBox",
                style: t({
                    backgroundColor: o.themeData.keybinds.generalColor,
                    border: o.themeData.keybinds.defaultBorder,
                    color: o.themeData.keybinds.activeTextColor
                })
            }, " /" + h(o.currentCommand), 5), jo("p", ac, h(o.commandText), 1)]), Ho(l, {
                width: "85",
                unit: "%"
            })], 4)])])])
        }

        function lc(e, n, r, o, i, a) {
            return To(), Po("div", {
                class: "line",
                style: t({
                    width: r.width + "" + r.unit
                })
            }, null, 4)
        }
        var cc = {
                name: "Line",
                props: ["width", "unit"]
            },
            dc = (n(7837), n(89));
        const uc = (0, dc.Z)(cc, [
            ["render", lc]
        ]);
        var pc = uc,
            fc = {
                emits: ["close"],
                components: {
                    Line: pc
                },
                mounted() {
                    for (let e in window.nuiHandoverData?.Config.Commands || [])
                        if (window.nuiHandoverData.Config.Commands[e]) return void this.setCurrentCommand(e)
                },
                setup(e, {
                    emit: t
                }) {
                    const n = () => {
                            t("close")
                        },
                        {
                            themes: r
                        } = Wl(),
                        o = Ft(null),
                        i = Kt((() => window.nuiHandoverData?.Config.Commands[o.value] || !1)),
                        a = e => {
                            o.value = e
                        },
                        {
                            theme: s
                        } = Qs(),
                        l = Kt((() => r[s])),
                        c = Kt((() => ({
                            backgroundImage: `url('./assets/themes/${s}/info-container.png')`,
                            backgroundSize: "100% 100%",
                            backgroundRepeat: "no-repeat",
                            backgroundColor: "unset"
                        })));
                    return {
                        infoContainer: c,
                        setCurrentCommand: a,
                        commandText: i,
                        currentCommand: o,
                        close: n,
                        commands: window.nuiHandoverData?.Config.Commands || [],
                        language: window.nuiHandoverData?.Config.Language || [],
                        themeData: l
                    }
                }
            };
        n(3865);
        const hc = (0, dc.Z)(fc, [
            ["render", sc],
            ["__scopeId", "data-v-5f631893"]
        ]);
        var gc = hc,
            vc = {
                components: {
                    Line: pc,
                    Commands: gc
                },
                setup() {
                    const {
                        themes: e
                    } = Wl(), {
                        theme: t
                    } = Qs(), n = Ft(!1), r = Ft(!1), o = Ft(null), i = e => {
                        window.nuiHandoverData?.Config.Keybinds[e] && (g(), o.value = e)
                    }, a = Ft(null), s = Kt((() => window.nuiHandoverData.Config.PreviewCommands[a.value])), l = e => {
                        a.value = e
                    }, c = Kt((() => e[t])), d = e => o.value == e ? {
                        backgroundColor: c.value.keybinds.active,
                        border: c.value.keybinds.activeBorder,
                        color: c.value.keybinds.activeTextColor
                    } : window.nuiHandoverData?.Config.Keybinds[e] ? {
                        backgroundColor: c.value.keybinds.default,
                        border: c.value.keybinds.defaultBorder,
                        color: "#ffffff"
                    } : {
                        backgroundColor: "rgba(0, 0, 0, 0.58)",
                        border: c.value.keybinds.defaultBorder,
                        color: "#ffffff"
                    }, u = () => "ENTER" == o.value ? `./assets/themes/${t}/enter_active_2.png` : window.nuiHandoverData?.Config.Keybinds["ENTER"] ? `./assets/themes/${t}/enter_active.png` : `./assets/themes/${t}/enter.png`, p = Kt((() => window.nuiHandoverData?.Config.Keybinds[o.value] || !1)), f = Kt((() => ({
                        backgroundImage: `url('./assets/themes/${t}/keyboards.png'), url('./assets/themes/${t}/keyboards_2.png')`
                    }))), h = () => {
                        n.value = !0
                    }, g = () => {
                        n.value = !1
                    }, v = Kt((() => p.value ? {
                        backgroundImage: `url('./assets/themes/${t}/info-container.png')`,
                        backgroundSize: "100% 100%",
                        backgroundRepeat: "no-repeat",
                        backgroundColor: "unset"
                    } : {
                        backgroundColor: "rgba(0, 0, 0, 0.58)"
                    })), m = Kt((() => a.value ? {
                        backgroundImage: `url('./assets/themes/${t}/info-container.png')`,
                        backgroundSize: "100% 100%",
                        backgroundRepeat: "no-repeat",
                        backgroundColor: "unset"
                    } : {
                        backgroundColor: "rgba(0, 0, 0, 0.58)"
                    }));
                    return {
                        bgImage: f,
                        getCurrentKey: p,
                        currentKey: o,
                        setCurrentKey: i,
                        infoContainer: v,
                        OpenCombinations: h,
                        combinationsActive: n,
                        keyColor: d,
                        boxContainer: m,
                        commands: window.nuiHandoverData?.Config.PreviewCommands || {
                            ["hud"]: "Opens hud settings.",
                            ["notify"]: "Opens notify settings."
                        },
                        showAllCommands: r,
                        currentCommand: a,
                        commandText: s,
                        setCurrentCommand: l,
                        theme: t,
                        themeData: c,
                        enterImage: u,
                        language: window.nuiHandoverData?.Config.Language || []
                    }
                }
            };
        n(9667);
        const mc = (0, dc.Z)(vc, [
            ["render", Yl],
            ["__scopeId", "data-v-06d572ae"]
        ]);
        var yc = mc,
            bc = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABwAAAAbCAYAAABvCO8sAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAFOSURBVHgB3ZaPcYIwFMYfPQagG9ANZIM6QdsN2hE6Qe0GugFOoE4ATqAbyAayQfw+L3qRC4ZAOO/83X3mzyEf772EIHIHpVQKFWo4R+iP94wchjs0EwnH54vjgpBmJHMZBuf5DWP+cDWi+YBeoX0URWsZiVibcTUmei6HRjNkSr8Ns9HxrWENZdCb7o9uuEV9WeMK/X/pga/h6tKB6VzstWbkpQQy3DbGP1BljEsow8NM0S5koGGpU3kFY0bzpY1+aWRcM2s8zJlYurOxTbKmaKaW+RpbjhkozHmvCMUTmJbSSG1nQx1JH3Jz0DmlPESl395LfAxr4w+JBHgj2VJqHrq9NncLFZTbIpwgfe8sODc3+owylWGwHJvzlsENZ5aPnoM+RYLTVsMU2sE0R7sUz8XSfEHc0BLhIOQOD/mmqSQs7hcEsjBXYSiUY7GdACXVUznyavp+AAAAAElFTkSuQmCC",
            wc = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADEAAAAhCAYAAABwSkOHAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAHASURBVHgB1ZnvVYMwFMVfOH6XDYQJZATYoBuoE+gG1gnUCewGPU5QO4Fu0DgBdIJ4H4RjxPSo9RHI75ybNPRfbvISEqJogDGmRHYOFfbSHmqg2r5mMiiFTm3el/v3jqWx8l1/gLZKKX3w26h8Bm3M/Lkd1l05Jl7ps/XnzhtUoVfaXks4gYFLiscAw3Vd94XE5hcUH6Xpxm8XTijwoE0pPl4QUlUCA9w1MRpgCtQ/5XCK1QDTTu9sIqP/w7PEFaQpPIWUiRSxuYJymsCMWDghNjPOJzAz3pgIaYZNnNGIBDDTJBSIMc1IDexf45i5IxkzdbCe8LAi/7L7r+wnudlhJlsgE1s1S5r4sVVNt2fh1eda8n/Fwqlf2x8Clb+mrvUXJEtzQiNjb4JPUEkjIdUT2nfRaf2SRkSqJ76Ekt2s3FOg3WJCMtNc+xu8toe48hsKuN2VMtGHzg66ocCoyJ5y+Mhj39nx1K6nXHZIoDlJaJotpRSaEzaxpXh55oQHNo8JHtwZxUfejgm75qkovrB6/PaE3N6oltDOzJsaWrp1Vz6Lpnsq2IvPIDLn7ZSOn5aH5w/D8rvN3bMQ9zPadz7xAYVc5mXvDegYAAAAAElFTkSuQmCC",
            _c = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABUAAAAbCAYAAACTHcTmAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAB/SURBVHgB7dZBDYAwDIXhN4IAJCABHOAEKWABJeBgOGBScFA6spAFbmu59U+aJTt8WXoaiKjl8VTWDI7PEVkVz8ozQNbM8JSjHXR64Bq6Rfh+qaQmnWcOu7htlBecc/37UorGNp5FG/0k3amhhhpqqKE/ozt0C0g/lIN08tG7ANxVsQtsv4i1AAAAAElFTkSuQmCC",
            Ac = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAARCAYAAADdRIy+AAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAADeSURBVHgBpZPREYIwEEQPK0gHpgMtgRLsQEugAywBKoBOGCvADqCD2MF6IQlmNJAIb2Y/gMu7S4YQMQAkJcB1N04Hg+I0ei1H2G9XVzhwyoisRJjByjENZjs4ygWZRBwt7UPF3fcR8HORKJwmFPiM7NNwLrZhizhn110kLljF384Z+1HOd+CMnBft4zkLsyzTspr28fh5w2NX2I6cJ/ScR9pGy7scQxPm2IZcbAXzA6s/ZHeKAXPJU6RVaH3mdRGcEyenODWfW7E20YA0dF1OKcDcW30Fe0+grKRKFb0BLT3Tt+8sGNMAAAAASUVORK5CYII=",
            xc = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABMAAAATCAYAAAByUDbMAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAE9SURBVHgBnVSBUcMwDJSZIN3AG8AGwASUCZoNyAZkg3aDsEHYwDBBu4HZoNlAyOFdVNWlpn+nU0+W3tKrDhHAzI3Yq1jkOmzFBjGfORyI7sQFsQbxL/objcl9ds7tEpFX3WxSh1QB1L2hbj/XqcBAlQBRD79BfU+YnfXsqijpuBRr4RvEg54EvyPlNgtEL2hfI4p1IB+hNWWZ6MB6SpQRMNKoYp3JL5Oh7Yh4a4raI8EryJaIvVNZ/IDzJ0t2U8jPN+6ojE/4hT0okU3w91TGLfzJ0s5plre4MrkrtdXLmuGw41+M2Gb49zYNYeRj7C0RcudJHIi82EIe62SS0igP9LOUdPZRyEm1iWN+6D1uXdMVYP22jeADF97oGZJUt1YL8fp7NmJcwkjTBT6d+zh/z9RNHi1vuQ4REh3+It9sm4IT1Up0swAAAABJRU5ErkJggg==",
            Cc = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAARCAYAAADdRIy+AAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAEaSURBVHgBrZSBkYIwEEWTq4ASchVcSqAFK8AOrpTDCqQD7CBeBdJBrgOug/h32Oi6k4zg+GfeiAn/Z9kQjFmplFIDRvANWh77SYsuwJktgmEPIodGDqJfDwbQ030fGzJbcLDW7sAnrnegAf/mFaGCmapRY72o1K0Ncvy4c8lEva0a8w3c+MAhWjPPddqb/3hhjJWQmiKH3zbI0gVynXmPJgpMlckBWNCp8YNZdrcrukTJUkHMj2L89MR3zJugRX1s2Bj1QuyJNU9+x0qhW8YvlJVPylToRsOYypzWJPvoC6ue0vJS0zkNTM9jY6Fq9xCf7qdB6ghaDnF8PRTCfPE52BTSegVdma0E04p78AW86Nkf8wvO+OqctfcK9zhxfDVjaXkAAAAASUVORK5CYII=",
            kc = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABYAAAAQCAYAAAAS7Y8mAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAD8SURBVHgBrVSBEYIwDEyZADfACXAE3EAnkA2cwQnECdRJwAkcoW4ATlATIVxog3rC3/1dSNLwJKEACpxzG2SJrJFWidsuRjk7+AZMSpB3F6IesRkWGX8qfHH/oxwrmrnpyLheJGrnMB17NkynlvpTw3Q0yKUxpmHF2UjSCXlVYhXygHx4fhK46p9QcaH0KxHxUvjPwq/NpaAYK05BV8y4CfvJBn5ypZxLpWJtN49ClRV+yqV9jylHOfeeFQ/PwbxYRLKXMyI2M65aD+y9iWjnoF0dCfKtoV23CoaDbDofxbYQrtywFirPvSEFt5oPP9+JX1pL5hf8WpgYXJ0va4TE0WjJmXEAAAAASUVORK5CYII=";
        const Sc = e => (Cn("data-v-a78098e4"), e = e(), kn(), e),
            Tc = {
                class: "header"
            },
            Ec = {
                class: "section-header"
            },
            Oc = {
                class: "section-desc"
            },
            Mc = Sc((() => jo("img", {
                class: "icon",
                src: bc
            }, null, -1))),
            Ic = ["src"],
            Pc = {
                key: 1,
                class: "video-wrapper"
            },
            Bc = ["src"],
            Lc = Sc((() => jo("img", {
                class: "play-icon",
                src: wc
            }, null, -1))),
            Fc = {
                class: "section-header"
            },
            Dc = {
                class: "section-desc"
            },
            Nc = Sc((() => jo("img", {
                class: "icon",
                src: _c
            }, null, -1))),
            Rc = {
                class: "patch-header"
            },
            jc = {
                class: "patch-item"
            },
            Hc = {
                class: "socials"
            },
            Gc = {
                class: "socials-header"
            },
            zc = {
                class: "social-links"
            },
            $c = Sc((() => jo("img", {
                src: Ac
            }, null, -1))),
            Vc = [$c],
            Uc = Sc((() => jo("img", {
                src: xc
            }, null, -1))),
            Kc = [Uc],
            Yc = Sc((() => jo("img", {
                src: Cc
            }, null, -1))),
            Wc = [Yc],
            Xc = Sc((() => jo("img", {
                src: kc
            }, null, -1))),
            Qc = [Xc];

        function qc(e, n, r, o, i, a) {
            const s = xr("Line");
            return To(), Po("div", {
                class: "menu",
                style: t(o.bgImage("left-menu"))
            }, [jo("div", Tc, [jo("p", null, h(o.language?.["WELCOME"] || "WELCOME TO"), 1), Ho(s, {
                width: "21",
                unit: "%"
            })]), jo("p", {
                class: "server-name",
                style: t({
                    backgroundImage: o.themeData["left-menu"]["server-name"],
                    textShadow: o.themeData["left-menu"]?.["server-name-shadow"]
                })
            }, h(o.serverName), 5), Ho(s, {
                width: "87",
                unit: "%"
            }), jo("section", null, [jo("h2", Ec, h(o.language?.["INSIDE_CITY"] || "Inside The City"), 1), jo("p", Oc, h(o.language?.["FOOTAGES"] || "Latest footages from the city."), 1), jo("div", {
                class: "albums",
                style: t(o.bgImage("albums-container")),
                onClick: n[0] || (n[0] = e => o.showAlbums = !0)
            }, [Mc, o.albumsThumbnail[0] ? (To(), Po("img", {
                key: 0,
                class: "album img-1",
                src: o.albumsThumbnail[0].source
            }, null, 8, Ic)) : Uo("", !0), o.albumsThumbnail[1] ? (To(), Po("div", Pc, [jo("img", {
                class: "album img-2",
                src: o.albumsThumbnail[1].source
            }, null, 8, Bc), Lc])) : Uo("", !0)], 4)]), jo("section", null, [jo("h2", Fc, h(o.language?.["PATCH_NOTES"] || "Patch Notes"), 1), jo("p", Dc, h(o.language?.["LATEST_UPDATES"] || "Latest updates..."), 1), jo("div", {
                class: "patch-notes",
                style: t(o.bgImage("patch-notes-container"))
            }, [Nc, jo("h2", Rc, h(o.language?.["PATCH_NOTES_VERSION"] || "Patch Notes v4.20"), 1), (To(), Po("ul", {
                class: "patch-list",
                key: e.index
            }, [(To(!0), Po(_o, null, Tr(o.PatchNotes, ((e, t) => (To(), Po("li", jc, h(e), 1)))), 256))]))], 4)]), jo("footer", Hc, [jo("h2", Gc, h(o.language?.["FOLLOW_CITY"] || "Follow the city on social!"), 1), jo("div", zc, [jo("div", {
                class: "social-link",
                onClick: n[1] || (n[1] = e => o.OpenLink("twitter"))
            }, Vc), jo("div", {
                class: "social-link",
                onClick: n[2] || (n[2] = e => o.OpenLink("instagram"))
            }, Kc), jo("div", {
                class: "social-link",
                onClick: n[3] || (n[3] = e => o.OpenLink("reddit"))
            }, Wc), jo("div", {
                class: "social-link",
                onClick: n[4] || (n[4] = e => o.OpenLink("discord"))
            }, Qc), Ho(s, {
                width: "16",
                unit: "%"
            })])])], 4)
        }
        var Zc = {
            name: "LeftMenu",
            components: {
                Line: pc
            },
            setup() {
                const {
                    theme: e
                } = Qs(), {
                    themes: t
                } = Wl(), n = mi((() => t[e])), {
                    showAlbums: r,
                    albumsThumbnail: o
                } = Vs(qs()), i = e => {
                    window.nuiHandoverData?.Config.ButtonLinks[e] && window.invokeNative("openUrl", window.nuiHandoverData?.Config.ButtonLinks[e])
                }, a = t => ({
                    backgroundImage: `url('./assets/themes/${e}/${t}.png')`
                });
                return {
                    bgImage: a,
                    showAlbums: r,
                    themeData: n,
                    albumsThumbnail: o,
                    OpenLink: i,
                    PatchNotes: window?.nuiHandoverData?.Config.PatchNotes || !1,
                    language: window.nuiHandoverData?.Config.Language || [],
                    serverName: window.nuiHandoverData?.Config.ServerName || "M ROLEPLAY"
                }
            }
        };
        n(6143);
        const Jc = (0, dc.Z)(Zc, [
            ["render", qc],
            ["__scopeId", "data-v-a78098e4"]
        ]);
        var ed = Jc;
        const td = {
                class: "header"
            },
            nd = {
                class: "options"
            },
            rd = {
                class: "option"
            },
            od = {
                className: "check"
            },
            id = {
                class: "option"
            },
            ad = {
                className: "check"
            },
            sd = {
                class: "option"
            },
            ld = {
                className: "check"
            },
            cd = {
                class: "option"
            },
            dd = {
                className: "check"
            };

        function ud(e, n, r, o, i, a) {
            const s = xr("Line");
            return To(), Po("div", {
                class: "menu",
                style: t(o.bgImage)
            }, [jo("div", td, [jo("p", null, h(o.language?.["SETTINGS"] || "Settings"), 1), Ho(s, {
                width: "7.8",
                unit: "vw"
            })]), jo("div", nd, [jo("div", rd, [jo("p", null, h(o.language?.["ENABLE_MUSIC"] || "Enable music"), 1), jo("div", od, [wr(jo("input", {
                type: "checkbox",
                "onUpdate:modelValue": n[0] || (n[0] = e => o.enableSound = e),
                className: "check__check"
            }, null, 512), [
                [ha, o.enableSound]
            ]), jo("div", {
                className: "check__indicator",
                style: t({
                    background: o.enableSound ? o.themeData["settings"]["input-active"] : o.themeData["settings"]["input"]
                })
            }, null, 4)])]), jo("div", id, [jo("p", null, h(o.language?.["SHOW_MENU"] || "Show left menu"), 1), jo("div", ad, [wr(jo("input", {
                type: "checkbox",
                "onUpdate:modelValue": n[1] || (n[1] = e => o.showLeftMenu = e),
                className: "check__check"
            }, null, 512), [
                [ha, o.showLeftMenu]
            ]), jo("div", {
                className: "check__indicator",
                style: t({
                    background: o.showLeftMenu ? o.themeData["settings"]["input-active"] : o.themeData["settings"]["input"]
                })
            }, null, 4)])]), jo("div", sd, [jo("p", null, h(o.language?.["SHOW_HINT"] || "Show hint"), 1), jo("div", ld, [wr(jo("input", {
                type: "checkbox",
                "onUpdate:modelValue": n[2] || (n[2] = e => o.showHint = e),
                className: "check__check"
            }, null, 512), [
                [ha, o.showHint]
            ]), jo("div", {
                className: "check__indicator",
                style: t({
                    background: o.showHint ? o.themeData["settings"]["input-active"] : o.themeData["settings"]["input"]
                })
            }, null, 4)])]), jo("div", cd, [jo("p", null, h(o.language?.["SHOW_ALL"] || "Show all UI"), 1), jo("div", dd, [wr(jo("input", {
                type: "checkbox",
                "onUpdate:modelValue": n[3] || (n[3] = e => o.showAll = e),
                className: "check__check"
            }, null, 512), [
                [ha, o.showAll]
            ]), jo("div", {
                className: "check__indicator",
                style: t({
                    background: o.showAll ? o.themeData["settings"]["input-active"] : o.themeData["settings"]["input"]
                })
            }, null, 4)])])])], 4)
        }
        var pd = {
            name: "RightMenu",
            components: {
                Line: pc
            },
            setup() {
                const {
                    themes: e
                } = Wl(), {
                    showLeftMenu: t,
                    enableSound: n,
                    showHint: r,
                    showAll: o,
                    theme: i
                } = Vs(Qs()), a = mi((() => e[i.value])), s = mi((() => ({
                    backgroundImage: `url('./assets/themes/${i.value}/right-menu.png')`
                })));
                return {
                    bgImage: s,
                    showLeftMenu: t,
                    showHint: r,
                    showAll: o,
                    themeData: a,
                    enableSound: n,
                    language: window.nuiHandoverData?.Config.Language || []
                }
            }
        };
        n(5225);
        const fd = (0, dc.Z)(pd, [
            ["render", ud],
            ["__scopeId", "data-v-aa404f7c"]
        ]);
        var hd = fd,
            gd = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADQAAAAzCAYAAADYfStTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAI6SURBVHgB7ZqBVcIwEIb/+hyAEWAC2UDcACcAJlAnoE4gTiBMIEwAG8gGzQaywXlHi68PS5u2uZIi33tHS5NCfnK5JFeAihDRgG1N5yVi+2Drog78AVPyi4itI20LUBKKf40I/jEPgmByg/I8w0+G8lJFUAd+0hHvqSLIa66CfOcqyHeugnzn9nDCMXzAhxFbN1W+49n3ES1iL4jFTPkQZpQbtIwbFjNGtphWImPoCReECOrjgtCMci9sPbYHNDgWb6GD7E1mybnhcTrh4xoNoNVDy/QbFrdB3GPqqAhiAauMa9JjGyijIWiVUyaut4MiGoI+TxVwLxk+vKIYqSfBRIJKOVctyqZk1J8X3NO1+M68z5gdMjip+iHZ0XUtyCqSSYMpTj2l+WYb5tzzRRaCXLvcyqYSu56MI1n0muSSRMUeX1/m3GbneuS2h1RXHRS7Y2M9ZPgX3kKXEAWrDpeCNlAmcdVJXh2XghZogGTV8X6q3JWgXfJFTRHixATtrIfoaO7QJHG9TFyttkXMmkVZhW0H3ONEjt3l9qEPDzaL/y4vl9Wt2nNNVWQeNIWC6O9icw7lLUBF9tOGjcuN02+SCCNLe59ELbhdoZwEsgAqqCwN7x2HyqTn5PHkHc6HQSxm83uF7HhDWyB7pmgDVA7/RVF5IrYR1f33hhI2QSEPmZO0ot2WB3vpXF7dpY93efHrI0nfEUEGfmJQARHUyNa5AtXaRXHSzyaJ1yQh6kCxKEm3RnRe1mwj1OAHHwXVTArXFRQAAAAASUVORK5CYII=";
        const vd = e => (Cn("data-v-5c4d4f3e"), e = e(), kn(), e),
            md = {
                class: "wrapper"
            },
            yd = ["src"],
            bd = {
                class: "container"
            },
            wd = vd((() => jo("img", {
                class: "icon",
                src: gd
            }, null, -1))),
            _d = ["src"],
            Ad = ["src"],
            xd = ["src"];

        function Cd(e, t, n, r, o, i) {
            const a = xr("swiper-slide"),
                s = xr("swiper");
            return To(), Po("div", {
                class: "albums",
                onClick: t[2] || (t[2] = wa(((...e) => r.Hide && r.Hide(...e)), ["self"]))
            }, [jo("div", md, [jo("img", {
                onClick: t[0] || (t[0] = e => r.swiperRef.slidePrev()),
                class: "button",
                src: r.GetSrc("left")
            }, null, 8, yd), jo("div", bd, [wd, Ho(s, {
                style: {
                    width: "100%",
                    height: "100%"
                },
                onSwiper: r.onSwiper,
                onSlideChange: r.onSlideChange
            }, {
                default: Sn((() => [(To(!0), Po(_o, null, Tr(r.albums, ((e, t) => (To(), Bo(a, {
                    style: {
                        width: "100%",
                        height: "100%",
                        display: "flex",
                        "align-items": "center",
                        "justify-content": "center"
                    },
                    key: t
                }, {
                    default: Sn((() => [r.youtube_parser("https://www.youtube.com/watch?v=" + e.source) ? (To(), Po("iframe", {
                        key: 0,
                        class: "img",
                        src: "https://www.youtube.com/embed/" + e.source + "?rel=0&controls=1&showinfo=1&autoplay=0&mute=0&loop=0&",
                        frameborder: "0",
                        allow: "autoplay; encrypted-media",
                        webkitallowfullscreen: "",
                        mozallowfullscreen: "",
                        allowfullscreen: ""
                    }, null, 8, _d)) : (To(), Po("img", {
                        key: 1,
                        class: "img",
                        src: e.source
                    }, null, 8, Ad))])),
                    _: 2
                }, 1024)))), 128))])),
                _: 1
            }, 8, ["onSwiper", "onSlideChange"])]), jo("img", {
                onClick: t[1] || (t[1] = e => r.swiperRef.slideNext()),
                class: "button",
                src: r.GetSrc("right")
            }, null, 8, xd)])])
        }

        function kd(e) {
            return null !== e && "object" === typeof e && "constructor" in e && e.constructor === Object
        }

        function Sd(e = {}, t = {}) {
            Object.keys(t).forEach((n => {
                "undefined" === typeof e[n] ? e[n] = t[n] : kd(t[n]) && kd(e[n]) && Object.keys(t[n]).length > 0 && Sd(e[n], t[n])
            }))
        }
        const Td = {
            body: {},
            addEventListener() {},
            removeEventListener() {},
            activeElement: {
                blur() {},
                nodeName: ""
            },
            querySelector() {
                return null
            },
            querySelectorAll() {
                return []
            },
            getElementById() {
                return null
            },
            createEvent() {
                return {
                    initEvent() {}
                }
            },
            createElement() {
                return {
                    children: [],
                    childNodes: [],
                    style: {},
                    setAttribute() {},
                    getElementsByTagName() {
                        return []
                    }
                }
            },
            createElementNS() {
                return {}
            },
            importNode() {
                return null
            },
            location: {
                hash: "",
                host: "",
                hostname: "",
                href: "",
                origin: "",
                pathname: "",
                protocol: "",
                search: ""
            }
        };

        function Ed() {
            const e = "undefined" !== typeof document ? document : {};
            return Sd(e, Td), e
        }
        const Od = {
            document: Td,
            navigator: {
                userAgent: ""
            },
            location: {
                hash: "",
                host: "",
                hostname: "",
                href: "",
                origin: "",
                pathname: "",
                protocol: "",
                search: ""
            },
            history: {
                replaceState() {},
                pushState() {},
                go() {},
                back() {}
            },
            CustomEvent: function() {
                return this
            },
            addEventListener() {},
            removeEventListener() {},
            getComputedStyle() {
                return {
                    getPropertyValue() {
                        return ""
                    }
                }
            },
            Image() {},
            Date() {},
            screen: {},
            setTimeout() {},
            clearTimeout() {},
            matchMedia() {
                return {}
            },
            requestAnimationFrame(e) {
                return "undefined" === typeof setTimeout ? (e(), null) : setTimeout(e, 0)
            },
            cancelAnimationFrame(e) {
                "undefined" !== typeof setTimeout && clearTimeout(e)
            }
        };

        function Md() {
            const e = "undefined" !== typeof window ? window : {};
            return Sd(e, Od), e
        }

        function Id(e) {
            const t = e.__proto__;
            Object.defineProperty(e, "__proto__", {
                get() {
                    return t
                },
                set(e) {
                    t.__proto__ = e
                }
            })
        }
        class Pd extends Array {
            constructor(e) {
                "number" === typeof e ? super(e) : (super(...e || []), Id(this))
            }
        }

        function Bd(e = []) {
            const t = [];
            return e.forEach((e => {
                Array.isArray(e) ? t.push(...Bd(e)) : t.push(e)
            })), t
        }

        function Ld(e, t) {
            return Array.prototype.filter.call(e, t)
        }

        function Fd(e) {
            const t = [];
            for (let n = 0; n < e.length; n += 1) - 1 === t.indexOf(e[n]) && t.push(e[n]);
            return t
        }

        function Dd(e, t) {
            if ("string" !== typeof e) return [e];
            const n = [],
                r = t.querySelectorAll(e);
            for (let o = 0; o < r.length; o += 1) n.push(r[o]);
            return n
        }

        function Nd(e, t) {
            const n = Md(),
                r = Ed();
            let o = [];
            if (!t && e instanceof Pd) return e;
            if (!e) return new Pd(o);
            if ("string" === typeof e) {
                const n = e.trim();
                if (n.indexOf("<") >= 0 && n.indexOf(">") >= 0) {
                    let e = "div";
                    0 === n.indexOf("<li") && (e = "ul"), 0 === n.indexOf("<tr") && (e = "tbody"), 0 !== n.indexOf("<td") && 0 !== n.indexOf("<th") || (e = "tr"), 0 === n.indexOf("<tbody") && (e = "table"), 0 === n.indexOf("<option") && (e = "select");
                    const t = r.createElement(e);
                    t.innerHTML = n;
                    for (let n = 0; n < t.childNodes.length; n += 1) o.push(t.childNodes[n])
                } else o = Dd(e.trim(), t || r)
            } else if (e.nodeType || e === n || e === r) o.push(e);
            else if (Array.isArray(e)) {
                if (e instanceof Pd) return e;
                o = e
            }
            return new Pd(Fd(o))
        }

        function Rd(...e) {
            const t = Bd(e.map((e => e.split(" "))));
            return this.forEach((e => {
                e.classList.add(...t)
            })), this
        }

        function jd(...e) {
            const t = Bd(e.map((e => e.split(" "))));
            return this.forEach((e => {
                e.classList.remove(...t)
            })), this
        }

        function Hd(...e) {
            const t = Bd(e.map((e => e.split(" "))));
            this.forEach((e => {
                t.forEach((t => {
                    e.classList.toggle(t)
                }))
            }))
        }

        function Gd(...e) {
            const t = Bd(e.map((e => e.split(" "))));
            return Ld(this, (e => t.filter((t => e.classList.contains(t))).length > 0)).length > 0
        }

        function zd(e, t) {
            if (1 === arguments.length && "string" === typeof e) return this[0] ? this[0].getAttribute(e) : void 0;
            for (let n = 0; n < this.length; n += 1)
                if (2 === arguments.length) this[n].setAttribute(e, t);
                else
                    for (const t in e) this[n][t] = e[t], this[n].setAttribute(t, e[t]);
            return this
        }

        function $d(e) {
            for (let t = 0; t < this.length; t += 1) this[t].removeAttribute(e);
            return this
        }

        function Vd(e) {
            for (let t = 0; t < this.length; t += 1) this[t].style.transform = e;
            return this
        }

        function Ud(e) {
            for (let t = 0; t < this.length; t += 1) this[t].style.transitionDuration = "string" !== typeof e ? `${e}ms` : e;
            return this
        }

        function Kd(...e) {
            let [t, n, r, o] = e;

            function i(e) {
                const t = e.target;
                if (!t) return;
                const o = e.target.dom7EventData || [];
                if (o.indexOf(e) < 0 && o.unshift(e), Nd(t).is(n)) r.apply(t, o);
                else {
                    const e = Nd(t).parents();
                    for (let t = 0; t < e.length; t += 1) Nd(e[t]).is(n) && r.apply(e[t], o)
                }
            }

            function a(e) {
                const t = e && e.target && e.target.dom7EventData || [];
                t.indexOf(e) < 0 && t.unshift(e), r.apply(this, t)
            }
            "function" === typeof e[1] && ([t, r, o] = e, n = void 0), o || (o = !1);
            const s = t.split(" ");
            let l;
            for (let c = 0; c < this.length; c += 1) {
                const e = this[c];
                if (n)
                    for (l = 0; l < s.length; l += 1) {
                        const t = s[l];
                        e.dom7LiveListeners || (e.dom7LiveListeners = {}), e.dom7LiveListeners[t] || (e.dom7LiveListeners[t] = []), e.dom7LiveListeners[t].push({
                            listener: r,
                            proxyListener: i
                        }), e.addEventListener(t, i, o)
                    } else
                        for (l = 0; l < s.length; l += 1) {
                            const t = s[l];
                            e.dom7Listeners || (e.dom7Listeners = {}), e.dom7Listeners[t] || (e.dom7Listeners[t] = []), e.dom7Listeners[t].push({
                                listener: r,
                                proxyListener: a
                            }), e.addEventListener(t, a, o)
                        }
            }
            return this
        }

        function Yd(...e) {
            let [t, n, r, o] = e;
            "function" === typeof e[1] && ([t, r, o] = e, n = void 0), o || (o = !1);
            const i = t.split(" ");
            for (let a = 0; a < i.length; a += 1) {
                const e = i[a];
                for (let t = 0; t < this.length; t += 1) {
                    const i = this[t];
                    let a;
                    if (!n && i.dom7Listeners ? a = i.dom7Listeners[e] : n && i.dom7LiveListeners && (a = i.dom7LiveListeners[e]), a && a.length)
                        for (let t = a.length - 1; t >= 0; t -= 1) {
                            const n = a[t];
                            r && n.listener === r || r && n.listener && n.listener.dom7proxy && n.listener.dom7proxy === r ? (i.removeEventListener(e, n.proxyListener, o), a.splice(t, 1)) : r || (i.removeEventListener(e, n.proxyListener, o), a.splice(t, 1))
                        }
                }
            }
            return this
        }

        function Wd(...e) {
            const t = Md(),
                n = e[0].split(" "),
                r = e[1];
            for (let o = 0; o < n.length; o += 1) {
                const i = n[o];
                for (let n = 0; n < this.length; n += 1) {
                    const o = this[n];
                    if (t.CustomEvent) {
                        const n = new t.CustomEvent(i, {
                            detail: r,
                            bubbles: !0,
                            cancelable: !0
                        });
                        o.dom7EventData = e.filter(((e, t) => t > 0)), o.dispatchEvent(n), o.dom7EventData = [], delete o.dom7EventData
                    }
                }
            }
            return this
        }

        function Xd(e) {
            const t = this;

            function n(r) {
                r.target === this && (e.call(this, r), t.off("transitionend", n))
            }
            return e && t.on("transitionend", n), this
        }

        function Qd(e) {
            if (this.length > 0) {
                if (e) {
                    const e = this.styles();
                    return this[0].offsetWidth + parseFloat(e.getPropertyValue("margin-right")) + parseFloat(e.getPropertyValue("margin-left"))
                }
                return this[0].offsetWidth
            }
            return null
        }

        function qd(e) {
            if (this.length > 0) {
                if (e) {
                    const e = this.styles();
                    return this[0].offsetHeight + parseFloat(e.getPropertyValue("margin-top")) + parseFloat(e.getPropertyValue("margin-bottom"))
                }
                return this[0].offsetHeight
            }
            return null
        }

        function Zd() {
            if (this.length > 0) {
                const e = Md(),
                    t = Ed(),
                    n = this[0],
                    r = n.getBoundingClientRect(),
                    o = t.body,
                    i = n.clientTop || o.clientTop || 0,
                    a = n.clientLeft || o.clientLeft || 0,
                    s = n === e ? e.scrollY : n.scrollTop,
                    l = n === e ? e.scrollX : n.scrollLeft;
                return {
                    top: r.top + s - i,
                    left: r.left + l - a
                }
            }
            return null
        }

        function Jd() {
            const e = Md();
            return this[0] ? e.getComputedStyle(this[0], null) : {}
        }

        function eu(e, t) {
            const n = Md();
            let r;
            if (1 === arguments.length) {
                if ("string" !== typeof e) {
                    for (r = 0; r < this.length; r += 1)
                        for (const t in e) this[r].style[t] = e[t];
                    return this
                }
                if (this[0]) return n.getComputedStyle(this[0], null).getPropertyValue(e)
            }
            if (2 === arguments.length && "string" === typeof e) {
                for (r = 0; r < this.length; r += 1) this[r].style[e] = t;
                return this
            }
            return this
        }

        function tu(e) {
            return e ? (this.forEach(((t, n) => {
                e.apply(t, [t, n])
            })), this) : this
        }

        function nu(e) {
            const t = Ld(this, e);
            return Nd(t)
        }

        function ru(e) {
            if ("undefined" === typeof e) return this[0] ? this[0].innerHTML : null;
            for (let t = 0; t < this.length; t += 1) this[t].innerHTML = e;
            return this
        }

        function ou(e) {
            if ("undefined" === typeof e) return this[0] ? this[0].textContent.trim() : null;
            for (let t = 0; t < this.length; t += 1) this[t].textContent = e;
            return this
        }

        function iu(e) {
            const t = Md(),
                n = Ed(),
                r = this[0];
            let o, i;
            if (!r || "undefined" === typeof e) return !1;
            if ("string" === typeof e) {
                if (r.matches) return r.matches(e);
                if (r.webkitMatchesSelector) return r.webkitMatchesSelector(e);
                if (r.msMatchesSelector) return r.msMatchesSelector(e);
                for (o = Nd(e), i = 0; i < o.length; i += 1)
                    if (o[i] === r) return !0;
                return !1
            }
            if (e === n) return r === n;
            if (e === t) return r === t;
            if (e.nodeType || e instanceof Pd) {
                for (o = e.nodeType ? [e] : e, i = 0; i < o.length; i += 1)
                    if (o[i] === r) return !0;
                return !1
            }
            return !1
        }

        function au() {
            let e, t = this[0];
            if (t) {
                e = 0;
                while (null !== (t = t.previousSibling)) 1 === t.nodeType && (e += 1);
                return e
            }
        }

        function su(e) {
            if ("undefined" === typeof e) return this;
            const t = this.length;
            if (e > t - 1) return Nd([]);
            if (e < 0) {
                const n = t + e;
                return Nd(n < 0 ? [] : [this[n]])
            }
            return Nd([this[e]])
        }

        function lu(...e) {
            let t;
            const n = Ed();
            for (let r = 0; r < e.length; r += 1) {
                t = e[r];
                for (let e = 0; e < this.length; e += 1)
                    if ("string" === typeof t) {
                        const r = n.createElement("div");
                        r.innerHTML = t;
                        while (r.firstChild) this[e].appendChild(r.firstChild)
                    } else if (t instanceof Pd)
                    for (let n = 0; n < t.length; n += 1) this[e].appendChild(t[n]);
                else this[e].appendChild(t)
            }
            return this
        }

        function cu(e) {
            const t = Ed();
            let n, r;
            for (n = 0; n < this.length; n += 1)
                if ("string" === typeof e) {
                    const o = t.createElement("div");
                    for (o.innerHTML = e, r = o.childNodes.length - 1; r >= 0; r -= 1) this[n].insertBefore(o.childNodes[r], this[n].childNodes[0])
                } else if (e instanceof Pd)
                for (r = 0; r < e.length; r += 1) this[n].insertBefore(e[r], this[n].childNodes[0]);
            else this[n].insertBefore(e, this[n].childNodes[0]);
            return this
        }

        function du(e) {
            return this.length > 0 ? e ? this[0].nextElementSibling && Nd(this[0].nextElementSibling).is(e) ? Nd([this[0].nextElementSibling]) : Nd([]) : this[0].nextElementSibling ? Nd([this[0].nextElementSibling]) : Nd([]) : Nd([])
        }

        function uu(e) {
            const t = [];
            let n = this[0];
            if (!n) return Nd([]);
            while (n.nextElementSibling) {
                const r = n.nextElementSibling;
                e ? Nd(r).is(e) && t.push(r) : t.push(r), n = r
            }
            return Nd(t)
        }

        function pu(e) {
            if (this.length > 0) {
                const t = this[0];
                return e ? t.previousElementSibling && Nd(t.previousElementSibling).is(e) ? Nd([t.previousElementSibling]) : Nd([]) : t.previousElementSibling ? Nd([t.previousElementSibling]) : Nd([])
            }
            return Nd([])
        }

        function fu(e) {
            const t = [];
            let n = this[0];
            if (!n) return Nd([]);
            while (n.previousElementSibling) {
                const r = n.previousElementSibling;
                e ? Nd(r).is(e) && t.push(r) : t.push(r), n = r
            }
            return Nd(t)
        }

        function hu(e) {
            const t = [];
            for (let n = 0; n < this.length; n += 1) null !== this[n].parentNode && (e ? Nd(this[n].parentNode).is(e) && t.push(this[n].parentNode) : t.push(this[n].parentNode));
            return Nd(t)
        }

        function gu(e) {
            const t = [];
            for (let n = 0; n < this.length; n += 1) {
                let r = this[n].parentNode;
                while (r) e ? Nd(r).is(e) && t.push(r) : t.push(r), r = r.parentNode
            }
            return Nd(t)
        }

        function vu(e) {
            let t = this;
            return "undefined" === typeof e ? Nd([]) : (t.is(e) || (t = t.parents(e).eq(0)), t)
        }

        function mu(e) {
            const t = [];
            for (let n = 0; n < this.length; n += 1) {
                const r = this[n].querySelectorAll(e);
                for (let e = 0; e < r.length; e += 1) t.push(r[e])
            }
            return Nd(t)
        }

        function yu(e) {
            const t = [];
            for (let n = 0; n < this.length; n += 1) {
                const r = this[n].children;
                for (let n = 0; n < r.length; n += 1) e && !Nd(r[n]).is(e) || t.push(r[n])
            }
            return Nd(t)
        }

        function bu() {
            for (let e = 0; e < this.length; e += 1) this[e].parentNode && this[e].parentNode.removeChild(this[e]);
            return this
        }
        Nd.fn = Pd.prototype;
        const wu = "resize scroll".split(" ");

        function _u(e) {
            function t(...t) {
                if ("undefined" === typeof t[0]) {
                    for (let t = 0; t < this.length; t += 1) wu.indexOf(e) < 0 && (e in this[t] ? this[t][e]() : Nd(this[t]).trigger(e));
                    return this
                }
                return this.on(e, ...t)
            }
            return t
        }
        _u("click"), _u("blur"), _u("focus"), _u("focusin"), _u("focusout"), _u("keyup"), _u("keydown"), _u("keypress"), _u("submit"), _u("change"), _u("mousedown"), _u("mousemove"), _u("mouseup"), _u("mouseenter"), _u("mouseleave"), _u("mouseout"), _u("mouseover"), _u("touchstart"), _u("touchend"), _u("touchmove"), _u("resize"), _u("scroll");
        const Au = {
            addClass: Rd,
            removeClass: jd,
            hasClass: Gd,
            toggleClass: Hd,
            attr: zd,
            removeAttr: $d,
            transform: Vd,
            transition: Ud,
            on: Kd,
            off: Yd,
            trigger: Wd,
            transitionEnd: Xd,
            outerWidth: Qd,
            outerHeight: qd,
            styles: Jd,
            offset: Zd,
            css: eu,
            each: tu,
            html: ru,
            text: ou,
            is: iu,
            index: au,
            eq: su,
            append: lu,
            prepend: cu,
            next: du,
            nextAll: uu,
            prev: pu,
            prevAll: fu,
            parent: hu,
            parents: gu,
            closest: vu,
            find: mu,
            children: yu,
            filter: nu,
            remove: bu
        };
        Object.keys(Au).forEach((e => {
            Object.defineProperty(Nd.fn, e, {
                value: Au[e],
                writable: !0
            })
        }));
        var xu = Nd;

        function Cu(e) {
            const t = e;
            Object.keys(t).forEach((e => {
                try {
                    t[e] = null
                } catch (n) {}
                try {
                    delete t[e]
                } catch (n) {}
            }))
        }

        function ku(e, t = 0) {
            return setTimeout(e, t)
        }

        function Su() {
            return Date.now()
        }

        function Tu(e) {
            const t = Md();
            let n;
            return t.getComputedStyle && (n = t.getComputedStyle(e, null)), !n && e.currentStyle && (n = e.currentStyle), n || (n = e.style), n
        }

        function Eu(e, t = "x") {
            const n = Md();
            let r, o, i;
            const a = Tu(e, null);
            return n.WebKitCSSMatrix ? (o = a.transform || a.webkitTransform, o.split(",").length > 6 && (o = o.split(", ").map((e => e.replace(",", "."))).join(", ")), i = new n.WebKitCSSMatrix("none" === o ? "" : o)) : (i = a.MozTransform || a.OTransform || a.MsTransform || a.msTransform || a.transform || a.getPropertyValue("transform").replace("translate(", "matrix(1, 0, 0, 1,"), r = i.toString().split(",")), "x" === t && (o = n.WebKitCSSMatrix ? i.m41 : 16 === r.length ? parseFloat(r[12]) : parseFloat(r[4])), "y" === t && (o = n.WebKitCSSMatrix ? i.m42 : 16 === r.length ? parseFloat(r[13]) : parseFloat(r[5])), o || 0
        }

        function Ou(e) {
            return "object" === typeof e && null !== e && e.constructor && "Object" === Object.prototype.toString.call(e).slice(8, -1)
        }

        function Mu(e) {
            return "undefined" !== typeof window && "undefined" !== typeof window.HTMLElement ? e instanceof HTMLElement : e && (1 === e.nodeType || 11 === e.nodeType)
        }

        function Iu(...e) {
            const t = Object(e[0]),
                n = ["__proto__", "constructor", "prototype"];
            for (let r = 1; r < e.length; r += 1) {
                const o = e[r];
                if (void 0 !== o && null !== o && !Mu(o)) {
                    const e = Object.keys(Object(o)).filter((e => n.indexOf(e) < 0));
                    for (let n = 0, r = e.length; n < r; n += 1) {
                        const r = e[n],
                            i = Object.getOwnPropertyDescriptor(o, r);
                        void 0 !== i && i.enumerable && (Ou(t[r]) && Ou(o[r]) ? o[r].__swiper__ ? t[r] = o[r] : Iu(t[r], o[r]) : !Ou(t[r]) && Ou(o[r]) ? (t[r] = {}, o[r].__swiper__ ? t[r] = o[r] : Iu(t[r], o[r])) : t[r] = o[r])
                    }
                }
            }
            return t
        }

        function Pu(e, t, n) {
            e.style.setProperty(t, n)
        }

        function Bu({
            swiper: e,
            targetPosition: t,
            side: n
        }) {
            const r = Md(),
                o = -e.translate;
            let i, a = null;
            const s = e.params.speed;
            e.wrapperEl.style.scrollSnapType = "none", r.cancelAnimationFrame(e.cssModeFrameID);
            const l = t > o ? "next" : "prev",
                c = (e, t) => "next" === l && e >= t || "prev" === l && e <= t,
                d = () => {
                    i = (new Date).getTime(), null === a && (a = i);
                    const l = Math.max(Math.min((i - a) / s, 1), 0),
                        u = .5 - Math.cos(l * Math.PI) / 2;
                    let p = o + u * (t - o);
                    if (c(p, t) && (p = t), e.wrapperEl.scrollTo({
                            [n]: p
                        }), c(p, t)) return e.wrapperEl.style.overflow = "hidden", e.wrapperEl.style.scrollSnapType = "", setTimeout((() => {
                        e.wrapperEl.style.overflow = "", e.wrapperEl.scrollTo({
                            [n]: p
                        })
                    })), void r.cancelAnimationFrame(e.cssModeFrameID);
                    e.cssModeFrameID = r.requestAnimationFrame(d)
                };
            d()
        }
        let Lu, Fu, Du;

        function Nu() {
            const e = Md(),
                t = Ed();
            return {
                smoothScroll: t.documentElement && "scrollBehavior" in t.documentElement.style,
                touch: !!("ontouchstart" in e || e.DocumentTouch && t instanceof e.DocumentTouch),
                passiveListener: function() {
                    let t = !1;
                    try {
                        const n = Object.defineProperty({}, "passive", {
                            get() {
                                t = !0
                            }
                        });
                        e.addEventListener("testPassiveListener", null, n)
                    } catch (n) {}
                    return t
                }(),
                gestures: function() {
                    return "ongesturestart" in e
                }()
            }
        }

        function Ru() {
            return Lu || (Lu = Nu()), Lu
        }

        function ju({
            userAgent: e
        } = {}) {
            const t = Ru(),
                n = Md(),
                r = n.navigator.platform,
                o = e || n.navigator.userAgent,
                i = {
                    ios: !1,
                    android: !1
                },
                a = n.screen.width,
                s = n.screen.height,
                l = o.match(/(Android);?[\s\/]+([\d.]+)?/);
            let c = o.match(/(iPad).*OS\s([\d_]+)/);
            const d = o.match(/(iPod)(.*OS\s([\d_]+))?/),
                u = !c && o.match(/(iPhone\sOS|iOS)\s([\d_]+)/),
                p = "Win32" === r;
            let f = "MacIntel" === r;
            const h = ["1024x1366", "1366x1024", "834x1194", "1194x834", "834x1112", "1112x834", "768x1024", "1024x768", "820x1180", "1180x820", "810x1080", "1080x810"];
            return !c && f && t.touch && h.indexOf(`${a}x${s}`) >= 0 && (c = o.match(/(Version)\/([\d.]+)/), c || (c = [0, 1, "13_0_0"]), f = !1), l && !p && (i.os = "android", i.android = !0), (c || u || d) && (i.os = "ios", i.ios = !0), i
        }

        function Hu(e = {}) {
            return Fu || (Fu = ju(e)), Fu
        }

        function Gu() {
            const e = Md();

            function t() {
                const t = e.navigator.userAgent.toLowerCase();
                return t.indexOf("safari") >= 0 && t.indexOf("chrome") < 0 && t.indexOf("android") < 0
            }
            return {
                isSafari: t(),
                isWebView: /(iPhone|iPod|iPad).*AppleWebKit(?!.*Safari)/i.test(e.navigator.userAgent)
            }
        }

        function zu() {
            return Du || (Du = Gu()), Du
        }

        function $u({
            swiper: e,
            on: t,
            emit: n
        }) {
            const r = Md();
            let o = null,
                i = null;
            const a = () => {
                    e && !e.destroyed && e.initialized && (n("beforeResize"), n("resize"))
                },
                s = () => {
                    e && !e.destroyed && e.initialized && (o = new ResizeObserver((t => {
                        i = r.requestAnimationFrame((() => {
                            const {
                                width: n,
                                height: r
                            } = e;
                            let o = n,
                                i = r;
                            t.forEach((({
                                contentBoxSize: t,
                                contentRect: n,
                                target: r
                            }) => {
                                r && r !== e.el || (o = n ? n.width : (t[0] || t).inlineSize, i = n ? n.height : (t[0] || t).blockSize)
                            })), o === n && i === r || a()
                        }))
                    })), o.observe(e.el))
                },
                l = () => {
                    i && r.cancelAnimationFrame(i), o && o.unobserve && e.el && (o.unobserve(e.el), o = null)
                },
                c = () => {
                    e && !e.destroyed && e.initialized && n("orientationchange")
                };
            t("init", (() => {
                e.params.resizeObserver && "undefined" !== typeof r.ResizeObserver ? s() : (r.addEventListener("resize", a), r.addEventListener("orientationchange", c))
            })), t("destroy", (() => {
                l(), r.removeEventListener("resize", a), r.removeEventListener("orientationchange", c)
            }))
        }

        function Vu({
            swiper: e,
            extendParams: t,
            on: n,
            emit: r
        }) {
            const o = [],
                i = Md(),
                a = (e, t = {}) => {
                    const n = i.MutationObserver || i.WebkitMutationObserver,
                        a = new n((e => {
                            if (1 === e.length) return void r("observerUpdate", e[0]);
                            const t = function() {
                                r("observerUpdate", e[0])
                            };
                            i.requestAnimationFrame ? i.requestAnimationFrame(t) : i.setTimeout(t, 0)
                        }));
                    a.observe(e, {
                        attributes: "undefined" === typeof t.attributes || t.attributes,
                        childList: "undefined" === typeof t.childList || t.childList,
                        characterData: "undefined" === typeof t.characterData || t.characterData
                    }), o.push(a)
                },
                s = () => {
                    if (e.params.observer) {
                        if (e.params.observeParents) {
                            const t = e.$el.parents();
                            for (let e = 0; e < t.length; e += 1) a(t[e])
                        }
                        a(e.$el[0], {
                            childList: e.params.observeSlideChildren
                        }), a(e.$wrapperEl[0], {
                            attributes: !1
                        })
                    }
                },
                l = () => {
                    o.forEach((e => {
                        e.disconnect()
                    })), o.splice(0, o.length)
                };
            t({
                observer: !1,
                observeParents: !1,
                observeSlideChildren: !1
            }), n("init", s), n("destroy", l)
        }
        var Uu = {
            on(e, t, n) {
                const r = this;
                if (!r.eventsListeners || r.destroyed) return r;
                if ("function" !== typeof t) return r;
                const o = n ? "unshift" : "push";
                return e.split(" ").forEach((e => {
                    r.eventsListeners[e] || (r.eventsListeners[e] = []), r.eventsListeners[e][o](t)
                })), r
            },
            once(e, t, n) {
                const r = this;
                if (!r.eventsListeners || r.destroyed) return r;
                if ("function" !== typeof t) return r;

                function o(...n) {
                    r.off(e, o), o.__emitterProxy && delete o.__emitterProxy, t.apply(r, n)
                }
                return o.__emitterProxy = t, r.on(e, o, n)
            },
            onAny(e, t) {
                const n = this;
                if (!n.eventsListeners || n.destroyed) return n;
                if ("function" !== typeof e) return n;
                const r = t ? "unshift" : "push";
                return n.eventsAnyListeners.indexOf(e) < 0 && n.eventsAnyListeners[r](e), n
            },
            offAny(e) {
                const t = this;
                if (!t.eventsListeners || t.destroyed) return t;
                if (!t.eventsAnyListeners) return t;
                const n = t.eventsAnyListeners.indexOf(e);
                return n >= 0 && t.eventsAnyListeners.splice(n, 1), t
            },
            off(e, t) {
                const n = this;
                return !n.eventsListeners || n.destroyed ? n : n.eventsListeners ? (e.split(" ").forEach((e => {
                    "undefined" === typeof t ? n.eventsListeners[e] = [] : n.eventsListeners[e] && n.eventsListeners[e].forEach(((r, o) => {
                        (r === t || r.__emitterProxy && r.__emitterProxy === t) && n.eventsListeners[e].splice(o, 1)
                    }))
                })), n) : n
            },
            emit(...e) {
                const t = this;
                if (!t.eventsListeners || t.destroyed) return t;
                if (!t.eventsListeners) return t;
                let n, r, o;
                "string" === typeof e[0] || Array.isArray(e[0]) ? (n = e[0], r = e.slice(1, e.length), o = t) : (n = e[0].events, r = e[0].data, o = e[0].context || t), r.unshift(o);
                const i = Array.isArray(n) ? n : n.split(" ");
                return i.forEach((e => {
                    t.eventsAnyListeners && t.eventsAnyListeners.length && t.eventsAnyListeners.forEach((t => {
                        t.apply(o, [e, ...r])
                    })), t.eventsListeners && t.eventsListeners[e] && t.eventsListeners[e].forEach((e => {
                        e.apply(o, r)
                    }))
                })), t
            }
        };

        function Ku() {
            const e = this;
            let t, n;
            const r = e.$el;
            t = "undefined" !== typeof e.params.width && null !== e.params.width ? e.params.width : r[0].clientWidth, n = "undefined" !== typeof e.params.height && null !== e.params.height ? e.params.height : r[0].clientHeight, 0 === t && e.isHorizontal() || 0 === n && e.isVertical() || (t = t - parseInt(r.css("padding-left") || 0, 10) - parseInt(r.css("padding-right") || 0, 10), n = n - parseInt(r.css("padding-top") || 0, 10) - parseInt(r.css("padding-bottom") || 0, 10), Number.isNaN(t) && (t = 0), Number.isNaN(n) && (n = 0), Object.assign(e, {
                width: t,
                height: n,
                size: e.isHorizontal() ? t : n
            }))
        }

        function Yu() {
            const e = this;

            function t(t) {
                return e.isHorizontal() ? t : {
                    width: "height",
                    "margin-top": "margin-left",
                    "margin-bottom ": "margin-right",
                    "margin-left": "margin-top",
                    "margin-right": "margin-bottom",
                    "padding-left": "padding-top",
                    "padding-right": "padding-bottom",
                    marginRight: "marginBottom"
                } [t]
            }

            function n(e, n) {
                return parseFloat(e.getPropertyValue(t(n)) || 0)
            }
            const r = e.params,
                {
                    $wrapperEl: o,
                    size: i,
                    rtlTranslate: a,
                    wrongRTL: s
                } = e,
                l = e.virtual && r.virtual.enabled,
                c = l ? e.virtual.slides.length : e.slides.length,
                d = o.children(`.${e.params.slideClass}`),
                u = l ? e.virtual.slides.length : d.length;
            let p = [];
            const f = [],
                h = [];
            let g = r.slidesOffsetBefore;
            "function" === typeof g && (g = r.slidesOffsetBefore.call(e));
            let v = r.slidesOffsetAfter;
            "function" === typeof v && (v = r.slidesOffsetAfter.call(e));
            const m = e.snapGrid.length,
                y = e.slidesGrid.length;
            let b = r.spaceBetween,
                w = -g,
                _ = 0,
                A = 0;
            if ("undefined" === typeof i) return;
            "string" === typeof b && b.indexOf("%") >= 0 && (b = parseFloat(b.replace("%", "")) / 100 * i), e.virtualSize = -b, a ? d.css({
                marginLeft: "",
                marginBottom: "",
                marginTop: ""
            }) : d.css({
                marginRight: "",
                marginBottom: "",
                marginTop: ""
            }), r.centeredSlides && r.cssMode && (Pu(e.wrapperEl, "--swiper-centered-offset-before", ""), Pu(e.wrapperEl, "--swiper-centered-offset-after", ""));
            const x = r.grid && r.grid.rows > 1 && e.grid;
            let C;
            x && e.grid.initSlides(u);
            const k = "auto" === r.slidesPerView && r.breakpoints && Object.keys(r.breakpoints).filter((e => "undefined" !== typeof r.breakpoints[e].slidesPerView)).length > 0;
            for (let S = 0; S < u; S += 1) {
                C = 0;
                const o = d.eq(S);
                if (x && e.grid.updateSlide(S, o, u, t), "none" !== o.css("display")) {
                    if ("auto" === r.slidesPerView) {
                        k && (d[S].style[t("width")] = "");
                        const i = getComputedStyle(o[0]),
                            a = o[0].style.transform,
                            s = o[0].style.webkitTransform;
                        if (a && (o[0].style.transform = "none"), s && (o[0].style.webkitTransform = "none"), r.roundLengths) C = e.isHorizontal() ? o.outerWidth(!0) : o.outerHeight(!0);
                        else {
                            const e = n(i, "width"),
                                t = n(i, "padding-left"),
                                r = n(i, "padding-right"),
                                a = n(i, "margin-left"),
                                s = n(i, "margin-right"),
                                l = i.getPropertyValue("box-sizing");
                            if (l && "border-box" === l) C = e + a + s;
                            else {
                                const {
                                    clientWidth: n,
                                    offsetWidth: i
                                } = o[0];
                                C = e + t + r + a + s + (i - n)
                            }
                        }
                        a && (o[0].style.transform = a), s && (o[0].style.webkitTransform = s), r.roundLengths && (C = Math.floor(C))
                    } else C = (i - (r.slidesPerView - 1) * b) / r.slidesPerView, r.roundLengths && (C = Math.floor(C)), d[S] && (d[S].style[t("width")] = `${C}px`);
                    d[S] && (d[S].swiperSlideSize = C), h.push(C), r.centeredSlides ? (w = w + C / 2 + _ / 2 + b, 0 === _ && 0 !== S && (w = w - i / 2 - b), 0 === S && (w = w - i / 2 - b), Math.abs(w) < .001 && (w = 0), r.roundLengths && (w = Math.floor(w)), A % r.slidesPerGroup === 0 && p.push(w), f.push(w)) : (r.roundLengths && (w = Math.floor(w)), (A - Math.min(e.params.slidesPerGroupSkip, A)) % e.params.slidesPerGroup === 0 && p.push(w), f.push(w), w = w + C + b), e.virtualSize += C + b, _ = C, A += 1
                }
            }
            if (e.virtualSize = Math.max(e.virtualSize, i) + v, a && s && ("slide" === r.effect || "coverflow" === r.effect) && o.css({
                    width: `${e.virtualSize+r.spaceBetween}px`
                }), r.setWrapperSize && o.css({
                    [t("width")]: `${e.virtualSize+r.spaceBetween}px`
                }), x && e.grid.updateWrapperSize(C, p, t), !r.centeredSlides) {
                const t = [];
                for (let n = 0; n < p.length; n += 1) {
                    let o = p[n];
                    r.roundLengths && (o = Math.floor(o)), p[n] <= e.virtualSize - i && t.push(o)
                }
                p = t, Math.floor(e.virtualSize - i) - Math.floor(p[p.length - 1]) > 1 && p.push(e.virtualSize - i)
            }
            if (0 === p.length && (p = [0]), 0 !== r.spaceBetween) {
                const n = e.isHorizontal() && a ? "marginLeft" : t("marginRight");
                d.filter(((e, t) => !r.cssMode || t !== d.length - 1)).css({
                    [n]: `${b}px`
                })
            }
            if (r.centeredSlides && r.centeredSlidesBounds) {
                let e = 0;
                h.forEach((t => {
                    e += t + (r.spaceBetween ? r.spaceBetween : 0)
                })), e -= r.spaceBetween;
                const t = e - i;
                p = p.map((e => e < 0 ? -g : e > t ? t + v : e))
            }
            if (r.centerInsufficientSlides) {
                let e = 0;
                if (h.forEach((t => {
                        e += t + (r.spaceBetween ? r.spaceBetween : 0)
                    })), e -= r.spaceBetween, e < i) {
                    const t = (i - e) / 2;
                    p.forEach(((e, n) => {
                        p[n] = e - t
                    })), f.forEach(((e, n) => {
                        f[n] = e + t
                    }))
                }
            }
            if (Object.assign(e, {
                    slides: d,
                    snapGrid: p,
                    slidesGrid: f,
                    slidesSizesGrid: h
                }), r.centeredSlides && r.cssMode && !r.centeredSlidesBounds) {
                Pu(e.wrapperEl, "--swiper-centered-offset-before", -p[0] + "px"), Pu(e.wrapperEl, "--swiper-centered-offset-after", e.size / 2 - h[h.length - 1] / 2 + "px");
                const t = -e.snapGrid[0],
                    n = -e.slidesGrid[0];
                e.snapGrid = e.snapGrid.map((e => e + t)), e.slidesGrid = e.slidesGrid.map((e => e + n))
            }
            if (u !== c && e.emit("slidesLengthChange"), p.length !== m && (e.params.watchOverflow && e.checkOverflow(), e.emit("snapGridLengthChange")), f.length !== y && e.emit("slidesGridLengthChange"), r.watchSlidesProgress && e.updateSlidesOffset(), !l && !r.cssMode && ("slide" === r.effect || "fade" === r.effect)) {
                const t = `${r.containerModifierClass}backface-hidden`,
                    n = e.$el.hasClass(t);
                u <= r.maxBackfaceHiddenSlides ? n || e.$el.addClass(t) : n && e.$el.removeClass(t)
            }
        }

        function Wu(e) {
            const t = this,
                n = [],
                r = t.virtual && t.params.virtual.enabled;
            let o, i = 0;
            "number" === typeof e ? t.setTransition(e) : !0 === e && t.setTransition(t.params.speed);
            const a = e => r ? t.slides.filter((t => parseInt(t.getAttribute("data-swiper-slide-index"), 10) === e))[0] : t.slides.eq(e)[0];
            if ("auto" !== t.params.slidesPerView && t.params.slidesPerView > 1)
                if (t.params.centeredSlides)(t.visibleSlides || xu([])).each((e => {
                    n.push(e)
                }));
                else
                    for (o = 0; o < Math.ceil(t.params.slidesPerView); o += 1) {
                        const e = t.activeIndex + o;
                        if (e > t.slides.length && !r) break;
                        n.push(a(e))
                    } else n.push(a(t.activeIndex));
            for (o = 0; o < n.length; o += 1)
                if ("undefined" !== typeof n[o]) {
                    const e = n[o].offsetHeight;
                    i = e > i ? e : i
                }(i || 0 === i) && t.$wrapperEl.css("height", `${i}px`)
        }

        function Xu() {
            const e = this,
                t = e.slides;
            for (let n = 0; n < t.length; n += 1) t[n].swiperSlideOffset = e.isHorizontal() ? t[n].offsetLeft : t[n].offsetTop
        }

        function Qu(e = this && this.translate || 0) {
            const t = this,
                n = t.params,
                {
                    slides: r,
                    rtlTranslate: o,
                    snapGrid: i
                } = t;
            if (0 === r.length) return;
            "undefined" === typeof r[0].swiperSlideOffset && t.updateSlidesOffset();
            let a = -e;
            o && (a = e), r.removeClass(n.slideVisibleClass), t.visibleSlidesIndexes = [], t.visibleSlides = [];
            for (let s = 0; s < r.length; s += 1) {
                const e = r[s];
                let l = e.swiperSlideOffset;
                n.cssMode && n.centeredSlides && (l -= r[0].swiperSlideOffset);
                const c = (a + (n.centeredSlides ? t.minTranslate() : 0) - l) / (e.swiperSlideSize + n.spaceBetween),
                    d = (a - i[0] + (n.centeredSlides ? t.minTranslate() : 0) - l) / (e.swiperSlideSize + n.spaceBetween),
                    u = -(a - l),
                    p = u + t.slidesSizesGrid[s],
                    f = u >= 0 && u < t.size - 1 || p > 1 && p <= t.size || u <= 0 && p >= t.size;
                f && (t.visibleSlides.push(e), t.visibleSlidesIndexes.push(s), r.eq(s).addClass(n.slideVisibleClass)), e.progress = o ? -c : c, e.originalProgress = o ? -d : d
            }
            t.visibleSlides = xu(t.visibleSlides)
        }

        function qu(e) {
            const t = this;
            if ("undefined" === typeof e) {
                const n = t.rtlTranslate ? -1 : 1;
                e = t && t.translate && t.translate * n || 0
            }
            const n = t.params,
                r = t.maxTranslate() - t.minTranslate();
            let {
                progress: o,
                isBeginning: i,
                isEnd: a
            } = t;
            const s = i,
                l = a;
            0 === r ? (o = 0, i = !0, a = !0) : (o = (e - t.minTranslate()) / r, i = o <= 0, a = o >= 1), Object.assign(t, {
                progress: o,
                isBeginning: i,
                isEnd: a
            }), (n.watchSlidesProgress || n.centeredSlides && n.autoHeight) && t.updateSlidesProgress(e), i && !s && t.emit("reachBeginning toEdge"), a && !l && t.emit("reachEnd toEdge"), (s && !i || l && !a) && t.emit("fromEdge"), t.emit("progress", o)
        }

        function Zu() {
            const e = this,
                {
                    slides: t,
                    params: n,
                    $wrapperEl: r,
                    activeIndex: o,
                    realIndex: i
                } = e,
                a = e.virtual && n.virtual.enabled;
            let s;
            t.removeClass(`${n.slideActiveClass} ${n.slideNextClass} ${n.slidePrevClass} ${n.slideDuplicateActiveClass} ${n.slideDuplicateNextClass} ${n.slideDuplicatePrevClass}`), s = a ? e.$wrapperEl.find(`.${n.slideClass}[data-swiper-slide-index="${o}"]`) : t.eq(o), s.addClass(n.slideActiveClass), n.loop && (s.hasClass(n.slideDuplicateClass) ? r.children(`.${n.slideClass}:not(.${n.slideDuplicateClass})[data-swiper-slide-index="${i}"]`).addClass(n.slideDuplicateActiveClass) : r.children(`.${n.slideClass}.${n.slideDuplicateClass}[data-swiper-slide-index="${i}"]`).addClass(n.slideDuplicateActiveClass));
            let l = s.nextAll(`.${n.slideClass}`).eq(0).addClass(n.slideNextClass);
            n.loop && 0 === l.length && (l = t.eq(0), l.addClass(n.slideNextClass));
            let c = s.prevAll(`.${n.slideClass}`).eq(0).addClass(n.slidePrevClass);
            n.loop && 0 === c.length && (c = t.eq(-1), c.addClass(n.slidePrevClass)), n.loop && (l.hasClass(n.slideDuplicateClass) ? r.children(`.${n.slideClass}:not(.${n.slideDuplicateClass})[data-swiper-slide-index="${l.attr("data-swiper-slide-index")}"]`).addClass(n.slideDuplicateNextClass) : r.children(`.${n.slideClass}.${n.slideDuplicateClass}[data-swiper-slide-index="${l.attr("data-swiper-slide-index")}"]`).addClass(n.slideDuplicateNextClass), c.hasClass(n.slideDuplicateClass) ? r.children(`.${n.slideClass}:not(.${n.slideDuplicateClass})[data-swiper-slide-index="${c.attr("data-swiper-slide-index")}"]`).addClass(n.slideDuplicatePrevClass) : r.children(`.${n.slideClass}.${n.slideDuplicateClass}[data-swiper-slide-index="${c.attr("data-swiper-slide-index")}"]`).addClass(n.slideDuplicatePrevClass)), e.emitSlidesClasses()
        }

        function Ju(e) {
            const t = this,
                n = t.rtlTranslate ? t.translate : -t.translate,
                {
                    slidesGrid: r,
                    snapGrid: o,
                    params: i,
                    activeIndex: a,
                    realIndex: s,
                    snapIndex: l
                } = t;
            let c, d = e;
            if ("undefined" === typeof d) {
                for (let e = 0; e < r.length; e += 1) "undefined" !== typeof r[e + 1] ? n >= r[e] && n < r[e + 1] - (r[e + 1] - r[e]) / 2 ? d = e : n >= r[e] && n < r[e + 1] && (d = e + 1) : n >= r[e] && (d = e);
                i.normalizeSlideIndex && (d < 0 || "undefined" === typeof d) && (d = 0)
            }
            if (o.indexOf(n) >= 0) c = o.indexOf(n);
            else {
                const e = Math.min(i.slidesPerGroupSkip, d);
                c = e + Math.floor((d - e) / i.slidesPerGroup)
            }
            if (c >= o.length && (c = o.length - 1), d === a) return void(c !== l && (t.snapIndex = c, t.emit("snapIndexChange")));
            const u = parseInt(t.slides.eq(d).attr("data-swiper-slide-index") || d, 10);
            Object.assign(t, {
                snapIndex: c,
                realIndex: u,
                previousIndex: a,
                activeIndex: d
            }), t.emit("activeIndexChange"), t.emit("snapIndexChange"), s !== u && t.emit("realIndexChange"), (t.initialized || t.params.runCallbacksOnInit) && t.emit("slideChange")
        }

        function ep(e) {
            const t = this,
                n = t.params,
                r = xu(e).closest(`.${n.slideClass}`)[0];
            let o, i = !1;
            if (r)
                for (let a = 0; a < t.slides.length; a += 1)
                    if (t.slides[a] === r) {
                        i = !0, o = a;
                        break
                    } if (!r || !i) return t.clickedSlide = void 0, void(t.clickedIndex = void 0);
            t.clickedSlide = r, t.virtual && t.params.virtual.enabled ? t.clickedIndex = parseInt(xu(r).attr("data-swiper-slide-index"), 10) : t.clickedIndex = o, n.slideToClickedSlide && void 0 !== t.clickedIndex && t.clickedIndex !== t.activeIndex && t.slideToClickedSlide()
        }
        var tp = {
            updateSize: Ku,
            updateSlides: Yu,
            updateAutoHeight: Wu,
            updateSlidesOffset: Xu,
            updateSlidesProgress: Qu,
            updateProgress: qu,
            updateSlidesClasses: Zu,
            updateActiveIndex: Ju,
            updateClickedSlide: ep
        };

        function np(e = (this.isHorizontal() ? "x" : "y")) {
            const t = this,
                {
                    params: n,
                    rtlTranslate: r,
                    translate: o,
                    $wrapperEl: i
                } = t;
            if (n.virtualTranslate) return r ? -o : o;
            if (n.cssMode) return o;
            let a = Eu(i[0], e);
            return r && (a = -a), a || 0
        }

        function rp(e, t) {
            const n = this,
                {
                    rtlTranslate: r,
                    params: o,
                    $wrapperEl: i,
                    wrapperEl: a,
                    progress: s
                } = n;
            let l = 0,
                c = 0;
            const d = 0;
            let u;
            n.isHorizontal() ? l = r ? -e : e : c = e, o.roundLengths && (l = Math.floor(l), c = Math.floor(c)), o.cssMode ? a[n.isHorizontal() ? "scrollLeft" : "scrollTop"] = n.isHorizontal() ? -l : -c : o.virtualTranslate || i.transform(`translate3d(${l}px, ${c}px, ${d}px)`), n.previousTranslate = n.translate, n.translate = n.isHorizontal() ? l : c;
            const p = n.maxTranslate() - n.minTranslate();
            u = 0 === p ? 0 : (e - n.minTranslate()) / p, u !== s && n.updateProgress(e), n.emit("setTranslate", n.translate, t)
        }

        function op() {
            return -this.snapGrid[0]
        }

        function ip() {
            return -this.snapGrid[this.snapGrid.length - 1]
        }

        function ap(e = 0, t = this.params.speed, n = !0, r = !0, o) {
            const i = this,
                {
                    params: a,
                    wrapperEl: s
                } = i;
            if (i.animating && a.preventInteractionOnTransition) return !1;
            const l = i.minTranslate(),
                c = i.maxTranslate();
            let d;
            if (d = r && e > l ? l : r && e < c ? c : e, i.updateProgress(d), a.cssMode) {
                const e = i.isHorizontal();
                if (0 === t) s[e ? "scrollLeft" : "scrollTop"] = -d;
                else {
                    if (!i.support.smoothScroll) return Bu({
                        swiper: i,
                        targetPosition: -d,
                        side: e ? "left" : "top"
                    }), !0;
                    s.scrollTo({
                        [e ? "left" : "top"]: -d,
                        behavior: "smooth"
                    })
                }
                return !0
            }
            return 0 === t ? (i.setTransition(0), i.setTranslate(d), n && (i.emit("beforeTransitionStart", t, o), i.emit("transitionEnd"))) : (i.setTransition(t), i.setTranslate(d), n && (i.emit("beforeTransitionStart", t, o), i.emit("transitionStart")), i.animating || (i.animating = !0, i.onTranslateToWrapperTransitionEnd || (i.onTranslateToWrapperTransitionEnd = function(e) {
                i && !i.destroyed && e.target === this && (i.$wrapperEl[0].removeEventListener("transitionend", i.onTranslateToWrapperTransitionEnd), i.$wrapperEl[0].removeEventListener("webkitTransitionEnd", i.onTranslateToWrapperTransitionEnd), i.onTranslateToWrapperTransitionEnd = null, delete i.onTranslateToWrapperTransitionEnd, n && i.emit("transitionEnd"))
            }), i.$wrapperEl[0].addEventListener("transitionend", i.onTranslateToWrapperTransitionEnd), i.$wrapperEl[0].addEventListener("webkitTransitionEnd", i.onTranslateToWrapperTransitionEnd))), !0
        }
        var sp = {
            getTranslate: np,
            setTranslate: rp,
            minTranslate: op,
            maxTranslate: ip,
            translateTo: ap
        };

        function lp(e, t) {
            const n = this;
            n.params.cssMode || n.$wrapperEl.transition(e), n.emit("setTransition", e, t)
        }

        function cp({
            swiper: e,
            runCallbacks: t,
            direction: n,
            step: r
        }) {
            const {
                activeIndex: o,
                previousIndex: i
            } = e;
            let a = n;
            if (a || (a = o > i ? "next" : o < i ? "prev" : "reset"), e.emit(`transition${r}`), t && o !== i) {
                if ("reset" === a) return void e.emit(`slideResetTransition${r}`);
                e.emit(`slideChangeTransition${r}`), "next" === a ? e.emit(`slideNextTransition${r}`) : e.emit(`slidePrevTransition${r}`)
            }
        }

        function dp(e = !0, t) {
            const n = this,
                {
                    params: r
                } = n;
            r.cssMode || (r.autoHeight && n.updateAutoHeight(), cp({
                swiper: n,
                runCallbacks: e,
                direction: t,
                step: "Start"
            }))
        }

        function up(e = !0, t) {
            const n = this,
                {
                    params: r
                } = n;
            n.animating = !1, r.cssMode || (n.setTransition(0), cp({
                swiper: n,
                runCallbacks: e,
                direction: t,
                step: "End"
            }))
        }
        var pp = {
            setTransition: lp,
            transitionStart: dp,
            transitionEnd: up
        };

        function fp(e = 0, t = this.params.speed, n = !0, r, o) {
            if ("number" !== typeof e && "string" !== typeof e) throw new Error(`The 'index' argument cannot have type other than 'number' or 'string'. [${typeof e}] given.`);
            if ("string" === typeof e) {
                const t = parseInt(e, 10),
                    n = isFinite(t);
                if (!n) throw new Error(`The passed-in 'index' (string) couldn't be converted to 'number'. [${e}] given.`);
                e = t
            }
            const i = this;
            let a = e;
            a < 0 && (a = 0);
            const {
                params: s,
                snapGrid: l,
                slidesGrid: c,
                previousIndex: d,
                activeIndex: u,
                rtlTranslate: p,
                wrapperEl: f,
                enabled: h
            } = i;
            if (i.animating && s.preventInteractionOnTransition || !h && !r && !o) return !1;
            const g = Math.min(i.params.slidesPerGroupSkip, a);
            let v = g + Math.floor((a - g) / i.params.slidesPerGroup);
            v >= l.length && (v = l.length - 1);
            const m = -l[v];
            if (s.normalizeSlideIndex)
                for (let b = 0; b < c.length; b += 1) {
                    const e = -Math.floor(100 * m),
                        t = Math.floor(100 * c[b]),
                        n = Math.floor(100 * c[b + 1]);
                    "undefined" !== typeof c[b + 1] ? e >= t && e < n - (n - t) / 2 ? a = b : e >= t && e < n && (a = b + 1) : e >= t && (a = b)
                }
            if (i.initialized && a !== u) {
                if (!i.allowSlideNext && m < i.translate && m < i.minTranslate()) return !1;
                if (!i.allowSlidePrev && m > i.translate && m > i.maxTranslate() && (u || 0) !== a) return !1
            }
            let y;
            if (a !== (d || 0) && n && i.emit("beforeSlideChangeStart"), i.updateProgress(m), y = a > u ? "next" : a < u ? "prev" : "reset", p && -m === i.translate || !p && m === i.translate) return i.updateActiveIndex(a), s.autoHeight && i.updateAutoHeight(), i.updateSlidesClasses(), "slide" !== s.effect && i.setTranslate(m), "reset" !== y && (i.transitionStart(n, y), i.transitionEnd(n, y)), !1;
            if (s.cssMode) {
                const e = i.isHorizontal(),
                    n = p ? m : -m;
                if (0 === t) {
                    const t = i.virtual && i.params.virtual.enabled;
                    t && (i.wrapperEl.style.scrollSnapType = "none", i._immediateVirtual = !0), f[e ? "scrollLeft" : "scrollTop"] = n, t && requestAnimationFrame((() => {
                        i.wrapperEl.style.scrollSnapType = "", i._swiperImmediateVirtual = !1
                    }))
                } else {
                    if (!i.support.smoothScroll) return Bu({
                        swiper: i,
                        targetPosition: n,
                        side: e ? "left" : "top"
                    }), !0;
                    f.scrollTo({
                        [e ? "left" : "top"]: n,
                        behavior: "smooth"
                    })
                }
                return !0
            }
            return i.setTransition(t), i.setTranslate(m), i.updateActiveIndex(a), i.updateSlidesClasses(), i.emit("beforeTransitionStart", t, r), i.transitionStart(n, y), 0 === t ? i.transitionEnd(n, y) : i.animating || (i.animating = !0, i.onSlideToWrapperTransitionEnd || (i.onSlideToWrapperTransitionEnd = function(e) {
                i && !i.destroyed && e.target === this && (i.$wrapperEl[0].removeEventListener("transitionend", i.onSlideToWrapperTransitionEnd), i.$wrapperEl[0].removeEventListener("webkitTransitionEnd", i.onSlideToWrapperTransitionEnd), i.onSlideToWrapperTransitionEnd = null, delete i.onSlideToWrapperTransitionEnd, i.transitionEnd(n, y))
            }), i.$wrapperEl[0].addEventListener("transitionend", i.onSlideToWrapperTransitionEnd), i.$wrapperEl[0].addEventListener("webkitTransitionEnd", i.onSlideToWrapperTransitionEnd)), !0
        }

        function hp(e = 0, t = this.params.speed, n = !0, r) {
            if ("string" === typeof e) {
                const t = parseInt(e, 10),
                    n = isFinite(t);
                if (!n) throw new Error(`The passed-in 'index' (string) couldn't be converted to 'number'. [${e}] given.`);
                e = t
            }
            const o = this;
            let i = e;
            return o.params.loop && (i += o.loopedSlides), o.slideTo(i, t, n, r)
        }

        function gp(e = this.params.speed, t = !0, n) {
            const r = this,
                {
                    animating: o,
                    enabled: i,
                    params: a
                } = r;
            if (!i) return r;
            let s = a.slidesPerGroup;
            "auto" === a.slidesPerView && 1 === a.slidesPerGroup && a.slidesPerGroupAuto && (s = Math.max(r.slidesPerViewDynamic("current", !0), 1));
            const l = r.activeIndex < a.slidesPerGroupSkip ? 1 : s;
            if (a.loop) {
                if (o && a.loopPreventsSlide) return !1;
                r.loopFix(), r._clientLeft = r.$wrapperEl[0].clientLeft
            }
            return a.rewind && r.isEnd ? r.slideTo(0, e, t, n) : r.slideTo(r.activeIndex + l, e, t, n)
        }

        function vp(e = this.params.speed, t = !0, n) {
            const r = this,
                {
                    params: o,
                    animating: i,
                    snapGrid: a,
                    slidesGrid: s,
                    rtlTranslate: l,
                    enabled: c
                } = r;
            if (!c) return r;
            if (o.loop) {
                if (i && o.loopPreventsSlide) return !1;
                r.loopFix(), r._clientLeft = r.$wrapperEl[0].clientLeft
            }
            const d = l ? r.translate : -r.translate;

            function u(e) {
                return e < 0 ? -Math.floor(Math.abs(e)) : Math.floor(e)
            }
            const p = u(d),
                f = a.map((e => u(e)));
            let h = a[f.indexOf(p) - 1];
            if ("undefined" === typeof h && o.cssMode) {
                let e;
                a.forEach(((t, n) => {
                    p >= t && (e = n)
                })), "undefined" !== typeof e && (h = a[e > 0 ? e - 1 : e])
            }
            let g = 0;
            if ("undefined" !== typeof h && (g = s.indexOf(h), g < 0 && (g = r.activeIndex - 1), "auto" === o.slidesPerView && 1 === o.slidesPerGroup && o.slidesPerGroupAuto && (g = g - r.slidesPerViewDynamic("previous", !0) + 1, g = Math.max(g, 0))), o.rewind && r.isBeginning) {
                const o = r.params.virtual && r.params.virtual.enabled && r.virtual ? r.virtual.slides.length - 1 : r.slides.length - 1;
                return r.slideTo(o, e, t, n)
            }
            return r.slideTo(g, e, t, n)
        }

        function mp(e = this.params.speed, t = !0, n) {
            const r = this;
            return r.slideTo(r.activeIndex, e, t, n)
        }

        function yp(e = this.params.speed, t = !0, n, r = .5) {
            const o = this;
            let i = o.activeIndex;
            const a = Math.min(o.params.slidesPerGroupSkip, i),
                s = a + Math.floor((i - a) / o.params.slidesPerGroup),
                l = o.rtlTranslate ? o.translate : -o.translate;
            if (l >= o.snapGrid[s]) {
                const e = o.snapGrid[s],
                    t = o.snapGrid[s + 1];
                l - e > (t - e) * r && (i += o.params.slidesPerGroup)
            } else {
                const e = o.snapGrid[s - 1],
                    t = o.snapGrid[s];
                l - e <= (t - e) * r && (i -= o.params.slidesPerGroup)
            }
            return i = Math.max(i, 0), i = Math.min(i, o.slidesGrid.length - 1), o.slideTo(i, e, t, n)
        }

        function bp() {
            const e = this,
                {
                    params: t,
                    $wrapperEl: n
                } = e,
                r = "auto" === t.slidesPerView ? e.slidesPerViewDynamic() : t.slidesPerView;
            let o, i = e.clickedIndex;
            if (t.loop) {
                if (e.animating) return;
                o = parseInt(xu(e.clickedSlide).attr("data-swiper-slide-index"), 10), t.centeredSlides ? i < e.loopedSlides - r / 2 || i > e.slides.length - e.loopedSlides + r / 2 ? (e.loopFix(), i = n.children(`.${t.slideClass}[data-swiper-slide-index="${o}"]:not(.${t.slideDuplicateClass})`).eq(0).index(), ku((() => {
                    e.slideTo(i)
                }))) : e.slideTo(i) : i > e.slides.length - r ? (e.loopFix(), i = n.children(`.${t.slideClass}[data-swiper-slide-index="${o}"]:not(.${t.slideDuplicateClass})`).eq(0).index(), ku((() => {
                    e.slideTo(i)
                }))) : e.slideTo(i)
            } else e.slideTo(i)
        }
        var wp = {
            slideTo: fp,
            slideToLoop: hp,
            slideNext: gp,
            slidePrev: vp,
            slideReset: mp,
            slideToClosest: yp,
            slideToClickedSlide: bp
        };

        function _p() {
            const e = this,
                t = Ed(),
                {
                    params: n,
                    $wrapperEl: r
                } = e,
                o = r.children().length > 0 ? xu(r.children()[0].parentNode) : r;
            o.children(`.${n.slideClass}.${n.slideDuplicateClass}`).remove();
            let i = o.children(`.${n.slideClass}`);
            if (n.loopFillGroupWithBlank) {
                const e = n.slidesPerGroup - i.length % n.slidesPerGroup;
                if (e !== n.slidesPerGroup) {
                    for (let r = 0; r < e; r += 1) {
                        const e = xu(t.createElement("div")).addClass(`${n.slideClass} ${n.slideBlankClass}`);
                        o.append(e)
                    }
                    i = o.children(`.${n.slideClass}`)
                }
            }
            "auto" !== n.slidesPerView || n.loopedSlides || (n.loopedSlides = i.length), e.loopedSlides = Math.ceil(parseFloat(n.loopedSlides || n.slidesPerView, 10)), e.loopedSlides += n.loopAdditionalSlides, e.loopedSlides > i.length && e.params.loopedSlidesLimit && (e.loopedSlides = i.length);
            const a = [],
                s = [];
            i.each(((e, t) => {
                const n = xu(e);
                n.attr("data-swiper-slide-index", t)
            }));
            for (let l = 0; l < e.loopedSlides; l += 1) {
                const e = l - Math.floor(l / i.length) * i.length;
                s.push(i.eq(e)[0]), a.unshift(i.eq(i.length - e - 1)[0])
            }
            for (let l = 0; l < s.length; l += 1) o.append(xu(s[l].cloneNode(!0)).addClass(n.slideDuplicateClass));
            for (let l = a.length - 1; l >= 0; l -= 1) o.prepend(xu(a[l].cloneNode(!0)).addClass(n.slideDuplicateClass))
        }

        function Ap() {
            const e = this;
            e.emit("beforeLoopFix");
            const {
                activeIndex: t,
                slides: n,
                loopedSlides: r,
                allowSlidePrev: o,
                allowSlideNext: i,
                snapGrid: a,
                rtlTranslate: s
            } = e;
            let l;
            e.allowSlidePrev = !0, e.allowSlideNext = !0;
            const c = -a[t],
                d = c - e.getTranslate();
            if (t < r) {
                l = n.length - 3 * r + t, l += r;
                const o = e.slideTo(l, 0, !1, !0);
                o && 0 !== d && e.setTranslate((s ? -e.translate : e.translate) - d)
            } else if (t >= n.length - r) {
                l = -n.length + t + r, l += r;
                const o = e.slideTo(l, 0, !1, !0);
                o && 0 !== d && e.setTranslate((s ? -e.translate : e.translate) - d)
            }
            e.allowSlidePrev = o, e.allowSlideNext = i, e.emit("loopFix")
        }

        function xp() {
            const e = this,
                {
                    $wrapperEl: t,
                    params: n,
                    slides: r
                } = e;
            t.children(`.${n.slideClass}.${n.slideDuplicateClass},.${n.slideClass}.${n.slideBlankClass}`).remove(), r.removeAttr("data-swiper-slide-index")
        }
        var Cp = {
            loopCreate: _p,
            loopFix: Ap,
            loopDestroy: xp
        };

        function kp(e) {
            const t = this;
            if (t.support.touch || !t.params.simulateTouch || t.params.watchOverflow && t.isLocked || t.params.cssMode) return;
            const n = "container" === t.params.touchEventsTarget ? t.el : t.wrapperEl;
            n.style.cursor = "move", n.style.cursor = e ? "grabbing" : "grab"
        }

        function Sp() {
            const e = this;
            e.support.touch || e.params.watchOverflow && e.isLocked || e.params.cssMode || (e["container" === e.params.touchEventsTarget ? "el" : "wrapperEl"].style.cursor = "")
        }
        var Tp = {
            setGrabCursor: kp,
            unsetGrabCursor: Sp
        };

        function Ep(e, t = this) {
            function n(t) {
                if (!t || t === Ed() || t === Md()) return null;
                t.assignedSlot && (t = t.assignedSlot);
                const r = t.closest(e);
                return r || t.getRootNode ? r || n(t.getRootNode().host) : null
            }
            return n(t)
        }

        function Op(e) {
            const t = this,
                n = Ed(),
                r = Md(),
                o = t.touchEventsData,
                {
                    params: i,
                    touches: a,
                    enabled: s
                } = t;
            if (!s) return;
            if (t.animating && i.preventInteractionOnTransition) return;
            !t.animating && i.cssMode && i.loop && t.loopFix();
            let l = e;
            l.originalEvent && (l = l.originalEvent);
            let c = xu(l.target);
            if ("wrapper" === i.touchEventsTarget && !c.closest(t.wrapperEl).length) return;
            if (o.isTouchEvent = "touchstart" === l.type, !o.isTouchEvent && "which" in l && 3 === l.which) return;
            if (!o.isTouchEvent && "button" in l && l.button > 0) return;
            if (o.isTouched && o.isMoved) return;
            const d = !!i.noSwipingClass && "" !== i.noSwipingClass,
                u = e.composedPath ? e.composedPath() : e.path;
            d && l.target && l.target.shadowRoot && u && (c = xu(u[0]));
            const p = i.noSwipingSelector ? i.noSwipingSelector : `.${i.noSwipingClass}`,
                f = !(!l.target || !l.target.shadowRoot);
            if (i.noSwiping && (f ? Ep(p, c[0]) : c.closest(p)[0])) return void(t.allowClick = !0);
            if (i.swipeHandler && !c.closest(i.swipeHandler)[0]) return;
            a.currentX = "touchstart" === l.type ? l.targetTouches[0].pageX : l.pageX, a.currentY = "touchstart" === l.type ? l.targetTouches[0].pageY : l.pageY;
            const h = a.currentX,
                g = a.currentY,
                v = i.edgeSwipeDetection || i.iOSEdgeSwipeDetection,
                m = i.edgeSwipeThreshold || i.iOSEdgeSwipeThreshold;
            if (v && (h <= m || h >= r.innerWidth - m)) {
                if ("prevent" !== v) return;
                e.preventDefault()
            }
            if (Object.assign(o, {
                    isTouched: !0,
                    isMoved: !1,
                    allowTouchCallbacks: !0,
                    isScrolling: void 0,
                    startMoving: void 0
                }), a.startX = h, a.startY = g, o.touchStartTime = Su(), t.allowClick = !0, t.updateSize(), t.swipeDirection = void 0, i.threshold > 0 && (o.allowThresholdMove = !1), "touchstart" !== l.type) {
                let e = !0;
                c.is(o.focusableElements) && (e = !1, "SELECT" === c[0].nodeName && (o.isTouched = !1)), n.activeElement && xu(n.activeElement).is(o.focusableElements) && n.activeElement !== c[0] && n.activeElement.blur();
                const r = e && t.allowTouchMove && i.touchStartPreventDefault;
                !i.touchStartForcePreventDefault && !r || c[0].isContentEditable || l.preventDefault()
            }
            t.params.freeMode && t.params.freeMode.enabled && t.freeMode && t.animating && !i.cssMode && t.freeMode.onTouchStart(), t.emit("touchStart", l)
        }

        function Mp(e) {
            const t = Ed(),
                n = this,
                r = n.touchEventsData,
                {
                    params: o,
                    touches: i,
                    rtlTranslate: a,
                    enabled: s
                } = n;
            if (!s) return;
            let l = e;
            if (l.originalEvent && (l = l.originalEvent), !r.isTouched) return void(r.startMoving && r.isScrolling && n.emit("touchMoveOpposite", l));
            if (r.isTouchEvent && "touchmove" !== l.type) return;
            const c = "touchmove" === l.type && l.targetTouches && (l.targetTouches[0] || l.changedTouches[0]),
                d = "touchmove" === l.type ? c.pageX : l.pageX,
                u = "touchmove" === l.type ? c.pageY : l.pageY;
            if (l.preventedByNestedSwiper) return i.startX = d, void(i.startY = u);
            if (!n.allowTouchMove) return xu(l.target).is(r.focusableElements) || (n.allowClick = !1), void(r.isTouched && (Object.assign(i, {
                startX: d,
                startY: u,
                currentX: d,
                currentY: u
            }), r.touchStartTime = Su()));
            if (r.isTouchEvent && o.touchReleaseOnEdges && !o.loop)
                if (n.isVertical()) {
                    if (u < i.startY && n.translate <= n.maxTranslate() || u > i.startY && n.translate >= n.minTranslate()) return r.isTouched = !1, void(r.isMoved = !1)
                } else if (d < i.startX && n.translate <= n.maxTranslate() || d > i.startX && n.translate >= n.minTranslate()) return;
            if (r.isTouchEvent && t.activeElement && l.target === t.activeElement && xu(l.target).is(r.focusableElements)) return r.isMoved = !0, void(n.allowClick = !1);
            if (r.allowTouchCallbacks && n.emit("touchMove", l), l.targetTouches && l.targetTouches.length > 1) return;
            i.currentX = d, i.currentY = u;
            const p = i.currentX - i.startX,
                f = i.currentY - i.startY;
            if (n.params.threshold && Math.sqrt(p ** 2 + f ** 2) < n.params.threshold) return;
            if ("undefined" === typeof r.isScrolling) {
                let e;
                n.isHorizontal() && i.currentY === i.startY || n.isVertical() && i.currentX === i.startX ? r.isScrolling = !1 : p * p + f * f >= 25 && (e = 180 * Math.atan2(Math.abs(f), Math.abs(p)) / Math.PI, r.isScrolling = n.isHorizontal() ? e > o.touchAngle : 90 - e > o.touchAngle)
            }
            if (r.isScrolling && n.emit("touchMoveOpposite", l), "undefined" === typeof r.startMoving && (i.currentX === i.startX && i.currentY === i.startY || (r.startMoving = !0)), r.isScrolling) return void(r.isTouched = !1);
            if (!r.startMoving) return;
            n.allowClick = !1, !o.cssMode && l.cancelable && l.preventDefault(), o.touchMoveStopPropagation && !o.nested && l.stopPropagation(), r.isMoved || (o.loop && !o.cssMode && n.loopFix(), r.startTranslate = n.getTranslate(), n.setTransition(0), n.animating && n.$wrapperEl.trigger("webkitTransitionEnd transitionend"), r.allowMomentumBounce = !1, !o.grabCursor || !0 !== n.allowSlideNext && !0 !== n.allowSlidePrev || n.setGrabCursor(!0), n.emit("sliderFirstMove", l)), n.emit("sliderMove", l), r.isMoved = !0;
            let h = n.isHorizontal() ? p : f;
            i.diff = h, h *= o.touchRatio, a && (h = -h), n.swipeDirection = h > 0 ? "prev" : "next", r.currentTranslate = h + r.startTranslate;
            let g = !0,
                v = o.resistanceRatio;
            if (o.touchReleaseOnEdges && (v = 0), h > 0 && r.currentTranslate > n.minTranslate() ? (g = !1, o.resistance && (r.currentTranslate = n.minTranslate() - 1 + (-n.minTranslate() + r.startTranslate + h) ** v)) : h < 0 && r.currentTranslate < n.maxTranslate() && (g = !1, o.resistance && (r.currentTranslate = n.maxTranslate() + 1 - (n.maxTranslate() - r.startTranslate - h) ** v)), g && (l.preventedByNestedSwiper = !0), !n.allowSlideNext && "next" === n.swipeDirection && r.currentTranslate < r.startTranslate && (r.currentTranslate = r.startTranslate), !n.allowSlidePrev && "prev" === n.swipeDirection && r.currentTranslate > r.startTranslate && (r.currentTranslate = r.startTranslate), n.allowSlidePrev || n.allowSlideNext || (r.currentTranslate = r.startTranslate), o.threshold > 0) {
                if (!(Math.abs(h) > o.threshold || r.allowThresholdMove)) return void(r.currentTranslate = r.startTranslate);
                if (!r.allowThresholdMove) return r.allowThresholdMove = !0, i.startX = i.currentX, i.startY = i.currentY, r.currentTranslate = r.startTranslate, void(i.diff = n.isHorizontal() ? i.currentX - i.startX : i.currentY - i.startY)
            }
            o.followFinger && !o.cssMode && ((o.freeMode && o.freeMode.enabled && n.freeMode || o.watchSlidesProgress) && (n.updateActiveIndex(), n.updateSlidesClasses()), n.params.freeMode && o.freeMode.enabled && n.freeMode && n.freeMode.onTouchMove(), n.updateProgress(r.currentTranslate), n.setTranslate(r.currentTranslate))
        }

        function Ip(e) {
            const t = this,
                n = t.touchEventsData,
                {
                    params: r,
                    touches: o,
                    rtlTranslate: i,
                    slidesGrid: a,
                    enabled: s
                } = t;
            if (!s) return;
            let l = e;
            if (l.originalEvent && (l = l.originalEvent), n.allowTouchCallbacks && t.emit("touchEnd", l), n.allowTouchCallbacks = !1, !n.isTouched) return n.isMoved && r.grabCursor && t.setGrabCursor(!1), n.isMoved = !1, void(n.startMoving = !1);
            r.grabCursor && n.isMoved && n.isTouched && (!0 === t.allowSlideNext || !0 === t.allowSlidePrev) && t.setGrabCursor(!1);
            const c = Su(),
                d = c - n.touchStartTime;
            if (t.allowClick) {
                const e = l.path || l.composedPath && l.composedPath();
                t.updateClickedSlide(e && e[0] || l.target), t.emit("tap click", l), d < 300 && c - n.lastClickTime < 300 && t.emit("doubleTap doubleClick", l)
            }
            if (n.lastClickTime = Su(), ku((() => {
                    t.destroyed || (t.allowClick = !0)
                })), !n.isTouched || !n.isMoved || !t.swipeDirection || 0 === o.diff || n.currentTranslate === n.startTranslate) return n.isTouched = !1, n.isMoved = !1, void(n.startMoving = !1);
            let u;
            if (n.isTouched = !1, n.isMoved = !1, n.startMoving = !1, u = r.followFinger ? i ? t.translate : -t.translate : -n.currentTranslate, r.cssMode) return;
            if (t.params.freeMode && r.freeMode.enabled) return void t.freeMode.onTouchEnd({
                currentPos: u
            });
            let p = 0,
                f = t.slidesSizesGrid[0];
            for (let y = 0; y < a.length; y += y < r.slidesPerGroupSkip ? 1 : r.slidesPerGroup) {
                const e = y < r.slidesPerGroupSkip - 1 ? 1 : r.slidesPerGroup;
                "undefined" !== typeof a[y + e] ? u >= a[y] && u < a[y + e] && (p = y, f = a[y + e] - a[y]) : u >= a[y] && (p = y, f = a[a.length - 1] - a[a.length - 2])
            }
            let h = null,
                g = null;
            r.rewind && (t.isBeginning ? g = t.params.virtual && t.params.virtual.enabled && t.virtual ? t.virtual.slides.length - 1 : t.slides.length - 1 : t.isEnd && (h = 0));
            const v = (u - a[p]) / f,
                m = p < r.slidesPerGroupSkip - 1 ? 1 : r.slidesPerGroup;
            if (d > r.longSwipesMs) {
                if (!r.longSwipes) return void t.slideTo(t.activeIndex);
                "next" === t.swipeDirection && (v >= r.longSwipesRatio ? t.slideTo(r.rewind && t.isEnd ? h : p + m) : t.slideTo(p)), "prev" === t.swipeDirection && (v > 1 - r.longSwipesRatio ? t.slideTo(p + m) : null !== g && v < 0 && Math.abs(v) > r.longSwipesRatio ? t.slideTo(g) : t.slideTo(p))
            } else {
                if (!r.shortSwipes) return void t.slideTo(t.activeIndex);
                const e = t.navigation && (l.target === t.navigation.nextEl || l.target === t.navigation.prevEl);
                e ? l.target === t.navigation.nextEl ? t.slideTo(p + m) : t.slideTo(p) : ("next" === t.swipeDirection && t.slideTo(null !== h ? h : p + m), "prev" === t.swipeDirection && t.slideTo(null !== g ? g : p))
            }
        }

        function Pp() {
            const e = this,
                {
                    params: t,
                    el: n
                } = e;
            if (n && 0 === n.offsetWidth) return;
            t.breakpoints && e.setBreakpoint();
            const {
                allowSlideNext: r,
                allowSlidePrev: o,
                snapGrid: i
            } = e;
            e.allowSlideNext = !0, e.allowSlidePrev = !0, e.updateSize(), e.updateSlides(), e.updateSlidesClasses(), ("auto" === t.slidesPerView || t.slidesPerView > 1) && e.isEnd && !e.isBeginning && !e.params.centeredSlides ? e.slideTo(e.slides.length - 1, 0, !1, !0) : e.slideTo(e.activeIndex, 0, !1, !0), e.autoplay && e.autoplay.running && e.autoplay.paused && e.autoplay.run(), e.allowSlidePrev = o, e.allowSlideNext = r, e.params.watchOverflow && i !== e.snapGrid && e.checkOverflow()
        }

        function Bp(e) {
            const t = this;
            t.enabled && (t.allowClick || (t.params.preventClicks && e.preventDefault(), t.params.preventClicksPropagation && t.animating && (e.stopPropagation(), e.stopImmediatePropagation())))
        }

        function Lp() {
            const e = this,
                {
                    wrapperEl: t,
                    rtlTranslate: n,
                    enabled: r
                } = e;
            if (!r) return;
            let o;
            e.previousTranslate = e.translate, e.isHorizontal() ? e.translate = -t.scrollLeft : e.translate = -t.scrollTop, 0 === e.translate && (e.translate = 0), e.updateActiveIndex(), e.updateSlidesClasses();
            const i = e.maxTranslate() - e.minTranslate();
            o = 0 === i ? 0 : (e.translate - e.minTranslate()) / i, o !== e.progress && e.updateProgress(n ? -e.translate : e.translate), e.emit("setTranslate", e.translate, !1)
        }
        let Fp = !1;

        function Dp() {}
        const Np = (e, t) => {
            const n = Ed(),
                {
                    params: r,
                    touchEvents: o,
                    el: i,
                    wrapperEl: a,
                    device: s,
                    support: l
                } = e,
                c = !!r.nested,
                d = "on" === t ? "addEventListener" : "removeEventListener",
                u = t;
            if (l.touch) {
                const t = !("touchstart" !== o.start || !l.passiveListener || !r.passiveListeners) && {
                    passive: !0,
                    capture: !1
                };
                i[d](o.start, e.onTouchStart, t), i[d](o.move, e.onTouchMove, l.passiveListener ? {
                    passive: !1,
                    capture: c
                } : c), i[d](o.end, e.onTouchEnd, t), o.cancel && i[d](o.cancel, e.onTouchEnd, t)
            } else i[d](o.start, e.onTouchStart, !1), n[d](o.move, e.onTouchMove, c), n[d](o.end, e.onTouchEnd, !1);
            (r.preventClicks || r.preventClicksPropagation) && i[d]("click", e.onClick, !0), r.cssMode && a[d]("scroll", e.onScroll), r.updateOnWindowResize ? e[u](s.ios || s.android ? "resize orientationchange observerUpdate" : "resize observerUpdate", Pp, !0) : e[u]("observerUpdate", Pp, !0)
        };

        function Rp() {
            const e = this,
                t = Ed(),
                {
                    params: n,
                    support: r
                } = e;
            e.onTouchStart = Op.bind(e), e.onTouchMove = Mp.bind(e), e.onTouchEnd = Ip.bind(e), n.cssMode && (e.onScroll = Lp.bind(e)), e.onClick = Bp.bind(e), r.touch && !Fp && (t.addEventListener("touchstart", Dp), Fp = !0), Np(e, "on")
        }

        function jp() {
            const e = this;
            Np(e, "off")
        }
        var Hp = {
            attachEvents: Rp,
            detachEvents: jp
        };
        const Gp = (e, t) => e.grid && t.grid && t.grid.rows > 1;

        function zp() {
            const e = this,
                {
                    activeIndex: t,
                    initialized: n,
                    loopedSlides: r = 0,
                    params: o,
                    $el: i
                } = e,
                a = o.breakpoints;
            if (!a || a && 0 === Object.keys(a).length) return;
            const s = e.getBreakpoint(a, e.params.breakpointsBase, e.el);
            if (!s || e.currentBreakpoint === s) return;
            const l = s in a ? a[s] : void 0,
                c = l || e.originalParams,
                d = Gp(e, o),
                u = Gp(e, c),
                p = o.enabled;
            d && !u ? (i.removeClass(`${o.containerModifierClass}grid ${o.containerModifierClass}grid-column`), e.emitContainerClasses()) : !d && u && (i.addClass(`${o.containerModifierClass}grid`), (c.grid.fill && "column" === c.grid.fill || !c.grid.fill && "column" === o.grid.fill) && i.addClass(`${o.containerModifierClass}grid-column`), e.emitContainerClasses()), ["navigation", "pagination", "scrollbar"].forEach((t => {
                const n = o[t] && o[t].enabled,
                    r = c[t] && c[t].enabled;
                n && !r && e[t].disable(), !n && r && e[t].enable()
            }));
            const f = c.direction && c.direction !== o.direction,
                h = o.loop && (c.slidesPerView !== o.slidesPerView || f);
            f && n && e.changeDirection(), Iu(e.params, c);
            const g = e.params.enabled;
            Object.assign(e, {
                allowTouchMove: e.params.allowTouchMove,
                allowSlideNext: e.params.allowSlideNext,
                allowSlidePrev: e.params.allowSlidePrev
            }), p && !g ? e.disable() : !p && g && e.enable(), e.currentBreakpoint = s, e.emit("_beforeBreakpoint", c), h && n && (e.loopDestroy(), e.loopCreate(), e.updateSlides(), e.slideTo(t - r + e.loopedSlides, 0, !1)), e.emit("breakpoint", c)
        }

        function $p(e, t = "window", n) {
            if (!e || "container" === t && !n) return;
            let r = !1;
            const o = Md(),
                i = "window" === t ? o.innerHeight : n.clientHeight,
                a = Object.keys(e).map((e => {
                    if ("string" === typeof e && 0 === e.indexOf("@")) {
                        const t = parseFloat(e.substr(1)),
                            n = i * t;
                        return {
                            value: n,
                            point: e
                        }
                    }
                    return {
                        value: e,
                        point: e
                    }
                }));
            a.sort(((e, t) => parseInt(e.value, 10) - parseInt(t.value, 10)));
            for (let s = 0; s < a.length; s += 1) {
                const {
                    point: e,
                    value: i
                } = a[s];
                "window" === t ? o.matchMedia(`(min-width: ${i}px)`).matches && (r = e) : i <= n.clientWidth && (r = e)
            }
            return r || "max"
        }
        var Vp = {
            setBreakpoint: zp,
            getBreakpoint: $p
        };

        function Up(e, t) {
            const n = [];
            return e.forEach((e => {
                "object" === typeof e ? Object.keys(e).forEach((r => {
                    e[r] && n.push(t + r)
                })) : "string" === typeof e && n.push(t + e)
            })), n
        }

        function Kp() {
            const e = this,
                {
                    classNames: t,
                    params: n,
                    rtl: r,
                    $el: o,
                    device: i,
                    support: a
                } = e,
                s = Up(["initialized", n.direction, {
                    "pointer-events": !a.touch
                }, {
                    "free-mode": e.params.freeMode && n.freeMode.enabled
                }, {
                    autoheight: n.autoHeight
                }, {
                    rtl: r
                }, {
                    grid: n.grid && n.grid.rows > 1
                }, {
                    "grid-column": n.grid && n.grid.rows > 1 && "column" === n.grid.fill
                }, {
                    android: i.android
                }, {
                    ios: i.ios
                }, {
                    "css-mode": n.cssMode
                }, {
                    centered: n.cssMode && n.centeredSlides
                }, {
                    "watch-progress": n.watchSlidesProgress
                }], n.containerModifierClass);
            t.push(...s), o.addClass([...t].join(" ")), e.emitContainerClasses()
        }

        function Yp() {
            const e = this,
                {
                    $el: t,
                    classNames: n
                } = e;
            t.removeClass(n.join(" ")), e.emitContainerClasses()
        }
        var Wp = {
            addClasses: Kp,
            removeClasses: Yp
        };

        function Xp(e, t, n, r, o, i) {
            const a = Md();
            let s;

            function l() {
                i && i()
            }
            const c = xu(e).parent("picture")[0];
            c || e.complete && o ? l() : t ? (s = new a.Image, s.onload = l, s.onerror = l, r && (s.sizes = r), n && (s.srcset = n), t && (s.src = t)) : l()
        }

        function Qp() {
            const e = this;

            function t() {
                "undefined" !== typeof e && null !== e && e && !e.destroyed && (void 0 !== e.imagesLoaded && (e.imagesLoaded += 1), e.imagesLoaded === e.imagesToLoad.length && (e.params.updateOnImagesReady && e.update(), e.emit("imagesReady")))
            }
            e.imagesToLoad = e.$el.find("img");
            for (let n = 0; n < e.imagesToLoad.length; n += 1) {
                const r = e.imagesToLoad[n];
                e.loadImage(r, r.currentSrc || r.getAttribute("src"), r.srcset || r.getAttribute("srcset"), r.sizes || r.getAttribute("sizes"), !0, t)
            }
        }
        var qp = {
            loadImage: Xp,
            preloadImages: Qp
        };

        function Zp() {
            const e = this,
                {
                    isLocked: t,
                    params: n
                } = e,
                {
                    slidesOffsetBefore: r
                } = n;
            if (r) {
                const t = e.slides.length - 1,
                    n = e.slidesGrid[t] + e.slidesSizesGrid[t] + 2 * r;
                e.isLocked = e.size > n
            } else e.isLocked = 1 === e.snapGrid.length;
            !0 === n.allowSlideNext && (e.allowSlideNext = !e.isLocked), !0 === n.allowSlidePrev && (e.allowSlidePrev = !e.isLocked), t && t !== e.isLocked && (e.isEnd = !1), t !== e.isLocked && e.emit(e.isLocked ? "lock" : "unlock")
        }
        var Jp = {
                checkOverflow: Zp
            },
            ef = {
                init: !0,
                direction: "horizontal",
                touchEventsTarget: "wrapper",
                initialSlide: 0,
                speed: 300,
                cssMode: !1,
                updateOnWindowResize: !0,
                resizeObserver: !0,
                nested: !1,
                createElements: !1,
                enabled: !0,
                focusableElements: "input, select, option, textarea, button, video, label",
                width: null,
                height: null,
                preventInteractionOnTransition: !1,
                userAgent: null,
                url: null,
                edgeSwipeDetection: !1,
                edgeSwipeThreshold: 20,
                autoHeight: !1,
                setWrapperSize: !1,
                virtualTranslate: !1,
                effect: "slide",
                breakpoints: void 0,
                breakpointsBase: "window",
                spaceBetween: 0,
                slidesPerView: 1,
                slidesPerGroup: 1,
                slidesPerGroupSkip: 0,
                slidesPerGroupAuto: !1,
                centeredSlides: !1,
                centeredSlidesBounds: !1,
                slidesOffsetBefore: 0,
                slidesOffsetAfter: 0,
                normalizeSlideIndex: !0,
                centerInsufficientSlides: !1,
                watchOverflow: !0,
                roundLengths: !1,
                touchRatio: 1,
                touchAngle: 45,
                simulateTouch: !0,
                shortSwipes: !0,
                longSwipes: !0,
                longSwipesRatio: .5,
                longSwipesMs: 300,
                followFinger: !0,
                allowTouchMove: !0,
                threshold: 0,
                touchMoveStopPropagation: !1,
                touchStartPreventDefault: !0,
                touchStartForcePreventDefault: !1,
                touchReleaseOnEdges: !1,
                uniqueNavElements: !0,
                resistance: !0,
                resistanceRatio: .85,
                watchSlidesProgress: !1,
                grabCursor: !1,
                preventClicks: !0,
                preventClicksPropagation: !0,
                slideToClickedSlide: !1,
                preloadImages: !0,
                updateOnImagesReady: !0,
                loop: !1,
                loopAdditionalSlides: 0,
                loopedSlides: null,
                loopedSlidesLimit: !0,
                loopFillGroupWithBlank: !1,
                loopPreventsSlide: !0,
                rewind: !1,
                allowSlidePrev: !0,
                allowSlideNext: !0,
                swipeHandler: null,
                noSwiping: !0,
                noSwipingClass: "swiper-no-swiping",
                noSwipingSelector: null,
                passiveListeners: !0,
                maxBackfaceHiddenSlides: 10,
                containerModifierClass: "swiper-",
                slideClass: "swiper-slide",
                slideBlankClass: "swiper-slide-invisible-blank",
                slideActiveClass: "swiper-slide-active",
                slideDuplicateActiveClass: "swiper-slide-duplicate-active",
                slideVisibleClass: "swiper-slide-visible",
                slideDuplicateClass: "swiper-slide-duplicate",
                slideNextClass: "swiper-slide-next",
                slideDuplicateNextClass: "swiper-slide-duplicate-next",
                slidePrevClass: "swiper-slide-prev",
                slideDuplicatePrevClass: "swiper-slide-duplicate-prev",
                wrapperClass: "swiper-wrapper",
                runCallbacksOnInit: !0,
                _emitClasses: !1
            };

        function tf(e, t) {
            return function(n = {}) {
                const r = Object.keys(n)[0],
                    o = n[r];
                "object" === typeof o && null !== o ? (["navigation", "pagination", "scrollbar"].indexOf(r) >= 0 && !0 === e[r] && (e[r] = {
                    auto: !0
                }), r in e && "enabled" in o ? (!0 === e[r] && (e[r] = {
                    enabled: !0
                }), "object" !== typeof e[r] || "enabled" in e[r] || (e[r].enabled = !0), e[r] || (e[r] = {
                    enabled: !1
                }), Iu(t, n)) : Iu(t, n)) : Iu(t, n)
            }
        }
        const nf = {
                eventsEmitter: Uu,
                update: tp,
                translate: sp,
                transition: pp,
                slide: wp,
                loop: Cp,
                grabCursor: Tp,
                events: Hp,
                breakpoints: Vp,
                checkOverflow: Jp,
                classes: Wp,
                images: qp
            },
            rf = {};
        class of {
            constructor(...e) {
                let t, n;
                if (1 === e.length && e[0].constructor && "Object" === Object.prototype.toString.call(e[0]).slice(8, -1) ? n = e[0] : [t, n] = e, n || (n = {}), n = Iu({}, n), t && !n.el && (n.el = t), n.el && xu(n.el).length > 1) {
                    const e = [];
                    return xu(n.el).each((t => {
                        const r = Iu({}, n, {
                            el: t
                        });
                        e.push(new of(r))
                    })), e
                }
                const r = this;
                r.__swiper__ = !0, r.support = Ru(), r.device = Hu({
                    userAgent: n.userAgent
                }), r.browser = zu(), r.eventsListeners = {}, r.eventsAnyListeners = [], r.modules = [...r.__modules__], n.modules && Array.isArray(n.modules) && r.modules.push(...n.modules);
                const o = {};
                r.modules.forEach((e => {
                    e({
                        swiper: r,
                        extendParams: tf(n, o),
                        on: r.on.bind(r),
                        once: r.once.bind(r),
                        off: r.off.bind(r),
                        emit: r.emit.bind(r)
                    })
                }));
                const i = Iu({}, ef, o);
                return r.params = Iu({}, i, rf, n), r.originalParams = Iu({}, r.params), r.passedParams = Iu({}, n), r.params && r.params.on && Object.keys(r.params.on).forEach((e => {
                    r.on(e, r.params.on[e])
                })), r.params && r.params.onAny && r.onAny(r.params.onAny), r.$ = xu, Object.assign(r, {
                    enabled: r.params.enabled,
                    el: t,
                    classNames: [],
                    slides: xu(),
                    slidesGrid: [],
                    snapGrid: [],
                    slidesSizesGrid: [],
                    isHorizontal() {
                        return "horizontal" === r.params.direction
                    },
                    isVertical() {
                        return "vertical" === r.params.direction
                    },
                    activeIndex: 0,
                    realIndex: 0,
                    isBeginning: !0,
                    isEnd: !1,
                    translate: 0,
                    previousTranslate: 0,
                    progress: 0,
                    velocity: 0,
                    animating: !1,
                    allowSlideNext: r.params.allowSlideNext,
                    allowSlidePrev: r.params.allowSlidePrev,
                    touchEvents: function() {
                        const e = ["touchstart", "touchmove", "touchend", "touchcancel"],
                            t = ["pointerdown", "pointermove", "pointerup"];
                        return r.touchEventsTouch = {
                            start: e[0],
                            move: e[1],
                            end: e[2],
                            cancel: e[3]
                        }, r.touchEventsDesktop = {
                            start: t[0],
                            move: t[1],
                            end: t[2]
                        }, r.support.touch || !r.params.simulateTouch ? r.touchEventsTouch : r.touchEventsDesktop
                    }(),
                    touchEventsData: {
                        isTouched: void 0,
                        isMoved: void 0,
                        allowTouchCallbacks: void 0,
                        touchStartTime: void 0,
                        isScrolling: void 0,
                        currentTranslate: void 0,
                        startTranslate: void 0,
                        allowThresholdMove: void 0,
                        focusableElements: r.params.focusableElements,
                        lastClickTime: Su(),
                        clickTimeout: void 0,
                        velocities: [],
                        allowMomentumBounce: void 0,
                        isTouchEvent: void 0,
                        startMoving: void 0
                    },
                    allowClick: !0,
                    allowTouchMove: r.params.allowTouchMove,
                    touches: {
                        startX: 0,
                        startY: 0,
                        currentX: 0,
                        currentY: 0,
                        diff: 0
                    },
                    imagesToLoad: [],
                    imagesLoaded: 0
                }), r.emit("_swiper"), r.params.init && r.init(), r
            }
            enable() {
                const e = this;
                e.enabled || (e.enabled = !0, e.params.grabCursor && e.setGrabCursor(), e.emit("enable"))
            }
            disable() {
                const e = this;
                e.enabled && (e.enabled = !1, e.params.grabCursor && e.unsetGrabCursor(), e.emit("disable"))
            }
            setProgress(e, t) {
                const n = this;
                e = Math.min(Math.max(e, 0), 1);
                const r = n.minTranslate(),
                    o = n.maxTranslate(),
                    i = (o - r) * e + r;
                n.translateTo(i, "undefined" === typeof t ? 0 : t), n.updateActiveIndex(), n.updateSlidesClasses()
            }
            emitContainerClasses() {
                const e = this;
                if (!e.params._emitClasses || !e.el) return;
                const t = e.el.className.split(" ").filter((t => 0 === t.indexOf("swiper") || 0 === t.indexOf(e.params.containerModifierClass)));
                e.emit("_containerClasses", t.join(" "))
            }
            getSlideClasses(e) {
                const t = this;
                return t.destroyed ? "" : e.className.split(" ").filter((e => 0 === e.indexOf("swiper-slide") || 0 === e.indexOf(t.params.slideClass))).join(" ")
            }
            emitSlidesClasses() {
                const e = this;
                if (!e.params._emitClasses || !e.el) return;
                const t = [];
                e.slides.each((n => {
                    const r = e.getSlideClasses(n);
                    t.push({
                        slideEl: n,
                        classNames: r
                    }), e.emit("_slideClass", n, r)
                })), e.emit("_slideClasses", t)
            }
            slidesPerViewDynamic(e = "current", t = !1) {
                const n = this,
                    {
                        params: r,
                        slides: o,
                        slidesGrid: i,
                        slidesSizesGrid: a,
                        size: s,
                        activeIndex: l
                    } = n;
                let c = 1;
                if (r.centeredSlides) {
                    let e, t = o[l].swiperSlideSize;
                    for (let n = l + 1; n < o.length; n += 1) o[n] && !e && (t += o[n].swiperSlideSize, c += 1, t > s && (e = !0));
                    for (let n = l - 1; n >= 0; n -= 1) o[n] && !e && (t += o[n].swiperSlideSize, c += 1, t > s && (e = !0))
                } else if ("current" === e)
                    for (let d = l + 1; d < o.length; d += 1) {
                        const e = t ? i[d] + a[d] - i[l] < s : i[d] - i[l] < s;
                        e && (c += 1)
                    } else
                        for (let d = l - 1; d >= 0; d -= 1) {
                            const e = i[l] - i[d] < s;
                            e && (c += 1)
                        }
                return c
            }
            update() {
                const e = this;
                if (!e || e.destroyed) return;
                const {
                    snapGrid: t,
                    params: n
                } = e;

                function r() {
                    const t = e.rtlTranslate ? -1 * e.translate : e.translate,
                        n = Math.min(Math.max(t, e.maxTranslate()), e.minTranslate());
                    e.setTranslate(n), e.updateActiveIndex(), e.updateSlidesClasses()
                }
                let o;
                n.breakpoints && e.setBreakpoint(), e.updateSize(), e.updateSlides(), e.updateProgress(), e.updateSlidesClasses(), e.params.freeMode && e.params.freeMode.enabled ? (r(), e.params.autoHeight && e.updateAutoHeight()) : (o = ("auto" === e.params.slidesPerView || e.params.slidesPerView > 1) && e.isEnd && !e.params.centeredSlides ? e.slideTo(e.slides.length - 1, 0, !1, !0) : e.slideTo(e.activeIndex, 0, !1, !0), o || r()), n.watchOverflow && t !== e.snapGrid && e.checkOverflow(), e.emit("update")
            }
            changeDirection(e, t = !0) {
                const n = this,
                    r = n.params.direction;
                return e || (e = "horizontal" === r ? "vertical" : "horizontal"), e === r || "horizontal" !== e && "vertical" !== e || (n.$el.removeClass(`${n.params.containerModifierClass}${r}`).addClass(`${n.params.containerModifierClass}${e}`), n.emitContainerClasses(), n.params.direction = e, n.slides.each((t => {
                    "vertical" === e ? t.style.width = "" : t.style.height = ""
                })), n.emit("changeDirection"), t && n.update()), n
            }
            changeLanguageDirection(e) {
                const t = this;
                t.rtl && "rtl" === e || !t.rtl && "ltr" === e || (t.rtl = "rtl" === e, t.rtlTranslate = "horizontal" === t.params.direction && t.rtl, t.rtl ? (t.$el.addClass(`${t.params.containerModifierClass}rtl`), t.el.dir = "rtl") : (t.$el.removeClass(`${t.params.containerModifierClass}rtl`), t.el.dir = "ltr"), t.update())
            }
            mount(e) {
                const t = this;
                if (t.mounted) return !0;
                const n = xu(e || t.params.el);
                if (e = n[0], !e) return !1;
                e.swiper = t;
                const r = () => `.${(t.params.wrapperClass||"").trim().split(" ").join(".")}`,
                    o = () => {
                        if (e && e.shadowRoot && e.shadowRoot.querySelector) {
                            const t = xu(e.shadowRoot.querySelector(r()));
                            return t.children = e => n.children(e), t
                        }
                        return n.children ? n.children(r()) : xu(n).children(r())
                    };
                let i = o();
                if (0 === i.length && t.params.createElements) {
                    const e = Ed(),
                        r = e.createElement("div");
                    i = xu(r), r.className = t.params.wrapperClass, n.append(r), n.children(`.${t.params.slideClass}`).each((e => {
                        i.append(e)
                    }))
                }
                return Object.assign(t, {
                    $el: n,
                    el: e,
                    $wrapperEl: i,
                    wrapperEl: i[0],
                    mounted: !0,
                    rtl: "rtl" === e.dir.toLowerCase() || "rtl" === n.css("direction"),
                    rtlTranslate: "horizontal" === t.params.direction && ("rtl" === e.dir.toLowerCase() || "rtl" === n.css("direction")),
                    wrongRTL: "-webkit-box" === i.css("display")
                }), !0
            }
            init(e) {
                const t = this;
                if (t.initialized) return t;
                const n = t.mount(e);
                return !1 === n || (t.emit("beforeInit"), t.params.breakpoints && t.setBreakpoint(), t.addClasses(), t.params.loop && t.loopCreate(), t.updateSize(), t.updateSlides(), t.params.watchOverflow && t.checkOverflow(), t.params.grabCursor && t.enabled && t.setGrabCursor(), t.params.preloadImages && t.preloadImages(), t.params.loop ? t.slideTo(t.params.initialSlide + t.loopedSlides, 0, t.params.runCallbacksOnInit, !1, !0) : t.slideTo(t.params.initialSlide, 0, t.params.runCallbacksOnInit, !1, !0), t.attachEvents(), t.initialized = !0, t.emit("init"), t.emit("afterInit")), t
            }
            destroy(e = !0, t = !0) {
                const n = this,
                    {
                        params: r,
                        $el: o,
                        $wrapperEl: i,
                        slides: a
                    } = n;
                return "undefined" === typeof n.params || n.destroyed || (n.emit("beforeDestroy"), n.initialized = !1, n.detachEvents(), r.loop && n.loopDestroy(), t && (n.removeClasses(), o.removeAttr("style"), i.removeAttr("style"), a && a.length && a.removeClass([r.slideVisibleClass, r.slideActiveClass, r.slideNextClass, r.slidePrevClass].join(" ")).removeAttr("style").removeAttr("data-swiper-slide-index")), n.emit("destroy"), Object.keys(n.eventsListeners).forEach((e => {
                    n.off(e)
                })), !1 !== e && (n.$el[0].swiper = null, Cu(n)), n.destroyed = !0), null
            }
            static extendDefaults(e) {
                Iu(rf, e)
            }
            static get extendedDefaults() {
                return rf
            }
            static get defaults() {
                return ef
            }
            static installModule(e) {
                of.prototype.__modules__ || (of.prototype.__modules__ = []);
                const t = of.prototype.__modules__;
                "function" === typeof e && t.indexOf(e) < 0 && t.push(e)
            }
            static use(e) {
                return Array.isArray(e) ? (e.forEach((e => of.installModule(e))), of) : (of.installModule(e), of)
            }
        }
        Object.keys(nf).forEach((e => {
            Object.keys(nf[e]).forEach((t => {
                of.prototype[t] = nf[e][t]
            }))
        })), of.use([$u, Vu]);
        var af = of;

        function sf(e) {
            return "object" === typeof e && null !== e && e.constructor && "Object" === Object.prototype.toString.call(e).slice(8, -1)
        }

        function lf(e, t) {
            const n = ["__proto__", "constructor", "prototype"];
            Object.keys(t).filter((e => n.indexOf(e) < 0)).forEach((n => {
                "undefined" === typeof e[n] ? e[n] = t[n] : sf(t[n]) && sf(e[n]) && Object.keys(t[n]).length > 0 ? t[n].__swiper__ ? e[n] = t[n] : lf(e[n], t[n]) : e[n] = t[n]
            }))
        }

        function cf(e = {}) {
            return e.navigation && "undefined" === typeof e.navigation.nextEl && "undefined" === typeof e.navigation.prevEl
        }

        function df(e = {}) {
            return e.pagination && "undefined" === typeof e.pagination.el
        }

        function uf(e = {}) {
            return e.scrollbar && "undefined" === typeof e.scrollbar.el
        }

        function pf(e = "") {
            const t = e.split(" ").map((e => e.trim())).filter((e => !!e)),
                n = [];
            return t.forEach((e => {
                n.indexOf(e) < 0 && n.push(e)
            })), n.join(" ")
        }
        const ff = ["modules", "init", "_direction", "touchEventsTarget", "initialSlide", "_speed", "cssMode", "updateOnWindowResize", "resizeObserver", "nested", "focusableElements", "_enabled", "_width", "_height", "preventInteractionOnTransition", "userAgent", "url", "_edgeSwipeDetection", "_edgeSwipeThreshold", "_freeMode", "_autoHeight", "setWrapperSize", "virtualTranslate", "_effect", "breakpoints", "_spaceBetween", "_slidesPerView", "maxBackfaceHiddenSlides", "_grid", "_slidesPerGroup", "_slidesPerGroupSkip", "_slidesPerGroupAuto", "_centeredSlides", "_centeredSlidesBounds", "_slidesOffsetBefore", "_slidesOffsetAfter", "normalizeSlideIndex", "_centerInsufficientSlides", "_watchOverflow", "roundLengths", "touchRatio", "touchAngle", "simulateTouch", "_shortSwipes", "_longSwipes", "longSwipesRatio", "longSwipesMs", "_followFinger", "allowTouchMove", "_threshold", "touchMoveStopPropagation", "touchStartPreventDefault", "touchStartForcePreventDefault", "touchReleaseOnEdges", "uniqueNavElements", "_resistance", "_resistanceRatio", "_watchSlidesProgress", "_grabCursor", "preventClicks", "preventClicksPropagation", "_slideToClickedSlide", "_preloadImages", "updateOnImagesReady", "_loop", "_loopAdditionalSlides", "_loopedSlides", "_loopedSlidesLimit", "_loopFillGroupWithBlank", "loopPreventsSlide", "_rewind", "_allowSlidePrev", "_allowSlideNext", "_swipeHandler", "_noSwiping", "noSwipingClass", "noSwipingSelector", "passiveListeners", "containerModifierClass", "slideClass", "slideBlankClass", "slideActiveClass", "slideDuplicateActiveClass", "slideVisibleClass", "slideDuplicateClass", "slideNextClass", "slideDuplicateNextClass", "slidePrevClass", "slideDuplicatePrevClass", "wrapperClass", "runCallbacksOnInit", "observer", "observeParents", "observeSlideChildren", "a11y", "_autoplay", "_controller", "coverflowEffect", "cubeEffect", "fadeEffect", "flipEffect", "creativeEffect", "cardsEffect", "hashNavigation", "history", "keyboard", "lazy", "mousewheel", "_navigation", "_pagination", "parallax", "_scrollbar", "_thumbs", "virtual", "zoom"];

        function hf(e = {}, t = !0) {
            const n = {
                    on: {}
                },
                r = {},
                o = {};
            lf(n, af.defaults), lf(n, af.extendedDefaults), n._emitClasses = !0, n.init = !1;
            const i = {},
                a = ff.map((e => e.replace(/_/, ""))),
                s = Object.assign({}, e);
            return Object.keys(s).forEach((s => {
                "undefined" !== typeof e[s] && (a.indexOf(s) >= 0 ? sf(e[s]) ? (n[s] = {}, o[s] = {}, lf(n[s], e[s]), lf(o[s], e[s])) : (n[s] = e[s], o[s] = e[s]) : 0 === s.search(/on[A-Z]/) && "function" === typeof e[s] ? t ? r[`${s[2].toLowerCase()}${s.substr(3)}`] = e[s] : n.on[`${s[2].toLowerCase()}${s.substr(3)}`] = e[s] : i[s] = e[s])
            })), ["navigation", "pagination", "scrollbar"].forEach((e => {
                !0 === n[e] && (n[e] = {}), !1 === n[e] && delete n[e]
            })), {
                params: n,
                passedParams: o,
                rest: i,
                events: r
            }
        }

        function gf({
            el: e,
            nextEl: t,
            prevEl: n,
            paginationEl: r,
            scrollbarEl: o,
            swiper: i
        }, a) {
            cf(a) && t && n && (i.params.navigation.nextEl = t, i.originalParams.navigation.nextEl = t, i.params.navigation.prevEl = n, i.originalParams.navigation.prevEl = n), df(a) && r && (i.params.pagination.el = r, i.originalParams.pagination.el = r), uf(a) && o && (i.params.scrollbar.el = o, i.originalParams.scrollbar.el = o), i.init(e)
        }
        const vf = (e, t) => {
            let n = t.slidesPerView;
            if (t.breakpoints) {
                const e = af.prototype.getBreakpoint(t.breakpoints),
                    r = e in t.breakpoints ? t.breakpoints[e] : void 0;
                r && r.slidesPerView && (n = r.slidesPerView)
            }
            let r = Math.ceil(parseFloat(t.loopedSlides || n, 10));
            return r += t.loopAdditionalSlides, r > e.length && t.loopedSlidesLimit && (r = e.length), r
        };

        function mf(e, t, n) {
            const r = t.map(((t, n) => (t.props || (t.props = {}), t.props.swiperRef = e, t.props["data-swiper-slide-index"] = n, t)));

            function o(e, t, r) {
                return e.props || (e.props = {}), yi(e.type, {
                    ...e.props,
                    key: `${e.key}-duplicate-${t}-${r}`,
                    class: `${e.props.className||""} ${n.slideDuplicateClass} ${e.props.class||""}`
                }, e.children)
            }
            if (n.loopFillGroupWithBlank) {
                const e = n.slidesPerGroup - r.length % n.slidesPerGroup;
                if (e !== n.slidesPerGroup)
                    for (let t = 0; t < e; t += 1) {
                        const e = yi("div", {
                            class: `${n.slideClass} ${n.slideBlankClass}`
                        });
                        r.push(e)
                    }
            }
            "auto" !== n.slidesPerView || n.loopedSlides || (n.loopedSlides = r.length);
            const i = vf(r, n),
                a = [],
                s = [];
            for (let l = 0; l < i; l += 1) {
                const e = l - Math.floor(l / r.length) * r.length;
                s.push(o(r[e], l, "append")), a.unshift(o(r[r.length - e - 1], l, "prepend"))
            }
            return e.value && (e.value.loopedSlides = i), [...a, ...r, ...s]
        }

        function yf(e, t, n, r, o) {
            const i = [];
            if (!t) return i;
            const a = e => {
                i.indexOf(e) < 0 && i.push(e)
            };
            if (n && r) {
                const e = r.map(o),
                    t = n.map(o);
                e.join("") !== t.join("") && a("children"), r.length !== n.length && a("children")
            }
            const s = ff.filter((e => "_" === e[0])).map((e => e.replace(/_/, "")));
            return s.forEach((n => {
                if (n in e && n in t)
                    if (sf(e[n]) && sf(t[n])) {
                        const r = Object.keys(e[n]),
                            o = Object.keys(t[n]);
                        r.length !== o.length ? a(n) : (r.forEach((r => {
                            e[n][r] !== t[n][r] && a(n)
                        })), o.forEach((r => {
                            e[n][r] !== t[n][r] && a(n)
                        })))
                    } else e[n] !== t[n] && a(n)
            })), i
        }

        function bf(e, t, n) {
            void 0 === e && (e = {});
            const r = [],
                o = {
                    "container-start": [],
                    "container-end": [],
                    "wrapper-start": [],
                    "wrapper-end": []
                },
                i = (e, t) => {
                    Array.isArray(e) && e.forEach((e => {
                        const n = "symbol" === typeof e.type;
                        "default" === t && (t = "container-end"), n && e.children ? i(e.children, "default") : !e.type || "SwiperSlide" !== e.type.name && "AsyncComponentWrapper" !== e.type.name ? o[t] && o[t].push(e) : r.push(e)
                    }))
                };
            return Object.keys(e).forEach((t => {
                if ("function" !== typeof e[t]) return;
                const n = e[t]();
                i(n, t)
            })), n.value = t.value, t.value = r, {
                slides: r,
                slots: o
            }
        }

        function wf({
            swiper: e,
            slides: t,
            passedParams: n,
            changedParams: r,
            nextEl: o,
            prevEl: i,
            scrollbarEl: a,
            paginationEl: s
        }) {
            const l = r.filter((e => "children" !== e && "direction" !== e)),
                {
                    params: c,
                    pagination: d,
                    navigation: u,
                    scrollbar: p,
                    virtual: f,
                    thumbs: h
                } = e;
            let g, v, m, y, b;
            r.includes("thumbs") && n.thumbs && n.thumbs.swiper && c.thumbs && !c.thumbs.swiper && (g = !0), r.includes("controller") && n.controller && n.controller.control && c.controller && !c.controller.control && (v = !0), r.includes("pagination") && n.pagination && (n.pagination.el || s) && (c.pagination || !1 === c.pagination) && d && !d.el && (m = !0), r.includes("scrollbar") && n.scrollbar && (n.scrollbar.el || a) && (c.scrollbar || !1 === c.scrollbar) && p && !p.el && (y = !0), r.includes("navigation") && n.navigation && (n.navigation.prevEl || i) && (n.navigation.nextEl || o) && (c.navigation || !1 === c.navigation) && u && !u.prevEl && !u.nextEl && (b = !0);
            const w = t => {
                e[t] && (e[t].destroy(), "navigation" === t ? (c[t].prevEl = void 0, c[t].nextEl = void 0, e[t].prevEl = void 0, e[t].nextEl = void 0) : (c[t].el = void 0, e[t].el = void 0))
            };
            if (l.forEach((e => {
                    if (sf(c[e]) && sf(n[e])) lf(c[e], n[e]);
                    else {
                        const t = n[e];
                        !0 !== t && !1 !== t || "navigation" !== e && "pagination" !== e && "scrollbar" !== e ? c[e] = n[e] : !1 === t && w(e)
                    }
                })), l.includes("controller") && !v && e.controller && e.controller.control && c.controller && c.controller.control && (e.controller.control = c.controller.control), r.includes("children") && t && f && c.virtual.enabled ? (f.slides = t, f.update(!0)) : r.includes("children") && e.lazy && e.params.lazy.enabled && e.lazy.load(), g) {
                const e = h.init();
                e && h.update(!0)
            }
            v && (e.controller.control = c.controller.control), m && (s && (c.pagination.el = s), d.init(), d.render(), d.update()), y && (a && (c.scrollbar.el = a), p.init(), p.updateSize(), p.setTranslate()), b && (o && (c.navigation.nextEl = o), i && (c.navigation.prevEl = i), u.init(), u.update()), r.includes("allowSlideNext") && (e.allowSlideNext = n.allowSlideNext), r.includes("allowSlidePrev") && (e.allowSlidePrev = n.allowSlidePrev), r.includes("direction") && e.changeDirection(n.direction, !1), e.update()
        }

        function _f(e, t, n) {
            if (!n) return null;
            const r = e.value.isHorizontal() ? {
                [e.value.rtlTranslate ? "right" : "left"]: `${n.offset}px`
            } : {
                top: `${n.offset}px`
            };
            return t.filter(((e, t) => t >= n.from && t <= n.to)).map((t => (t.props || (t.props = {}), t.props.style || (t.props.style = {}), t.props.swiperRef = e, t.props.style = r, yi(t.type, {
                ...t.props
            }, t.children))))
        }
        const Af = e => {
                !e || e.destroyed || !e.params.virtual || e.params.virtual && !e.params.virtual.enabled || (e.updateSlides(), e.updateProgress(), e.updateSlidesClasses(), e.lazy && e.params.lazy.enabled && e.lazy.load(), e.parallax && e.params.parallax && e.params.parallax.enabled && e.parallax.setTranslate())
            },
            xf = {
                name: "Swiper",
                props: {
                    tag: {
                        type: String,
                        default: "div"
                    },
                    wrapperTag: {
                        type: String,
                        default: "div"
                    },
                    modules: {
                        type: Array,
                        default: void 0
                    },
                    init: {
                        type: Boolean,
                        default: void 0
                    },
                    direction: {
                        type: String,
                        default: void 0
                    },
                    touchEventsTarget: {
                        type: String,
                        default: void 0
                    },
                    initialSlide: {
                        type: Number,
                        default: void 0
                    },
                    speed: {
                        type: Number,
                        default: void 0
                    },
                    cssMode: {
                        type: Boolean,
                        default: void 0
                    },
                    updateOnWindowResize: {
                        type: Boolean,
                        default: void 0
                    },
                    resizeObserver: {
                        type: Boolean,
                        default: void 0
                    },
                    nested: {
                        type: Boolean,
                        default: void 0
                    },
                    focusableElements: {
                        type: String,
                        default: void 0
                    },
                    width: {
                        type: Number,
                        default: void 0
                    },
                    height: {
                        type: Number,
                        default: void 0
                    },
                    preventInteractionOnTransition: {
                        type: Boolean,
                        default: void 0
                    },
                    userAgent: {
                        type: String,
                        default: void 0
                    },
                    url: {
                        type: String,
                        default: void 0
                    },
                    edgeSwipeDetection: {
                        type: [Boolean, String],
                        default: void 0
                    },
                    edgeSwipeThreshold: {
                        type: Number,
                        default: void 0
                    },
                    autoHeight: {
                        type: Boolean,
                        default: void 0
                    },
                    setWrapperSize: {
                        type: Boolean,
                        default: void 0
                    },
                    virtualTranslate: {
                        type: Boolean,
                        default: void 0
                    },
                    effect: {
                        type: String,
                        default: void 0
                    },
                    breakpoints: {
                        type: Object,
                        default: void 0
                    },
                    spaceBetween: {
                        type: Number,
                        default: void 0
                    },
                    slidesPerView: {
                        type: [Number, String],
                        default: void 0
                    },
                    maxBackfaceHiddenSlides: {
                        type: Number,
                        default: void 0
                    },
                    slidesPerGroup: {
                        type: Number,
                        default: void 0
                    },
                    slidesPerGroupSkip: {
                        type: Number,
                        default: void 0
                    },
                    slidesPerGroupAuto: {
                        type: Boolean,
                        default: void 0
                    },
                    centeredSlides: {
                        type: Boolean,
                        default: void 0
                    },
                    centeredSlidesBounds: {
                        type: Boolean,
                        default: void 0
                    },
                    slidesOffsetBefore: {
                        type: Number,
                        default: void 0
                    },
                    slidesOffsetAfter: {
                        type: Number,
                        default: void 0
                    },
                    normalizeSlideIndex: {
                        type: Boolean,
                        default: void 0
                    },
                    centerInsufficientSlides: {
                        type: Boolean,
                        default: void 0
                    },
                    watchOverflow: {
                        type: Boolean,
                        default: void 0
                    },
                    roundLengths: {
                        type: Boolean,
                        default: void 0
                    },
                    touchRatio: {
                        type: Number,
                        default: void 0
                    },
                    touchAngle: {
                        type: Number,
                        default: void 0
                    },
                    simulateTouch: {
                        type: Boolean,
                        default: void 0
                    },
                    shortSwipes: {
                        type: Boolean,
                        default: void 0
                    },
                    longSwipes: {
                        type: Boolean,
                        default: void 0
                    },
                    longSwipesRatio: {
                        type: Number,
                        default: void 0
                    },
                    longSwipesMs: {
                        type: Number,
                        default: void 0
                    },
                    followFinger: {
                        type: Boolean,
                        default: void 0
                    },
                    allowTouchMove: {
                        type: Boolean,
                        default: void 0
                    },
                    threshold: {
                        type: Number,
                        default: void 0
                    },
                    touchMoveStopPropagation: {
                        type: Boolean,
                        default: void 0
                    },
                    touchStartPreventDefault: {
                        type: Boolean,
                        default: void 0
                    },
                    touchStartForcePreventDefault: {
                        type: Boolean,
                        default: void 0
                    },
                    touchReleaseOnEdges: {
                        type: Boolean,
                        default: void 0
                    },
                    uniqueNavElements: {
                        type: Boolean,
                        default: void 0
                    },
                    resistance: {
                        type: Boolean,
                        default: void 0
                    },
                    resistanceRatio: {
                        type: Number,
                        default: void 0
                    },
                    watchSlidesProgress: {
                        type: Boolean,
                        default: void 0
                    },
                    grabCursor: {
                        type: Boolean,
                        default: void 0
                    },
                    preventClicks: {
                        type: Boolean,
                        default: void 0
                    },
                    preventClicksPropagation: {
                        type: Boolean,
                        default: void 0
                    },
                    slideToClickedSlide: {
                        type: Boolean,
                        default: void 0
                    },
                    preloadImages: {
                        type: Boolean,
                        default: void 0
                    },
                    updateOnImagesReady: {
                        type: Boolean,
                        default: void 0
                    },
                    loop: {
                        type: Boolean,
                        default: void 0
                    },
                    loopAdditionalSlides: {
                        type: Number,
                        default: void 0
                    },
                    loopedSlides: {
                        type: Number,
                        default: void 0
                    },
                    loopedSlidesLimit: {
                        type: Boolean,
                        default: !0
                    },
                    loopFillGroupWithBlank: {
                        type: Boolean,
                        default: void 0
                    },
                    loopPreventsSlide: {
                        type: Boolean,
                        default: void 0
                    },
                    rewind: {
                        type: Boolean,
                        default: void 0
                    },
                    allowSlidePrev: {
                        type: Boolean,
                        default: void 0
                    },
                    allowSlideNext: {
                        type: Boolean,
                        default: void 0
                    },
                    swipeHandler: {
                        type: Boolean,
                        default: void 0
                    },
                    noSwiping: {
                        type: Boolean,
                        default: void 0
                    },
                    noSwipingClass: {
                        type: String,
                        default: void 0
                    },
                    noSwipingSelector: {
                        type: String,
                        default: void 0
                    },
                    passiveListeners: {
                        type: Boolean,
                        default: void 0
                    },
                    containerModifierClass: {
                        type: String,
                        default: void 0
                    },
                    slideClass: {
                        type: String,
                        default: void 0
                    },
                    slideBlankClass: {
                        type: String,
                        default: void 0
                    },
                    slideActiveClass: {
                        type: String,
                        default: void 0
                    },
                    slideDuplicateActiveClass: {
                        type: String,
                        default: void 0
                    },
                    slideVisibleClass: {
                        type: String,
                        default: void 0
                    },
                    slideDuplicateClass: {
                        type: String,
                        default: void 0
                    },
                    slideNextClass: {
                        type: String,
                        default: void 0
                    },
                    slideDuplicateNextClass: {
                        type: String,
                        default: void 0
                    },
                    slidePrevClass: {
                        type: String,
                        default: void 0
                    },
                    slideDuplicatePrevClass: {
                        type: String,
                        default: void 0
                    },
                    wrapperClass: {
                        type: String,
                        default: void 0
                    },
                    runCallbacksOnInit: {
                        type: Boolean,
                        default: void 0
                    },
                    observer: {
                        type: Boolean,
                        default: void 0
                    },
                    observeParents: {
                        type: Boolean,
                        default: void 0
                    },
                    observeSlideChildren: {
                        type: Boolean,
                        default: void 0
                    },
                    a11y: {
                        type: [Boolean, Object],
                        default: void 0
                    },
                    autoplay: {
                        type: [Boolean, Object],
                        default: void 0
                    },
                    controller: {
                        type: Object,
                        default: void 0
                    },
                    coverflowEffect: {
                        type: Object,
                        default: void 0
                    },
                    cubeEffect: {
                        type: Object,
                        default: void 0
                    },
                    fadeEffect: {
                        type: Object,
                        default: void 0
                    },
                    flipEffect: {
                        type: Object,
                        default: void 0
                    },
                    creativeEffect: {
                        type: Object,
                        default: void 0
                    },
                    cardsEffect: {
                        type: Object,
                        default: void 0
                    },
                    hashNavigation: {
                        type: [Boolean, Object],
                        default: void 0
                    },
                    history: {
                        type: [Boolean, Object],
                        default: void 0
                    },
                    keyboard: {
                        type: [Boolean, Object],
                        default: void 0
                    },
                    lazy: {
                        type: [Boolean, Object],
                        default: void 0
                    },
                    mousewheel: {
                        type: [Boolean, Object],
                        default: void 0
                    },
                    navigation: {
                        type: [Boolean, Object],
                        default: void 0
                    },
                    pagination: {
                        type: [Boolean, Object],
                        default: void 0
                    },
                    parallax: {
                        type: [Boolean, Object],
                        default: void 0
                    },
                    scrollbar: {
                        type: [Boolean, Object],
                        default: void 0
                    },
                    thumbs: {
                        type: Object,
                        default: void 0
                    },
                    virtual: {
                        type: [Boolean, Object],
                        default: void 0
                    },
                    zoom: {
                        type: [Boolean, Object],
                        default: void 0
                    },
                    grid: {
                        type: [Object],
                        default: void 0
                    },
                    freeMode: {
                        type: [Boolean, Object],
                        default: void 0
                    },
                    enabled: {
                        type: Boolean,
                        default: void 0
                    }
                },
                emits: ["_beforeBreakpoint", "_containerClasses", "_slideClass", "_slideClasses", "_swiper", "_freeModeNoMomentumRelease", "activeIndexChange", "afterInit", "autoplay", "autoplayStart", "autoplayStop", "autoplayPause", "autoplayResume", "beforeDestroy", "beforeInit", "beforeLoopFix", "beforeResize", "beforeSlideChangeStart", "beforeTransitionStart", "breakpoint", "changeDirection", "click", "disable", "doubleTap", "doubleClick", "destroy", "enable", "fromEdge", "hashChange", "hashSet", "imagesReady", "init", "keyPress", "lazyImageLoad", "lazyImageReady", "lock", "loopFix", "momentumBounce", "navigationHide", "navigationShow", "navigationPrev", "navigationNext", "observerUpdate", "orientationchange", "paginationHide", "paginationRender", "paginationShow", "paginationUpdate", "progress", "reachBeginning", "reachEnd", "realIndexChange", "resize", "scroll", "scrollbarDragEnd", "scrollbarDragMove", "scrollbarDragStart", "setTransition", "setTranslate", "slideChange", "slideChangeTransitionEnd", "slideChangeTransitionStart", "slideNextTransitionEnd", "slideNextTransitionStart", "slidePrevTransitionEnd", "slidePrevTransitionStart", "slideResetTransitionStart", "slideResetTransitionEnd", "sliderMove", "sliderFirstMove", "slidesLengthChange", "slidesGridLengthChange", "snapGridLengthChange", "snapIndexChange", "swiper", "tap", "toEdge", "touchEnd", "touchMove", "touchMoveOpposite", "touchStart", "transitionEnd", "transitionStart", "unlock", "update", "virtualUpdate", "zoomChange"],
                setup(e, t) {
                    let {
                        slots: n,
                        emit: r
                    } = t;
                    const {
                        tag: o,
                        wrapperTag: i
                    } = e, a = Ft("swiper"), s = Ft(null), l = Ft(!1), c = Ft(!1), d = Ft(null), u = Ft(null), p = Ft(null), f = {
                        value: []
                    }, h = {
                        value: []
                    }, g = Ft(null), v = Ft(null), m = Ft(null), y = Ft(null), {
                        params: b,
                        passedParams: w
                    } = hf(e, !1);
                    bf(n, f, h), p.value = w, h.value = f.value;
                    const _ = () => {
                        bf(n, f, h), l.value = !0
                    };
                    if (b.onAny = function(e) {
                            for (var t = arguments.length, n = new Array(t > 1 ? t - 1 : 0), o = 1; o < t; o++) n[o - 1] = arguments[o];
                            r(e, ...n)
                        }, Object.assign(b.on, {
                            _beforeBreakpoint: _,
                            _containerClasses(e, t) {
                                a.value = t
                            }
                        }), u.value = new af(b), u.value.loopCreate = () => {}, u.value.loopDestroy = () => {}, b.loop && (u.value.loopedSlides = vf(f.value, b)), u.value.virtual && u.value.params.virtual.enabled) {
                        u.value.virtual.slides = f.value;
                        const e = {
                            cache: !1,
                            slides: f.value,
                            renderExternal: e => {
                                s.value = e
                            },
                            renderExternalUpdate: !1
                        };
                        lf(u.value.params.virtual, e), lf(u.value.originalParams.virtual, e)
                    }

                    function A(e) {
                        return b.virtual ? _f(u, e, s.value) : !b.loop || u.value && u.value.destroyed ? (e.forEach((e => {
                            e.props || (e.props = {}), e.props.swiperRef = u
                        })), e) : mf(u, e, b)
                    }
                    return fr((() => {
                        !c.value && u.value && (u.value.emitSlidesClasses(), c.value = !0);
                        const {
                            passedParams: t
                        } = hf(e, !1), n = yf(t, p.value, f.value, h.value, (e => e.props && e.props.key));
                        p.value = t, (n.length || l.value) && u.value && !u.value.destroyed && wf({
                            swiper: u.value,
                            slides: f.value,
                            passedParams: t,
                            changedParams: n,
                            nextEl: g.value,
                            prevEl: v.value,
                            scrollbarEl: y.value,
                            paginationEl: m.value
                        }), l.value = !1
                    })), Fn("swiper", u), Rn(s, (() => {
                        sn((() => {
                            Af(u.value)
                        }))
                    })), ur((() => {
                        d.value && (gf({
                            el: d.value,
                            nextEl: g.value,
                            prevEl: v.value,
                            paginationEl: m.value,
                            scrollbarEl: y.value,
                            swiper: u.value
                        }, b), r("swiper", u.value))
                    })), hr((() => {
                        u.value && !u.value.destroyed && u.value.destroy(!0, !1)
                    })), () => {
                        const {
                            slides: t,
                            slots: r
                        } = bf(n, f, h);
                        return yi(o, {
                            ref: d,
                            class: pf(a.value)
                        }, [r["container-start"], yi(i, {
                            class: "swiper-wrapper"
                        }, [r["wrapper-start"], A(t), r["wrapper-end"]]), cf(e) && [yi("div", {
                            ref: v,
                            class: "swiper-button-prev"
                        }), yi("div", {
                            ref: g,
                            class: "swiper-button-next"
                        })], uf(e) && yi("div", {
                            ref: y,
                            class: "swiper-scrollbar"
                        }), df(e) && yi("div", {
                            ref: m,
                            class: "swiper-pagination"
                        }), r["container-end"]])
                    }
                }
            },
            Cf = {
                name: "SwiperSlide",
                props: {
                    tag: {
                        type: String,
                        default: "div"
                    },
                    swiperRef: {
                        type: Object,
                        required: !1
                    },
                    zoom: {
                        type: Boolean,
                        default: void 0
                    },
                    virtualIndex: {
                        type: [String, Number],
                        default: void 0
                    }
                },
                setup(e, t) {
                    let {
                        slots: n
                    } = t, r = !1;
                    const {
                        swiperRef: o
                    } = e, i = Ft(null), a = Ft("swiper-slide");

                    function s(e, t, n) {
                        t === i.value && (a.value = n)
                    }
                    ur((() => {
                        o && o.value && (o.value.on("_slideClass", s), r = !0)
                    })), pr((() => {
                        !r && o && o.value && (o.value.on("_slideClass", s), r = !0)
                    })), fr((() => {
                        i.value && o && o.value && o.value.destroyed && "swiper-slide" !== a.value && (a.value = "swiper-slide")
                    })), hr((() => {
                        o && o.value && o.value.off("_slideClass", s)
                    }));
                    const l = mi((() => ({
                        isActive: a.value.indexOf("swiper-slide-active") >= 0 || a.value.indexOf("swiper-slide-duplicate-active") >= 0,
                        isVisible: a.value.indexOf("swiper-slide-visible") >= 0,
                        isDuplicate: a.value.indexOf("swiper-slide-duplicate") >= 0,
                        isPrev: a.value.indexOf("swiper-slide-prev") >= 0 || a.value.indexOf("swiper-slide-duplicate-prev") >= 0,
                        isNext: a.value.indexOf("swiper-slide-next") >= 0 || a.value.indexOf("swiper-slide-duplicate-next") >= 0
                    })));
                    return Fn("swiperSlide", l), () => yi(e.tag, {
                        class: pf(`${a.value}`),
                        ref: i,
                        "data-swiper-slide-index": e.virtualIndex
                    }, e.zoom ? yi("div", {
                        class: "swiper-zoom-container",
                        "data-swiper-zoom": "number" === typeof e.zoom ? e.zoom : void 0
                    }, n.default && n.default(l.value)) : n.default && n.default(l.value))
                }
            };
        n(1161);
        var kf = {
            components: {
                Swiper: xf,
                SwiperSlide: Cf
            },
            mounted() {
                document.addEventListener("keyup", this.Event)
            },
            unmounted() {
                document.removeEventListener("keyup", this.Event)
            },
            setup() {
                const e = Ft(null),
                    {
                        showAlbums: t,
                        albums: n
                    } = Vs(qs()),
                    {
                        theme: r
                    } = Qs(),
                    o = t => {
                        e.value = t
                    },
                    i = e => {
                        if (27 === e.keyCode) return u()
                    },
                    a = e => `./assets/themes/${r}/${e}.png`,
                    s = e => {
                        const t = ["mp4", "webm"];
                        let n = !1;
                        for (let r = 0; r < t.length; r++) {
                            const o = t[r];
                            e.includes(o) && (n = !0)
                        }
                        return n
                    },
                    l = e => (console.log("source ", e), "./assets/video/" + e);

                function c(e) {
                    var t = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*/,
                        n = e.match(t);
                    return !(!n || 11 != n[7].length) && n[7]
                }
                const d = () => {
                        let e = document.querySelectorAll("video");
                        for (let t = 0; t < e.length; t++) {
                            const n = e[t];
                            n.removeAttribute("controls"), setTimeout((() => {
                                n.setAttribute("controls", "controls")
                            }), 100), n.muted = !0, n.play()
                        }
                    },
                    u = () => {
                        t.value = !1
                    };
                return {
                    onSwiper: o,
                    onSlideChange: d,
                    swiperRef: e,
                    Hide: u,
                    GetSrc: a,
                    albums: n,
                    CheckIsVideo: s,
                    Event: i,
                    VideoSrc: l,
                    youtube_parser: c
                }
            }
        };
        n(5328);
        const Sf = (0, dc.Z)(kf, [
            ["render", Cd],
            ["__scopeId", "data-v-5c4d4f3e"]
        ]);
        var Tf = Sf;
        const Ef = {
                class: "loading-bar"
            },
            Of = {
                class: "content"
            },
            Mf = {
                class: "content-header"
            },
            If = {
                class: "content-icons"
            },
            Pf = ["src"],
            Bf = ["src"],
            Lf = ["src"],
            Ff = ["src"];

        function Df(e, n, r, o, i, a) {
            return To(), Po("div", Ef, [jo("div", Of, [jo("h2", Mf, h(o.language?.["CITY_LOADING"] || "Please wait, the city is loading..."), 1), jo("div", If, [jo("div", {
                class: "content-icon",
                onClick: n[0] || (n[0] = (...e) => o.ToggleKeylist && o.ToggleKeylist(...e)),
                style: t({
                    background: o.showKeyboard ? o.themeData["loading-bar"]["button-active"] : o.themeData["loading-bar"]["button"]
                })
            }, [o.showKeyboard ? (To(), Po("img", {
                key: 0,
                src: o.GetSrc("keyboard_active")
            }, null, 8, Pf)) : (To(), Po("img", {
                key: 1,
                src: o.GetSrc("keyboard")
            }, null, 8, Bf))], 4), jo("div", {
                class: "content-icon",
                onClick: n[1] || (n[1] = (...e) => o.ToggleSettings && o.ToggleSettings(...e)),
                style: t({
                    background: o.showSettings ? o.themeData["loading-bar"]["button-active"] : o.themeData["loading-bar"]["button"]
                })
            }, [o.showSettings ? (To(), Po("img", {
                key: 0,
                src: o.GetSrc("settings_active")
            }, null, 8, Lf)) : (To(), Po("img", {
                key: 1,
                src: o.GetSrc("settings")
            }, null, 8, Ff))], 4)])]), jo("div", {
                class: "bar",
                style: t({
                    background: o.themeData["loading-bar"]["progress"]
                })
            }, [jo("div", {
                class: "bar-inner",
                style: t({
                    width: r.percentage + "%",
                    background: o.themeData["loading-bar"]["progress-active"]
                })
            }, null, 4)], 4)])
        }
        var Nf = {
            name: "LoadingBar",
            props: ["percentage"],
            setup() {
                const {
                    showSettings: e,
                    showKeyboard: t
                } = Vs(qs()), {
                    theme: n
                } = Qs(), {
                    themes: r
                } = Wl(), o = Kt((() => r[n])), i = () => {
                    e.value = !1, t.value = !t.value
                }, a = e => `./assets/themes/${n}/${e}.png`, s = () => {
                    t.value = !1, e.value = !e.value
                };
                return {
                    showSettings: e,
                    showKeyboard: t,
                    ToggleKeylist: i,
                    ToggleSettings: s,
                    themeData: o,
                    GetSrc: a,
                    language: window.nuiHandoverData?.Config.Language || []
                }
            }
        };
        n(3912);
        const Rf = (0, dc.Z)(Nf, [
            ["render", Df]
        ]);
        var jf = Rf;
        const Hf = {
                key: 0,
                class: "hint"
            },
            Gf = {
                class: "hint-progress"
            },
            zf = {
                class: "hint-top"
            },
            $f = ["src"],
            Vf = {
                class: "hint-bottom"
            },
            Uf = {
                class: "hint-text"
            };

        function Kf(e, n, r, o, i, a) {
            return 0 != Object.keys(o.currentMessage).length && o.EnableHintMessages ? (To(), Po("div", Hf, [jo("div", Gf, [jo("div", {
                class: "hint-progress-inner",
                style: t({
                    width: o.getPercent + "%",
                    background: o.themeData["hint"]["timer"]
                })
            }, null, 4)]), jo("div", zf, [jo("img", {
                src: o.GetSrc("hint")
            }, null, 8, $f), jo("p", {
                style: t({
                    color: o.themeData["hint"]["header"]
                })
            }, h(o.language?.["HINT"] || "Hint"), 5)]), jo("div", Vf, [jo("div", {
                class: "hint-line",
                style: t({
                    background: o.themeData["hint"]["line"]
                })
            }, null, 4), jo("p", Uf, h(o.currentMessage.text), 1)])])) : Uo("", !0)
        }
        var Yf = {
                update: null,
                begin: null,
                loopBegin: null,
                changeBegin: null,
                change: null,
                changeComplete: null,
                loopComplete: null,
                complete: null,
                loop: 1,
                direction: "normal",
                autoplay: !0,
                timelineOffset: 0
            },
            Wf = {
                duration: 1e3,
                delay: 0,
                endDelay: 0,
                easing: "easeOutElastic(1, .5)",
                round: 0
            },
            Xf = ["translateX", "translateY", "translateZ", "rotate", "rotateX", "rotateY", "rotateZ", "scale", "scaleX", "scaleY", "scaleZ", "skew", "skewX", "skewY", "perspective", "matrix", "matrix3d"],
            Qf = {
                CSS: {},
                springs: {}
            };

        function qf(e, t, n) {
            return Math.min(Math.max(e, t), n)
        }

        function Zf(e, t) {
            return e.indexOf(t) > -1
        }

        function Jf(e, t) {
            return e.apply(null, t)
        }
        var eh = {
            arr: function(e) {
                return Array.isArray(e)
            },
            obj: function(e) {
                return Zf(Object.prototype.toString.call(e), "Object")
            },
            pth: function(e) {
                return eh.obj(e) && e.hasOwnProperty("totalLength")
            },
            svg: function(e) {
                return e instanceof SVGElement
            },
            inp: function(e) {
                return e instanceof HTMLInputElement
            },
            dom: function(e) {
                return e.nodeType || eh.svg(e)
            },
            str: function(e) {
                return "string" === typeof e
            },
            fnc: function(e) {
                return "function" === typeof e
            },
            und: function(e) {
                return "undefined" === typeof e
            },
            nil: function(e) {
                return eh.und(e) || null === e
            },
            hex: function(e) {
                return /(^#[0-9A-F]{6}$)|(^#[0-9A-F]{3}$)/i.test(e)
            },
            rgb: function(e) {
                return /^rgb/.test(e)
            },
            hsl: function(e) {
                return /^hsl/.test(e)
            },
            col: function(e) {
                return eh.hex(e) || eh.rgb(e) || eh.hsl(e)
            },
            key: function(e) {
                return !Yf.hasOwnProperty(e) && !Wf.hasOwnProperty(e) && "targets" !== e && "keyframes" !== e
            }
        };

        function th(e) {
            var t = /\(([^)]+)\)/.exec(e);
            return t ? t[1].split(",").map((function(e) {
                return parseFloat(e)
            })) : []
        }

        function nh(e, t) {
            var n = th(e),
                r = qf(eh.und(n[0]) ? 1 : n[0], .1, 100),
                o = qf(eh.und(n[1]) ? 100 : n[1], .1, 100),
                i = qf(eh.und(n[2]) ? 10 : n[2], .1, 100),
                a = qf(eh.und(n[3]) ? 0 : n[3], .1, 100),
                s = Math.sqrt(o / r),
                l = i / (2 * Math.sqrt(o * r)),
                c = l < 1 ? s * Math.sqrt(1 - l * l) : 0,
                d = 1,
                u = l < 1 ? (l * s - a) / c : -a + s;

            function p(e) {
                var n = t ? t * e / 1e3 : e;
                return n = l < 1 ? Math.exp(-n * l * s) * (d * Math.cos(c * n) + u * Math.sin(c * n)) : (d + u * n) * Math.exp(-n * s), 0 === e || 1 === e ? e : 1 - n
            }

            function f() {
                var t = Qf.springs[e];
                if (t) return t;
                var n = 1 / 6,
                    r = 0,
                    o = 0;
                while (1)
                    if (r += n, 1 === p(r)) {
                        if (o++, o >= 16) break
                    } else o = 0;
                var i = r * n * 1e3;
                return Qf.springs[e] = i, i
            }
            return t ? p : f
        }

        function rh(e) {
            return void 0 === e && (e = 10),
                function(t) {
                    return Math.ceil(qf(t, 1e-6, 1) * e) * (1 / e)
                }
        }
        var oh = function() {
                var e = 11,
                    t = 1 / (e - 1);

                function n(e, t) {
                    return 1 - 3 * t + 3 * e
                }

                function r(e, t) {
                    return 3 * t - 6 * e
                }

                function o(e) {
                    return 3 * e
                }

                function i(e, t, i) {
                    return ((n(t, i) * e + r(t, i)) * e + o(t)) * e
                }

                function a(e, t, i) {
                    return 3 * n(t, i) * e * e + 2 * r(t, i) * e + o(t)
                }

                function s(e, t, n, r, o) {
                    var a, s, l = 0;
                    do {
                        s = t + (n - t) / 2, a = i(s, r, o) - e, a > 0 ? n = s : t = s
                    } while (Math.abs(a) > 1e-7 && ++l < 10);
                    return s
                }

                function l(e, t, n, r) {
                    for (var o = 0; o < 4; ++o) {
                        var s = a(t, n, r);
                        if (0 === s) return t;
                        var l = i(t, n, r) - e;
                        t -= l / s
                    }
                    return t
                }

                function c(n, r, o, c) {
                    if (0 <= n && n <= 1 && 0 <= o && o <= 1) {
                        var d = new Float32Array(e);
                        if (n !== r || o !== c)
                            for (var u = 0; u < e; ++u) d[u] = i(u * t, n, o);
                        return function(e) {
                            return n === r && o === c || 0 === e || 1 === e ? e : i(p(e), r, c)
                        }
                    }

                    function p(r) {
                        for (var i = 0, c = 1, u = e - 1; c !== u && d[c] <= r; ++c) i += t;
                        --c;
                        var p = (r - d[c]) / (d[c + 1] - d[c]),
                            f = i + p * t,
                            h = a(f, n, o);
                        return h >= .001 ? l(r, f, n, o) : 0 === h ? f : s(r, i, i + t, n, o)
                    }
                }
                return c
            }(),
            ih = function() {
                var e = {
                        linear: function() {
                            return function(e) {
                                return e
                            }
                        }
                    },
                    t = {
                        Sine: function() {
                            return function(e) {
                                return 1 - Math.cos(e * Math.PI / 2)
                            }
                        },
                        Circ: function() {
                            return function(e) {
                                return 1 - Math.sqrt(1 - e * e)
                            }
                        },
                        Back: function() {
                            return function(e) {
                                return e * e * (3 * e - 2)
                            }
                        },
                        Bounce: function() {
                            return function(e) {
                                var t, n = 4;
                                while (e < ((t = Math.pow(2, --n)) - 1) / 11);
                                return 1 / Math.pow(4, 3 - n) - 7.5625 * Math.pow((3 * t - 2) / 22 - e, 2)
                            }
                        },
                        Elastic: function(e, t) {
                            void 0 === e && (e = 1), void 0 === t && (t = .5);
                            var n = qf(e, 1, 10),
                                r = qf(t, .1, 2);
                            return function(e) {
                                return 0 === e || 1 === e ? e : -n * Math.pow(2, 10 * (e - 1)) * Math.sin((e - 1 - r / (2 * Math.PI) * Math.asin(1 / n)) * (2 * Math.PI) / r)
                            }
                        }
                    },
                    n = ["Quad", "Cubic", "Quart", "Quint", "Expo"];
                return n.forEach((function(e, n) {
                    t[e] = function() {
                        return function(e) {
                            return Math.pow(e, n + 2)
                        }
                    }
                })), Object.keys(t).forEach((function(n) {
                    var r = t[n];
                    e["easeIn" + n] = r, e["easeOut" + n] = function(e, t) {
                        return function(n) {
                            return 1 - r(e, t)(1 - n)
                        }
                    }, e["easeInOut" + n] = function(e, t) {
                        return function(n) {
                            return n < .5 ? r(e, t)(2 * n) / 2 : 1 - r(e, t)(-2 * n + 2) / 2
                        }
                    }, e["easeOutIn" + n] = function(e, t) {
                        return function(n) {
                            return n < .5 ? (1 - r(e, t)(1 - 2 * n)) / 2 : (r(e, t)(2 * n - 1) + 1) / 2
                        }
                    }
                })), e
            }();

        function ah(e, t) {
            if (eh.fnc(e)) return e;
            var n = e.split("(")[0],
                r = ih[n],
                o = th(e);
            switch (n) {
                case "spring":
                    return nh(e, t);
                case "cubicBezier":
                    return Jf(oh, o);
                case "steps":
                    return Jf(rh, o);
                default:
                    return Jf(r, o)
            }
        }

        function sh(e) {
            try {
                var t = document.querySelectorAll(e);
                return t
            } catch (n) {
                return
            }
        }

        function lh(e, t) {
            for (var n = e.length, r = arguments.length >= 2 ? arguments[1] : void 0, o = [], i = 0; i < n; i++)
                if (i in e) {
                    var a = e[i];
                    t.call(r, a, i, e) && o.push(a)
                } return o
        }

        function ch(e) {
            return e.reduce((function(e, t) {
                return e.concat(eh.arr(t) ? ch(t) : t)
            }), [])
        }

        function dh(e) {
            return eh.arr(e) ? e : (eh.str(e) && (e = sh(e) || e), e instanceof NodeList || e instanceof HTMLCollection ? [].slice.call(e) : [e])
        }

        function uh(e, t) {
            return e.some((function(e) {
                return e === t
            }))
        }

        function ph(e) {
            var t = {};
            for (var n in e) t[n] = e[n];
            return t
        }

        function fh(e, t) {
            var n = ph(e);
            for (var r in e) n[r] = t.hasOwnProperty(r) ? t[r] : e[r];
            return n
        }

        function hh(e, t) {
            var n = ph(e);
            for (var r in t) n[r] = eh.und(e[r]) ? t[r] : e[r];
            return n
        }

        function gh(e) {
            var t = /rgb\((\d+,\s*[\d]+,\s*[\d]+)\)/g.exec(e);
            return t ? "rgba(" + t[1] + ",1)" : e
        }

        function vh(e) {
            var t = /^#?([a-f\d])([a-f\d])([a-f\d])$/i,
                n = e.replace(t, (function(e, t, n, r) {
                    return t + t + n + n + r + r
                })),
                r = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(n),
                o = parseInt(r[1], 16),
                i = parseInt(r[2], 16),
                a = parseInt(r[3], 16);
            return "rgba(" + o + "," + i + "," + a + ",1)"
        }

        function mh(e) {
            var t, n, r, o = /hsl\((\d+),\s*([\d.]+)%,\s*([\d.]+)%\)/g.exec(e) || /hsla\((\d+),\s*([\d.]+)%,\s*([\d.]+)%,\s*([\d.]+)\)/g.exec(e),
                i = parseInt(o[1], 10) / 360,
                a = parseInt(o[2], 10) / 100,
                s = parseInt(o[3], 10) / 100,
                l = o[4] || 1;

            function c(e, t, n) {
                return n < 0 && (n += 1), n > 1 && (n -= 1), n < 1 / 6 ? e + 6 * (t - e) * n : n < .5 ? t : n < 2 / 3 ? e + (t - e) * (2 / 3 - n) * 6 : e
            }
            if (0 == a) t = n = r = s;
            else {
                var d = s < .5 ? s * (1 + a) : s + a - s * a,
                    u = 2 * s - d;
                t = c(u, d, i + 1 / 3), n = c(u, d, i), r = c(u, d, i - 1 / 3)
            }
            return "rgba(" + 255 * t + "," + 255 * n + "," + 255 * r + "," + l + ")"
        }

        function yh(e) {
            return eh.rgb(e) ? gh(e) : eh.hex(e) ? vh(e) : eh.hsl(e) ? mh(e) : void 0
        }

        function bh(e) {
            var t = /[+-]?\d*\.?\d+(?:\.\d+)?(?:[eE][+-]?\d+)?(%|px|pt|em|rem|in|cm|mm|ex|ch|pc|vw|vh|vmin|vmax|deg|rad|turn)?$/.exec(e);
            if (t) return t[1]
        }

        function wh(e) {
            return Zf(e, "translate") || "perspective" === e ? "px" : Zf(e, "rotate") || Zf(e, "skew") ? "deg" : void 0
        }

        function _h(e, t) {
            return eh.fnc(e) ? e(t.target, t.id, t.total) : e
        }

        function Ah(e, t) {
            return e.getAttribute(t)
        }

        function xh(e, t, n) {
            var r = bh(t);
            if (uh([n, "deg", "rad", "turn"], r)) return t;
            var o = Qf.CSS[t + n];
            if (!eh.und(o)) return o;
            var i = 100,
                a = document.createElement(e.tagName),
                s = e.parentNode && e.parentNode !== document ? e.parentNode : document.body;
            s.appendChild(a), a.style.position = "absolute", a.style.width = i + n;
            var l = i / a.offsetWidth;
            s.removeChild(a);
            var c = l * parseFloat(t);
            return Qf.CSS[t + n] = c, c
        }

        function Ch(e, t, n) {
            if (t in e.style) {
                var r = t.replace(/([a-z])([A-Z])/g, "$1-$2").toLowerCase(),
                    o = e.style[t] || getComputedStyle(e).getPropertyValue(r) || "0";
                return n ? xh(e, o, n) : o
            }
        }

        function kh(e, t) {
            return eh.dom(e) && !eh.inp(e) && (!eh.nil(Ah(e, t)) || eh.svg(e) && e[t]) ? "attribute" : eh.dom(e) && uh(Xf, t) ? "transform" : eh.dom(e) && "transform" !== t && Ch(e, t) ? "css" : null != e[t] ? "object" : void 0
        }

        function Sh(e) {
            if (eh.dom(e)) {
                var t, n = e.style.transform || "",
                    r = /(\w+)\(([^)]*)\)/g,
                    o = new Map;
                while (t = r.exec(n)) o.set(t[1], t[2]);
                return o
            }
        }

        function Th(e, t, n, r) {
            var o = Zf(t, "scale") ? 1 : 0 + wh(t),
                i = Sh(e).get(t) || o;
            return n && (n.transforms.list.set(t, i), n.transforms["last"] = t), r ? xh(e, i, r) : i
        }

        function Eh(e, t, n, r) {
            switch (kh(e, t)) {
                case "transform":
                    return Th(e, t, r, n);
                case "css":
                    return Ch(e, t, n);
                case "attribute":
                    return Ah(e, t);
                default:
                    return e[t] || 0
            }
        }

        function Oh(e, t) {
            var n = /^(\*=|\+=|-=)/.exec(e);
            if (!n) return e;
            var r = bh(e) || 0,
                o = parseFloat(t),
                i = parseFloat(e.replace(n[0], ""));
            switch (n[0][0]) {
                case "+":
                    return o + i + r;
                case "-":
                    return o - i + r;
                case "*":
                    return o * i + r
            }
        }

        function Mh(e, t) {
            if (eh.col(e)) return yh(e);
            if (/\s/g.test(e)) return e;
            var n = bh(e),
                r = n ? e.substr(0, e.length - n.length) : e;
            return t ? r + t : r
        }

        function Ih(e, t) {
            return Math.sqrt(Math.pow(t.x - e.x, 2) + Math.pow(t.y - e.y, 2))
        }

        function Ph(e) {
            return 2 * Math.PI * Ah(e, "r")
        }

        function Bh(e) {
            return 2 * Ah(e, "width") + 2 * Ah(e, "height")
        }

        function Lh(e) {
            return Ih({
                x: Ah(e, "x1"),
                y: Ah(e, "y1")
            }, {
                x: Ah(e, "x2"),
                y: Ah(e, "y2")
            })
        }

        function Fh(e) {
            for (var t, n = e.points, r = 0, o = 0; o < n.numberOfItems; o++) {
                var i = n.getItem(o);
                o > 0 && (r += Ih(t, i)), t = i
            }
            return r
        }

        function Dh(e) {
            var t = e.points;
            return Fh(e) + Ih(t.getItem(t.numberOfItems - 1), t.getItem(0))
        }

        function Nh(e) {
            if (e.getTotalLength) return e.getTotalLength();
            switch (e.tagName.toLowerCase()) {
                case "circle":
                    return Ph(e);
                case "rect":
                    return Bh(e);
                case "line":
                    return Lh(e);
                case "polyline":
                    return Fh(e);
                case "polygon":
                    return Dh(e)
            }
        }

        function Rh(e) {
            var t = Nh(e);
            return e.setAttribute("stroke-dasharray", t), t
        }

        function jh(e) {
            var t = e.parentNode;
            while (eh.svg(t)) {
                if (!eh.svg(t.parentNode)) break;
                t = t.parentNode
            }
            return t
        }

        function Hh(e, t) {
            var n = t || {},
                r = n.el || jh(e),
                o = r.getBoundingClientRect(),
                i = Ah(r, "viewBox"),
                a = o.width,
                s = o.height,
                l = n.viewBox || (i ? i.split(" ") : [0, 0, a, s]);
            return {
                el: r,
                viewBox: l,
                x: l[0] / 1,
                y: l[1] / 1,
                w: a,
                h: s,
                vW: l[2],
                vH: l[3]
            }
        }

        function Gh(e, t) {
            var n = eh.str(e) ? sh(e)[0] : e,
                r = t || 100;
            return function(e) {
                return {
                    property: e,
                    el: n,
                    svg: Hh(n),
                    totalLength: Nh(n) * (r / 100)
                }
            }
        }

        function zh(e, t, n) {
            function r(n) {
                void 0 === n && (n = 0);
                var r = t + n >= 1 ? t + n : 0;
                return e.el.getPointAtLength(r)
            }
            var o = Hh(e.el, e.svg),
                i = r(),
                a = r(-1),
                s = r(1),
                l = n ? 1 : o.w / o.vW,
                c = n ? 1 : o.h / o.vH;
            switch (e.property) {
                case "x":
                    return (i.x - o.x) * l;
                case "y":
                    return (i.y - o.y) * c;
                case "angle":
                    return 180 * Math.atan2(s.y - a.y, s.x - a.x) / Math.PI
            }
        }

        function $h(e, t) {
            var n = /[+-]?\d*\.?\d+(?:\.\d+)?(?:[eE][+-]?\d+)?/g,
                r = Mh(eh.pth(e) ? e.totalLength : e, t) + "";
            return {
                original: r,
                numbers: r.match(n) ? r.match(n).map(Number) : [0],
                strings: eh.str(e) || t ? r.split(n) : []
            }
        }

        function Vh(e) {
            var t = e ? ch(eh.arr(e) ? e.map(dh) : dh(e)) : [];
            return lh(t, (function(e, t, n) {
                return n.indexOf(e) === t
            }))
        }

        function Uh(e) {
            var t = Vh(e);
            return t.map((function(e, n) {
                return {
                    target: e,
                    id: n,
                    total: t.length,
                    transforms: {
                        list: Sh(e)
                    }
                }
            }))
        }

        function Kh(e, t) {
            var n = ph(t);
            if (/^spring/.test(n.easing) && (n.duration = nh(n.easing)), eh.arr(e)) {
                var r = e.length,
                    o = 2 === r && !eh.obj(e[0]);
                o ? e = {
                    value: e
                } : eh.fnc(t.duration) || (n.duration = t.duration / r)
            }
            var i = eh.arr(e) ? e : [e];
            return i.map((function(e, n) {
                var r = eh.obj(e) && !eh.pth(e) ? e : {
                    value: e
                };
                return eh.und(r.delay) && (r.delay = n ? 0 : t.delay), eh.und(r.endDelay) && (r.endDelay = n === i.length - 1 ? t.endDelay : 0), r
            })).map((function(e) {
                return hh(e, n)
            }))
        }

        function Yh(e) {
            for (var t = lh(ch(e.map((function(e) {
                    return Object.keys(e)
                }))), (function(e) {
                    return eh.key(e)
                })).reduce((function(e, t) {
                    return e.indexOf(t) < 0 && e.push(t), e
                }), []), n = {}, r = function(r) {
                    var o = t[r];
                    n[o] = e.map((function(e) {
                        var t = {};
                        for (var n in e) eh.key(n) ? n == o && (t.value = e[n]) : t[n] = e[n];
                        return t
                    }))
                }, o = 0; o < t.length; o++) r(o);
            return n
        }

        function Wh(e, t) {
            var n = [],
                r = t.keyframes;
            for (var o in r && (t = hh(Yh(r), t)), t) eh.key(o) && n.push({
                name: o,
                tweens: Kh(t[o], e)
            });
            return n
        }

        function Xh(e, t) {
            var n = {};
            for (var r in e) {
                var o = _h(e[r], t);
                eh.arr(o) && (o = o.map((function(e) {
                    return _h(e, t)
                })), 1 === o.length && (o = o[0])), n[r] = o
            }
            return n.duration = parseFloat(n.duration), n.delay = parseFloat(n.delay), n
        }

        function Qh(e, t) {
            var n;
            return e.tweens.map((function(r) {
                var o = Xh(r, t),
                    i = o.value,
                    a = eh.arr(i) ? i[1] : i,
                    s = bh(a),
                    l = Eh(t.target, e.name, s, t),
                    c = n ? n.to.original : l,
                    d = eh.arr(i) ? i[0] : c,
                    u = bh(d) || bh(l),
                    p = s || u;
                return eh.und(a) && (a = c), o.from = $h(d, p), o.to = $h(Oh(a, d), p), o.start = n ? n.end : 0, o.end = o.start + o.delay + o.duration + o.endDelay, o.easing = ah(o.easing, o.duration), o.isPath = eh.pth(i), o.isPathTargetInsideSVG = o.isPath && eh.svg(t.target), o.isColor = eh.col(o.from.original), o.isColor && (o.round = 1), n = o, o
            }))
        }
        var qh = {
            css: function(e, t, n) {
                return e.style[t] = n
            },
            attribute: function(e, t, n) {
                return e.setAttribute(t, n)
            },
            object: function(e, t, n) {
                return e[t] = n
            },
            transform: function(e, t, n, r, o) {
                if (r.list.set(t, n), t === r.last || o) {
                    var i = "";
                    r.list.forEach((function(e, t) {
                        i += t + "(" + e + ") "
                    })), e.style.transform = i
                }
            }
        };

        function Zh(e, t) {
            var n = Uh(e);
            n.forEach((function(e) {
                for (var n in t) {
                    var r = _h(t[n], e),
                        o = e.target,
                        i = bh(r),
                        a = Eh(o, n, i, e),
                        s = i || bh(a),
                        l = Oh(Mh(r, s), a),
                        c = kh(o, n);
                    qh[c](o, n, l, e.transforms, !0)
                }
            }))
        }

        function Jh(e, t) {
            var n = kh(e.target, t.name);
            if (n) {
                var r = Qh(t, e),
                    o = r[r.length - 1];
                return {
                    type: n,
                    property: t.name,
                    animatable: e,
                    tweens: r,
                    duration: o.end,
                    delay: r[0].delay,
                    endDelay: o.endDelay
                }
            }
        }

        function eg(e, t) {
            return lh(ch(e.map((function(e) {
                return t.map((function(t) {
                    return Jh(e, t)
                }))
            }))), (function(e) {
                return !eh.und(e)
            }))
        }

        function tg(e, t) {
            var n = e.length,
                r = function(e) {
                    return e.timelineOffset ? e.timelineOffset : 0
                },
                o = {};
            return o.duration = n ? Math.max.apply(Math, e.map((function(e) {
                return r(e) + e.duration
            }))) : t.duration, o.delay = n ? Math.min.apply(Math, e.map((function(e) {
                return r(e) + e.delay
            }))) : t.delay, o.endDelay = n ? o.duration - Math.max.apply(Math, e.map((function(e) {
                return r(e) + e.duration - e.endDelay
            }))) : t.endDelay, o
        }
        var ng = 0;

        function rg(e) {
            var t = fh(Yf, e),
                n = fh(Wf, e),
                r = Wh(n, e),
                o = Uh(e.targets),
                i = eg(o, r),
                a = tg(i, n),
                s = ng;
            return ng++, hh(t, {
                id: s,
                children: [],
                animatables: o,
                animations: i,
                duration: a.duration,
                delay: a.delay,
                endDelay: a.endDelay
            })
        }
        var og = [],
            ig = function() {
                var e;

                function t() {
                    e || ag() && sg.suspendWhenDocumentHidden || !(og.length > 0) || (e = requestAnimationFrame(n))
                }

                function n(t) {
                    var r = og.length,
                        o = 0;
                    while (o < r) {
                        var i = og[o];
                        i.paused ? (og.splice(o, 1), r--) : (i.tick(t), o++)
                    }
                    e = o > 0 ? requestAnimationFrame(n) : void 0
                }

                function r() {
                    sg.suspendWhenDocumentHidden && (ag() ? e = cancelAnimationFrame(e) : (og.forEach((function(e) {
                        return e._onDocumentVisibility()
                    })), ig()))
                }
                return "undefined" !== typeof document && document.addEventListener("visibilitychange", r), t
            }();

        function ag() {
            return !!document && document.hidden
        }

        function sg(e) {
            void 0 === e && (e = {});
            var t, n = 0,
                r = 0,
                o = 0,
                i = 0,
                a = null;

            function s(e) {
                var t = window.Promise && new Promise((function(e) {
                    return a = e
                }));
                return e.finished = t, t
            }
            var l = rg(e);
            s(l);

            function c() {
                var e = l.direction;
                "alternate" !== e && (l.direction = "normal" !== e ? "normal" : "reverse"), l.reversed = !l.reversed, t.forEach((function(e) {
                    return e.reversed = l.reversed
                }))
            }

            function d(e) {
                return l.reversed ? l.duration - e : e
            }

            function u() {
                n = 0, r = d(l.currentTime) * (1 / sg.speed)
            }

            function p(e, t) {
                t && t.seek(e - t.timelineOffset)
            }

            function f(e) {
                if (l.reversePlayback)
                    for (var n = i; n--;) p(e, t[n]);
                else
                    for (var r = 0; r < i; r++) p(e, t[r])
            }

            function h(e) {
                var t = 0,
                    n = l.animations,
                    r = n.length;
                while (t < r) {
                    var o = n[t],
                        i = o.animatable,
                        a = o.tweens,
                        s = a.length - 1,
                        c = a[s];
                    s && (c = lh(a, (function(t) {
                        return e < t.end
                    }))[0] || c);
                    for (var d = qf(e - c.start - c.delay, 0, c.duration) / c.duration, u = isNaN(d) ? 1 : c.easing(d), p = c.to.strings, f = c.round, h = [], g = c.to.numbers.length, v = void 0, m = 0; m < g; m++) {
                        var y = void 0,
                            b = c.to.numbers[m],
                            w = c.from.numbers[m] || 0;
                        y = c.isPath ? zh(c.value, u * b, c.isPathTargetInsideSVG) : w + u * (b - w), f && (c.isColor && m > 2 || (y = Math.round(y * f) / f)), h.push(y)
                    }
                    var _ = p.length;
                    if (_) {
                        v = p[0];
                        for (var A = 0; A < _; A++) {
                            p[A];
                            var x = p[A + 1],
                                C = h[A];
                            isNaN(C) || (v += x ? C + x : C + " ")
                        }
                    } else v = h[0];
                    qh[o.type](i.target, o.property, v, i.transforms), o.currentValue = v, t++
                }
            }

            function g(e) {
                l[e] && !l.passThrough && l[e](l)
            }

            function v() {
                l.remaining && !0 !== l.remaining && l.remaining--
            }

            function m(e) {
                var i = l.duration,
                    u = l.delay,
                    p = i - l.endDelay,
                    m = d(e);
                l.progress = qf(m / i * 100, 0, 100), l.reversePlayback = m < l.currentTime, t && f(m), !l.began && l.currentTime > 0 && (l.began = !0, g("begin")), !l.loopBegan && l.currentTime > 0 && (l.loopBegan = !0, g("loopBegin")), m <= u && 0 !== l.currentTime && h(0), (m >= p && l.currentTime !== i || !i) && h(i), m > u && m < p ? (l.changeBegan || (l.changeBegan = !0, l.changeCompleted = !1, g("changeBegin")), g("change"), h(m)) : l.changeBegan && (l.changeCompleted = !0, l.changeBegan = !1, g("changeComplete")), l.currentTime = qf(m, 0, i), l.began && g("update"), e >= i && (r = 0, v(), l.remaining ? (n = o, g("loopComplete"), l.loopBegan = !1, "alternate" === l.direction && c()) : (l.paused = !0, l.completed || (l.completed = !0, g("loopComplete"), g("complete"), !l.passThrough && "Promise" in window && (a(), s(l)))))
            }
            return l.reset = function() {
                var e = l.direction;
                l.passThrough = !1, l.currentTime = 0, l.progress = 0, l.paused = !0, l.began = !1, l.loopBegan = !1, l.changeBegan = !1, l.completed = !1, l.changeCompleted = !1, l.reversePlayback = !1, l.reversed = "reverse" === e, l.remaining = l.loop, t = l.children, i = t.length;
                for (var n = i; n--;) l.children[n].reset();
                (l.reversed && !0 !== l.loop || "alternate" === e && 1 === l.loop) && l.remaining++, h(l.reversed ? l.duration : 0)
            }, l._onDocumentVisibility = u, l.set = function(e, t) {
                return Zh(e, t), l
            }, l.tick = function(e) {
                o = e, n || (n = o), m((o + (r - n)) * sg.speed)
            }, l.seek = function(e) {
                m(d(e))
            }, l.pause = function() {
                l.paused = !0, u()
            }, l.play = function() {
                l.paused && (l.completed && l.reset(), l.paused = !1, og.push(l), u(), ig())
            }, l.reverse = function() {
                c(), l.completed = !l.reversed, u()
            }, l.restart = function() {
                l.reset(), l.play()
            }, l.remove = function(e) {
                var t = Vh(e);
                cg(t, l)
            }, l.reset(), l.autoplay && l.play(), l
        }

        function lg(e, t) {
            for (var n = t.length; n--;) uh(e, t[n].animatable.target) && t.splice(n, 1)
        }

        function cg(e, t) {
            var n = t.animations,
                r = t.children;
            lg(e, n);
            for (var o = r.length; o--;) {
                var i = r[o],
                    a = i.animations;
                lg(e, a), a.length || i.children.length || r.splice(o, 1)
            }
            n.length || r.length || t.pause()
        }

        function dg(e) {
            for (var t = Vh(e), n = og.length; n--;) {
                var r = og[n];
                cg(t, r)
            }
        }

        function ug(e, t) {
            void 0 === t && (t = {});
            var n = t.direction || "normal",
                r = t.easing ? ah(t.easing) : null,
                o = t.grid,
                i = t.axis,
                a = t.from || 0,
                s = "first" === a,
                l = "center" === a,
                c = "last" === a,
                d = eh.arr(e),
                u = d ? parseFloat(e[0]) : parseFloat(e),
                p = d ? parseFloat(e[1]) : 0,
                f = bh(d ? e[1] : e) || 0,
                h = t.start || 0 + (d ? u : 0),
                g = [],
                v = 0;
            return function(e, t, m) {
                if (s && (a = 0), l && (a = (m - 1) / 2), c && (a = m - 1), !g.length) {
                    for (var y = 0; y < m; y++) {
                        if (o) {
                            var b = l ? (o[0] - 1) / 2 : a % o[0],
                                w = l ? (o[1] - 1) / 2 : Math.floor(a / o[0]),
                                _ = y % o[0],
                                A = Math.floor(y / o[0]),
                                x = b - _,
                                C = w - A,
                                k = Math.sqrt(x * x + C * C);
                            "x" === i && (k = -x), "y" === i && (k = -C), g.push(k)
                        } else g.push(Math.abs(a - y));
                        v = Math.max.apply(Math, g)
                    }
                    r && (g = g.map((function(e) {
                        return r(e / v) * v
                    }))), "reverse" === n && (g = g.map((function(e) {
                        return i ? e < 0 ? -1 * e : -e : Math.abs(v - e)
                    })))
                }
                var S = d ? (p - u) / v : u;
                return h + S * (Math.round(100 * g[t]) / 100) + f
            }
        }

        function pg(e) {
            void 0 === e && (e = {});
            var t = sg(e);
            return t.duration = 0, t.add = function(n, r) {
                var o = og.indexOf(t),
                    i = t.children;

                function a(e) {
                    e.passThrough = !0
                }
                o > -1 && og.splice(o, 1);
                for (var s = 0; s < i.length; s++) a(i[s]);
                var l = hh(n, fh(Wf, e));
                l.targets = l.targets || e.targets;
                var c = t.duration;
                l.autoplay = !1, l.direction = t.direction, l.timelineOffset = eh.und(r) ? c : Oh(r, c), a(t), t.seek(l.timelineOffset);
                var d = sg(l);
                a(d), i.push(d);
                var u = tg(i, e);
                return t.delay = u.delay, t.endDelay = u.endDelay, t.duration = u.duration, t.seek(0), t.reset(), t.autoplay && t.play(), t
            }, t
        }
        sg.version = "3.2.1", sg.speed = 1, sg.suspendWhenDocumentHidden = !0, sg.running = og, sg.remove = dg, sg.get = Eh, sg.set = Zh, sg.convertPx = xh, sg.path = Gh, sg.setDashoffset = Rh, sg.stagger = ug, sg.timeline = pg, sg.easing = ah, sg.penner = ih, sg.random = function(e, t) {
            return Math.floor(Math.random() * (t - e + 1)) + e
        };
        var fg = sg,
            hg = {
                name: "Hint",
                mounted() {
                    let e = !1;
                    const t = () => {
                        0 != Object.keys(this.currentMessage).length && (fg({
                            targets: ".hint",
                            scale: .5,
                            opacity: 0,
                            duration: 300,
                            easing: "linear"
                        }), setTimeout((() => {
                            e && clearInterval(e), e = setInterval((() => {
                                this.currentMessage.time - 1e3 >= 0 && (this.currentMessage.time -= 1e3)
                            }), 1e3), fg({
                                targets: ".hint",
                                scale: 1,
                                opacity: 1,
                                easing: "linear",
                                duration: 500
                            }), this.currentMessageIndex++, this.currentMessage = {
                                ...this.hintMessages[this.currentMessageIndex]
                            }, 0 == Object.keys(this.currentMessage).length && (this.currentMessage = {
                                ...this.hintMessages[0]
                            }, this.currentMessageIndex = 0), this.interval && clearInterval(this.interval)
                        }), 500), this.interval = setInterval(t, this.hintMessages[this.currentMessageIndex]?.time + 1e3 || 1e4))
                    };
                    this.interval = setInterval(t, this.hintMessages[this.currentMessageIndex]?.time + 1e3 || 1e4), e && clearInterval(e), e = setInterval((() => {
                        0 != Object.keys(this.currentMessage).length && this.currentMessage.time - 1e3 >= 0 && (this.currentMessage.time -= 1e3)
                    }), 1e3)
                },
                unmounted() {
                    this.interval && clearInterval(this.interval)
                },
                setup() {
                    const {
                        themes: e
                    } = Wl(), {
                        hintMessages: t
                    } = Vs(qs()), n = Ft(0), r = Ft(!1), o = Ft({
                        ...t.value[0]
                    }), i = mi((() => 0 != Object.keys(o.value).length ? o.value.time / t.value[n.value].time * 100 : 0)), a = e => `./assets/themes/${s.value}/${e}.png`, {
                        theme: s
                    } = Vs(Qs()), l = mi((() => e[s.value]));
                    return {
                        themeData: l,
                        GetSrc: a,
                        currentMessage: o,
                        currentMessageIndex: n,
                        hintMessages: t,
                        getPercent: i,
                        interval: r,
                        EnableHintMessages: window?.nuiHandoverData?.Config.EnableHintMessages || !0,
                        language: window.nuiHandoverData?.Config.Language || []
                    }
                }
            };
        n(7867);
        const gg = (0, dc.Z)(hg, [
            ["render", Kf]
        ]);
        var vg = gg,
            mg = n(2005),
            yg = {
                name: "App",
                components: {
                    LeftMenu: ed,
                    LoadingBar: jf,
                    RightMenu: hd,
                    Hint: vg,
                    Keybinds: yc,
                    Album: Tf
                },
                setup() {
                    const e = Ft(!1),
                        t = Ft(0),
                        n = Ft(0),
                        r = Ft(0),
                        o = mi((() => n.value / t.value * 100)),
                        {
                            enableSound: i,
                            showAll: a,
                            showLeftMenu: s,
                            showHint: l,
                            theme: c
                        } = Vs(Qs()),
                        {
                            showSettings: d,
                            showKeyboard: u,
                            showAlbums: p
                        } = Vs(qs()),
                        f = e => {
                            const t = ["mp4", "webm"];
                            let n = !1;
                            for (let r = 0; r < t.length; r++) {
                                const o = t[r];
                                e.includes(o) && (n = !0)
                            }
                            return n
                        },
                        h = Ft(!1),
                        g = () => {
                            i.value && (h.value = new mg.Howl({
                                src: ["./assets/music/music.mp3"],
                                autoplay: !0,
                                loop: !0,
                                volume: .2
                            }), h.value.play())
                        };
                    Rn(i, (e => {
                        e ? g() : v()
                    }));
                    const v = () => {
                            h.value && h.value.stop()
                        },
                        m = e => "logo" == e && window.nuiHandoverData?.Config.Logo && "default" != window.nuiHandoverData.Config.Logo ? window.nuiHandoverData.Config.Logo : `./assets/themes/${c.value}/${e}.png`,
                        y = () => "default" == window.nuiHandoverData?.Config?.BackgroundImage ? `./assets/themes/${c.value}/bg.png` : `./assets/background/${window?.nuiHandoverData?.Config.BackgroundImage||"bg_video.webm"}`;
                    return ur((() => {
                        g(), document.getElementById("video").muted = !0, document.getElementById("video").play();
                        const e = {
                            startInitFunctionOrder(e) {
                                t.value = e.count
                            },
                            initFunctionInvoking(e) {
                                r.value = e.idx / t.value * 100
                            },
                            startDataFileEntries(e) {
                                t.value = e.count
                            },
                            performMapLoadFunction(e) {
                                ++n.value, r.value = n.value / t.value * 100
                            }
                        };
                        window.addEventListener("message", (function(t) {
                            (e[t.data.eventName] || function() {})(t.data)
                        }))
                    })), gr((() => {})), {
                        getPercentage: o,
                        showSettings: d,
                        showKeyboard: u,
                        showAlbums: p,
                        showLeftMenu: s,
                        showHint: l,
                        showAll: a,
                        theme: c,
                        GetSrc: m,
                        playMusic: g,
                        sound: h,
                        progress: r,
                        loaded: e,
                        CheckIsVideo: f,
                        bgImage: y
                    }
                }
            };
        n(7062);
        const bg = (0, dc.Z)(yg, [
            ["render", Xs]
        ]);
        var wg = bg;
        const _g = Is();
        Ca(wg).use(_g).mount("#app")
    }()
})();