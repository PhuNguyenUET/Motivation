import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:motivation/screens/QuoteAdditionScreen/quotes_addition_controller.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../models/quote.dart';
import '../../models/userQuote.dart';
import '../../utilities/hex_color.dart';
import '../Home/quotes_controller.dart';
import 'CustomRectTween.dart';
class PopUpAddQuote extends StatefulWidget {
  PopUpAddQuote({super.key, this.quote, this.author, required this.insertFunction});

  String? quote;
  String? author;
  VoidCallback insertFunction;

  @override
  State<PopUpAddQuote> createState() => _PopUpAddQuoteState();
}

class _PopUpAddQuoteState extends State<PopUpAddQuote> {
  final _formKey = GlobalKey<FormState>();
  final quoteController = TextEditingController();
  final authorController = TextEditingController();


  String quote = '';
  String author = '';
  Quote? currentQuote;

  @override
  Widget build(BuildContext context) {
    var quoteAdditionState = Provider.of<QuotesAdditionController>(context, listen: true);

    if(quote == '' && widget.quote != null) {
      quoteController.text = widget.quote!;
    }

    if(author == '' && widget.author != null) {
      authorController.text = widget.author!;
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Hero(
          tag: 'quote-add-popup',
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: Colors.white,
            elevation: 4,
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Form(
                      key: _formKey,
                      //autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Text(
                              "Make your own quotes",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: quoteController,
                            decoration: Constants.textInputDecoration.copyWith(
                                labelText: 'Quote',
                                hintText: 'Add your quote here',
                            ),
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
                            ),
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
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(backgroundColor: HexColor('#8B4CFC')),
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
                                          widget.insertFunction();
                                        }
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
          ),
        ),
      ),
    );
  }
}