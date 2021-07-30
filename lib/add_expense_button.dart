import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'models.dart';
import 'styles.dart';

import 'custom_rect_tween.dart';
import 'hero_dialog_route.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

/// {@template add_todo_button}
/// Button to add a new [Todo].
///
/// Opens a [HeroDialogRoute] of [_AddTodoPopupCard].
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class AddExpenseButton extends StatelessWidget {
  /// {@macro add_todo_button}
  const AddExpenseButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
            return const _AddExpensePopupCard();
          }));
        },
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: AppColors.accentColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: const Icon(
              Icons.add_rounded,
              size: 56,
            ),
          ),
        ),
      ),
    );
  }
}

/// Tag-value used for the add todo popup button.
const String _heroAddTodo = 'add-todo-hero';

/// {@template add_todo_popup_card}
/// Popup card to add a new [todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class _AddExpensePopupCard extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  const _AddExpensePopupCard({Key key}) : super(key: key);

  @override
  _AddExpensePopupCardState createState() => _AddExpensePopupCardState();
}

class _AddExpensePopupCardState extends State<_AddExpensePopupCard> {
  String _category;
  String _details;
  double _amount = 0;
  bool _isIncome = false;

  //currency controller
  final currencyController = MoneyMaskedTextController(
    initialValue: 0.00,
    leftSymbol: 'CAD\$ ', // add selectionButton better
    decimalSeparator: '.',
    thousandSeparator: ',',
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: AppColors.accentColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 50,
                      child: TextField(
                        style: TextStyle(fontSize: 19),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: 'Category',
                          border: InputBorder.none,
                          suffixIcon: Icon(
                            Icons.chat_outlined,
                            color: Colors.black45,
                            size: 28,
                          ),
                        ),
                        cursorColor: Colors.transparent,
                        onChanged: (String value) => setState(() {
                          _category = value;
                        }),
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      height: 10,
                      thickness: 0.5,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: 'Details',
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.description_outlined,
                          color: Colors.black45,
                          size: 28,
                        ),
                      ),
                      cursorColor: Colors.transparent,
                      onChanged: (String value) => setState(() {
                        _details = value;
                      }),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: currencyController,
                      decoration: InputDecoration(
                        hintText: 'Amount',
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.monetization_on_outlined,
                          color: Colors.black45,
                          size: 28,
                        ),
                      ),
                      cursorColor: Colors.transparent,
                      onChanged: (String value) => setState(() {
                        _amount = double.parse(value.substring(4));
                      }),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    SwitchListTile(
                      value: _isIncome,
                      onChanged: (bool value) {
                        setState(() => _isIncome = value);
                      },
                      title: Text('Expense/Income'),
                      activeColor: Colors.greenAccent,
                      inactiveThumbColor: Colors.redAccent,
                      inactiveTrackColor: Colors.redAccent,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all<Color>(
                                Colors.black12)),
                        onPressed: () {
                          if ([_category, _details, _isIncome].contains(null) ||
                              _amount == 0) {
                            // print(_category);
                            // print(_details);
                            // print(_isIncome);
                            // print(_amount);
                            // alertdialog saying something is empty
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                        backgroundColor: AppColors.cardColor,
                                        title: const Text(
                                          'Missing input value',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text(
                                              'Ok',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ]));
                          } else {
                            Navigator.of(context)
                                .push(HeroDialogRoute(builder: (context) {
                              return HomePage(
                                  expense: Expense(
                                category: _category,
                                details: _details,
                                amount: _amount,
                                isExpense: !_isIncome,
                              ));
                            }));
                          }
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(color: AppColors.cardColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
