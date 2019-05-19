BEGIN TRANSACTION;
-- Creazione Tabelle
CREATE TABLE "TB_NET_DEVICE_TYPE" ( `TYPE_CODE` TEXT NOT NULL UNIQUE, `TYPE_DESCRIPTION` TEXT DEFAULT '-', PRIMARY KEY(`TYPE_CODE`) );
CREATE TABLE "TB_NET_DEVICE" ( `NET_CODE` TEXT NOT NULL, `NET_DESC` TEXT, `NET_TYPE` TEXT NOT NULL, `NET_STATUS` TEXT DEFAULT '', `NET_LASTUPDATE` TEXT DEFAULT (datetime('now','localtime')), `NET_IP` TEXT DEFAULT '', `NET_MAC` TEXT NOT NULL DEFAULT '' UNIQUE, `NET_USER` TEXT, `NET_PSW` TEXT, `NET_MAC_INFO` TEXT DEFAULT '', PRIMARY KEY(`NET_MAC`) );
CREATE TABLE "TB_NET_DIZ_CMD" ( `CMD_STR` TEXT NOT NULL, `CMD_NET_TYPE` TEXT NOT NULL, `CMD_RESULT` TEXT );
CREATE TABLE "TB_NET_HISTORY" ( `REQ_ID` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, `REQ_NODE` TEXT NOT NULL, `REQ_CMD` TEXT NOT NULL, `REQ_RESPONSE` TEXT, `REQ_RESULT` TEXT NOT NULL, `REQ_DATETIME` TEXT DEFAULT (datetime('now','localtime')) );
CREATE TABLE "TB_RES_DECODE" ( `RES_DEVICE_TYPE` TEXT NOT NULL, `RES_DEVICE_SUBTYPE` TEXT NOT NULL, `RES_COMMAND` TEXT NOT NULL, `RES_LANG` TEXT NOT NULL, `RES_VALUE` TEXT NOT NULL, `RES_RESULT` TEXT NOT NULL, `RES_STATE` TEXT NOT NULL, PRIMARY KEY(`RES_DEVICE_TYPE`,`RES_DEVICE_SUBTYPE`,`RES_COMMAND`,`RES_LANG`,`RES_VALUE`) );
CREATE TABLE "TB_SYS_SETTINGS" ( `SYS_SET` TEXT NOT NULL UNIQUE, `SYS_VALUE` TEXT NOT NULL );
-- POPOLO TB_DEVICE_TYPE
-- INSERT INTO TB_NET_DEVICE (NET_CODE, NET_DESC, NET_TYPE, NET_STATUS, NET_LASTUPDATE, NET_IP, NET_MAC, NET_USER, NET_PSW, NET_MAC_INFO) VALUES ("Test", "Test descrizione", "NET", "ON", "last", "192.168.1.5", "44:55:88:99:88:77", "", "", "MAC info");
INSERT INTO TB_NET_DEVICE_TYPE (TYPE_CODE,TYPE_DESCRIPTION) VALUES ("NET","Generic Device");
INSERT INTO TB_NET_DEVICE_TYPE (TYPE_CODE,TYPE_DESCRIPTION) VALUES ("PCWIN","PC Windows");
INSERT INTO TB_NET_DEVICE_TYPE (TYPE_CODE,TYPE_DESCRIPTION) VALUES ("AP","Access Point UNIX based SSH Compatible");
INSERT INTO TB_NET_DEVICE_TYPE (TYPE_CODE,TYPE_DESCRIPTION) VALUES ("PS4","Sony Playstation 4");
INSERT INTO TB_NET_DEVICE_TYPE (TYPE_CODE,TYPE_DESCRIPTION) VALUES ("XBULB","Xiaomi Yeelight Bulb");
INSERT INTO TB_NET_DEVICE_TYPE (TYPE_CODE,TYPE_DESCRIPTION) VALUES ("ESP_RELE","ESP8266 con software per rele");
-- POPOLO TB_NET_DIZ_CMD
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("stato","NET","100");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("stato","PCWIN","100");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("stato","AP","100");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("stato","ESP_RELE","100");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("on","PCWIN","102");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("on","AP","102");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("on","ESP_RELE","130");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("off","ESP_RELE","130");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("toggle","ESP_RELE","130");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("stato_rele","ESP_RELE","130");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("off","PCWIN","201");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("radio_up","AP","302");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("radio_down","AP","301");
INSERT INTO TB_NET_DIZ_CMD (CMD_STR,CMD_NET_TYPE, CMD_RESULT) VALUES ("radio","AP","300");
-- POPOLO TB_NET_DIZ_CMD
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","AP","100","IT","-1","Ping Function Error!","ERR");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","AP","100","IT","0","Ping OK!","ON");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","AP","100","IT","1","Ping FAIL!","OFF");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","AP","302","IT","-1","Radio Function Error!","");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","AP","301","IT","-1","Radio Function Error!","");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","AP","302","IT","0","Comando Radio OK!","ON Wifi OFF");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","AP","301","IT","0","Comando Radio OK!","ON Wifi OFF");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","AP","302","IT","-2","No Interfaccia WiFi","ON Wifi ERR");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","AP","301","IT","-2","No Interfaccia WiFi","ON Wifi ERR");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","AP","302","IT","2","Credenziali Invalide","ON Wifi ERR");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","AP","301","IT","2","Credenziali Invalide","ON Wifi ERR");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","AP","300","IT","0","Radio OFF","ON Wifi OFF");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","AP","300","IT","1","Radio ON","ON Wifi ON");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","AP","302","IT","1","Comando Radio OK!","ON Wifi ON");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","AP","301","IT","1","Comando Radio OK!","ON Wifi ON");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","PCWIN","201","IT","0","Comando Shutdown OK!","Spegnimento");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","PCWIN","201","IT","-1","Shutdown Function Error!","ERR");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","PCWIN","201","IT","1","Comando Shutdown FAIL!","ERR");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","PCWIN","102","IT","0","Comando Wake-On-Lan OK!","Accensione");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","PCWIN","102","IT","1","Comando Wake-On-Lan FAIL!","ERR");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","PCWIN","102","IT","-1","Comando Wake-On-Lan Error!","ERR");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","NET","100","IT","0","Ping OK!","ON");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","PCWIN","100","IT","-1","Ping Function Error!","ERR");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","PCWIN","100","IT","1","Ping FAIL!","OFF");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","ESP_RELE","100","IT","0","Ping OK!","ON");
INSERT INTO TB_RES_DECODE (RES_DEVICE_TYPE,RES_DEVICE_SUBTYPE,RES_COMMAND,RES_LANG,RES_VALUE,RES_RESULT,RES_STATE) VALUES ("NET","ESP_RELE","100","IT","1","Ping FAIL!","OFF");
-- POPOLO TB_SYS_SETTINGS
INSERT INTO TB_SYS_SETTINGS (SYS_SET, SYS_VALUE) VALUES ("SYS_f_update","1");
INSERT INTO TB_SYS_SETTINGS (SYS_SET, SYS_VALUE) VALUES ("SYS_t_update","2000");
INSERT INTO TB_SYS_SETTINGS (SYS_SET, SYS_VALUE) VALUES ("NET_f_update","1");
INSERT INTO TB_SYS_SETTINGS (SYS_SET, SYS_VALUE) VALUES ("NET_t_update","3500");
COMMIT;









