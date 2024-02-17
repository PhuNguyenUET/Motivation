import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:motivation/screens/quotes_controller.dart';
import 'package:provider/provider.dart';



class FavouriteIcon extends StatefulWidget {
  const FavouriteIcon({super.key});

  @override
  State<FavouriteIcon> createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {

    var quoteState = Provider.of<QuoteController>(context, listen: true);

    isFav = quoteState.isCurrentQuoteFav();

    return IconButton(
      onPressed: () async {
        if (quoteState.noQuotes) {
          return;
        }
        await quoteState.changeFavouriteCurrentQuote();
        setState(() {
          isFav = quoteState.isCurrentQuoteFav();
        });
      },
      icon: Icon(
        Symbols.favorite_border,
        size: 50.0,
        weight: 200,
        fill: quoteState.isCurrentQuoteFav() ? 1 : 0,
        color: Colors.white,
      ),
    );
  }
}
