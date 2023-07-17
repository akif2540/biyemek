import 'package:biyemek/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddressDetailsPage extends StatefulWidget {
  const AddressDetailsPage({Key? key}) : super(key: key);

  @override
  _AddressDetailsPageState createState() => _AddressDetailsPageState();
}

class _AddressDetailsPageState extends State<AddressDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hoodController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.figma1Color,
        title: const Text('Adres Bilgileri'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Adres İsmi',
                ),
              ),
              TextFormField(
                controller: _streetController,
                decoration: const InputDecoration(
                  labelText: 'Sokak',
                ),
              ),
              TextFormField(
                controller: _hoodController,
                decoration: const InputDecoration(
                  labelText: 'Mahalle',
                ),
              ),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'Şehir',
                ),
              ),
              TextFormField(
                controller: _stateController,
                decoration: const InputDecoration(
                  labelText: 'İlçe',
                ),
              ),
              TextFormField(
                controller: _zipController,
                decoration: const InputDecoration(
                  labelText: 'Kapı No',
                ),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.figma1Color,
                ),
                onPressed: () {
                  // Save address details to firestore
                  final addressDetails = {
                    'name': _nameController.text,
                    'street': _streetController.text,
                    'hood': _hoodController.text,
                    'city': _cityController.text,
                    'state': _stateController.text,
                    'doorNo': _zipController.text,
                  };
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    FirebaseFirestore.instance
                        .collection('address')
                        .doc(user.uid)
                        .set(addressDetails);
                  }

                  Navigator.pop(context);
                },
                child: const Text('Adresi Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
