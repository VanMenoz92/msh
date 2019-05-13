function invia(){
    var form = $('#form')[0];
	var device = $('#device')[0].value;
	var command = $('#command')[0].value;
	var ko = 0;
	form.classList.add('was-validated');
	Array.prototype.filter.call(form, function (element) {
      if (element.checkValidity() == false) {
		  ko++;
        }
    })
	if (ko > 0){
		console.log("Non faccio niente, ci sono dei campi invaldi");
	} else {
	    console.log("Tutto ok");
		$.ajax({
		    url: "/api/netcmd",
		    type: 'GET',
		    data: {
				d: device,
				c: command
			},
		    success: function(response){
                console.log("OK");
				var json = $.parseJSON(JSON.stringify(response));
				console.log(response);
				console.log(json["device_status"]);
				$('#result')[0].value = json["device_status"];
            },
            error: function(xhr){
                console.log("KO");
            }
        });
	}
}