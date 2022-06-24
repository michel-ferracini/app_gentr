import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ListTilesWidget extends StatelessWidget {
  const ListTilesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Desenvolvedores',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: const ListViewWidget(),
    );
  }
}

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(context: context, tiles: const [
        ListTileWidget(
            typeImage: 'LA',
            title: 'Claudemir Públio Júnior',
            subtitle: 'Docente EBTT IFMT',
            urlImage:
            'CLA',
            urLinkedin: 'https://lattes.cnpq.br/6986438491496935'),
        ListTileWidget(
            typeImage: 'LA',
            title: 'Yoji Massago',
            subtitle: 'Docente EBTT IFMT',
            urlImage:
            'YOJ',
            urLinkedin: 'https://lattes.cnpq.br/9137805402174351'),
        ListTileWidget(
            typeImage: 'LI',
            title: 'Michel Ferracini',
            subtitle: 'Discente CSTADS',
            urlImage:
            'MIC',
            urLinkedin:
            'https://www.linkedin.com/in/michel-ferracini-69529463'),
        ListTileWidget(
            typeImage: 'LI',
            title: 'Raul Tavares Cecatto',
            subtitle: 'Discente CSTADS',
            urlImage:
            'RAU',
            urLinkedin: 'https://www.linkedin.com/in/raulcecatto'),
        ListTileWidget(
            typeImage: 'LI',
            title: 'Arlindo Junior Fernandes Pina',
            subtitle: 'Discente CSTADS',
            urlImage:
            'LIN',
            urLinkedin:
            'https://www.linkedin.com/in/arlindo-junior-fernandes-662aa821a'),
        ListTileWidget(
            typeImage: 'LI',
            title: 'Danilo Batista da Cruz',
            subtitle: 'Discente CSTADS',
            urlImage:
            'DAN',
            urLinkedin:
            'https://www.linkedin.com/in/danilo-batista-8679b516a/'),
        ListTileWidget(
            typeImage: 'LI',
            title: 'João Kleber Alves Neto',
            subtitle: 'Discente CSTADS',
            urlImage:
            'JKB',
            urLinkedin: 'linkedin.com/in/joão-kleber-a-neto-422420242'),
        ListTileWidget(
            typeImage: 'LI',
            title: 'Jucelio da Silva Santos',
            subtitle: 'Discente CSTADS',
            urlImage:
            'JUC',
            urLinkedin: 'https://www.linkedin.com/in/juceliodigital/'),
        ListTileWidget(
            typeImage: 'LI',
            title: 'Matheus Augusto dos Santos Santana',
            subtitle: 'Discente CSTADS',
            urlImage:
            'MAT',
            urLinkedin: 'https://www.linkedin.com/in/matheus-augusto-96141b242'),
        ListTileWidget(
            typeImage: 'LI',
            title: 'Miqueias Cardoso Soares',
            subtitle: 'Discente CSTADS',
            urlImage:
            'MIQ',
            urLinkedin:
            'https://www.linkedin.com/in/miqueias-cardoso-soares-507222224'),
        ListTileWidget(
            typeImage: 'LI',
            title: 'Priscila da Silva Batista',
            subtitle: 'Discente CSTADS',
            urlImage:
            'PRI',
            urLinkedin:
            'https://www.linkedin.com/in/priscila-batista-972b72186'),
        ListTileWidget(
            typeImage: 'LI',
            title: 'Wagner Daniel Macedo Delmondes',
            subtitle: 'Discente CSTADS',
            urlImage:
            'WGN',
            urLinkedin: 'https://www.linkedin.com/in/wagnerdelmondes'),
        ListTileWidget(
            typeImage: 'LI',
            title: 'Wanderson Renato Moraes da Silva',
            subtitle: 'Discente CSTADS',
            urlImage:
            'WAN',
            urLinkedin:
            'https://www.linkedin.com/in/wanderson-renato-moraes-da-silva-b49681239/'),
      ]).toList(),
    );
  }
}

class ListTileWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String urlImage;
  final String urLinkedin;
  final String typeImage;
  const ListTileWidget(
      {key,
        required this.title,
        required this.subtitle,
        required this.urlImage,
        required this.urLinkedin,
        required this.typeImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:  CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage("img/" + urlImage + ".png"),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 18.0)),
      trailing: Image.asset("img/" + typeImage + ".png"),
      //trailing: const Icon(FontAwesomeIcons.linkedin, color: Colors.indigo, size: 30,),
      onTap: () {
        var _url = Uri.parse(urLinkedin);
        launchUrl(_url);
      },
      dense: false,
      selected: false,
      enabled: true,
    );
  }
}

void mensagem(String msg, context) {
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
