/// The exact glyphs Figma draws inside each row's teal tile — exported from
/// the Final page's `Profile` frame (`1372:1676`), already white. Each is
/// 28.8px (or 36px for the two that were exported at tile size), so they
/// centre on the 36px tile without any offset.
class ProfileGlyphs {
  ProfileGlyphs._();

  static const _dir = 'assets/icons/profile_';

  static const chart = '${_dir}chart.svg';
  static const education = '${_dir}education.svg';
  static const investor = '${_dir}investor.svg';
  static const user = '${_dir}user.svg';
  static const gift = '${_dir}gift.svg';
  static const tickets = '${_dir}tickets.svg';
  static const support = '${_dir}support.svg';
  static const star = '${_dir}star.svg';
  static const rupee = '${_dir}rupee.svg';
  static const share = '${_dir}share.svg';
  static const bell = '${_dir}bell.svg';
  static const privacy = '${_dir}privacy.svg';
  static const document = '${_dir}document.svg';

  /// The row chevron (7x3.95 box, drawn pointing right, `#153D3A` at 60%).
  static const chevron = '${_dir}chevron.svg';
  static const camera = '${_dir}camera.svg';
}
