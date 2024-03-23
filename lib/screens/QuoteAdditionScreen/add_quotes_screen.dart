import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:motivation/constants/constants.dart';
import 'package:motivation/models/userQuote.dart';
import 'package:motivation/screens/QuoteAdditionScreen/QuoteAddButton.dart';
import 'package:motivation/screens/UtilityScreens/loading.dart';
import 'package:motivation/screens/QuoteAdditionScreen/quotes_addition_controller.dart';
import 'package:motivation/screens/Home/quotes_controller.dart';
import 'package:motivation/screens/QuoteAdditionScreen/your_quote_tile.dart';
import 'package:provider/provider.dart';

import '../../models/quote.dart';
import '../UtilityScreens/FakePopUpRoute.dart';
import 'PopUpAddQuote.dart';

class QuotesAddition extends StatefulWidget {
  const QuotesAddition({super.key});

  @override
  State<QuotesAddition> createState() => _QuotesAdditionState();
}

class _QuotesAdditionState extends State<QuotesAddition> {
  final key = GlobalKey<AnimatedListState>();
  List<Quote> userCreated = [];

  @override
  Widget build(BuildContext context) {
    var quoteAdditionState = Provider.of<QuotesAdditionController>(context, listen: true);
    var quoteState = Provider.of<QuoteController>(context, listen: true);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingQuoteAddButton(insertFunction: insertItem,),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () async {
              Navigator.of(context).pop();
              await quoteState.forceRebuild();
            },
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onHorizontalDragEnd: (details) async {
            if (details.primaryVelocity! > 0) {
              Navigator.of(context).pop();
              await quoteState.forceRebuild();
            }
          },
          child: FutureBuilder<List<Quote>>(
              future: quoteAdditionState.getAllUserCreatedQuotes(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Quote>> snapshot) {
                if (snapshot.hasData) {
                  userCreated = snapshot.data ?? [];
                  return userCreated.isEmpty ? Center(child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 300,
                          child: Image.asset('assets/images/empty_box.png')
                      ),
                      Text("Hmmm you don't have any quote yet", style: TextStyle(fontSize: 20),),
                    ],
                  )) : AnimationLimiter(
                    child: AnimatedList (
                        key: key,
                        scrollDirection: Axis.vertical,
                        initialItemCount: userCreated.length,
                        itemBuilder: (context, index, animation) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 700),
                            child: SlideAnimation(
                              verticalOffset: 500.0,
                              child: FadeInAnimation(
                                child: SizeTransition(
                                  sizeFactor: animation,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3.0, horizontal: 4.0),
                                    child: YourQuoteTile(
                                      quote: index >= userCreated.length ? Quote(id: 0, quote: 'Fetching...') : userCreated[index],
                                      editFunction: () {
                                        Navigator.of(context).push(FakePopUpRoute(builder: (context) {
                                          return PopUpAddQuote(quote: userCreated[index].quote, author: userCreated[index].author, insertFunction: insertItem,);
                                        }));
                                      },
                                      deleteFunction: () async {
                                        Quote quoteToAnimate = userCreated[index];
                                        await quoteAdditionState.deleteQuote(
                                            userCreated[index]);
                                        setState(() {
                                          userCreated = [];
                                        });
                                        removeAtKey(index, quoteToAnimate);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                } else {
                  return Center(
                    child: Loading(),
                  );
                }
              }),
        ),
      ),
    );
  }

  void removeAtKey(int index, Quote quote) {
    key.currentState?.removeItem(index, (context, animation) => SizeTransition(
      sizeFactor: animation,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 3.0, horizontal: 4.0),
        child: YourQuoteTile(
          quote: quote,
          editFunction: () {},
          deleteFunction: () {},
        ),
      ),
    ));
  }

  void insertItem() {
    key.currentState?.insertItem(userCreated.length);
  }
}
