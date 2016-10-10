var mapFunction = function() {
    var key = {
        HPCATM: this.HPCATM,
		
    };
    if( (this.Surcharge != null) ) {
        if( (this.Surcharge.length > 0 ) && ( this.TxnTypeID == 1) && (this.Surcharge == "0") ) {
            emit(key,{Terminal:this.Terminal,count:1});
        }
	}
};
var reduceFunction = function(key,values) {
	var sum = 0;
        var TerminalID;
	values.forEach(function(value) {
                TerminalID = value.Terminal;
		sum += value.count;
	});
	return {Terminal:TerminalID,count:sum};
};
var start = new Date(2014, 0, 1);
var end = new Date(2014, 0, 10);
db.transactions.mapReduce( mapFunction, 
                    reduceFunction,
                       {query: { SettlementDate : { $gte:start, $lte:end } },
                        out: { replace: "db.mr.transactions_free_terminal" }
                       }
                     );