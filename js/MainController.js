.import QtQuick.LocalStorage 2.0 as Sql
Qt.include("DatabaseBase.js");
Qt.include("DatabaseDefault.js");


function MainController() {};

MainController.getDatabase = function() {
     var db = Sql.LocalStorage.openDatabaseSync("fixel", "1.0", "Description", 100000);
     return db;
};

MainController.checkData = function(version) {
    var rs;
    var rq;
    var versiondb;
    var db = this.getDatabase();

    db.transaction( function(tx) {
        rs = tx.executeSql("SELECT name FROM sqlite_master WHERE type='table' AND name='core_config';");
    });

    if(rs.rows.length<=0)
    {
        DatabaseBase.create();
        DatabaseBase.insert();
    }

    db.transaction( function(tx) {
        rq = tx.executeSql('SELECT value FROM core_config where key="version";');
    });

    for(var i = 0; i < rq.rows.length; i++) {
        var dbItem = rq.rows.item(i);
        console.log("Database version: "+ dbItem.value);
        versiondb=dbItem.value;
        break;
    }
    if(typeof versiondb !== "undefined" && parseInt(versiondb) < parseInt(version))
    {
        if (parseInt(versiondb) < 1.0)
        {
            //nothing todo
        }

        DatabaseDefault.update(version);
    }
};

MainController.checkValidHexColor = function(colorStr) {
    colorStr=colorStr.trim();
    if(/^#[0-9A-F]{6}$/i.test(colorStr))
    {
        return colorStr;
    }
    else if (/^[0-9A-F]{6}$/i.test(colorStr))
    {
        return "#"+colorStr;
    }

    return DatabaseDefault.black;

};

MainController.checkValidDuration = function(duration) {
    var durationInt;
    duration=duration.replace("ms", "").trim();
    durationInt=parseInt(duration, 10);

    if (!isNaN(durationInt) && duration === parseInt(duration, 10).toString())
    {
        return duration;
    }
    return DatabaseDefault.default_duration;
};
