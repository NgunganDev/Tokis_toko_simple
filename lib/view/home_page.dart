import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tokis_app/constant/color.dart';
import 'package:tokis_app/presenter/functional_presenter.dart';
import 'package:tokis_app/state_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  FunctionalPresenter? _present;

  @override
  void initState() {
    super.initState();
    _present = ref.read(funcPresenter);
  }

  @override
  Widget build(BuildContext context) {
    final watchPage = ref.watch(pageState);
    return Scaffold(
      body: _present!.homeChild(watchPage),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GNav(
            backgroundColor: const Color.fromARGB(22, 255, 255, 255),
            rippleColor: ColorUse.secC,
            curve: Curves.easeOutExpo,
            duration: const Duration(milliseconds: 200),
            gap: 3,
            color: ColorUse.secC,
            activeColor: ColorUse.getC,
            iconSize: 24,
            tabBackgroundColor: ColorUse.hintC,
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 8), // navigation bar padding
            tabs: [
              GButton(
                onPressed: () {
                  ref.read(pageState.notifier).update((state) => 0);
                },
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                onPressed: () {
                  ref.read(pageState.notifier).update((state) => 2);
                },
                icon: Icons.payment,
                text: 'Cash',
              ),
              GButton(
                onPressed: () {
                  ref.read(pageState.notifier).update((state) => 3);
                },
                icon: Icons.print,
                text: 'Print',
              ),
            ]),
      ),
      drawer: Drawer(
        child: ListView(
            // children: [

            // ],
            ),
      ),
    );
  }
}
