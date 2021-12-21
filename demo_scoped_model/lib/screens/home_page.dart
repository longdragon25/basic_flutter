import 'package:demo_scoped_model/scoped_model/my_scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatelessWidget {
  MyScopedModel myScopedModel = MyScopedModel();
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MyScopedModel>(
        model: myScopedModel,
        child: ScopedModelDescendant<MyScopedModel>(
          builder: (context, child, model) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Scoped Model'),
              ),
              body: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        model.decrementValue();
                      },
                      child: Icon(Icons.exposure_minus_1),
                      shape: CircleBorder(),
                      color: Colors.red,
                      elevation: 2,
                      padding: EdgeInsets.all(10.0),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      model.value.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    MaterialButton(
                      onPressed: () {
                        model.incrementValue();
                      },
                      child: Icon(Icons.add),
                      shape: CircleBorder(),
                      elevation: 2,
                      color: Colors.red,
                      padding: EdgeInsets.all(10.0),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
