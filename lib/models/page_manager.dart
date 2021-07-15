
import 'package:flutter/cupertino.dart';

class PageManager {

  PageManager(this._pageController);

  /// Recebemos o PageController passado como parametro pelo BaseScreen
  final PageController _pageController;

  int page = 0;

  /// setPage no pageController atráves do parâmetro
  void setPage(int value){
  if(value == page) return;
  page = value;

  /// navegamos até a pagina que foi clicada em qualquer parte da aplicação
    _pageController.jumpToPage(value);
  }

}