select /*+ STREAMTABLE(a) */ b.program, count(*) 
from atmtxn a 
JOIN terminaldetails b 
ON (a.atminternalid = b.atminternalid) 
where a.TxnTypeID=1 
and a.Settlementdate >='2013-01-01 00:00:00.0' 
and a.Settlementdate <= '2013-12-31 24:00:00.0' 
and a.hpcatm in
(
               select /*+ STREAMTABLE(c) */ c.hpcatm
               from atmtxn c 
    INNER JOIN terminaldetails d ON (c.atminternalid = d.atminternalid) 
               where d.program = 'TARGET' 
    and c.Settlementdate >='2013-01-01 00:00:00.0' 
    and c.Settlementdate <= '2013-12-31 24:00:00.0'    
    and length(hpcatm) > 20
)
group by b.program


SELECT cust_id,
       SUM(li.qty) as qty
FROM orders o,
     order_lineitem li
WHERE li.order_id = o.id
GROUP BY cust_id

	

db.orders.aggregate( [
   { $unwind: "$items" },
   {
     $group: {
        _id: "$cust_id",
        qty: { $sum: "$items.qty" }
     }
   }
] )

db.article.aggregate(
    { $project : {
        author : 1 ,
        title : 1 ,
        tags : 1
    }},
    { $unwind : "$tags" }
);