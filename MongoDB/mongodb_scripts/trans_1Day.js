	var hD='0123456789ABCDEF';
    function dec2hex(d) {
        var h = hD.substr(d&15,1);
        while (d>15) {
            d>>=4;
            h=hD.substr(d&15,1)+h;
        }
        return h;
    }

    var keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="
    function base64_decode(input) {
        var output = new Array();
        var chr1, chr2, chr3;
        var enc1, enc2, enc3, enc4;
        var i = 0;

        var orig_input = input;
        input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
        if (orig_input != input)
            alert ("Warning! Characters outside Base64 range in input string ignored.");
        if (input.length % 4) {
            alert ("Error: Input length is not a multiple of 4 bytes.");
            return "";
        }
        
        var j=0;
        while (i < input.length) {

            enc1 = keyStr.indexOf(input.charAt(i++));
            enc2 = keyStr.indexOf(input.charAt(i++));
            enc3 = keyStr.indexOf(input.charAt(i++));
            enc4 = keyStr.indexOf(input.charAt(i++));

            chr1 = (enc1 << 2) | (enc2 >> 4);
            chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
            chr3 = ((enc3 & 3) << 6) | enc4;
            
            output[j++] = chr1;
            if (enc3 != 64)
              output[j++] = chr2;
            if (enc4 != 64)
              output[j++] = chr3;
              
        }
        return output;
    } 
    
    function Base64Tohex(str) {
        var output = base64_decode(str);
        var separator = "";
        var hexText = "";
        for (i=0; i<output.length; i++) {
          hexText = hexText + separator + (output[i]<16?"0":"") + dec2hex(output[i]);
          }
		return hexText;
    }
	
	// code starts here, no need for above javacript functions to execute below code
	var start_proc = new Date();
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
				   myDoc.H6 = Base64Tohex(myDoc.H6);
	           }
			   else if (myDoc.hasOwnProperty(key) && key=='H7')
	           {
				   myDoc.H7 = Base64Tohex(myDoc.H7);
	           }
			   else if (myDoc.hasOwnProperty(key) && key=='H8')
	           {
				   myDoc.H8 = Base64Tohex(myDoc.H8);
	           }
			   else if (myDoc.hasOwnProperty(key) && key=='H9')
	           {
				   myDoc.H9 = Base64Tohex(myDoc.H9);
	           }
			   else if (myDoc.hasOwnProperty(key) && key=='HA')
	           {
				   myDoc.HA = Base64Tohex(myDoc.HA);
	           }
			   else if (myDoc.hasOwnProperty(key) && key=='HB')
	           {
				   myDoc.HB = Base64Tohex(myDoc.HB);
	           }
			   else if (myDoc.hasOwnProperty(key) && key=='HC')
	           {
				   myDoc.HC = Base64Tohex(myDoc.HC);
	           }
			   else if (myDoc.hasOwnProperty(key) && key=='HM')
	           {
				   myDoc.HM = Base64Tohex(myDoc.HM);
	           }
	        }
	        db.transactions_1day.insert(myDoc);
	    }
	);
	print((new Date() - start_proc));