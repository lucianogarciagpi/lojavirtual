import 'package:flutter/material.dart';
import 'package:lojavirtual/commom/custom_drawer/custom_drawer_header.dart';
import 'package:lojavirtual/commom/custom_drawer/drawer_tile.dart';

  /// Drawer Customizado
class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      /// Stack para adicionar o Container
      child: Stack(
        children: [
          /// Container que vai receber a decoração gradiente
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 203, 236, 241),
                  Colors.white,
                ],
                /// Inicio do degrade
                begin: Alignment.topCenter,
                /// Fim do degrade
                end: Alignment.bottomCenter
              )
            ),
          ),
          /// ListView que vai ficar por cima do container
          ListView(
            children: const<Widget>[
              // Cabeçalho do Drawer
              CustomDrawerHeader(),

              /// Divider
              Divider(),

              DrawerTile(
                iconData: Icons.home,
                title: "Inicio",
                page: 0,
              ),

              // Menu Products
              DrawerTile(
                iconData: Icons.list,
                title: "Produtos",
                page: 1,
              ),

              DrawerTile(
                iconData: Icons.playlist_add_check,
                title: "Meus Pedidos",
                page: 2,
              ),
              DrawerTile(iconData: Icons.location_on,
                title: "Lojas",
                page: 3,),
            ],
          ),
        ],
      ),
    );
  }
}
