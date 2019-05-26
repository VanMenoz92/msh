var device_net_list = [];
var device_net_commands = [];
var device_net_types = [];

function net_cmd(){
	var device = $('#device')[0].value;
	var command = $('#command')[0].value;
	var check_device = $('#chk_device');
	var check_command = $('#chk_command');
	if (device == "")
	    check_device.show();
	else
	    check_device.hide();
    if (command == "")
	    check_command.show();
	else
	    check_command.hide();
	if (device != "" && command != ""){
        var body = {
            "dispositivo": device,
            "comando": command
        };
		$.ajax({
		    url: "/api/net_cmd",
		    type: 'POST',
		    contentType: "application/json",
            data : JSON.stringify(body),
		    success: function(response){
				var json = $.parseJSON(JSON.stringify(response));
				$('#result')[0].value = json["output"];
				$('#cmd_result')[0].value = json["res_decode"]["res_result"];
				net_device('list');
            },
            error: function(xhr){
            }
        });
	} else {

	}
}

function net_scan(){
    $.ajax({
        url: "/api/net_scan",
        type: 'GET',
        success: function(response){
            var json = $.parseJSON(JSON.stringify(response));
            $('#esito')[0].value = json["output"];
            $('#found')[0].value = json["find_device"];
            $('#new')[0].value = json["new_device"];
            $('#update')[0].value = json["updated_device"];
            net_device('list');
        },
        error: function(xhr){
        }
    });
}

function net_device(type_op){
    var code = '';
    var type = '';
    var mac = '';
    var user = '';
    var password = '';
    var id = '';
    if (type_op.search('update') >=0){
        id = type_op.replace('update','');
        type_op = 'update';
        type = $("#type" + id)[0].value;
        code = $("#code" + id)[0].value;
        mac = $("#mac" + id).text();
        user = $("#usr" + id)[0].value;
        password = $("#psw" + id)[0].value;
    }
    if (type_op.search('type') >=0){
        id = type_op.replace('type','');
        type_op = 'type';
    }
    if (type_op == 'command'){
        for(var i = 0; i < device_net_list.length;i++) {
            if (device_net_list[i]['net_code'] == $('#device')[0].value)
                type = device_net_list[i]['net_type'];
        }
    }
    var body = {
        "tipo_operazione": type_op,
        "codice": code,
        "tipo": type,
        "mac": mac,
        "user": user,
        "password": password
    };
    $.ajax({
        url: "/api/net_device",
        type: 'POST',
        contentType: "application/json",
        data : JSON.stringify(body),
        success: function(response){
            var json = $.parseJSON(JSON.stringify(response));
            if (json["output"].search("OK") == 0){
				$('#errore').text("");
				$('#errore')[0].classList.remove("d-block");
                $('#errore')[0].classList.add("d-none")
                if (type_op == 'type'){
                    var types = json["types"]
                    var template = Handlebars.compile($("#drop_type-template")[0].innerHTML);
                    $('#drop_type' + id).html(template(types));
                    device_net_types = []
                    for(var i = 0; i < types.length;i++) {
                        device_net_types.push(types[i]);
                        $('#drop_type' + id + ' li').click(function(){
                          $('#type' + id).text($(this).text());
                          $("#type" + id).val($(this).text());
                          must_save(id);
                       });
                    }
                }
                if (type_op == 'list'){
                    var devices = json["devices"];
                    var template = Handlebars.compile($("#table-device-template")[0].innerHTML);
                    $('#table-device').html(template(devices));
                    device_net_list = [];
                    for(var i = 0; i < devices.length;i++) {
                        device_net_list.push(devices[i]);
                        $('#code' + i).on('input',function(e){must_save(this.id.replace("code", ""))});
                        $('#usr' + i).on('input',function(e){must_save(this.id.replace("usr", ""))});
                        $('#psw' + i).on('input',function(e){must_save(this.id.replace("psw", ""))});
                    }
                }
                if (type_op == 'command'){
                    var commands = json["commands"]
                    var template = Handlebars.compile($("#drop_command-template")[0].innerHTML);
                    $('#drop_command').html(template(commands));
                    device_net_commands = [];
                    for(var i = 0; i < commands.length;i++) {
                        device_net_commands.push(commands[i]);
                        $("#drop_command li").click(function(){
                          $('#command').text($(this).text());
                          $("#command").val($(this).text());
                          $('#chk_command').hide();
                       });
                    }
                }
                if (type_op == 'update'){
                    net_device('list');
                }
            } else {
                $('#errore').text(json["output"]);
                $('#errore')[0].classList.remove("d-none");
                $('#errore')[0].classList.add("d-block");
            }
        },
        error: function(xhr){
        }
    });
}

function device_net_code(){
    var template = Handlebars.compile($("#drop_device-template")[0].innerHTML);
    $('#drop_device').html(template(device_net_list));
    for(var i = 0; i < device_net_list.length;i++) {
        $("#drop_device li").click(function(){
          $('#device').text($(this).text());
          $("#device").val($(this).text());
          $('#chk_device').hide();
       });
    }
}

function must_save(id){
    var type = $("#type" + id)[0].value;
    var code = $("#code" + id)[0].value;
    var mac = $("#mac" + id).text();
    var user = $("#usr" + id)[0].value;
    var password = $("#psw" + id)[0].value;
    for (var i = 0; i < device_net_list.length; i++){
        if (device_net_list[i]['net_mac'] == mac){
            if (type != device_net_list[i]['net_type'] || code != device_net_list[i]['net_code'] || user != device_net_list[i]['net_usr'] || password != device_net_list[i]['net_psw']){
                $("#salva" + i).attr("disabled", false);
                $("#reset" + i).attr("disabled", false);
            } else {
                $("#salva" + i).attr("disabled", true);
                $("#reset" + i).attr("disabled", true);
            }
        }
    }
}

function net_reset(id){
    var mac = $("#mac" + id).text();
    for (var i = 0; i < device_net_list.length; i++){
        if (device_net_list[i]['net_mac'] == mac){
            $("#salva" + i).attr("disabled", true);
            $("#reset" + i).attr("disabled", true);
            $("#type" + id)[0].value = device_net_list[i]['net_type'];
            $("#code" + id)[0].value = device_net_list[i]['net_code'];
            $("#usr" + id)[0].value = device_net_list[i]['net_usr'];
            $("#psw" + id)[0].value = device_net_list[i]['net_psw'];
        }
    }
}

function view_password(i){
    var input_text = $("#psw" + i)[0];
    var icon = $("#psw_icon" + i)[0];
    if (input_text.type == 'text'){
        input_text.type = 'password';
        icon.classList.remove("fa-eye");
        icon.classList.add("fa-eye-slash");
    } else {
        input_text.type = 'text';
        icon.classList.remove("fa-eye-slash");
        icon.classList.add("fa-eye");
    }
}