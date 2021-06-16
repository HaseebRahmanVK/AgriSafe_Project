import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';
import './scoped-models/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:project/Model/doc.dart';
// import 'package:project/Pages/pdf_preview.dart';

class AnimalHistory extends StatefulWidget {
  // final Doc doc;
  // ListTileWidget(this.doc);
  final MainModel model;
  AnimalHistory(this.model);
  @override
  _AnimalHistoryState createState() => _AnimalHistoryState();
}

class _AnimalHistoryState extends State<AnimalHistory> {
  @override
  void initState() {
    // ignore: unused_local_variable
    MainModel model = ScopedModel.of(this.context);
    // model.fetchAnimals();
    // model.allAnimals;
    model.fetchAnimals();
    super.initState();
  }

  Widget _buildAnimalList() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Center(child: Text('Not Connected to Device'));
        if (model.allAnimals.length > 0 && !model.isLoading) {
          content = ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                  key: Key(model.allAnimals[index].label),
                  onDismissed: (DismissDirection direction) {
                    if (direction == DismissDirection.endToStart) {
                      model.selectAnimal(model.allAnimals[index].animalId);
                      model.deleteAnimal();
                    } else if (direction == DismissDirection.startToEnd) {
                      print('Swiped start to end');
                    } else {
                      print('Other swiping');
                    }
                  },
                  background: Container(color: Colors.red),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(model.allAnimals[index].image),
                          backgroundColor: Colors.transparent,
                          radius: 50,
                        ),
                        title: Text(model.allAnimals[index].label),
                        subtitle: Text(model.allAnimals[index].Time),
                        // trailing: _buildEditButton(context, index, model),
                      ),
                      Divider()
                    ],
                  ));
            },
            itemCount: model.allAnimals.length,
          );
        } else if (model.isLoading) {
          content = Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: model.fetchAnimals,
          child: content,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.greenAccent[700],
            title: Text(
              'Intrusion History',
              style: GoogleFonts.roboto(),
            ),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                }),
          ),
          body: _buildAnimalList(),
        );
      },
    );
  }
}
