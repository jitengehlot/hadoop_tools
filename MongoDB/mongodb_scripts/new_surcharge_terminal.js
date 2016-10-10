var mapFunction = function() {
    var key = {
        HPCATM: this.HPCATM,
        Terminal:this.Terminal
    };
    if( (this.Surcharge != null) ) {
        if( (this.Surcharge.length > 0 ) && ( this.TxnTypeID == 1) && (this.Surcharge != "0") ) {
            emit(key, {count:1});
        }
	}
};
var reduceFunction = function(key,values) {
	var sum = 0;
	values.forEach(function(value) {
		sum += value.count;
	});
	return ({count:sum});
};
var start = new Date(2014, 0, 1);
var end = new Date(2014, 0, 10);
db.transactions.mapReduce( mapFunction, 
                    reduceFunction,
                       {query: { SettlementDate : { $gte:start, $lte:end } },
                        out: { replace: "transactions_terminal" }
                       }
                     );
					 
					 
//Count of Unique HPCATM
db.transactions_terminal.distinct("_id.HPCATM").length;

//No of withdrawals
db.transactions_terminal.aggregate(
[    {     $group: { 
        _id:null, 
        total: { 
                    $sum: "$value.count"
                    } 
                            } 
     } 
] );

//Count of No. of Txns where - HPCATM, Count(*) > 1
db.transactions_terminal.aggregate(
[
  { $group: {
    _id: "$_id.HPCATM",
    NoOfWithdrawal: { $sum: "$value.count" }
  } },
  { $match : {
    NoOfWithdrawal: { $gt: 1 }
  } },
  { $group: {
    _id: "TotalTxn",
    Count: { $sum: 1 }
  } }
]);




// new queries
var HPCATM = db.transactions_terminal.aggregate(
[
  { $group: {
    _id: "$_id.HPCATM",
    NoOfWithdrawal: { $sum: "$value.count" }
  } },
  { $match : {
    NoOfWithdrawal: { $gt: 1 }
  } },
  { $project : {
    _id: 1
  } }
]);
  
db.transactions_terminal.find();
db.transactions_terminal.count();
  
db.transactions_terminal.find({},{"value.count":0});

db.transactions_terminal.distinct( "_id.Terminal" , { "_id.HPCATM" : HPCATM } } );

db.transactions_terminal.find( { "_id.Terminal" },
                 { "_id.HPCATM": { $elemMatch: "29F8FA7BA2538680719E811776594E306CA5C8DCD9C0DACA2FFD408F45A03AC6" } } );
  
printjson(HPCATM);