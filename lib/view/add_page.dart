import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:tokis_app/model/cart.dart';
import 'package:tokis_app/model/product.dart';
import 'package:tokis_app/model/temp_cart.dart';
import 'package:tokis_app/presenter/functional_presenter.dart';
import 'package:tokis_app/widget/inadd_cart.dart';
import 'package:tokis_app/widget/product_tile.dart';
import '../state_riverpod.dart';

class AddPage extends ConsumerStatefulWidget {
  const AddPage({super.key});

  @override
  ConsumerState<AddPage> createState() => _AddPageState();
}

class _AddPageState extends ConsumerState<AddPage> {
  FunctionalPresenter? _present;
  TextEditingController controlProduct = TextEditingController();
  TextEditingController controlPrice = TextEditingController();
  TextEditingController controlCategory = TextEditingController();
  String select = 'all';
  @override
  void initState() {
    super.initState();
    _present = ref.read(funcPresenter);
  }

  @override
  void dispose() {
    super.dispose();
    controlPrice.dispose();
    controlProduct.dispose();
    controlCategory.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02, horizontal: size.width * 0.04),
              width: size.width,
              height: size.height * 0.35,
              color: Theme.of(context).primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tokis',
                            style: TextStyle(
                              fontFamily: 'NunitoSans',
                                fontSize: size.height * 0.06,
                                color: Theme.of(context).hintColor,
                                fontWeight: FontWeight.w700),
                          ),
                          InkWell(
                            onTap: () {
                              ref.read(pageState.notifier).update((state) => 1);
                            },
                            child: Stack(
                              children: [
                                Icon(
                                  Icons.card_giftcard_outlined,
                                  size: size.height * 0.07,
                                  // weight: ,
                                  color: Theme.of(context).hintColor,
                                ),
                                Positioned(
                                  top: 8,
                                  right: 2,
                                  child: _present!.cartTotal == 0
                                      ? Container()
                                      : CircleAvatar(
                                          radius: size.height * 0.02,
                                          backgroundColor:
                                              Theme.of(context).hintColor,
                                          child: Text(
                                            _present!.cartTotal.toString(),
                                            style: TextStyle(
                                                fontSize: size.height * 0.019,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        '12-08-23',
                        style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).hintColor),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.02,
                        height: size.height * 0.05,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.14,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        InAddCard(
                          value: _present!.percentWeek,
                          bl: 'Rp${_present!.balanceInWeek}',
                          nameC: 'Balance',
                          ic: Icons.payment,
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        const InAddCard(
                          value: 10,
                          bl: '3',
                          nameC: 'Debt',
                          ic: Icons.deblur_outlined,
                        ),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: size.width,
                height: size.height * 0.65,
                color: Theme.of(context).hintColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Row(
                              children: [
                                Icon(
                                  Icons.list,
                                  size: 16,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: size.width * 0.012,
                                ),
                                Expanded(
                                  child: Text(
                                    'Category',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            items: _present!.listDrop
                                .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: select,
                            onChanged: (String? value) {
                              setState(() {
                                select = value!;
                                _present!.thecategory = select;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: size.height * 0.06,
                              width: size.width * 0.6,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                // border: Border.all(
                                //   color: Colors.black26,
                                // ),
                                color: Theme.of(context).hintColor,
                              ),
                              elevation: 1,
                            ),
                            iconStyleData: IconStyleData(
                              icon: const Icon(
                                Icons.arrow_forward_ios_outlined,
                              ),
                              iconSize: 14,
                              iconEnabledColor: Theme.of(context).primaryColor,
                              iconDisabledColor: Colors.grey,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Theme.of(context).hintColor,
                              ),
                              // offset: const Offset(-20, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(6),
                                thickness: MaterialStateProperty.all<double>(6),
                                thumbVisibility:
                                    MaterialStateProperty.all<bool>(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _present!.showPopProduct(context, controlProduct,
                                controlPrice, controlCategory, () {
                              setState(() {
                                _present!
                                    .addTheProduct(Product(
                                        imagePath: _present!.initPath,
                                        productCategory: controlCategory.text,
                                        productName: controlProduct.text,
                                        productPrice:
                                            int.parse(controlPrice.text)))
                                    .then((value) {
                                  Navigator.pop(context);
                                  controlPrice.clear();
                                  controlProduct.clear();
                                  controlCategory.clear();
                                });
                              });
                            }, ref);
                          },
                          child: SizedBox(
                            width: size.width * 0.3,
                            height: size.height * 0.07,
                            // color: ColorUse.getC,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              color: Theme.of(context).hintColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'add',
                                    style: TextStyle(
                                        fontSize: size.height * 0.022,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.1,
                                    height: size.height * 0.08,
                                    child: Image.asset(
                                      'images/shadowbox.png',
                                      fit: BoxFit.fitWidth,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                        child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.04),
                      child: AnimationLimiter(
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: size.width * 0.5,
                                    mainAxisExtent: size.height * 0.3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemCount: select == 'all'
                                ? _present!.fetchAllData.length
                                : _present!.fetchDB.length,
                            itemBuilder: (c, i) {
                              return AnimationConfiguration.staggeredGrid(
                                position: i,
                                duration: const Duration(milliseconds: 300),
                                columnCount: select == 'all'
                                    ? _present!.fetchAllData.length
                                    : _present!.fetchDB.length,
                                child: ScaleAnimation(
                                  child: FadeInAnimation(
                                    curve: Curves.easeInExpo,
                                    child: ProductTile(
                                      totalLength: _present!.itemLength(
                                        _present!.listInTemp,
                                        select == 'all'
                                            ? _present!
                                                .fetchAllData[i].productName
                                            : _present!.fetchDB[i].productName,
                                      ),
                                      imageUrl: select == 'all'
                                          ? _present!.fetchAllData[i].imagePath
                                          : _present!.fetchDB[i].imagePath,
                                      cbadd: () {
                                        setState(() {
                                          _present!.addCart(
                                              CartModel(
                                                productAmount: 1,
                                                totalPrice: select == 'all'
                                                    ? _present!.fetchAllData[i]
                                                        .productPrice
                                                    : _present!.fetchDB[i]
                                                        .productPrice,
                                                productName: select == 'all'
                                                    ? _present!.fetchAllData[i]
                                                        .productName
                                                    : _present!
                                                        .fetchDB[i].productName,
                                              ),
                                              TempCart(
                                                allPrice: select == 'all'
                                                    ? _present!.fetchAllData[i]
                                                        .productPrice
                                                    : _present!.fetchDB[i]
                                                        .productPrice,
                                                amount: 1,
                                                name: select == 'all'
                                                    ? _present!.fetchAllData[i]
                                                        .productName
                                                    : _present!
                                                        .fetchDB[i].productName,
                                              ));
                                        });
                                      },
                                      cbmin: () {
                                        setState(() {
                                          _present!.decCart(
                                              CartModel(
                                                productAmount: 1,
                                                totalPrice: select == 'all'
                                                    ? _present!.fetchAllData[i]
                                                        .productPrice
                                                    : _present!.fetchDB[i]
                                                        .productPrice,
                                                productName: select == 'all'
                                                    ? _present!.fetchAllData[i]
                                                        .productName
                                                    : _present!
                                                        .fetchDB[i].productName,
                                              ),
                                              TempCart(
                                                allPrice: select == 'all'
                                                    ? _present!.fetchAllData[i]
                                                        .productPrice
                                                    : _present!.fetchDB[i]
                                                        .productPrice,
                                                amount: 1,
                                                name: select == 'all'
                                                    ? _present!.fetchAllData[i]
                                                        .productName
                                                    : _present!
                                                        .fetchDB[i].productName,
                                              ));
                                        });
                                      },
                                      cdDel: () {
                                        setState(() {
                                          _present!.deleteItem(i);
                                        });
                                      },
                                      cbup: () {
                                        _present!.showPopProduct(
                                            context,
                                            controlProduct,
                                            controlPrice,
                                            controlCategory, () {
                                          setState(() {
                                            _present!
                                                .updateTheProduct(
                                                    i,
                                                    Product(
                                                        imagePath:
                                                            _present!.initPath,
                                                        productCategory:
                                                            controlCategory
                                                                .text,
                                                        productName:
                                                            controlProduct.text,
                                                        productPrice: int.parse(
                                                            controlPrice.text)))
                                                .then((value) {
                                              Navigator.pop(context);
                                              controlPrice.clear();
                                              controlProduct.clear();
                                              controlCategory.clear();
                                            });
                                          });
                                        }, ref);
                                      },
                                      productName: select == 'all'
                                          ? _present!
                                              .fetchAllData[i].productName
                                          : _present!.fetchDB[i].productName,
                                      price: select == 'all'
                                          ? _present!
                                              .fetchAllData[i].productPrice
                                          : _present!.fetchDB[i].productPrice,
                                      category: select == 'all'
                                          ? _present!
                                              .fetchAllData[i].productCategory
                                          : _present!
                                              .fetchDB[i].productCategory,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
