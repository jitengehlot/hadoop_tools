var mapFunction = function() {
    var key = this.HP6;
    var value = {
        HP6: this.HP6,
        TxnTypeID: this.TxnTypeID,		
		Surcharge: this.Surcharge,
        InternalID: this.InternalID
    };
    if( (value.Surcharge != null) ) {
        if( (value.Surcharge.length > 0 ) && ( value.TxnTypeID == 1) && (value.Surcharge == "0") ) {
            emit( key, value );
        }
	}
};
var reduceFunction = function() {};
var start = new Date(2014, 0, 1);
var end = new Date(2014, 0, 1);
db.transactions.mapReduce( mapFunction, 
                    reduceFunction,
                       {query: { ActivityDate : { $gte:start, $lte:end } },
                        out: { replace: "trans_free_surcharge" }
                       }
                     );