import 'package:flutter/material.dart';

import 'data.dart';

void main() {
  runApp(const DocumentApp());
}

//DocumentApp sets up the latest verison of Material Design for theming the UI
//Use DocumentApp to create, view, edit, and manage digital documents
class DocumentApp extends StatelessWidget {
  const DocumentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: DocumentScreen(document: Document()),
    );
  }
}

//DocumentScreen provides the visual layout of the page using the Scaffold widget
class DocumentScreen extends StatelessWidget {
  final Document document;

  const DocumentScreen({required this.document, super.key});

  @override
  Widget build(BuildContext context) {
    //Accessing Record fields
    final (title, :modified) = document.metadata;
    final blocks = document.getBlocks();
    //metadata getter method returns a record, which is assigned to the local variable, metaDataRecord
    //Records are a light and easy way to return multiple values from a single function call and assign them to a variable
    return Scaffold(
      appBar: AppBar(title: Text(title)),

      body: Column(
        children: [
          Text('Last modified $modified'),
          Expanded(
            child: ListView.builder(
              itemCount: blocks.length,
              itemBuilder: (context, index) {
                return BlockWidget(block: blocks[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BlockWidget extends StatelessWidget {
  final Block block;

  const BlockWidget({required this.block, super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle;
    switch (block.type) {
      case 'h1':
        textStyle = Theme.of(context).textTheme.displayMedium;
      case 'p' || 'checkbox':
        textStyle = Theme.of(context).textTheme.bodyMedium;
      case _:
        textStyle = Theme.of(context).textTheme.bodySmall;
    }

    return Container(
      margin: const EdgeInsets.all(8),
      child: Text(block.text, style: textStyle),
    );
  }
}
//to get a psitional field (a field without a name, like title), user the getter $<num> on the record. 
//this reurns only unnamed fields
//Named fields like modified don't have a positional getter, so you can use its name directly,  like metadataRecord.modified. 

//To Detemind the name of a getter for a positional field, start at $! and skip named fields. 
//A pattern represents a structure that one or more values can take, like a blueprint. 
//Patterns againast actual values to determine if they match.
//SOme patterns, when they match, destructure the matched value by pulling data out of it. 
//Destructing lets you unpack values from an object to assign them to local variables, or perform further matching on them. 
