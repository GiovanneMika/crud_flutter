import 'package:crud_flutter/models/costumer_model.dart';
import 'package:flutter/material.dart';

class CostumerProfile extends StatelessWidget {
  const CostumerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final costumer =
        ModalRoute.of(context)!.settings.arguments as CostumerModel?;

    return Scaffold(
      appBar: AppBar(title: Text('Meu Perfil')),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                costumer?.profileImageUrl ??
                    'https://avatars.githubusercontent.com/u/69139838?v=4',
              ),
            ),
            SizedBox(height: 20),
            Text(
              costumer?.fullName ?? 'Giovanni',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
