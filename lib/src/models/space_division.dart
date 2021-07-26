/// Class used to get user chosen space division:
/// - height is divided in three parts (empty top, middle where the text is
///     tutorial text is and the last one where the button is located)
class SpaceDivision {
  /// First from top to bottom
  final int topSpace;
  final int textSpace;
  final int middleSpace;
  final int nextSpace;
  final int bottomSpace;

  const SpaceDivision({
    this.topSpace = 1,
    this.textSpace = 6,
    this.middleSpace = 0,
    this.nextSpace = 1,
    this.bottomSpace = 0,
  });
}
