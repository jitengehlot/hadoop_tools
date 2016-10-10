var start = new Date();
var count=0;
function parse(myDoc) {
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
                db.transactions_Bin_1day_agg.update({_id:myDoc._id},myDoc);
				
				count = count + 1;
}
var cursor = db.transactions_Bin_1day_agg.find();
while (cursor.hasNext()) {
  var mydoc = cursor.next();
  parse(mydoc);
}
print(count);
print((new Date() - start));