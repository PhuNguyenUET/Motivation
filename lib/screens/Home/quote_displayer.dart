import 'package:flutter/material.dart';
import 'package:motivation/screens/Home/quote_column.dart';
import 'package:motivation/screens/Home/quotes_controller.dart';
import 'package:motivation/screens/Home/user_controller.dart';
import 'package:provider/provider.dart';

class QuoteDisplay extends StatefulWidget {
  bool isWaiting = false;
  QuoteDisplay({super.key, required this.isWaiting});

  @override
  State<QuoteDisplay> createState() => _QuoteDisplayState();
}

class _QuoteDisplayState extends State<QuoteDisplay> with TickerProviderStateMixin{
  Widget? oldColumn;
  Widget? currentColumn;
  late AnimationController oldController;
  late AnimationController newController;
  late Animation<int> oldAnimation;
  late Animation<int> newAnimation;
  late int screenSize;

  void initAnimationUp() {
    oldController = AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    newController = AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    oldAnimation = IntTween(begin: 0, end: screenSize).animate(CurvedAnimation(
      parent: oldController,
      curve: Curves.easeInOut,
    ));
    newAnimation = IntTween(begin: -screenSize, end: 0).animate(CurvedAnimation(
      parent: newController,
      curve: Curves.easeInOut,
    ));
    oldController.forward();
    newController.forward();
  }

  void initAnimationDown() {
    oldController = AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    newController = AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    oldAnimation = IntTween(begin: 0, end: -screenSize).animate(CurvedAnimation(
      parent: oldController,
      curve: Curves.easeInOut,
    ));
    newAnimation = IntTween(begin: screenSize, end: 0).animate(CurvedAnimation(
      parent: newController,
      curve: Curves.easeInOut,
    ));
    oldController.forward();
    newController.forward();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size.height.round();
    var quoteState = Provider.of<QuoteController>(context, listen: true);
    var decorState = Provider.of<DecorController>(context, listen: true);

    widget.isWaiting ? QuoteColumn(quote: 'Fetching...', author: '', fontId: 0) : currentColumn = QuoteColumn(quote: quoteState.getCurrentQuote(), author: quoteState.getCurrentAuthor(), fontId: decorState.getFontIndex());


    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onVerticalDragEnd: (details) async {
        if (details.primaryVelocity! < 0) {
          if(!widget.isWaiting) {
            oldColumn = currentColumn;
            initAnimationDown();
            await quoteState.increaseQuoteIndex();
          }
        } else if (details.primaryVelocity! > 0) {
          if(!widget.isWaiting) {
            if(quoteState.quoteNotAtStart()) {
              oldColumn = currentColumn;
              initAnimationUp();
              quoteState.decreaseQuoteIndex();
            }
          }
        }
      },
      onHorizontalDragUpdate: (details) {},
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 10.0, horizontal: 15.0),
        child: oldColumn == null ? currentColumn :
        Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: oldController,
              builder: (context, child) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: oldColumn,
                    transform: Matrix4.translationValues(0.0, oldAnimation.value.toDouble(), 0.0),
                  ),
                ],
              ),
            ),
            AnimatedBuilder(
              animation: newController,
              builder: (context, child) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: currentColumn,
                    transform: Matrix4.translationValues(0.0, newAnimation.value.toDouble(), 0.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
