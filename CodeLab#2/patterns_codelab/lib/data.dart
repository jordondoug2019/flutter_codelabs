import 'dart:convert';
 const documentJson = '''
{
  "metadata": {
    "title": "My Document",
    "modified": "2023-05-10"
  },
  "blocks": [
    {
      "type": "h1",
      "text": "Chapter 1"
    },
    {
      "type": "p",
      "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    },
    {
      "type": "checkbox",
      "checked": true,
      "text": "Learn Dart 3"
    }
  ]
}
''';

class Document {
  final Map<String, Object?> _json;
  Document() : _json = jsonDecode(documentJson);

  (String, {DateTime modified}) get metadata {
    if (_json // Modify from here...
        case {
          'metadata': {'title': String title, 'modified': String localModified},
        }) {
      return (title, modified: DateTime.parse(localModified));
    } else {
      throw const FormatException('Unexpected JSON');
    } // to here.
  }

  List<Block> getBlocks() {
    // Add from here...
    if (_json case {'blocks': List blocksJson}) {
      return [for (final blockJson in blocksJson) Block.fromJson(blockJson)];
    } else {
      throw const FormatException('Unexpected JSON format');
    }
  } // to here.
}

class HeaderBlock extends Block {
  HeaderBlock(String text) : super('h1', text);
}

class ParagraphBlock extends Block {
  ParagraphBlock(String text) : super('p', text);
}

class CheckboxBlock extends Block {
  final bool isChecked;
  CheckboxBlock(String text, this.isChecked) : super('checkbox', text);
}

class Block {
  final String type;
  final String text;
  Block(this.type, this.text);

  factory Block.fromJson(Map<String, dynamic> json) {
    if (json case {'type': final String type, 'text': final String text}) {
      switch (type) {
        case 'h1':
          return HeaderBlock(text);
        case 'p':
          return ParagraphBlock(text);
        case 'checkbox':
          final isChecked = json['checked'] as bool? ?? false;
          return CheckboxBlock(text, isChecked);
        default:
          return Block(type, text);
      }
    } else {
      throw const FormatException('Unexpected JSON format');
    }
  }
}
  //class Document {
  // final Map<String, Object?> _json;
  //  Document() : _json = jsonDecode(documentJson);

  //Create and Return a record
  //Records are comma-delimited field list enclosed in parentheses
  //Record fields can each have a different type, so recirds can collect mutliple types
  //Records can contain both named and positional foelds, like argument lists in a function
  //Records can be returned from a function, so they enable you to return mutliple values froma function call
  //(String, {DateTime modified}) get metadata {
  //Metadata returns data
  //const title = 'My Document';
  // final now = DateTime.now();

  //return (title, modified: now);
  // }
  //}
