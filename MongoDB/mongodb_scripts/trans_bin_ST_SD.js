function f(n) { return n < 10 ? '0' + n : n; }
db.transactions_test.find({"SD" : ISODate("2014-01-01T05:00:00.000Z")}).forEach(
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
                           else if (myDoc.hasOwnProperty(key) && key=='ST')
                   {
                        myDoc.ST = myDoc[key].getUTCFullYear() + "-" +
                                                        f((myDoc[key].getUTCMonth()+1)) + "-" +
                                                        f(myDoc[key].getUTCDate()) + " " + 
                                                        f(myDoc[key].getUTCHours()) + ":" +
                                                        f(myDoc[key].getUTCMinutes()) + ":" +
                                                        f(myDoc[key].getUTCSeconds()) + ".0";
                   }
                           else if (myDoc.hasOwnProperty(key) && key=='AD')
                   {
                        myDoc.AD = myDoc[key].getUTCFullYear() + "-" +
                                                        f((myDoc[key].getUTCMonth()+1)) + "-" +
                                                        f(myDoc[key].getUTCDate()) + " " + 
                                                        f(myDoc[key].getUTCHours()) + ":" +
                                                        f(myDoc[key].getUTCMinutes()) + ":" +
                                                        f(myDoc[key].getUTCSeconds()) + ".0";
                   }
                            else if (myDoc.hasOwnProperty(key) && key=='AT')
                   {
                        myDoc.AT = myDoc[key].getUTCFullYear() + "-" +
                                                        f((myDoc[key].getUTCMonth()+1)) + "-" +
                                                        f(myDoc[key].getUTCDate()) + " " + 
                                                        f(myDoc[key].getUTCHours()) + ":" +
                                                        f(myDoc[key].getUTCMinutes()) + ":" +
                                                        f(myDoc[key].getUTCSeconds()) + ".0";
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
                db.transactions_Bin_1day_test.insert(myDoc);
            }
        );
