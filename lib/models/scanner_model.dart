class Scanner {
  final String? dispSym;
  final String? baseSym;
  final String? companyName;
  final String? ltp;
  final String? chng;
  final String? chngPer;
  final String? exc;
  final Map<String, String>? additionalData;

  Scanner({
    this.dispSym,
    this.baseSym,
    this.companyName,
    this.ltp,
    this.chng,
    this.chngPer,
    this.exc,
    this.additionalData,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (dispSym != null) data['dispSym'] = dispSym;
    if (baseSym != null) data['baseSym'] = baseSym;
    if (companyName != null) data['companyName'] = companyName;
    if (ltp != null) data['ltp'] = ltp;
    if (chng != null) data['chng'] = chng;
    if (chngPer != null) data['chngPer'] = chngPer;
    if (exc != null) data['exc'] = exc;
    if (additionalData != null) {
      additionalData!.forEach((key, value) {
        data[key] = value;
      });
    }
    return data;
  }
}

