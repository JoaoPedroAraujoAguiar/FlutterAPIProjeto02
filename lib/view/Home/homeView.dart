import 'package:flutter/material.dart';
import 'package:money_search/data/MoneyController.dart';
import 'package:money_search/model/MoneyModel.dart';

import '../../model/ListPersonModel.dart';

List<ListPersonModel> model = [];

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

/// instancia do modelo para receber as informações

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Busca de Moedas'),
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
        ),
        body: FutureBuilder<List<ListPersonModel>>(

            ///future: local onde informções serão buscadas
            future: MoneyController().getListPerson(),
            builder: (context, snapshot) {
              /// validação de carregamento da conexão
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              /// validação de erro
              if (snapshot.error == true) {
                return SizedBox(
                  height: 300,
                  child: Text("Vazio"),
                );
              }

              /// passando informações para o modelo criado
              model = snapshot.data ?? model;
              //adicionar uma pessoa
              model.add(ListPersonModel(
                id: "24",
                name: "Jácare",
                avatar:
                    "https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/2021/06/15699_A429F3629477FA36.jpg?w=876&h=484&crop=1",
              ));
              //vai deixar em ordem
              model.sort(
                (a, b) => a.name!.compareTo(b.name!),
              );
              //remove a pessoa com o is 10
              model.removeWhere((pessoa) => pessoa.id == "10");
              //remove a pessoa com o nome Brett Erdman
              model.removeWhere((pessoa) => pessoa.name == "Brett Erdman");
              //remover avatar da pessoa com id 9
              model.forEach((pessoa) {
                if (pessoa.id == "9") {
                  pessoa.avatar = null;
                  //pessoa.avatar = "";
                }
              });
              return ListView.builder(
                  itemCount: model.length,
                  itemBuilder: (context, index) {
                    ListPersonModel item = model[index];
                    return ListTile(
                        leading: Image.network(
                            errorBuilder: (context, error, stackTrace) {
                          return Container();
                        }, item.avatar ?? ""),
                        title: Text(item.name ?? ""),
                        trailing: Text(item.id ?? ""));
                  });
            }));
  }

  Future<Null> refresh() async {
    setState(() {});
  }
}
