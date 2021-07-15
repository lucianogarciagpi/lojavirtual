import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/validators.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {

  /// Criando uma GlobalKey para acessar o formulario nessa própria tela
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Criando um scaffoldKey
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  /// Instanciando um objeto
  final User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Criar conta"),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __){
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(hintText: "Nome Completo"),
                      enabled: !userManager.loading,
                      validator: (name){
                        if(name.isEmpty) {
                          return 'Campo obrigatório';
                        } else if(name.trim().split(' ').length <= 1) {
                          return 'Preencha seu nome completo';
                        }
                        return null;
                      },
                      onSaved: (name) => user.name = name,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      decoration: const InputDecoration(hintText: "E-mail"),
                      enabled: !userManager.loading,
                      keyboardType: TextInputType.emailAddress,
                      validator: (email){
                        if(email.isEmpty) {
                          return 'Campo obrigatório';
                        } else if(!emailValid(email)) {
                          return 'E-mail invalido';
                        }
                        return null;
                      },
                      onSaved: (email) => user.email = email,
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      decoration: const InputDecoration(hintText: "Senha"),
                      enabled: !userManager.loading,
                      obscureText: true,
                      validator: (pass){
                        if(pass.isEmpty) {
                          return 'Campo obrigatório';
                        } else if(pass.length < 6) {
                          return 'Senha muito curta';
                        }
                        return null;
                      },
                      onSaved: (pass) => user.password = pass,
                    ),

                    const SizedBox(height: 16),
                    TextFormField(
                      obscureText: true,
                      enabled: !userManager.loading,
                      validator: (pass){
                        if(pass.isEmpty) {
                          return 'Campo obrigatório';
                        } else if(pass.length < 6) {
                          return 'Senha muito curta';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: "Repita a senha"),
                      onSaved: (pass) => user.confirmPassword = pass,
                    ),

                    const SizedBox(height: 16),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          onSurface: Theme.of(context).primaryColor
                              .withAlpha(100),
                        ),
                        onPressed: userManager.loading ? null : (){
                          /// Chama os validates definidos nos campos
                          formKey.currentState.validate();

                          /// Chama o onSaved definido em cada campo
                          formKey.currentState.save();

                          /// Verificando se senhas são iguais nos campos
                          if(user.password != user.confirmPassword){
                            scaffoldKey.currentState.showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.redAccent,
                                  content: Text(
                                      "Senhas diferentes, corrija!"
                                  ),
                                )
                            );

                          }
                          /// Chama a função signUp do UserManager
                          userManager.signUp(
                              user: user,
                              onSuccess: (){
                                debugPrint("sucesso");
                                Navigator.of(context).pop();
                              },
                              onFail: (e){
                                scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content: Text(
                                          "Falha ao cadastrar: $e"
                                      ),
                                    )
                                );
                              }
                          );

                        },

                        child: userManager.loading ?
                        const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        )
                        : const Text(""
                            "Criar Conta",
                          style: TextStyle(
                              fontSize: 18
                          ),
                        ),
                      ),
                    )


                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
