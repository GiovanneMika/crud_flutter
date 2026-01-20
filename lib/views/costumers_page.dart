import 'package:crud_flutter/controller/costumer_controller.dart';
import 'package:flutter/material.dart';

class CostumersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CostumersPageState();
}

class _CostumersPageState extends State<CostumersPage> {
  final controller = CostumersController();

  _success() {
    return ListView.builder(
      itemCount: controller.costumers.length,
      itemBuilder: (context, index) {
        var costumer = controller.costumers[index];
        return ListTile(title: Text('${costumer.fullName}'));
      },
    );
  }

  _error() {
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

  _loading() {
    return Center(child: CircularProgressIndicator(color: Colors.grey));
  }

  _initial() {
    return Container();
  }

  stateManagement(CostumerState state) {
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
    // TODO: implement initState
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
