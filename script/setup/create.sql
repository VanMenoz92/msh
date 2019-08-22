BEGIN TRANSACTION;
-- CREAZIONE TABELLE
CREATE TABLE "TB_NET_DEVICE_TYPE" ( `TYPE_CODE` TEXT NOT NULL UNIQUE, `TYPE_DESCRIPTION` TEXT DEFAULT '-', `GOOGLE_TYPE` TEXT DEFAULT '' NOT NULL, `GOOGLE_TRAITS` TEXT DEFAULT '' NOT NULL,  PRIMARY KEY(`TYPE_CODE`) );
CREATE TABLE "TB_NET_DEVICE" ( `NET_CODE` TEXT NOT NULL, `NET_DESC` TEXT, `NET_TYPE` TEXT NOT NULL, `NET_ONLINE` TEXT DEFAULT '', `NET_STATUS` TEXT DEFAULT '', `NET_LASTUPDATE` TEXT DEFAULT (datetime('now','localtime')), `NET_IP` TEXT DEFAULT '', `NET_MAC` TEXT NOT NULL DEFAULT '' UNIQUE, `NET_USER` TEXT, `NET_PSW` TEXT, `NET_MAC_INFO` TEXT DEFAULT '', PRIMARY KEY(`NET_MAC`) );
CREATE TABLE "TB_NET_DIZ_CMD" ( `CMD_STR` TEXT NOT NULL, `CMD_NET_TYPE` TEXT NOT NULL, `CMD_RESULT` TEXT );
CREATE TABLE "TB_RES_DECODE" ( `RES_DEVICE_TYPE` TEXT NOT NULL, `RES_COMMAND` TEXT NOT NULL, `RES_LANG` TEXT NOT NULL, `RES_VALUE` TEXT NOT NULL, `RES_RESULT` TEXT NOT NULL, `RES_STATE` TEXT NOT NULL, PRIMARY KEY(`RES_DEVICE_TYPE`,`RES_COMMAND`,`RES_LANG`,`RES_VALUE`) );
CREATE TABLE "TB_USER" ( `USERNAME` TEXT NOT NULL, `PASSWORD` TEXT, `ROLE` TEXT, PRIMARY KEY(`USERNAME`));
-- POPOLO TB_NET_DEVICE_TYPE
INSERT INTO TB_NET_DEVICE_TYPE (TYPE_CODE,TYPE_DESCRIPTION) VALUES ("NET","Generic Device", "action.devices.types.SWITCH", "action.devices.traits.OnOff,");
INSERT INTO TB_NET_DEVICE_TYPE (TYPE_CODE,TYPE_DESCRIPTION) VALUES ("PCWIN","PC Windows", "action.devices.types.SWITCH", "action.devices.traits.OnOff,");
INSERT INTO TB_NET_DEVICE_TYPE (TYPE_CODE,TYPE_DESCRIPTION) VALUES ("AP","Access Point UNIX based SSH Compatible", "action.devices.types.SWITCH", "action.devices.traits.OnOff,");
INSERT INTO TB_NET_DEVICE_TYPE (TYPE_CODE,TYPE_DESCRIPTION) VALUES ("PS4","Sony Playstation 4", "action.devices.types.SWITCH", "action.devices.traits.OnOff,");
INSERT INTO TB_NET_DEVICE_TYPE (TYPE_CODE,TYPE_DESCRIPTION) VALUES ("XBULB","Xiaomi Yeelight Bulb", "action.devices.types.SWITCH", "action.devices.traits.OnOff,");
INSERT INTO TB_NET_DEVICE_TYPE (TYPE_CODE,TYPE_DESCRIPTION) VALUES ("ESP_RELE","ESP8266 con software per rele", "action.devices.types.SWITCH", "action.devices.traits.OnOff,");
-- POPOLO TB_NET_DIZ_CMD
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("stato","NET","100");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("stato","PCWIN","100");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("on","PCWIN","102");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("off","PCWIN","201");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("stato","AP","100");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("on","AP","102");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("radio_stato","AP","300");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("radio_up","AP","300");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("radio_down","AP","300");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("stato","ESP_RELE","100");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("on","ESP_RELE","130");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("off","ESP_RELE","130");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("toggle","ESP_RELE","130");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("stato_rele","ESP_RELE","130");
-- POPOLO TB_RES_DECODE
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","100","IT","-1","Errore nel comando Ping!","ERR");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","100","IT","0","Ping OK!","ON");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","100","IT","1","Ping KO!","OFF");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","102","IT","0","Comando Wake-On-Lan OK!","Accensione");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","102","IT","1","Comando Wake-On-Lan KO!","ERR");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","102","IT","-1","Comando Wake-On-Lan Errore!","ERR");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","201","IT","-1","Errore nel comando Shutdown!","ERR");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","201","IT","0","Comando Shutdown OK!","Spegnimento");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","201","IT","1","Comando Shutdown KO!","ERR");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","300","IT","-2","No Interfaccia WiFi","ON Wifi ERR");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","300","IT","-1","Errore nel comando Radio!","ERR");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","300","IT","0","Comando Radio OK!","ON Wifi OFF");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","300","IT","1","Comando Radio OK!","ON Wifi ON");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","300","IT","2","Credenziali Invalide","ON Wifi ERR");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","130","IT","0","Comando Esp Rele OK","ON");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","130","IT","1","Comando Esp Rele OK","OFF");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","130","IT","-1","Comando Esp Rele ERR","ERR");
COMMIT;

--CREATE TABLE "TB_NET_DEVICE_TYPE" ( `TYPE_CODE` TEXT NOT NULL UNIQUE, `TYPE_DESCRIPTION` TEXT DEFAULT '-', `SYNC_RESPONSE` TEXT DEFAULT '' NOT NULL, `QUERY_RESPONSE` TEXT DEFAULT '' NOT NULL, `EXECUTE_REQUEST` TEXT DEFAULT '' NOT NULL, `EXECUTE_RESPONSE_OK` TEXT DEFAULT '' NOT NULL, `EXECUTE_RESPONSE_KO` TEXT DEFAULT '' NOT NULL, PRIMARY KEY(`TYPE_CODE`) );
--INSERT INTO TB_NET_DEVICE_TYPE (TYPE_CODE,TYPE_DESCRIPTION,SYNC_RESPONSE,QUERY_RESPONSE,EXECUTE_REQUEST,EXECUTE_RESPONSE_OK,EXECUTE_RESPONSE_KO) VALUES ("NET","Generic Device","{""id"": ""dev['net_mac']"",""type"": ""action.devices.types.SWITCH"",""traits"": [""action.devices.traits.OnOff""],""name"": {""defaultNames"": [""Smart Switch""],""name"": ""dev['net_code']"",""nicknames"": []},""willReportState"": true,""deviceInfo"": {""manufacturer"": ""MSH"",""model"": ""1"",""hwVersion"": ""1.0"",""swVersion"": ""1.0""},""customData"": {""mshType"": ""dev['net_type']""}}", "{""requestId"": ""data['requestId']"",""payload"": {""devices"": {""data['inputs'][0]['payload']['devices'][0]['id']"": {""on"": ""prova(dev['net_code'], 'stato', dev['net_mac'])"",""online"": ""prova(dev['net_code'], 'online', dev['net_mac'])""}}}}", "{""command"": ""action.devices.commands.OnOff"",""params"": {""on"": ""boolean""}}", "{""requestId"": ""data['requestId']"",""payload"": {""commands"": [{""ids"": [""data['inputs'][0]['payload']['commands'][0]['devices'][0]['id']""],""status"": ""SUCCESS"",""states"": {""on"": ""prova(dev['net_code'], 'stato', dev['net_mac'])"",""online"": ""prova(dev['net_code'], 'online', dev['net_mac'])""}}]}}", "{""requestId"": ""data['requestId']"",""payload"": {""commands"": [{""ids"": [""data['inputs'][0]['payload']['commands'][0]['devices'][0]['id']""],""status"": ""ERROR"",""errorCode"": ""result['output']""}]}}");
--CREATE TABLE "TB_NET_DEVICE" ( `NET_CODE` TEXT NOT NULL, `NET_DESC` TEXT, `NET_TYPE` TEXT NOT NULL, `NET_LASTUPDATE` TEXT DEFAULT (datetime('now','localtime')), `NET_IP` TEXT DEFAULT '', `NET_MAC` TEXT NOT NULL DEFAULT '' UNIQUE, `NET_USER` TEXT, `NET_PSW` TEXT, `NET_MAC_INFO` TEXT DEFAULT '', PRIMARY KEY(`NET_MAC`) );
--CREATE TABLE "TB_STRING" ( `LANGUAGE` TEXT NOT NULL, `VALUE` TEXT NOT NULL, `RESULT` TEXT NOT NULL, PRIMARY KEY(`LANGUAGE`,`VALUE`) );
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","0","Ping OK!");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","1","Ping KO!");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","2","Errore nel comando Ping!");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","3","Comando Wake-On-Lan OK!");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","4","Comando Wake-On-Lan KO!");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","5","Errore nel comando Wake-On-Lan!");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","6","Comando Shutdown OK!");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","7","Comando Shutdown KO!");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","8","Errore nel comando Shutdown!");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","9","Comando Radio OK!");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","10","WiFi acceso!");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","11","WiFi spento!");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","12","Nessuna interfaccia WiFi rilevata");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","13","Credenzilai non valide");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","14","Errore nel comando Radio!");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","15","Comando Esp Rele OK");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","16","Errore Comando Esp Rele!");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","17","Compilazione OK!");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","18","Errore nella compilazione!");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","19","Upload OK!");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","20","Errore in upload!");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","21","Questa API ha bisogno di un payload");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","22","Il payload deve essere in formato JSON");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","23","Il campo %s è obbligatorio");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","24","Il campo %s deve assumere uno dei seguenti valori: ");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","25","Devi effettuare la login per utilizzare questa API");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","26","La funzione richiesta può essere eseguita solo da un ADMIN");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","27","Per l'operazione scelta è obbligatorio il campo ");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","28","Esiste già un utente con questo nome");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","29","Deve essere sempre presente almeno un utente ADMIN");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","30","Solo gli ADMIN possono modificare i ruoli");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","31","Il campo password deve avere una lunghezza di almeno 4 caratteri");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","32","Solo l'utente propietario può modificare la sua password");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","33","Nessun campo da aggiornare, i possibili campi da aggiornare sono: ");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","34","Il campo codice non può essere valorizzato con una stringa vuota");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","35","Esiste già un dispositivo con questo codice");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","36","Username non trovato");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","37","Password errata");
--INSERT INTO TB_STRING (LANGUAGE,VALUE,RESULT) VALUES ("IT","38","Nessun dispositivo collegato");
--
