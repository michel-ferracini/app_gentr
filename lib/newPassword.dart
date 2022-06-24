import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert' as convert;
import 'login.dart';

class NewPassword extends StatefulWidget {
  final String emailDigitado;
  const NewPassword({Key? key, required this.emailDigitado}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final loading = ValueNotifier(false);
  final password = TextEditingController();
  final confirm = TextEditingController();
  var dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gerenciador de Entregas',
          style: TextStyle(fontSize: 20),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 2,
              child: ClipRect(
                child: Image.asset(
                  'img/logo.png',
                  height: 80,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.contain,
                ),
              ),
              shadowColor: Colors.red,
            ),
            const Text(
              'Nova Senha',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              child: TextField(
                controller: password,
                obscureText: true,
                obscuringCharacter: '*',
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 222, 105, 66),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 222, 105, 66),
                      width: 1,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 222, 105, 66),
                      width: 1,
                    ),
                  ),
                  icon: Icon(
                    Icons.password,
                    size: 25,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              child: TextField(
                controller: confirm,
                obscureText: true,
                obscuringCharacter: '*',
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  labelText: 'Confirmação',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 222, 105, 66),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 222, 105, 66),
                      width: 1,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 222, 105, 66),
                      width: 1,
                    ),
                  ),
                  icon: Icon(
                    Icons.password,
                    size: 25,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                    ),
                    onPressed: () async {
                      loading.value = !loading.value;
                      if (password.text == confirm.text) {
                        var dio = Dio();

                        var resposta = await dio.post(
                          // 'http://10.0.2.2:8765/mobile/newpassword',
                          'http://jsdteste.tk/mobile/newpassword',
                          data: {
                            'email': widget.emailDigitado,
                            'password': password.text,
                            'confirmPassword': confirm.text,
                          },
                        );

                        if (resposta.data != null) {
                          var jsonResposta = convert.jsonDecode(resposta.data);

                          if (jsonResposta[0] != 'Erro') {
                            Navigator.of(context).pop();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Login(),
                              ),
                            );
                            mensagem('Senha alterada, use-a para logar');
                          } else {
                            loading.value = !loading.value;
                            mensagem(jsonResposta[1]);
                          }
                        } else {
                          loading.value = !loading.value;
                          mensagem('Erro na requisição');
                        }
                      } else {
                        loading.value = !loading.value;
                        String msg = 'As senhas não conferem';
                        mensagem(msg);
                      }
                    },
                    child: AnimatedBuilder(
                        animation: loading,
                        builder: (context, _) {
                          return loading.value
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                      backgroundColor: Colors.red),
                                )
                              : const Text(
                                  "Enviar",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                );
                        }),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 222, 105, 66),
        child: const Icon(Icons.undo_sharp),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void mensagem(String msg) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            msg,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Fechar',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
