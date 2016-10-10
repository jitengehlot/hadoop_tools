db.activity_types.distinct('activity_desc')

db.activity_types.find()

var cursor = db.activity_types.find({"activity_desc" : "Close Incident"});
var doc;
if (cursor.hasNext()) {
    doc = cursor.next();
    db.activities_old.find({activity_type_id:doc.activity_type_id}).count()
}