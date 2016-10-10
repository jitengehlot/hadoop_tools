var start_proc = new Date();
var mapFunction = function() {
    var key = {
        HPCATM: this.HPCATM,
		
    };
    emit(key,{Terminal:this.Terminal,count:1});
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
var start = ISODate("2013-01-01T00:00:00.000Z");
var end = ISODate("2013-12-31T23:59:59.000Z");
db.transactions.mapReduce( mapFunction, 
                    reduceFunction,
                       {query: { SettlementDate : { $gte:start, $lte:end },
                                 Surcharge: { $gt: 0},
								 TxnTypeID: 1
                                },
                        out: { replace: "opus_trans_mr_surcharge_1_year", sharded: true }
                       }
                     );
print((new Date() - start_proc));