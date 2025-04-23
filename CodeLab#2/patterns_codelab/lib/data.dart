import 'dart:convert';

class Document {
  final Map<String, Object?> _json;
  Document() : _json = jsonDecode(documentJson);

//Create and Return a record 
//Records are comma-delimited field list enclosed in parentheses
//Record fields can each have a different type, so recirds can collect mutliple types
//Records can contain both named and positional foelds, like argument lists in a function 
//Records can be returned from a function, so they enable you to return mutliple values froma function call
  (String, {DateTime modified}) get metadata {           
    //Metadata returns data
    const title = 'My Document';
    final now = DateTime.now();

    return (title, modified: now);
  }  
}

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
      "checked": false,
      "text": "Learn Dart 3"
    }
  ]
}
''';