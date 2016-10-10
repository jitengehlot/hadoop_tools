mapterminals = function() {
    var values = {
		Program: this.Program
    };
    emit(this.ATMInternalID, values);
};

mapATMTxnDetails = function() {
    var values = {
		InternalID: this.InternalID, 
		TxnTypeID: this.TxnTypeID
    };
    emit(this.ATMInternalID, values);
};

reduce = function(k, values) {
    var result = {}, TrasanctionFields = {
        "InternalID": 0, 
        "TxnTypeID": 0
    };
    values.forEach(function(value) {
        var field;
        if ("InternalID" in value) 
		{
            if (!("InternalIDs" in result)) 
			{
                result.InternalIDs = [];
            }
            result.InternalIDs.push(value);
        } 
		else if ("InternalIDs" in value) 
		{
            if (!("InternalIDs" in result)) 
			{
                result.InternalIDs = [];
            }
            result.InternalIDs.push.apply(result.InternalIDs, value.InternalIDs);
        }
        for (field in value) {
            if (value.hasOwnProperty(field) && !(field in TrasanctionFields)) {
                result[field] = value[field];
            }
        }
    });
    return result;
};

var start = ISODate("2013-01-01 00:00:00.000");
var end = ISODate("2013-01-01 24:00:00.000");


//db.ATMTxnDetails.mapReduce(mapATMTxnDetails, reduce, {"out": {"reduce": "terminal_trans"}});
db.ATMTxnDetails.mapReduce( mapATMTxnDetails, 
						reduce,
                       {query: { SettlementDate : { $gte:start, $lte:end },
								 TxnTypeID: 1
                                },
                        out: { reduce: "terminal_trans" }
                       }
                     );
db.LocationDetails.mapReduce(mapterminals, reduce, {"out": {"reduce": "terminal_trans"}});
db.terminal_trans.find().pretty(); // see the resulting collection