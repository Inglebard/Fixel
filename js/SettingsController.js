.import QtQuick.LocalStorage 2.0 as Sql
//Qt.include("MainController.js");
Qt.include("DatabaseDefault.js");


function SettingsController() {};

SettingsController.getDatabase = function() {
     var db = Sql.LocalStorage.openDatabaseSync("fixel", "1.0", "Description", 100000);
     return db;
};

SettingsController.save = function(page) {

    var db=SettingsController.getDatabase();
    var rq;
    var dbItem;
    var checker_color;
    var fixer_duration;
    var fixer_color_arr = [];

    checker_color=SettingsController.checkValidHexColor(page.colorCheckerVal);
    fixer_duration=SettingsController.checkValidDuration(page.duraFixerVal);

    for (var i = 0; i < page.colorDurationList.children.length; ++i)
    {
        fixer_color_arr.push({id:page.colorDurationList.children[i].contentsItem.mapId, color:SettingsController.checkValidHexColor(page.colorDurationList.children[i].contentsItem.colorValue), duration:SettingsController.checkValidDuration(page.colorDurationList.children[i].contentsItem.durationValue), deleted:page.colorDurationList.children[i].contentsItem.deleted});
    }
    db.transaction( function(tx) {
        rq = tx.executeSql('UPDATE core_config SET value = "'+checker_color+'" WHERE key="checker_color";');
    });
    db.transaction( function(tx) {
        rq = tx.executeSql('UPDATE core_config SET value = "'+fixer_duration+'" WHERE key="fixer_duration";');
    });

    fixer_color_arr.forEach(function(obj) {
        if(obj.deleted===true)
        {
            if(obj.id <= 0)
            {
                // DO NOTHING
            }
            else
            {
                db.transaction( function(tx) {
                    rq = tx.executeSql('DELETE FROM fixer_color WHERE id='+obj.id+';');
                });
            }
        }
        else
        {
            if(parseInt(obj.id) <= 0)
            {
                db.transaction( function(tx) {
                    rq = tx.executeSql('INSERT INTO fixer_color (color, duration) VALUES ("'+obj.color+'", "'+obj.duration+'");');
                });
            }
            else
            {
                db.transaction( function(tx) {
                    rq = tx.executeSql('UPDATE fixer_color SET color = "'+obj.color+'", duration = "'+obj.duration+'" WHERE id='+obj.id+';');
                });
            }
        }
    });
};

SettingsController.load = function(page) {
    var checker_color;
    var fixer_duration;
    var fixer_color_arr = [];

    checker_color=SettingsController.getCheckerColor();

    fixer_duration=SettingsController.getFixerDuration();

    fixer_color_arr=SettingsController.getColorDurationList();

    //get all data, now put in UI

    page.colorCheckerVal=checker_color;
    page.duraFixerVal=fixer_duration;

    SettingsController.loadList(page.colorDurationList,fixer_color_arr);
};

SettingsController.loadList = function(list,data){
    SettingsController.clearList(list);
    var component;
    var componentRDY;

    data.forEach(function(obj) {
    component=Qt.createComponent("../qml/Components/AccordionColorDuration.qml");
        componentRDY=component.createObject(list);
        componentRDY.contentsItem.mapId = obj.id;
        componentRDY.contentsItem.colorValue = obj.color;
        componentRDY.contentsItem.durationValue = obj.duration;
    });
}


SettingsController.clearList = function (list){

    for (var i = list.children.length-1; i >= 0; --i)
    {
        list.children[i].destroy();
    }
}

SettingsController.getCheckerColor = function() {
    var db = SettingsController.getDatabase();
    var rq;
    var dbItem;
    var checker_color;

    db.transaction( function(tx) {
        rq = tx.executeSql('SELECT value FROM core_config where key="checker_color";');
    });

    if(rq.rows.length<=0)
    {
        checker_color=DatabaseDefault.black;
    }
    else
    {
        for(var i = 0; i < rq.rows.length; i++) {
            dbItem = rq.rows.item(i);
            checker_color=SettingsController.checkValidHexColor(dbItem.value);
            break;
        }
    }

    return checker_color;
};

SettingsController.getFixerDuration = function() {
    var db = SettingsController.getDatabase();
    var rq;
    var dbItem;
    var fixer_duration;


    db.transaction( function(tx) {
        rq = tx.executeSql('SELECT value FROM core_config where key="fixer_duration";');
    });

    if(rq.rows.length<=0)
    {
        fixer_duration=DatabaseDefault.default_duration;
    }
    else
    {
        for(var i = 0; i < rq.rows.length; i++) {
            dbItem = rq.rows.item(i);
            fixer_duration=SettingsController.checkValidDuration(dbItem.value);
            break;
        }
    }

   return fixer_duration;
};

SettingsController.getColorDurationList = function(page) {
    var db = SettingsController.getDatabase();
    var rq;
    var dbItem;
    var fixer_color_arr = [];

    db.transaction( function(tx) {
        rq = tx.executeSql('SELECT id,color,duration FROM fixer_color');
    });

    if(rq.rows.length<=0)
    {
        fixer_color_arr.push({id:-1, color:DatabaseDefault.black, duration:DatabaseDefault.default_duration});
    }
    else
    {
        for(var i = 0; i < rq.rows.length; i++)
        {
            dbItem = rq.rows.item(i);
            fixer_color_arr.push({id:dbItem.id, color:SettingsController.checkValidHexColor(dbItem.color), duration:SettingsController.checkValidDuration(dbItem.duration)});
        }
    }
    return fixer_color_arr;
};

SettingsController.checkValidHexColor = function(colorStr) {
    colorStr=colorStr.trim().toUpperCase();
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

SettingsController.checkValidDuration = function(duration) {
    var durationInt;
    duration=duration.replace("ms", "").trim();
    durationInt=parseInt(duration, 10);

    if (!isNaN(durationInt) && duration === parseInt(duration, 10).toString())
    {
        return duration;
    }
    return DatabaseDefault.default_duration;
};
