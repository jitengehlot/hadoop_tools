db.transactions_HX.find()

db.transactions_HX.distinct('PG')

db.transactions_HX.distinct('SD')

var start_proc = new Date();

var start = ISODate("2014-01-01T05:00:00.000Z");
var end = ISODate("2014-03-30T05:00:00.000Z");

db.transactions_HX.aggregate( [ { $match: { TT: 1, SD: { $gte:start, $lte:end } } }, { $group: { _id: "$PM", count: { $sum: 1 } } }] ).explain()

// ++++++++++++++++++++++++++++++       Query for H6, SD, PM, PX         ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
var start_proc = new Date();
var start = ISODate("2014-01-01T05:00:00.000Z");
var end = ISODate("2014-05-31T05:00:00.000Z");

db.transactions_HX.find(
{ 
	$and: 
		[ 
			{ "H6" : "09C9D1B4BC4E074F9E3715837104F7AC8F30C9D24D0F04FFCDBF917945FDDD89" },
			{ "SD" : { $gte:start, $lte:end } },
            { "PM" : "SPEEDWAY" },
			{ "HX": 
					{ $elemMatch: 
						{ "H7" : "869AB28EB8F69AE33AEE89DF7F3A27ED822AD592290F2E1FAF2E2274AE8D69B3" ,
                          "H8" : "089597D66B6561D62C04E5B2F356EDBF662C8DA18A610C4A9E297A8660CBA1C3"
                        } 
					} 
			}
		] 
} 
)
print((new Date() - start_proc));
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

print((new Date() - start_proc));
   
db.transactions_HX.aggregate( [
   { $group: { _id: "$PG", count: { $sum: 1 } } }
] )


db.transactions_HX.aggregate( [ { $match: { TT: 1, SD: { $gte:start, $lte:end } } }, { $group: { _id: "$PM", count: { $sum: 1 } } }] )

print((new Date() - start_proc));
{ "_id" : "PAY AND SAVE", "count" : 1893 }
{ "_id" : "D-WOODRUFF ST", "count" : 680 }
{ "_id" : "VARGAS", "count" : 570 }
{ "_id" : "D-OPEN SKY ST", "count" : 453 }
{ "_id" : "D-DESERT CASH ST", "count" : 300 }
{ "_id" : "AFIN GEN IC", "count" : 2432 }
{ "_id" : "D-PREM CARD ST", "count" : 2762 }
{ "_id" : "D-ISAO REC MS", "count" : 58768 }
{ "_id" : "D-SOLUTION SVC MS", "count" : 12981 }
{ "_id" : "D-ATM CASH PLUS MS", "count" : 5421 }
{ "_id" : "D-MGATM SERVICES MS", "count" : 16492 }
{ "_id" : "AFIN MISC MS", "count" : 1692 }
{ "_id" : "PIZZA PROP IC", "count" : 13977 }
{ "_id" : "D-THE ATM CO MS", "count" : 16844 }
{ "_id" : "D-MISC AFIN IC", "count" : 24710 }
{ "_id" : "REAYS RANCH IC", "count" : 17584 }
{ "_id" : "D-BOKEL ENT IC", "count" : 15345 }
{ "_id" : "D-COFFMAN ENTERPR ST", "count" : 1325 }
{ "_id" : "ROUSE PROP ST", "count" : 38684 }
{ "_id" : "AFIN MISC ST", "count" : 137972 }
Type "it" for more
>
> print((new Date() - start_proc));
861221


/root/.ssh/id_rsa