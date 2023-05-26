import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'メモ帳',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: 'listpage',
      routes: <String, WidgetBuilder>{
        'listpage': (BuildContext context) => MemoListPage(),
        'addpage': (BuildContext context) => MemoAddPage(),
      },
    );
  }
}

class MemoListPage extends StatefulWidget {
  @override
  MemoListPageState createState() => MemoListPageState();
}

class memotile {
  String memo;
  bool checked;
  memotile(this.memo, this.checked);
}

class MemoListPageState extends State<MemoListPage> {
  List<memotile> memolist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メモ一覧'),
      ),
      body: ListView.builder(
        itemCount: memolist.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
                leading: Checkbox(
                  value: memolist[index].checked,
                  onChanged: (isChecked) {
                    setState(() {
                      memolist[index].checked = isChecked!;
                    });
                  },
                ),
                title: Text(memolist[index].memo),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      memolist.removeAt(index);
                    });
                  },
                  icon: const Icon(Icons.delete),
                )),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final added_memo = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return MemoAddPage();
          }));
          if (added_memo != null) {
            setState(() {
              memolist.add(memotile(added_memo, false));
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class MemoAddPage extends StatefulWidget {
  @override
  MemoAddPageState createState() => MemoAddPageState();
}

class MemoAddPageState extends State<MemoAddPage> {
  String memo = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('メモ追加')),
        body: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  memo = value;
                });
              },
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(memo);
                },
                child: const Text('追加')),
          ],
        ));
  }
}
