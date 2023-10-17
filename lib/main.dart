import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dummy.json.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Json Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Funny Json Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<AndroidVerison> _versionListDisplay = [];
  List<AndroidVerison> versionList = [];

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.black87,
    backgroundColor: Colors.grey[300],
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  final TextEditingController controller = TextEditingController();

  void searchById(int id) {
    print("searching by id = $id");
    _versionListDisplay =
        versionList.where((element) => element.id == id).toList();

    setState(() {});
  }

  void assignValueFromString(String str) {
    controller.clear();
    FocusScope.of(context).unfocus();
    _versionListDisplay = JsonParser.parseJsonString(str);
    versionList = _versionListDisplay;
    setState(() {});
  }

  void sortValue() {
    _versionListDisplay.sort((a, b) => (a.id ?? -1) < (b.id ?? -1) ? -1 : 1);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppButton(
                  text: "input 1".toUpperCase(),
                  onPressed: () {
                    assignValueFromString(DummyJson.jsonStrOne);
                  },
                ),
                const SizedBox(width: 10),
                AppButton(
                  text: "input 2".toUpperCase(),
                  onPressed: () {
                    assignValueFromString(DummyJson.jsonStrTwo);
                  },
                ),
                const SizedBox(width: 10),
                AppButton(
                  text: "sort".toUpperCase(),
                  onPressed: () {
                    sortValue();
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'versions count => ${versionList.length}',
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    int? valueInt = int.tryParse(value);
                    if (valueInt != null) {
                      searchById(valueInt);
                    }
                  } else {
                    _versionListDisplay = versionList;
                    setState(() {});
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Search By Id',
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: _versionListDisplay.length,
                itemBuilder: (context, index) {
                  final data = _versionListDisplay[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "${data.id}\n${data.title} ",
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.text, required this.onPressed});

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.inversePrimary,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
