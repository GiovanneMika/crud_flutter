import 'package:brasil_fields/brasil_fields.dart';
import 'package:crud_flutter/components/button_form.dart';
import 'package:crud_flutter/components/input_form.dart';
import 'package:crud_flutter/controller/costumer_controller.dart';
import 'package:crud_flutter/models/costumer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewClient extends StatefulWidget {
  const NewClient({super.key});

  @override
  State<NewClient> createState() => _NewClientState();
}

class _NewClientState extends State<NewClient> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
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

  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      final costumer =
          ModalRoute.of(context)!.settings.arguments as CostumerModel?;
      if (costumer != null) {
        _nameController.text = costumer.fullName ?? '';
        _emailController.text = costumer.email ?? '';
        _phoneController.text = TelefoneInputFormatter()
            .formatEditUpdate(
              TextEditingValue.empty,
              TextEditingValue(text: costumer.phone ?? ''),
            )
            .text;
        _cepController.text = CepInputFormatter()
            .formatEditUpdate(
              TextEditingValue.empty,
              TextEditingValue(text: costumer.address?.zipCode ?? ''),
            )
            .text;
        _addressController.text = costumer.address?.street ?? '';
        _cityController.text = costumer.address?.city ?? '';
        _stateController.text = costumer.address?.state ?? '';
      }
      _isInit = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cepController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

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
                      controller: _nameController,
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
                      controller: _emailController,
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
                      controller: _phoneController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 14) {
                          return 'Por favor, insira um número de telefone válido';
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
                      controller: _cepController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 9) {
                          return 'Por favor, insira um CEP válido';
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
                      onChanged: (value) async {
                        if (value!.length == 9) {
                          final endereco =
                              await controller.findAddress(value) as Address;
                          endereco.city == null || endereco.city == ''
                              ? Fluttertoast.showToast(
                                  msg:
                                      "CEP não encontrado, por favor verifique e tente novamente!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    211,
                                    26,
                                    26,
                                  ),
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                )
                              : Fluttertoast.showToast(
                                  msg: "CEP encontrado com sucesso!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    26,
                                    211,
                                    57,
                                  ),
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                          if (endereco.city == null || endereco.city == '') {
                            _addressController.text = '';
                            _cityController.text = '';
                            _stateController.text = '';
                            return;
                          }
                          _addressController.text = endereco.street!;
                          _cityController.text = endereco.city!;
                          _stateController.text = endereco.state!;
                        }
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
                      controller: _addressController,
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
                      controller: _cityController,
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
                      controller: _stateController,
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
