
import 'package:flutter/material.dart';
import 'package:to_do_app_hive/locator.dart';
import '../model/contact_model.dart';
import '../service/contact_service.dart';


class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final ContactService _contactService = locator<ContactService>();
  String helperText = '';

  void addInfo(){
    if (nameController.text.isNotEmpty && numberController.text.isNotEmpty){
      var contactModel = ContactModel(nameController.text,numberController.text );
      _contactService.add(contactModel);
      Navigator.pop(context);
    } else if(numberController.text.isEmpty){
      setState(() {
        helperText = 'номер не может быть пустым';
      });
    } else if(nameController.text.isEmpty) {
      var contactModel = ContactModel('',numberController.text );
      _contactService.add(contactModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.cancel),
        ),
        title: const Text('Создать контакты'),
        actions: [
          SizedBox(
            width: 120,
            height: 40,
            child: ElevatedButton(
                onPressed: () {
                  addInfo();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent),
                child: const Text('Сохранить')),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body:  Column(
        children: [
          const CircleAvatar(
            radius: 55,
            backgroundColor: Colors.amberAccent,
            child: Center(
              child: Icon(
                Icons.person,
                size: 40,
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Icon(Icons.person),
              ),
              SizedBox(
                width: 330,
                child: TextField(

                  controller: nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Имя'
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            children: [
               const Padding(
                 padding: EdgeInsets.only(left: 15, right: 15),
                 child: Icon(Icons.call),
               ),
              SizedBox(
                width: 330,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: numberController,
                  decoration:  InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Номер',
                    helperText: helperText,
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
