import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'newPassword.dart';

class Check extends StatefulWidget {
  final String emailDigitado;
  const Check({Key? key, required this.emailDigitado}) : super(key: key);

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  final loading = ValueNotifier(false);
  final code = TextEditingController();

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
              'Código de Confirmação',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              child: TextField(
                controller: code,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  labelText: 'Código',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 222, 105, 66),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 222, 105, 66),
                    width: 1,
                  )),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 222, 105, 66),
                    width: 1,
                  )),
                  icon: Icon(
                    Icons.people,
                    size: 20,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 120,
                  margin: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                    ),
                    onPressed: () async {
                      loading.value = !loading.value;
                      var dio = Dio();

                      var resposta = await dio.post(
                        'http://201.15.116.228/mobile/check',
                        // 'http://jsdteste.tk/mobile/check',
                        data: {
                          'check': code.text,
                          'email': widget.emailDigitado,
                        },
                      );

                      if (resposta.data != null) {
                        var jsonResposta = convert.jsonDecode(resposta.data);

                        if (jsonResposta[0] != 'Erro') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewPassword(
                                emailDigitado: widget.emailDigitado,
                              ),
                            ),
                          );
                        } else {
                          loading.value = !loading.value;
                          mensagem(jsonResposta[1]);
                        }
                      } else {
                        loading.value = !loading.value;
                        mensagem('Erro na requisição');
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
                  fontSize: 25.0,
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
