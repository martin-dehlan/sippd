import 'package:flutter/material.dart';

/// share_plus 10.x crashes (`PlatformException(error, sharePositionOrigin:
/// argument must be set, {{0,0},{0,0}} must be non-zero...)`) when the
/// platform share sheet is asked to anchor without an origin Rect. iPad has
/// always required this for popover positioning; iOS 17+ surfaces the same
/// requirement in some run contexts. Pass the result of this helper as
/// `sharePositionOrigin:` on every `Share.share*` call.
///
/// Best signal we have for the visible UI surface is the [BuildContext]'s
/// own RenderBox — typically the button or sheet that triggered the share.
/// Falls back to a screen-centred 1×1 rect when the box hasn't laid out yet
/// (e.g. share fired from a closed menu): non-zero, on-screen, valid origin.
Rect shareOriginFor(BuildContext context) {
  final box = context.findRenderObject() as RenderBox?;
  if (box != null && box.hasSize) {
    return box.localToGlobal(Offset.zero) & box.size;
  }
  final size = MediaQuery.of(context).size;
  return Rect.fromCenter(
    center: Offset(size.width / 2, size.height / 2),
    width: 1,
    height: 1,
  );
}
