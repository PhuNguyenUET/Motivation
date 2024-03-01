import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:motivation/screens/CollectionScreen/quote_tile.dart';
import 'package:motivation/screens/Home/quotes_controller.dart';
import 'package:motivation/screens/CollectionScreen/user_created_category_controller.dart';
import 'package:motivation/screens/QuoteAdditionScreen/your_quote_tile.dart';
import 'package:provider/provider.dart';

import '../../constants/gradient_button.dart';
import '../../models/quote.dart';
import '../../utilities/hex_color.dart';
import '../UtilityScreens/loading.dart';

class QuoteInCollectionScreen extends StatefulWidget {
  const QuoteInCollectionScreen({super.key});

  @override
  State<QuoteInCollectionScreen> createState() =>
      _QuoteInCollectionScreenState();
}

class _QuoteInCollectionScreenState extends State<QuoteInCollectionScreen> {
  List<Quote> quoteList = [];

  @override
  Widget build(BuildContext context) {
    var userCateState = Provider.of<UserCreatedCategoryController>(context, listen: true);
    var quoteState = Provider.of<QuoteController>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: SafeArea(
            child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                    Navigator.pop(context);
                  }
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: UnicornOutlineButton(
                        strokeWidth: 4,
                        radius: 16,
                        gradient: LinearGradient(
                          colors: [HexColor('#D8B5FF'), HexColor('#1EAE98')],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        child: Expanded(
                            child: Center(
                                child: Text('Show all in feed',
                                    style: TextStyle(
                                        fontSize: 16)))),
                        onPressed: () async {
                          List<Quote> quotes = await userCateState.getQuotesByCate();
                          print(quotes.length);
                          quoteState.setCategoryUserCreated(userCateState.currentCategory, quotes);
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                        },
                      ),
                    ),
                    FutureBuilder<List<Quote>>(
                        future: userCateState.getQuotesByCate(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Quote>> snapshot) {
                          if (snapshot.hasData) {
                            quoteList = snapshot.data ?? [];
                            return Expanded(
                              child: AnimationLimiter(
                                child: ListView.builder(
                                    itemCount: quoteList.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (BuildContext context, int index) {
                                      return AnimationConfiguration.staggeredList(
                                        position: index,
                                        duration: const Duration(milliseconds: 700),
                                        child: SlideAnimation(
                                          verticalOffset: 500.0,
                                          child: FadeInAnimation(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 3.0, horizontal: 4.0),
                                              child: QuoteTile(
                                                quote: quoteList[index],
                                                deleteFunction: () async {
                                                  await userCateState.deleteQuoteFromCate(quoteList[index].id!);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            );
                          } else {
                            return Expanded(
                              flex: 5,
                              child: Loading(),
                            );
                          }
                        }),
                  ],
                )
            )));
  }
}
