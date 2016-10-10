db.transactions_Bin.find({InternalID : 2762732775}).forEach(
	    function(myDoc)
	    {   
	        printjson(myDoc);
	        for (var key in myDoc)
	        {
			   printjson(key);				
	           if (myDoc.hasOwnProperty(key) && key=='HP6')
	           {
				   myDoc.HP6 = myDoc.HP6.hex().toUpperCase();
	           }
			   else if (myDoc.hasOwnProperty(key) && key=='HP7')
	           {
				   myDoc.HP7 = myDoc.HP7.hex().toUpperCase();
	           }
			   else if (myDoc.hasOwnProperty(key) && key=='HP8')
	           {
				   myDoc.HP8 = myDoc.HP8.hex().toUpperCase();
	           }
	        }
	        db.transactions_Bin.update(myDoc);
	    }
	);
	
	
	
	
var tableStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
var table = tableStr.split("");
function btoa(bin) {
    for (var i = 0, j = 0, len = bin.length / 3, base64 = []; i < len; ++i) {
      var a = bin.charCodeAt(j++), b = bin.charCodeAt(j++), c = bin.charCodeAt(j++);
      if ((a | b | c) > 255) throw new Error("String contains an invalid character");
      base64[base64.length] = table[a >> 2] + table[((a << 4) & 63) | (b >> 4)] +
                              (isNaN(b) ? "=" : table[((b << 2) & 63) | (c >> 6)]) +
                              (isNaN(b + c) ? "=" : table[c & 63]);
    }
    return base64.join("");
}
function hexToBase64(str) {
    return btoa(String.fromCharCode.apply(null,
    str.replace(/\r|\n/g, "").replace(/([\da-fA-F]{2}) ?/g, "0x$1 ").replace(/ +$/, "").split(" "))
    );
}


db.trans_cr.find().forEach( 
    function(myDoc) 
    {
	   var flag=false;
	   var SD1;	
       for (var key in myDoc)
        {
           //print("key: " + key);
           //print("value: " + myDoc[key]);
		   
		   if (myDoc.hasOwnProperty(key) && key=='HP6')
           {
			   myDoc.HP6 = new BinData(0,hexToBase64(myDoc[key]));
           }
		   else if (myDoc.hasOwnProperty(key) && key=='HP7')
           {
			   myDoc.HP7 = new BinData(0,hexToBase64(myDoc[key]));
			   flag=true;
           }
		   else if (myDoc.hasOwnProperty(key) && key=='HP8')
           {
			   myDoc.HP8 = new BinData(0,hexToBase64(myDoc[key]));
			   flag=true;
           }
		   else if (myDoc.hasOwnProperty(key) && key=='HP9')
           {
			   myDoc.HP9 = new BinData(0,hexToBase64(myDoc[key]));
			   flag=true;
           }
		   else if (myDoc.hasOwnProperty(key) && key=='HP10')
           {
			   myDoc.HP10 = new BinData(0,hexToBase64(myDoc[key]));
			   flag=true;
           }
		   else if (myDoc.hasOwnProperty(key) && key=='HP11')
           {
			   myDoc.HP11 = new BinData(0,hexToBase64(myDoc[key]));
			   flag=true;
           }
		   else if (myDoc.hasOwnProperty(key) && key=='HP12')
           {
			   myDoc.HP12 = new BinData(0,hexToBase64(myDoc[key]));
			   flag=true;
           }
		   else if (myDoc.hasOwnProperty(key) && key=='HPCATM')
           {
			   myDoc.HPCATM = new BinData(0,hexToBase64(myDoc[key]));
			   flag=true;
           }    
        }
		if(flag)
			myDoc.SD1 = SD1;
		db.transactions_Bin.insert(myDoc);
    } 
);