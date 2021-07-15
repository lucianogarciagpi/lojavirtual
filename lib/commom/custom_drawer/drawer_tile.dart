import 'package:flutter/material.dart';
import 'package:lojavirtual/models/page_manager.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {

  const DrawerTile({this.iconData, this.title, this.page});

  final IconData iconData;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {
    final int curPage = context.watch<PageManager>().page;

    /// aplicando a cor primaria definido no ThemeData la no main
    /// aqui no DrawerTile
    final Color primaryColor = Theme.of(context).primaryColor;


    return InkWell(
      onTap: (){
        /// Utilizando o Provider PageManager
        /// indico no parametro a pagina que queremos ir
        context.read<PageManager>().setPage(page);
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: 32,
                color: curPage == page? primaryColor : Colors.grey[700],
              ),
            ),

            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: curPage == page? primaryColor : Colors.grey[700],
              ),
            )
          ],
        ),
      ),
    );
  }
}
