Qt.include("DatabaseDefault.js")

function DatabaseBase() {};

DatabaseBase.create = function() {
    var db=MainController.getDatabase();
    db.transaction(
         function(tx) {
             var query="CREATE TABLE IF NOT EXISTS core_config(id INTEGER PRIMARY KEY, key TEXT UNIQUE NOT NULL, value TEXT);";
             tx.executeSql(query);
             query="CREATE UNIQUE INDEX IF NOT EXISTS key_unique ON core_config(key);"
             tx.executeSql(query);
             query="CREATE TABLE IF NOT EXISTS fixer_color(id INTEGER PRIMARY KEY, color TEXT, duration TEXT);";
             tx.executeSql(query);
     });
};


DatabaseBase.insert = function () {
    var db=MainController.getDatabase();
    db.transaction(
        function(tx) {
            var query='INSERT INTO core_config (key, value) VALUES ("version","'+DatabaseDefault.dbversion+'");';
            tx.executeSql(query);
            query='INSERT INTO core_config (key, value) VALUES ("checker_color","'+DatabaseDefault.black+'");';
            tx.executeSql(query);
            query='INSERT INTO core_config (key, value) VALUES ("fixer_duration","'+DatabaseDefault.base_duration+'");';
            tx.executeSql(query);
            query='INSERT INTO fixer_color (color, duration) VALUES ("'+DatabaseDefault.red+'",'+DatabaseDefault.redDuration+');';
            tx.executeSql(query);
            query='INSERT INTO fixer_color (color, duration) VALUES ("'+DatabaseDefault.green+'",'+DatabaseDefault.greenDuration+');';
            tx.executeSql(query);
            query='INSERT INTO fixer_color (color, duration) VALUES ("'+DatabaseDefault.blue+'",'+DatabaseDefault.blueDuration+');';
            tx.executeSql(query);
    });
    console.log("Insert database version to: "+DatabaseDefault.dbversion);
};


