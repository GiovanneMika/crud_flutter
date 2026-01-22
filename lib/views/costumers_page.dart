import 'package:crud_flutter/controller/costumer_controller.dart';
import 'package:crud_flutter/models/costumer_model.dart';
import 'package:flutter/material.dart';

class CostumersPage extends StatefulWidget {
  const CostumersPage({super.key});

  @override
  State<StatefulWidget> createState() => _CostumersPageState();
}

class _CostumersPageState extends State<CostumersPage> {
  final controller = CostumersController();

  Padding _success() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: ListView.builder(
        itemCount: controller.costumers.length,
        itemBuilder: (context, index) {
          var costumer = controller.costumers[index];
          return ListTile(
            title: Text('${costumer.fullName}'),
            subtitle: Text('${costumer.email}'),
            trailing: SizedBox(
              width: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    padding: EdgeInsets.all(0),
                    constraints: BoxConstraints(maxHeight: 30, maxWidth: 30),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('/costumers/new', arguments: costumer)
                          .then((_) => controller.start());
                    },
                    splashRadius: 20,
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    padding: EdgeInsets.all(0),
                    constraints: BoxConstraints(maxHeight: 30, maxWidth: 30),
                    splashRadius: 20,
                    onPressed: () {
                      _modalExclusao(context, costumer, controller);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Center _error() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          controller.start();
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: Text("Tentar novamente"),
      ),
    );
  }

  Center _loading() {
    return Center(child: CircularProgressIndicator(color: Colors.grey));
  }

  Container _initial() {
    return Container();
  }

  Widget stateManagement(CostumerState state) {
    switch (state) {
      case CostumerState.initial:
        return _initial();

      case CostumerState.loading:
        return _loading();

      case CostumerState.success:
        return _success();

      case CostumerState.error:
        return _error();
    }
  }

  @override
  void initState() {
    super.initState();
    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clientes')),
      body: AnimatedBuilder(
        animation: controller.state,
        builder: (context, child) {
          return stateManagement(controller.state.value);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/costumers/new');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

Future<void> _modalExclusao(
  BuildContext context,
  CostumerModel costumer,
  CostumersController controller,
) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Excluir ${costumer.fullName}"),
        content: Text(
          "Tem certeza que deseja excluir ${costumer.fullName}? Esta ação não pode ser desfeita.",
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
            onPressed: () {
              controller.deleteCostumer(costumer.id!).then((value) {
                controller.start();
              });
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
