import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:motivation/constants/constants.dart';
import 'package:motivation/models/userQuote.dart';
import 'package:motivation/screens/quotes_addition_controller.dart';
import 'package:motivation/screens/quotes_controller.dart';
import 'package:motivation/screens/your_quote_tile.dart';
import 'package:provider/provider.dart';

import '../models/quote.dart';

class QuotesAddition extends StatefulWidget {
  const QuotesAddition({super.key});

  @override
  State<QuotesAddition> createState() => _QuotesAdditionState();
}

class _QuotesAdditionState extends State<QuotesAddition> {
  final _formKey = GlobalKey<FormState>();
  final quoteController = TextEditingController();
  final authorController = TextEditingController();

  String quote = '';
  String author = '';
  Quote? currentQuote;
  List<Quote> userCreated = [];

  @override
  Widget build(BuildContext context) {
    var quoteAdditionState = QuotesAdditionController();
    var quoteState = Provider.of<QuoteController>(context, listen: true);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          child: Column(children: [
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Form(
                      key: _formKey,
                      //autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Add your own quotes",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                decoration: TextDecoration.underline),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: quoteController,
                            decoration: Constants.textInputDecoration.copyWith(
                                labelText: 'Quote',
                                hintText: 'Add your quote here',
                                icon: Icon(Symbols.text_ad_rounded)),
                            maxLines: null,
                            validator: (val) {
                              if (val == null || val!.isEmpty) {
                                return 'Quote cannot be left empty';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) {
                              setState(() {
                                quote = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: authorController,
                            decoration: Constants.textInputDecoration.copyWith(
                                labelText: 'Author',
                                hintText: 'Add author here',
                                icon: Icon(Symbols.person_add)),
                            maxLines: null,
                            validator: (val) {},
                            onChanged: (val) {
                              setState(() {
                                author = val;
                              });
                            },
                          ),
                          SizedBox(height: 20.0),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      child: Text(
                                        'Save',
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(
                                              Colors.grey[300])),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          if (currentQuote == null) {
                                            UserQuote quoteToAdd = UserQuote(
                                                quote: quote, author: author);
                                            await quoteAdditionState
                                                .insertQuote(quoteToAdd);
                                          } else {
                                            currentQuote!.quote = quote;
                                            currentQuote!.author = author;
                                            String text = await quoteAdditionState
                                                .editQuote(currentQuote!);
                                          }
                                          _formKey.currentState!.reset();
                                          authorController.clear();
                                          quoteController.clear();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          setState(() {
                                            currentQuote = null;
                                            quote = '';
                                            author = '';
                                          });
                                        }
                                      }),
                                ),
                                SizedBox(width: 15,),
                                Expanded(
                                  child: ElevatedButton(
                                      child: Text(
                                        'Cancel',
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(
                                              Colors.grey[300])),
                                      onPressed: () {
                                        _formKey.currentState!.reset();
                                        authorController.clear();
                                        quoteController.clear();
                                        FocusManager.instance.primaryFocus?.unfocus();
                                        setState(() {
                                          currentQuote = null;
                                          quote = '';
                                          author = '';
                                        });
                                      }),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              indent: 10,
              endIndent: 10,
              color: Colors.black,
            ),
            FutureBuilder<List<Quote>>(
                future: quoteAdditionState.getAllUserCreatedQuotes(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Quote>> snapshot) {
                  if (snapshot.hasData) {
                    userCreated = snapshot.data ?? [];
                  }
                  return Expanded(
                    flex: 5,
                    child: AnimationLimiter(
                      child: ListView.builder(
                          itemCount: userCreated.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 700),
                              child: SlideAnimation(
                                verticalOffset: 1000.0,
                                child: FadeInAnimation(
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3.0, horizontal: 4.0),
                                      child: YourQuoteTile(
                                          quote: userCreated[index],
                                        editFunction: () {
                                            setState(() {
                                              currentQuote = userCreated[index];
                                              quote = userCreated[index].quote;
                                              author = userCreated[index].author ?? '';
                                            });
                                            quoteController.text = quote;
                                            authorController.text = author ?? '';
                                        },
                                        deleteFunction: () async {
                                            if(userCreated[index] == currentQuote) {
                                              setState(() {
                                                currentQuote = null;
                                                quote = '';
                                                author = '';
                                              });
                                            }
                                            await quoteAdditionState.deleteQuote(userCreated[index]);
                                            setState(() {
                                              userCreated = [];
                                            });
                                            quoteController.text = quote;
                                            authorController.text = author ?? '';
                                        },
                                      ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  );
                })
          ]),
        ),
      ),
    );
  }
}
