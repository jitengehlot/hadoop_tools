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


db.transactions.find().forEach( 
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
);