import 'performance_json.dart';
import 'performance_kind.dart';

enum TradeSide { buy, sell }

/// A trade row. The shape depends on the board's kind — see the subtypes.
/// Rows carry no serial number; the list numbers them by position.
sealed class PerformanceTrade {
  const PerformanceTrade({
    required this.id,
    required this.tradeDate,
    required this.name,
    this.logoUrl,
  });

  final String id;
  final DateTime tradeDate;
  final String name;

  /// The stock's logo, a ready absolute URL (no auth, load it as is). Null when
  /// the stock isn't in the server's table or has none yet — normal, not an
  /// error: the row shows [initials]. Also the fallback if the image fails.
  final String? logoUrl;

  /// Null for a row with no id or date, which is skipped rather than drawn.
  static PerformanceTrade? fromJson(
    Map<String, dynamic> json,
    PerformanceKind kind,
  ) {
    final id = json['id'] as String?;
    final date = asDate(json['tradeDate']);
    if (id == null || date == null) return null;
    return kind == PerformanceKind.intraday
        ? IntradayTrade.fromJson(json, id, date)
        : SwingTrade.fromJson(json, id, date);
  }

  /// "MF" for Muthoot Finance — the first letter of the first two words, or the
  /// first two letters of a single word.
  String get initials {
    final words = name.trim().split(RegExp(r'\s+'));
    if (name.trim().isEmpty) return '?';
    final raw = words.length > 1
        ? '${words[0][0]}${words[1][0]}'
        : name.trim().substring(0, name.trim().length < 2 ? 1 : 2);
    return raw.toUpperCase();
  }
}

class IntradayTrade extends PerformanceTrade {
  const IntradayTrade({
    required super.id,
    required super.tradeDate,
    required super.name,
    super.logoUrl,
    required this.side,
    required this.entryPrice,
    required this.exitPrice,
    required this.plPerShare,
    required this.plPct,
    required this.grossPnl,
    required this.charges,
    required this.netPnl,
  });

  final TradeSide side;
  final double entryPrice;
  final double exitPrice;

  /// The "P/L" column, against [grossPnl] ("P&L").
  final double plPerShare;
  final double plPct;
  final double grossPnl;

  /// A positive cost — shown as `-140`.
  final double charges;
  final double netPnl;

  factory IntradayTrade.fromJson(
    Map<String, dynamic> json,
    String id,
    DateTime date,
  ) => IntradayTrade(
    id: id,
    tradeDate: date,
    name: json['name'] as String? ?? '',
    logoUrl: _logo(json),
    side: json['side'] == 'sell' ? TradeSide.sell : TradeSide.buy,
    entryPrice: asDouble(json['entryPrice']) ?? 0,
    exitPrice: asDouble(json['exitPrice']) ?? 0,
    plPerShare: asDouble(json['plPerShare']) ?? 0,
    plPct: asDouble(json['plPct']) ?? 0,
    grossPnl: asDouble(json['grossPnl']) ?? 0,
    charges: asDouble(json['charges']) ?? 0,
    netPnl: asDouble(json['netPnl']) ?? 0,
  );
}

class SwingTrade extends PerformanceTrade {
  const SwingTrade({
    required super.id,
    required super.tradeDate,
    required super.name,
    super.logoUrl,
    required this.symbol,
    required this.entryPrice,
    required this.cmp,
    required this.returnPct,
    required this.targetMet,
    required this.targetPct,
    required this.targetPrice,
    required this.analysis,
    required this.exitDate,
    required this.holdingDays,
    this.theme,
    this.sector,
    this.stockType,
  });

  final String? symbol;
  final double entryPrice;

  /// As of the admin's last upload, **not live**. Null when none was given.
  final double? cmp;

  /// Meaningless once [targetMet]; null means "show a dash".
  final double? returnPct;

  /// Exactly when the trade has an exit date. Never derived from [cmp] — a
  /// target-met trade can have a CMP below its entry.
  final bool targetMet;
  final double? targetPct;
  final double? targetPrice;

  /// Free text from the admin (`HOLD`, `5% booked`); unknown text is plain.
  final String? analysis;

  /// Null means the trade is still open.
  final DateTime? exitDate;
  final int? holdingDays;

  /// The Long Term sheet's "Theme / Sector / Type" column. **Not in the API
  /// guide** — read from `theme`, `sector` and `type` if the backend sends them;
  /// null otherwise.
  final String? theme;
  final String? sector;
  final String? stockType;

  /// "Theme / Sector / Type" joined, or null when none is known.
  String? get classification {
    final parts = [theme, sector, stockType].whereType<String>().toList();
    return parts.isEmpty ? null : parts.join(' / ');
  }

  bool get isOpen => exitDate == null;

  factory SwingTrade.fromJson(
    Map<String, dynamic> json,
    String id,
    DateTime date,
  ) => SwingTrade(
    id: id,
    tradeDate: date,
    name: json['name'] as String? ?? '',
    logoUrl: _logo(json),
    symbol: json['symbol'] as String?,
    entryPrice: asDouble(json['entryPrice']) ?? 0,
    cmp: asDouble(json['cmp']),
    returnPct: asDouble(json['returnPct']),
    targetMet: json['status'] == 'target_met',
    targetPct: asDouble(json['targetPct']),
    targetPrice: asDouble(json['targetPrice']),
    analysis: (json['analysis'] as String?)?.trim().isEmpty ?? true
        ? null
        : json['analysis'] as String,
    exitDate: asDate(json['exitDate']),
    holdingDays: json['holdingDays'] is num
        ? (json['holdingDays'] as num).toInt()
        : null,
    theme: _text(json['theme']),
    sector: _text(json['sector']),
    stockType: _text(json['type']),
  );
}

String? _text(Object? v) =>
    v is String && v.trim().isNotEmpty ? v.trim() : null;

String? _logo(Map<String, dynamic> json) {
  final url = json['logoUrl'];
  return url is String && url.isNotEmpty ? url : null;
}
