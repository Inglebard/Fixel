function DatabaseDefault() {};

DatabaseDefault.dbversion = "0.1";
DatabaseDefault.base_duration = "100000";
DatabaseDefault.default_duration = "0";
DatabaseDefault.black = "#000000";
DatabaseDefault.red = "#FF0000";
DatabaseDefault.green = "#00FF00";
DatabaseDefault.blue = "#0000FF";
DatabaseDefault.redDuration = 100;
DatabaseDefault.greenDuration = 100;
DatabaseDefault.blueDuration = 100;

DatabaseDefault.update = function (version) {
    var db=MainController.getDatabase();
    db.transaction(
        function(tx) {
            var query='UPDATE core_config set value="'+version+'" WHERE key="version";';
            tx.executeSql(query);
            console.log("Update database version to: "+version);
    });
};
