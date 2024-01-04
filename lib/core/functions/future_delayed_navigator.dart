/// Add a brief delay to display a splash effect before navigating back.
///
/// This enhances the user experience by giving visual feedback on tap.
///
/// The delay is 350 milliseconds.
void futureDelayedNavigator(void Function() action) {
  Future.delayed(
    const Duration(milliseconds: 350),
    action,
  );
}
