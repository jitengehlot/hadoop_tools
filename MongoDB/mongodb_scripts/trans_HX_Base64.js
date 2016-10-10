var start_proc = new Date();
var start = ISODate("2014-01-01T05:00:00.000Z");
var end = ISODate("2014-05-31T05:00:00.000Z");

db.HXBin2.find(
{ 
	$and: 
		[ 
			
			{ SD1:{ $gte:start, $lte:end } },
			
			{ H8:BinData(0,hexToBase64("DE82DDB5387E268F3C0A021B96790846C1EB6816663997DBE7E77F3CB7C14E19")) }
		] 
} 
).explain()
print((new Date() - start_proc));


db.HXBin2.find(	{ H6:BinData(0,hexToBase64("1686DAD16326B452E3259445C1A7944E9DFDDA42226B47CA023F0BD34AE0ABD7")) } )