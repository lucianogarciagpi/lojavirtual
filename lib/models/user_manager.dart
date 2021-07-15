import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lojavirtual/helpers/firebase_errors.dart';
import 'package:lojavirtual/models/user_model.dart';

class UserManager extends ChangeNotifier {

    UserManager(){
      /// Carregando função dentro do Construtor
      _loadCurrentUser();
    }

  /// Instanciando FirebaseAuth
  final FirebaseAuth auth = FirebaseAuth.instance;

  /// Instanciando Banco de Dados
  final Firestore firestore = Firestore.instance;

  User user;

  /// Variavel loading
  bool _loading = false;
  bool get loading => _loading;

  bool get isLoggedIn => user != null;

  /// Método sigIn, recebe objeto User como parâmetro
  /// Objeto vem do user_model
  /// Quanto utilizamos chaves nos parâmetros indica que eles são opcionais
  Future<void> signIn({User user, Function onFail, Function onSuccess}) async{
    loading = true;
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      await _loadCurrentUser(firebaseUser: result.user);

      onSuccess();
    } on PlatformException catch (e){
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

    Future<void> signUp({User user, Function onFail, Function onSuccess}) async{
      loading = true;
      try {
        final AuthResult result = await auth.createUserWithEmailAndPassword(
            email: user.email, password: user.password);

        user.id = result.user.uid;
        this.user = user;

        await user.saveData();

        onSuccess();
      } on PlatformException catch (e){
        onFail(getErrorString(e.code));
      }
      loading = false;
    }

    void signOut(){
     auth.signOut();
     user = null;
     notifyListeners();
    }

  set loading(bool value){
    _loading = value;

    // Noficica os Listeners
    notifyListeners();
  }

  Future<void> _loadCurrentUser({FirebaseUser firebaseUser})async{
    final FirebaseUser currentUser = firebaseUser ?? await auth.currentUser();
    if(currentUser != null){
      final DocumentSnapshot docUser = await firestore.collection('users')
          .document(currentUser.uid).get();
      user = User.fromDocument(docUser);
      notifyListeners();
    }

  }
}