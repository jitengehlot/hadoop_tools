mapIncidents = function() {
    var values = {
		device_key: this.device_key, 
		incident_key: this.incident_key,
		opened_dtimestamp: this.opened_dtimestamp,
		closed_dtimestamp: this.closed_dtimestamp	
    };
    emit(this.fault_key, values);
};

mapFaults= function() {
    var values = {
		fault_id: this.fault_id,
		fault_text: this.fault_text
    };
    emit(this.fault_key, values);
};

reduce = function(k, values) {
    var result = {}, FaultFields = {
        "fault_id": 0, 
        "fault_text": 0,
    };
    values.forEach(function(value) {
	       /* var field;
	        if ("fault_text" in value) 
			{
	            if (!("InternalIDs" in result)) 
				{
	                result.InternalIDs = [];
	            }
	            result.InternalIDs.push(value);
	        } 
			else if ("InternalIDs" in value) 
			{
	            if (!("InternalIDs" in result)) 
				{
	                result.InternalIDs = [];
	            }
	            result.InternalIDs.push.apply(result.InternalIDs, value.InternalIDs);
	        }
	        for (field in value) {
	            if (value.hasOwnProperty(field) && !(field in FaultFields)) {
	                result[field] = value[field];
	            }
	        }*/
    });
    return result;
};


db.faults.mapReduce( mapFaults, reduce, { out: { reduce: "incident_faults_mr" } });

db.incidents.mapReduce( mapIncidents, reduce, out: {reduce: "incident_faults_mr"} );

db.incident_faults_mr.find().pretty(); // see the resulting collection