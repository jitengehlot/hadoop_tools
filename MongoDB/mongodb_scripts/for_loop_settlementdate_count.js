var now = new Date(2014,8,30); for (var d = new Date(2014,0,1); d <= now; d.setDate(d.getDate() + 1)){print(d + ': ' +db.transactions.count({SD:d}));}

var now = ISODate("2014-01-01T05:00:00.000Z"); for (var d = ISODate("2014-01-31T05:00:00.000Z"); d >= now; d.setDate(d.getDate() - 1)){print(d + ': ' +db.transactions.count({SD:d}));}

