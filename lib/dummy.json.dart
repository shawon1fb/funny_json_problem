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
    // Initialize an empty list to store the extracted AndroidVerison objects
    List<AndroidVerison> result = [];

    // Check if the input data is a list
    if (data is List) {
      // Iterate through each item in the list
      for (var item in data) {
        // Recursively call _findAndConvertToModel to process nested lists
        result = result + _findAndConvertToModel(item);
      }
    } else if (data is Map) {
      // Convert the map keys to a list of strings
      List<String> keys = data.keys.map((e) => e.toString()).toList();

      // Check if the map contains both 'id' and 'title' keys
      if (keys.contains('id') && keys.contains('title')) {
        // Extract the 'id' and 'title' values from the map
        final (id, title) = _obj(data);

        // Create an AndroidVerison object using the extracted values
        AndroidVerison verison = AndroidVerison(id: id, title: title);

        // Add the created object to the result list
        result.add(verison);

        // If there are additional keys besides 'id' and 'title'
        if (keys.length > 2) {
          // Iterate through the remaining keys
          for (var key in keys) {
            // Skip 'id' and 'title' keys
            if (key != 'id' && key != 'title') {
              // Recursively call _findAndConvertToModel to process nested maps
              result = result + _findAndConvertToModel(data[key]);
            }
          }
        }
      } else {
        // If the map doesn't contain both 'id' and 'title' keys, recursively process nested maps
        for (var key in keys) {
          result = result + _findAndConvertToModel(data[key]);
        }
      }
    }

    // Return the list of extracted AndroidVerison objects
    return result;
  }

  static List<AndroidVerison> parseJsonString(String jsonStr) {
    return _findAndConvertToModel(_parseJsonString(jsonStr));
  }

  static List<AndroidVerison> findAndConvertToModel(dynamic data) {
    return _findAndConvertToModel(data);
  }
}
