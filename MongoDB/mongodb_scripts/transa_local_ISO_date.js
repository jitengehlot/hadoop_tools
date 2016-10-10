var start = new Date();var bulk = db.transactions.initializeUnorderedBulkOp();bulk.find( { "SD" : ISODate("2013-12-31T18:30:00.000Z") } ).update( { $set: { SD: ISODate("2014-01-01T05:00:00.000Z") } } );bulk.execute();print((new Date() - start));

var start = new Date();var bulk = db.transactions.initializeUnorderedBulkOp();bulk.find( { "SD" : ISODate("2014-01-01T18:30:00.000Z") } ).update( { $set: { SD: ISODate("2014-01-02T05:00:00.000Z") } } );bulk.execute();print((new Date() - start));

var start = new Date();var bulk = db.transactions.initializeUnorderedBulkOp();bulk.find( { "SD" : ISODate("2014-01-02T18:30:00.000Z") } ).update( { $set: { SD: ISODate("2014-01-03T05:00:00.000Z") } } );bulk.execute();print((new Date() - start));