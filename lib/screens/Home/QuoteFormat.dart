import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:motivation/screens/Home/quote_column.dart';
import 'package:motivation/screens/Home/quotes_controller.dart';
import 'package:motivation/screens/Home/user_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/quote.dart';
import '../../services/screenshot_saver.dart';
import '../CollectionScreen/collection_addition_screen.dart';
import '../UtilityScreens/loading_screen.dart';
import 'favourite_icon.dart';

class QuoteFormat extends StatefulWidget {
  bool isWaiting = false;

  QuoteFormat({super.key, required this.isWaiting});

  @override
  State<QuoteFormat> createState() => _QuoteFormatState();
}

class _QuoteFormatState extends State<QuoteFormat> {
  late PageController _pageViewController;
  int _currentPageIndex = 0;
  late int screenSize;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageViewController.dispose();
  }

  void _updateCurrentPageIndex(int index) {
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    var quoteState = Provider.of<QuoteController>(context, listen: true);
    var decorState = Provider.of<DecorController>(context, listen: true);
    var loadingOverlay = LoadingScreen().loadingOverlay;

    void handlePageViewChanged(int currentPageIndex) {
      quoteState.updateQuoteIndex(currentPageIndex);
      setState(() {
        _currentPageIndex = currentPageIndex;
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

    return Column(
      children: [
        Expanded(
            child: widget.isWaiting
                ? QuoteColumn(quote: 'Fetching...', author: '', fontId: 0)
                : PageView.builder(
                itemCount: quoteState.getQuotesCount() == 0 ? 1 : quoteState.getQuotesCount(),
                controller: _pageViewController,
                onPageChanged: handlePageViewChanged,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  Quote quote = quoteState.getQuoteAtIndex(index);
                  return QuoteColumn(
                      quote: quote.quote,
                      author: quote.author ?? '',
                      fontId: decorState.getFontIndex());
                })),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () async {
                if (widget.isWaiting ||
                    quoteState.noQuotes) {
                  return;
                }
                Overlay.of(context).insert(loadingOverlay);
                Uint8List img = await ScreenshotSaver().captureScreen(
                    AssetImage(
                        'assets/images/wallpaper_${decorState
                            .getBackgroundIndex()}.jpg'),
                    quoteState.getCurrentQuote(),
                    quoteState.getCurrentAuthor(),
                    'Font${decorState.getFontIndex()}');
                final tempDir = await getTemporaryDirectory();
                File file =
                await File('${tempDir.path}/image.png')
                    .create();
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
                if (widget.isWaiting ||
                    quoteState.noQuotes) {
                  return;
                }
                _showUserQuoteAdditonPanel(
                    quoteState.getCurrentQuoteObject());
              },
              icon: const Icon(
                Symbols.bookmark_add,
                size: 50.0,
                weight: 200,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 20.0),
            FavouriteIcon(currentIdx: _currentPageIndex),
          ],
        ),
      ],
    );
  }
}
