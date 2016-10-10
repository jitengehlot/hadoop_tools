var start_proc = new Date();
var mapFunction = function() {
    var key = {
        SettlementDate: this.SettlementDate,
		
    };
    emit(key,{count:1});
};
var reduceFunction = function(key,values) {
	var sum = 0;
	values.forEach(function(value) {
		sum += value.count;
	});
	return {count:sum};
};
var start = ISODate("2013-01-01T00:00:00.000Z");
var end = ISODate("2013-12-31T23:59:59.999Z");
db.transactions.mapReduce( mapFunction, 
                    reduceFunction,
                       {query: { SettlementDate : { $gte:start, $lte:end } },
                        out: { replace: "trans_mr_settlement_count", sharded: true }
                       }
                     );
print((new Date() - start_proc));