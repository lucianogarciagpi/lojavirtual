import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/validators.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  /// Criando uma GlobalKey para acessar o formulario nessa própria tela
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// SnackBar
  /// Temos de declarar uma GlobalKey para acessar o scaffold
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
        actions: [
          FlatButton(
              onPressed: (){
                Navigator.of(context).pushReplacementNamed("/signup");
              },
              child: const Text(
                "CRIAR CONTA",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14),
              ),
          ),
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
                builder: (_, userManager, child) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: <Widget>[
                      /// Campo E-mail
                      /// Logon
                      TextFormField(
                        controller: emailController,
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(hintText: 'E-mail'),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (email) {
                          if (!emailValid(email)) {
                            return 'E-mail inválido';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      /// Campo Senha
                      TextFormField(
                        controller: passController,
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(hintText: 'Senha'),
                        autocorrect: false,
                        obscureText: true,
                        validator: (pass) {
                          if (pass.isEmpty || pass.length < 6) {
                            return 'Senha invalida';
                          }
                          return null;
                        },
                      ),
                      child,
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 44,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            onSurface: Theme.of(context).primaryColor
                            .withAlpha(100),
                          ),
                          onPressed: userManager.loading ? null : () {
                            if (formKey.currentState.validate()) {
                              context.read<UserManager>().signIn(
                                  user: User(
                                      email: emailController.text,
                                      password: passController.text),
                                  onFail: (e) {
                                    scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.redAccent,
                                          content: Text(
                                            "Falha ao entrar: $e"
                                          ),
                                        )
                                      );
                                  },
                                  onSuccess: () {
                                   Navigator.of(context).pop();
                                  }
                                );
                            }
                          },
                          child: userManager.loading ?
                          const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ) :
                          const Text(
                            'Entrar',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  );
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    child: const Text('Esqueci minha senha'),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
