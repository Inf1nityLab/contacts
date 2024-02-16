import 'package:hive/hive.dart';

import '../model/contact_model.dart';

class ContactService{
  // Название нашей хранилище
  final String contacts = 'contacts';
  // Создает наше хранилище
  Future<Box<ContactModel>> get _contacts async => await Hive.openBox<ContactModel>(contacts);

  // Добавляем нашу модель
  Future<void> add(ContactModel contactModel) async{
    var contact = await _contacts;
    await contact.add(contactModel);
  }

  // Получаем наши данные
  Future<List<ContactModel>> poluchitData() async {
    var contact = await _contacts;
    return contact.values.toList();
  }


}