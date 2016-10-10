    function(myDoc) 
    {
                   var flag=false;
                   var SD1;             
       for (var key in myDoc)
        {
           //print("key: " + key);
           //print("value: " + myDoc[key]);
                                   
           if (myDoc.hasOwnProperty(key) && key=='SD')
           {
                                                   SD1 = myDoc[key];
           }
           else if (myDoc.hasOwnProperty(key) && key=='H6')
           {
                                                   myDoc.H6 = new BinData(0,hexToBase64(myDoc[key]));
           }
                                   else if (myDoc.hasOwnProperty(key) && key=='H7')
           {
                                                   myDoc.H7 = new BinData(0,hexToBase64(myDoc[key]));
                                                   flag=true;
           }
                                   else if (myDoc.hasOwnProperty(key) && key=='H8')
           {
                                                   myDoc.H8 = new BinData(0,hexToBase64(myDoc[key]));
                                                   flag=true;
           }
                                   else if (myDoc.hasOwnProperty(key) && key=='H9')
           {
                                                   myDoc.H9 = new BinData(0,hexToBase64(myDoc[key]));
                                                   flag=true;
           }
                                   else if (myDoc.hasOwnProperty(key) && key=='HA')
           {
                                                   myDoc.HA = new BinData(0,hexToBase64(myDoc[key]));
                                                   flag=true;
           }
                                   else if (myDoc.hasOwnProperty(key) && key=='HB')
           {
                                                   myDoc.HB = new BinData(0,hexToBase64(myDoc[key]));
                                                   flag=true;
           }
                                   else if (myDoc.hasOwnProperty(key) && key=='HC')
           {
                                                   myDoc.HC = new BinData(0,hexToBase64(myDoc[key]));
                                                   flag=true;
           }
                                   else if (myDoc.hasOwnProperty(key) && key=='HM')
           {
                                                   myDoc.HM = new BinData(0,hexToBase64(myDoc[key]));
                                                   flag=true;
           }    
        }
                                if(flag)
                                                myDoc.SD1 = SD1;
                                db.transactions_Bin.insert(myDoc);
    } 
