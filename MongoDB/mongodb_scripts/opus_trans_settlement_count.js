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
db.transactions.mapReduce( mapFunction, 
                        reduceFunction,
                        {
                            out: { replace: "opus_trans_mr_settlement_count", sharded: true }
                        }
                     );
print((new Date() - start_proc));