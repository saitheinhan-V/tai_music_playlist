import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

L10n useL10n(BuildContext context) {
  // final context = useContext();
  return L10n.of(context)!;
}
