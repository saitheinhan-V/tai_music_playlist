import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tai_music/theme/theme_state.dart';
import 'package:tai_music/utils/responsive.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeState>(context);
    final theme = themeState.currentTheme;
    final responsive = Responsive.of(context);
    final switchThemeStatus = themeState.isDarkTheme;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Row(
          children: [
            const SizedBox(
              // width: responsive.widthPercent(5),
              width: 50.0,
              child: Image(
                image: AssetImage('assets/images/artist.png'),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              'Menu',
              style: TextStyle(
                color: theme.accentColor,
              ),
            ),
            Transform.scale(
              scale: .5,
              child: Switch.adaptive(
                value: switchThemeStatus,
                activeColor: const Color(0xff3183f6),
                onChanged: (value) => themeState.isDarkTheme = value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
