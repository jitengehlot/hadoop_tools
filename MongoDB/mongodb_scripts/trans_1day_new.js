	var start = new Date();
	function f(n) { return n < 10 ? '0' + n : n; }
	db.transactions.find({"SD" : ISODate("2014-01-01T05:00:00.000Z")}).forEach(
	    function(myDoc)
	    {   
	        for (var key in myDoc)
	        {
	           if (myDoc.hasOwnProperty(key) && key=='SD')
	           {
	                myDoc.SD = myDoc[key].getUTCFullYear() + "-" + 
							f((myDoc[key].getUTCMonth()+1)) + "-" + 
							f(myDoc[key].getUTCDate()) + " " + "00:00:00.0";
	           }
			   else if (myDoc.hasOwnProperty(key) && key=='H6')
	           {
				   myDoc.H6 = myDoc.H6.hex().toUpperCase();
	           }
			   else if (myDoc.hasOwnProperty(key) && key=='H7')
	           {
				   myDoc.H7 = myDoc.H7.hex().toUpperCase();
	           }
			   else if (myDoc.hasOwnProperty(key) && key=='H8')
	           {
				   myDoc.H8 = myDoc.H8.hex().toUpperCase();
	           }
			   else if (myDoc.hasOwnProperty(key) && key=='H9')
	           {
				   myDoc.H9 = myDoc.H9.hex().toUpperCase();
	           }
			   else if (myDoc.hasOwnProperty(key) && key=='HA')
	           {
				   myDoc.HA = myDoc.HA.hex().toUpperCase();
	           }
			   else if (myDoc.hasOwnProperty(key) && key=='HB')
	           {
				   myDoc.HB = myDoc.HB.hex().toUpperCase();
	           }
			   else if (myDoc.hasOwnProperty(key) && key=='HC')
	           {
				   myDoc.HC = myDoc.HC.hex().toUpperCase();
	           }
			   else if (myDoc.hasOwnProperty(key) && key=='HM')
	           {
				   myDoc.HM = myDoc.HM.hex().toUpperCase();
	           }
	        }
	        db.transactions_Bin_1day.insert(myDoc);
	    }
	);print((new Date() - start));
	
	var start = new Date();db.transactions.aggregate([ { $match: { SD:ISODate("2014-01-01T05:00:00.000Z") } }, { $out: "transactions_Bin_1day_agg" } ]);print((new Date() - start));
	
	var start = new Date();var bulk = db.transactions_Bin_1day_agg.initializeUnorderedBulkOp();bulk.find( { "SD" : ISODate("2014-01-01T05:00:00.000Z") } ).update( { $set: { SD: "2014-01-01 00:00:00.0"} } );bulk.execute();print((new Date() - start));
	
	var start = new Date();	var count = 0; db.transactions_Bin_1day_agg.find({},{H6:1,H7:1,H8:1,H9:1,HA:1,HB:1,HC:1,HM:1}).forEach(
            function(myDoc)
            {
                for (var key in myDoc)
                {
                   if (myDoc.hasOwnProperty(key) && key=='H6')
                   {
                                   myDoc.H6 = myDoc.H6.hex().toUpperCase();
                   }
					else if (myDoc.hasOwnProperty(key) && key=='H7')
                   {
                                   myDoc.H7 = myDoc.H7.hex().toUpperCase();
                   }
                    else if (myDoc.hasOwnProperty(key) && key=='H8')
                   {
                                   myDoc.H8 = myDoc.H8.hex().toUpperCase();
                   }
				   else if (myDoc.hasOwnProperty(key) && key=='H9')
                   {
                                   myDoc.H9 = myDoc.H9.hex().toUpperCase();
                   }
				   else if (myDoc.hasOwnProperty(key) && key=='HA')
                   {
                                   myDoc.HA = myDoc.HA.hex().toUpperCase();
                   }
				   else if (myDoc.hasOwnProperty(key) && key=='HB')
                   {
                                   myDoc.HB = myDoc.HB.hex().toUpperCase();
                   }
				   else if (myDoc.hasOwnProperty(key) && key=='HC')
                   {
                                   myDoc.HC = myDoc.HC.hex().toUpperCase();
                   }
				   else if (myDoc.hasOwnProperty(key) && key=='HM')
                   {
                                   myDoc.HM = myDoc.HM.hex().toUpperCase();
                   }

                }
                //db.transactions_Bin_1day_agg.update({_id:myDoc._id},myDoc);
				var a=myDoc._id;
                var H6=myDoc.H6;
                var H7=myDoc.H7;
                var H8=myDoc.H8;
                var H9=myDoc.H9;
                var HA=myDoc.HA;
                var HB=myDoc.HB;
                var HC=myDoc.HC;
                var HM=myDoc.HM;
                db.transactions_Bin_1day_agg.update( {_id: a }, { $set: { H6: H6, H7: H7, H8: H8, H9: H9, HA: HA, HB: HB, HC: HC, HM: HM, } } );

				count = count + 1;
            }
    );print('Count:' + count);print((new Date() - start));