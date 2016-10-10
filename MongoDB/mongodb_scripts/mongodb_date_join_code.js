{ i_timestamp: {
        $gte: { "$date" : "2012-03-09T00:00:00.000Z"},
        $lte: { "$date" : "2012-03-09T24:00:00.000Z"}
    }
}

db.incidents_old.find({ 
    i_timestamp: 
    {
        $gte: ISODate("2012-04-09T00:00:00.000Z"),
        $lte: ISODate("2012-04-09T24:00:00.000Z") 
    }
})

{ "$date" : "2012-03-09T04:10:31.690Z"}
