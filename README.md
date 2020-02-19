# Demo SqfLite
*Library (version 1.2.1): https://pub.dev/packages/sqflite*

## 1. Add `sqflite` lib on `pubspec.yaml`:

```javascript
  dependencies:
    flutter:
      sdk: flutter

    cupertino_icons: ^0.1.2
    sqflite: ^1.2.1
```

## 2. [Init Database](https://github.com/huubao2309/demo_sqflite_flutter/blob/master/demo_sqflite/lib/database/todo_db.dart)

```javascript
  init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DB_NAME);
    _database = await openDatabase(
      path,
      onCreate: (db, version) {
        initScript.forEach((script) async => await db.execute(script));
      },
      version: DB_VERSION,
    );
  }
  ...
```

With `initScript`:

```javascript
  static const initScript = [TodoTable.CREATE_TABLE_QUERY];
```

## 3. [Create Table Query](https://github.com/huubao2309/demo_sqflite_flutter/blob/master/demo_sqflite/lib/database/todo_table.dart):

```javascript
  static const TABLE_NAME = 'todo';
  static const CREATE_TABLE_QUERY = '''
    CREATE TABLE $TABLE_NAME (
      id INTEGER PRIMARY KEY,
      content TEXT
    );
  ''';
```

## 4. Init DB at `main()`:

```javascript
    void main() async {
    // Init DB
    WidgetsFlutterBinding.ensureInitialized();
    await TodoDatabase.instance.init();
    
    runApp(MyApp());
  }
  ...
```
