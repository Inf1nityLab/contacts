import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app_hive/contact_app/service/contact_service.dart';
import 'package:to_do_app_hive/locator.dart';

import '../model/contact_model.dart';
import 'add_screen.dart';

class Contacts extends StatelessWidget {
  Contacts({super.key});

  final ContactService _contactService = locator<ContactService>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _contactService.poluchitData(),
      builder: (context, AsyncSnapshot<List<ContactModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ContactScreen(snapshot.data ?? []);
        }
        return const Center(child:  CircularProgressIndicator());
      },
    );
  }
}

class ContactScreen extends StatefulWidget {
  final List<ContactModel> contacts;

  ContactScreen(this.contacts);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: SizedBox(
                height: 70,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddScreen(),),);
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.person_add_sharp),
                      Text('создать контакт'),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable:
                      Hive.box<ContactModel>('contacts').listenable(),
                  builder: (context, Box<ContactModel> box, _) {
                    return ListView.builder(
                        itemCount: box.values.length,
                        itemBuilder: (context, index) {
                          var contacts = box.getAt(index);
                          return ListTile(
                            leading: const CircleAvatar(),
                            title: Text(contacts!.name),
                            subtitle: Text(contacts!.number),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.call),
                            ),
                          );
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
