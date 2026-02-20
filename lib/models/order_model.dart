class Order {
  final String? ordId;
  final String? sym;
  final String? dispSym;
  final String? baseSym;
  final String? exc;
  final String? prdType;
  final String? ordType;
  final String? ordAction;
  final String? status;
  final String? qty;
  final String? tradedQty;
  final String? limitPrice;
  final String? avgPrice;
  final String? ltp;
  final String? ordDate;
  final bool? isAmo;
  final bool? isBasket;
  final String? comments;

  Order({
    this.ordId,
    this.sym,
    this.dispSym,
    this.baseSym,
    this.exc,
    this.prdType,
    this.ordType,
    this.ordAction,
    this.status,
    this.qty,
    this.tradedQty,
    this.limitPrice,
    this.avgPrice,
    this.ltp,
    this.ordDate,
    this.isAmo,
    this.isBasket,
    this.comments,
  });
}

