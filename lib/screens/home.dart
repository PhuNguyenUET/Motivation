import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivation/constants/button_style.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:motivation/models/quote.dart';
import 'package:motivation/screens/collection_addition_screen.dart';
import 'package:motivation/screens/favourite_icon.dart';
import 'package:motivation/screens/loading.dart';
import 'package:motivation/screens/loading_screen.dart';
import 'package:motivation/screens/quotes_controller.dart';
import 'package:motivation/screens/reminders_screen.dart';
import 'package:motivation/screens/save_screen.dart';
import 'package:motivation/screens/settings.dart';
import 'package:motivation/screens/theme_select.dart';
import 'package:motivation/screens/topics.dart';
import 'package:motivation/services/post_notification_service.dart';
import 'package:motivation/services/screenshot_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'user_controller.dart';
import '../main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var backgroundImage = AssetImage('assets/loading_background.jpg');

  @override
  Widget build(BuildContext context) {
    var quoteState = Provider.of<QuoteController>(context, listen: true);
    var decorState = Provider.of<DecorController>(context, listen: true);
    var loadingOverlay = LoadingScreen().loadingOverlay;

    void _showSettingsPanel() {
      showModalBottomSheet<dynamic>(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext bc) {
            return Wrap(
              children: [
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.8,
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: const SettingsTab(),
                )
              ],
            );
          });
    }

    void _showUserQuoteAdditonPanel(Quote currentQuote) {
      showModalBottomSheet<dynamic>(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext bc) {
            return Wrap(
              children: [
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.8,
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: CollectionAdditionScreen(currentQuote: currentQuote),
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
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.8,
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
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.8,
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: const Topics(),
                )
              ],
            );
          });
    }

    Future<void> initiateData() async {
      await decorState.initUserIntegration();
      await quoteState.initInstance();
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: FutureBuilder<void>(
            future: initiateData(),
            builder: (BuildContext context,
                AsyncSnapshot<void> snapshot) {
              if(snapshot.hasError) {
                print(snapshot.error);
              }
              if (snapshot.connectionState == ConnectionState.done) {
                backgroundImage = AssetImage('assets/wallpaper_${decorState
                    .getBackgroundIndex()}.jpg');
              }
              return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: backgroundImage,
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
                                  fontFamily: 'Font${snapshot.connectionState ==
                                      ConnectionState.done ? decorState
                                      .getFontIndex() : 0}',
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
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  snapshot.connectionState ==
                                      ConnectionState.waiting
                                      ? 'Fetching...'
                                      : quoteState.getCurrentQuote(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Font${snapshot
                                          .connectionState ==
                                          ConnectionState.done ? decorState
                                          .getFontIndex() : 0}',
                                      color: Colors.white,
                                      fontSize: 25.0),
                                ),
                                Text(
                                  snapshot.connectionState ==
                                      ConnectionState.waiting
                                      ? ''
                                      : quoteState.getCurrentAuthor(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Font${snapshot
                                          .connectionState ==
                                          ConnectionState.done ? decorState
                                          .getFontIndex() : 0}',
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
                            onPressed: () async {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                                  quoteState.noQuotes) {
                                return;
                              }
                              Overlay.of(context).insert(loadingOverlay);
                              Uint8List img = await ScreenshotSaver()
                                  .captureScreen(AssetImage(
                                  'assets/wallpaper_${decorState
                                      .getBackgroundIndex()}.jpg'),
                                  quoteState.getCurrentQuote(),
                                  quoteState.getCurrentAuthor(),
                                  'Font${decorState.getFontIndex()}');
                              final tempDir = await getTemporaryDirectory();
                              File file = await File(
                                  '${tempDir.path}/image.png').create();
                              file.writeAsBytesSync(img);
                              loadingOverlay.remove();
                              await Share.shareXFiles(
                                [
                                  new XFile('${tempDir.path}/image.png'),
                                ],
                                subject: 'Shared quote',
                              );
                            },
                            icon: const Icon(
                              Symbols.share,
                              size: 50.0,
                              weight: 200,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          IconButton(
                            onPressed: () async {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                                  quoteState.noQuotes) {
                                return;
                              }
                              _showUserQuoteAdditonPanel(quoteState.getCurrentQuoteObject());
                            },
                            icon: const Icon(
                              Symbols.bookmark_add,
                              size: 50.0,
                              weight: 200,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          FavouriteIcon(),
                        ],
                      ),
                      const SizedBox(height: 60.0)
                    ],
                  ),
                ),
              );
            })
    );
  }
}
