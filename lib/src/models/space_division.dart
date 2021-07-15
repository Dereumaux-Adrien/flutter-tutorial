/// Class used to get user chosen space division:
/// - height is divided in three parts (empty top, middle where the text is
///     tutorial text is and the last one where the button is located)
class SpaceDivision {
  /// First from top to bottom or left to right
  final int first;
  final int middle;
  final int last;

  const SpaceDivision(
    this.first,
    this.middle,
    this.last,
  );
}
