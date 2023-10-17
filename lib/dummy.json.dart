import 'dart:convert';

final class DummyJson {
  static String jsonStrOne = """
  [
  {
    "0": {
      "id": 1,
      "title": "Gingerbread"
    },
    "1": {
      "id": 2,
      "title": "Jellybean"
    },
    "3": {
      "id": 3,
      "title": "KitKat"
    }
  },
  [
    {
      "id": 4,
      "title": "Lollipop"
    },
    {
      "id": 5,
      "title": "Pie"
    },
    {
      "id": 6,
      "title": "Oreo"
    },
    {
      "id": 7,
      "title": "Nougat"
    }
  ]
]""";
  static String jsonStrTwo = """
  [
  {
    "0": {
      "id": 1,
      "title": "Gingerbread"
    },
    "1": {
      "id": 2,
      "title": "Jellybean"
    },
    "3": {
      "id": 3,
      "title": "KitKat"
    }
  },
  {
    "0": {
      "id": 8,
      "title": "Froyo"
    },
    "2": {
      "id": 9,
      "title": "Éclair"
    },
    "3": {
      "id": 10,
      "title": "Donut"
    }
  },
  [
    {
      "id": 4,
      "title": "Lollipop"
    },
    {
      "id": 5,
      "title": "Pie"
    },
    {
      "id": 6,
      "title": "Oreo"
    },
    {
      "id": 7,
      "title": "Nougat"
    }
  ]
]""";

  static String jsonStrThree = """
 {
  "0": [
    {
      "0": {
        "id": 1,
        "title": "Gingerbread"
      },
      "1": {
        "id": 2,
        "title": "Jellybean"
      },
      "3": {
        "id": 3,
        "title": "KitKat"
      }
    },
    {
      "0": {
        "id": 8,
        "title": "Froyo"
      },
      "2": {
        "id": 9,
        "title": "Éclair"
      },
      "3": {
        "id": 10,
        "title": "Donut"
      }
    },
    [
      {
        "id": 4,
        "title": "Lollipop"
      },
      {
        "id": 5,
        "title": "Pie"
      },
      {
        "id": 6,
        "title": "Oreo"
      },
      {
        "id": 7,
        "title": "Nougat"
      }
    ]
  ]
}
""";
}

class AndroidVerison {
  AndroidVerison({
    this.id,
    this.title,
  });

  int? id;
  String? title;
}

final class JsonParser {
  static dynamic _parseJsonString(String jsonStr) {
    return json.decode(jsonStr);
  }

  static (int, String) _obj(Map data) {
    return (data['id'], data['title']);
  }

  static List<AndroidVerison> _findAndConvertToModel(dynamic data) {
    List<AndroidVerison> result = [];

    if (data is List) {
      for (var item in data) {
        result = result + _findAndConvertToModel(item);
      }
    } else if (data is Map) {
      List<String> keys = data.keys.map((e) => e.toString()).toList();
      /// base case for the recursion
      if (keys.contains('id') && keys.contains('title')) {
        final (id, title) = _obj(data);
        AndroidVerison verison = AndroidVerison(id: id, title: title);
        result.add(verison);
      } else {
        for (var key in keys) {
          result = result + _findAndConvertToModel(data[key]);
        }
      }
    }

    return result;
  }

  static List<AndroidVerison> parseJsonString(String jsonStr) {
    return _findAndConvertToModel(_parseJsonString(jsonStr));
  }
}
