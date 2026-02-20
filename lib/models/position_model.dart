class Position {
  final String? dispSym;
  final String? baseSym;
  final String? sym;
  final String? exc;
  final String? prdType;
  final String? companyName;
  final String? netQty;
  final String? avgPrice;
  final String? ltp;
  final String? netPnl;
  final String? pnlPerc;
  final String? todayPL;
  final String? todayPLPercentage;
  final String? overallPnL;
  final String? overallPnLPercent;
  final String? currentValue;
  final String? investedValue;
  final String? buyQty;
  final String? sellQty;
  final String? buyAvgPrice;
  final String? sellAvgPrice;
  final bool? isFno;
  final String? optionType;
  final String? strikePrice;
  final String? expiryDate;

  Position({
    this.dispSym,
    this.baseSym,
    this.sym,
    this.exc,
    this.prdType,
    this.companyName,
    this.netQty,
    this.avgPrice,
    this.ltp,
    this.netPnl,
    this.pnlPerc,
    this.todayPL,
    this.todayPLPercentage,
    this.overallPnL,
    this.overallPnLPercent,
    this.currentValue,
    this.investedValue,
    this.buyQty,
    this.sellQty,
    this.buyAvgPrice,
    this.sellAvgPrice,
    this.isFno,
    this.optionType,
    this.strikePrice,
    this.expiryDate,
  });
}

class PositionsModel {
  final String? totBuyVal;
  final String? totBuyQnty;
  final String? totSellQnty;
  final String? totSellVal;
  final String? overallTodayPnL;
  final String? overallTodayPnLPercent;
  final String? overallPnL;
  final String? overallPnLPercent;
  final List<Position>? positions;

  PositionsModel({
    this.totBuyVal,
    this.totBuyQnty,
    this.totSellQnty,
    this.totSellVal,
    this.overallTodayPnL,
    this.overallTodayPnLPercent,
    this.overallPnL,
    this.overallPnLPercent,
    this.positions,
  });
}

