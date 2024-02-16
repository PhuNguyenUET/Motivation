import 'package:flutter/material.dart';
import 'package:motivation/constants/button_style.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:motivation/models/quote.dart';
import 'package:motivation/screens/loading.dart';
import 'package:motivation/screens/quotes_controller.dart';
import 'package:motivation/screens/settings.dart';
import 'package:motivation/screens/theme_select.dart';
import 'package:motivation/screens/topics.dart';
import 'package:provider/provider.dart';
import '../decor_controller.dart';
import '../main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var quoteState = Provider.of<QuoteController>(context, listen:true);
    var decorState = Provider.of<DecorController>(context, listen:true);

    void _showSettingsPanel() {
      showModalBottomSheet<dynamic>(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext bc) {
            return Wrap(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: const SettingsTab(),
                )
              ],
            );
          });
    }

    void _showThemePanel() {
      showModalBottomSheet<dynamic>(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext bc) {
            return Wrap(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: ThemeSelection(),
                )
              ],
            );
          });
    }

    void _showTopicsPanel() {
      showModalBottomSheet<dynamic>(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext bc) {
            return Wrap(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: const Topics(),
                )
              ],
            );
          });
    }

    return FutureBuilder<void>(
      future: quoteState.initInstance(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print("Waiting");
        } else {
          if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
          } else {
            print("Initiation completed");
          }
          print("Done waiting");
        }
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/wallpaper_${decorState.backgroundIndex}.jpg'),
                  fit: BoxFit.cover,
                )),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10.0),
                      ElevatedButton.icon(
                        onPressed: () => _showTopicsPanel(),
                        style: buttonStyle,
                        icon: const Icon(
                          Symbols.dashboard,
                          size: 35.0,
                          weight: 200,
                          color: Colors.white,
                        ),
                        label: Text(
                          quoteState.category,
                          style: TextStyle(
                              fontFamily: 'Font${decorState.fontIndex}',
                              fontSize: 20.0,
                              color: Colors.white),
                        ),
                      ),
                      Expanded(child: SizedBox(width: double.infinity)),
                      ElevatedButton(
                          onPressed: () => _showThemePanel(),
                          style: buttonStyle,
                          child: const Icon(
                            Symbols.format_paint,
                            size: 35.0,
                            weight: 200,
                            color: Colors.white,
                          )),
                      const SizedBox(
                        width: 15.0,
                      ),
                      ElevatedButton(
                          onPressed: () => _showSettingsPanel(),
                          style: buttonStyle,
                          child: const Icon(
                            Symbols.person_outline,
                            size: 35.0,
                            weight: 200,
                            color: Colors.white,
                          )),
                      SizedBox(width: 10.0),
                    ],
                  ),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onVerticalDragEnd: (details) async {
                        if (details.primaryVelocity! < 0) {
                          await quoteState.increaseQuoteIndex();
                        } else if (details.primaryVelocity! > 0) {
                          quoteState.decreaseQuoteIndex();
                        }
                      },
                      onHorizontalDragUpdate: (details) {},
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.connectionState == ConnectionState.waiting? 'Fetching...' : quoteState.getCurrentQuote(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Font${decorState.fontIndex}',
                                  color: Colors.white,
                                  fontSize: 25.0),
                            ),
                            Text(
                              snapshot.connectionState == ConnectionState.waiting? '': quoteState.getCurrentAuthor(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Font${decorState.fontIndex}',
                                  color: Colors.white,
                                  fontSize: 15.0),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Symbols.share,
                          size: 50.0,
                          weight: 200,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Symbols.favorite_border,
                          size: 50.0,
                          weight: 200,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60.0)
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
