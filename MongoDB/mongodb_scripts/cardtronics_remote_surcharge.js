var mapFunction = function() {
    var key = this.HPCATM;
    var value = {
        HPCATM: this.HPCATM,
        TxnTypeID: this.TxnTypeID,		
		Surcharge: this.Surcharge,
        InternalID: this.InternalID
    };
    if( (value.Surcharge != null) ) {
        if( (value.Surcharge.length > 0 ) && ( value.TxnTypeID == 1) && (value.Surcharge != "0") ) {
            emit( key, value );
        }
	}
};
var reduceFunction = function() {};
var start = new Date(2014, 0, 1);
var end = new Date(2014, 0, 10);
db.transactions.mapReduce( mapFunction, 
                    reduceFunction,
                       {query: { SettlementDate : { $gte:start, $lte:end } },
                        out: { replace: "trans_surcharge" }
                       }
                     );