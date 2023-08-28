import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tokis_app/presenter/functional_presenter.dart';
import 'package:tokis_app/state_riverpod.dart';

import '../presenter/chart_presenter.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  FunctionalPresenter? _present;
  ChartPresenter? _presC;
  @override
  void initState() {
    super.initState();
    _present = ref.read(funcPresenter);
    _presC = ref.read(chartPresenter);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.02,
                horizontal: size.width * 0.02,
              ),
              color:  Theme.of(context).primaryColor,
              width: size.width,
              height: size.height * 0.14,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            ref.read(pageState.notifier).update((state) => 0);
                          },
                          icon: Icon(Icons.arrow_back, color:  Theme.of(context).hintColor)),
                  Text(
                    'Your Cart',
                    style: TextStyle(
                        fontSize: size.height * 0.04,
                        fontWeight: FontWeight.w500,
                        color:  Theme.of(context).hintColor),
                  ),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        if (_present!.listInTemp.isNotEmpty) {
                          _presC!.doAalert(context, () {
                              _present!.listInCart.clear();
                              // _present!.finalTemp.clear();
                              print(_present!.finalTemp);
                            setState(() {
                              _present!.listInTemp.clear();
                              Navigator.pop(context);
                            });
                          }, () {
                            Navigator.pop(context);
                          });
                        }
                      },
                      child: Text(
                        'clear',
                        style: TextStyle(
                            fontSize: size.height * 0.022,
                            fontWeight: FontWeight.w400,
                            color:  Theme.of(context).hintColor
                            ),
                      )),
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: _present!.listInTemp.length,
                    itemBuilder: (c, i) {
                      return ListTile(
                        title: Text(_present!.listInTemp[i].name),
                        subtitle: Text(
                            'Jumlah ${_present!.listInTemp[i].amount}'),
                        trailing: Text(_present!
                            .itemPrice(_present!.listInTemp[i].allPrice,
                                _present!.listInTemp[i].amount)
                            .toString()),
                      );
                    })),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02, horizontal: size.width * 0.04),
              width: size.width,
              height: size.height * 0.1,
              color:  Theme.of(context).primaryColor,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price :',
                      style: TextStyle(
                          fontSize: size.height * 0.024,
                          fontWeight: FontWeight.w500,
                          color:  Theme.of(context).hintColor),
                    ),
                    Row(
                      children: [
                        Text(
                          _present!.allPrice.toString(),
                          style: TextStyle(
                              fontSize: size.height * 0.03,
                              fontWeight: FontWeight.w500,
                              color:  Theme.of(context).hintColor),
                        ),
                        SizedBox(
                          width: size.width * 0.04,
                        ),
                        InkWell(
                          onTap: () async {
                            if (_present!.listInCart.isNotEmpty) {
                              _presC!.doWarning(context);
                              await _presC!.addTheOrder(_present!.finalTemp);
                            } else {
                              _presC!.doAttention(context);
                            }
                          },
                          child: SizedBox(
                            child: Image.asset('images/finalprint.png'),
                          ),
                        )
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
