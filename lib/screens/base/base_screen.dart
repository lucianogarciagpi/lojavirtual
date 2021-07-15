import 'package:flutter/material.dart';
import 'package:lojavirtual/models/page_manager.dart';
import 'package:lojavirtual/screens/login/login_screen.dart';
import 'package:lojavirtual/screens/products/products_screen.dart';
import 'package:provider/provider.dart';
import 'package:lojavirtual/commom/custom_drawer/custom_drawer.dart';

class BaseScreen extends StatelessWidget {

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {

    /// Declaramos um Provider
    return Provider(
      /// Criamos um objeto PageManager
      /// Passamos o pageController como parâmetro p/ o PageManager
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text("Home"),
            ),
          ),
          ProductsScreen(),

        ],
      ),
    );
  }
}
