import 'package:brasil_fields/brasil_fields.dart';
import 'package:crud_flutter/components/button_form.dart';
import 'package:crud_flutter/components/input_form.dart';
import 'package:crud_flutter/controller/costumer_controller.dart';
import 'package:crud_flutter/models/costumer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewClient extends StatefulWidget {
  const NewClient({super.key});

  @override
  State<NewClient> createState() => _NewClientState();
}

class _NewClientState extends State<NewClient> {
  final controller = CostumersController();
  final _formKey = GlobalKey<FormState>();

  final _newCostumer = CostumerModel(
    fullName: '',
    email: '',
    phone: '',
    address: Address(street: '', city: '', state: '', zipCode: ''),
    balance: 0,
    isActive: true,
    lastPurchase: null,
  );

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_newCostumer.id == null) {
        controller.createCostumer(_newCostumer).then((value) {
          if (mounted) Navigator.of(context).pushReplacementNamed('/costumers');
        });
      } else {
        controller.updateCostumer(_newCostumer).then((value) {
          if (mounted) Navigator.of(context).pushReplacementNamed('/costumers');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    CostumerModel? costumer =
        ModalRoute.of(context)!.settings.arguments as CostumerModel?;
    if (costumer != null) {
      _newCostumer.id = costumer.id;
    }

    return Scaffold(
      appBar: AppBar(title: Text('Novo Cliente')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: InputForm(
                      label: "Nome Completo",
                      padding: 12.0,
                      keyboardType: TextInputType.name,
                      initialValue: costumer?.fullName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome completo';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newCostumer.fullName = value;
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: InputForm(
                      label: "Email",
                      padding: 12.0,
                      keyboardType: TextInputType.emailAddress,
                      initialValue: costumer?.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Por favor, insira um email válido';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newCostumer.email = value;
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: InputForm(
                      label: "Número de telefone",
                      padding: 12.0,
                      keyboardType: TextInputType.phone,
                      initialValue: costumer?.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o número de telefone';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter(),
                      ],
                      onSaved: (value) {
                        _newCostumer.phone = value;
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: InputForm(
                      label: "CEP",
                      padding: 12.0,
                      keyboardType: TextInputType.number,
                      initialValue: costumer?.address?.zipCode,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o CEP';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CepInputFormatter(ponto: false),
                      ],
                      onSaved: (value) {
                        _newCostumer.address!.zipCode = value;
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: InputForm(
                      label: "Endereço",
                      padding: 12.0,
                      keyboardType: TextInputType.text,
                      initialValue: costumer?.address?.street,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o endereço';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newCostumer.address!.street = value;
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: InputForm(
                      label: "Cidade",
                      padding: 12.0,
                      keyboardType: TextInputType.text,
                      initialValue: costumer?.address?.city,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a cidade';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newCostumer.address!.city = value;
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: InputForm(
                      label: "Estado",
                      padding: 12.0,
                      keyboardType: TextInputType.text,
                      initialValue: costumer?.address?.state,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o estado';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newCostumer.address!.state = value;
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ButtonForm(
                        label: "Salvar",
                        cor: Colors.blue,
                        onPressed: _saveForm,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ButtonForm(
                        label: "Cancelar",
                        cor: Colors.red,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
