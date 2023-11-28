import 'package:data_lager/database_service.dart';
import 'package:data_lager/model.dart';
import 'package:data_lager/provider.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final DbService dbService = DbService();
  @override
  Widget build(BuildContext context) {
    return Provider(
        data: dbService,
        child: const MaterialApp(title: 'My messages', home: MyCustomForm()));
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  TextEditingController titleTextController = TextEditingController();
  TextEditingController textTextcontroller = TextEditingController();
  var _list = [];
  @override
  void dispose() {
    titleTextController.dispose();
    textTextcontroller.dispose();
    super.dispose();
  }

  getMessages(DbService service) async {
    List<Message> newList = await service.getAllMessagesFromDb();
    List<String> _newList = newList
        .map((messages) => '${messages.title} || ${messages.text}')
        .toList();

    setState(() {
      _list = _newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    DbService service = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Messageboard'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: titleTextController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: textTextcontroller,
            ),
          ),
          TextButton(
            onPressed: () {
              service.putMessagesInDb(
                Message()
                  ..title = titleTextController.text
                  ..text = textTextcontroller.text,
              );
            },
            child: Text('save message'),
          ),
          TextButton(
            onPressed: () {
              getMessages(service);
            },
            child: Text('Get all messages'),
          ),
          for (String item in _list) Text(item),
        ],
      ),
    );
  }
}
