from sqlite3 import Error, connect
from logging import info
from module import XmlReader
from datetime import datetime
from json import loads, dumps


class DbManager:
    db = None
    
    def __init__(self):
        DbManager.db = connect(XmlReader.settings['path_db'], check_same_thread=False)
        DbManager.db.isolation_level = None
    
    @staticmethod
    def close_db():
        DbManager.db.close()

    @staticmethod
    def select(query):
        try:
            cur = DbManager.db.cursor()
            info("ESEGUO LA QUERY: %s", query)
            cur.execute(str(query))
            result = cur.fetchall()
        except Error:
            DbManager.db.rollback()
            raise
        return result

    @staticmethod
    def insert_or_update(query):
        try:
            cur = DbManager.db.cursor()
            info("ESEGUO LA QUERY: %s", query)
            cur.execute(str(query))
            DbManager.db.commit()
        except Error:
            DbManager.db.rollback()
            raise

    @staticmethod
    def multiple_statement(query):
        try:
            cur = DbManager.db.cursor()
            cur.executescript(str(query))
            DbManager.db.commit()
        except Error:
            DbManager.db.rollback()
            raise

    @staticmethod
    def select_tb_net_device_type(net_type=None):
        query = 'SELECT * ' \
                'FROM TB_NET_DEVICE_TYPE '
        if net_type is not None:
            query = query + ' WHERE TYPE_CODE = \'%s\';' % net_type
        else:
            query = query + ';'
        net_devices_type = DbManager.select(query)
        devices_types = []
        for net_device_type in net_devices_type:
            info(str(net_device_type[0]))
            tb_net_device_type = {
                'type_code': str(net_device_type[0]),
                'type_description': str(net_device_type[1]),
                'type_commands': list(loads(str(net_device_type[7])).keys()),
                'type_function': loads(str(net_device_type[7])),
                'type_config': loads(str(net_device_type[8])),
            }
            devices_types.append(tb_net_device_type)
        return devices_types

    @staticmethod
    def select_tb_net_device_and_msh_info(net_mac='', net_code='', net_type=''):
        query = 'SELECT DEV.*, MSH_COMMANDS ' \
                'FROM TB_NET_DEVICE DEV, TB_NET_DEVICE_TYPE TYP ' \
                'WHERE DEV.NET_TYPE = TYP.TYPE_CODE'
        if net_mac != '':
            query = query + ' AND NET_MAC = \'%s\';' % net_mac
        else:
            if net_code != '':
                query = query + ' AND NET_CODE = \'%s\';' % net_code
            else:
                if net_type != '':
                    query = query + ' AND NET_TYPE = \'%s\';' % net_type
                else:
                    query = query + ';'
        net_devices = DbManager.select(query)
        devices = []
        for net_device in net_devices:
            tb_net_device = {
                'net_code': str(net_device[0]),
                'net_type': str(net_device[1]),
                'net_last_update': str(net_device[2]),
                'net_ip': str(net_device[3]),
                'net_mac': str(net_device[4]),
                'net_mac_info': str(net_device[5]),
                'net_config_keys': list(loads(str(net_device[6])).keys()),
                'net_config': loads(str(net_device[6])),
                'commands': list(loads(str(net_device[7])).keys())
            }
            devices.append(tb_net_device)
        return devices

    @staticmethod
    def select_tb_net_device_and_google_info(net_mac=''):
        query = 'SELECT NET_CODE, NET_TYPE, NET_IP, NET_MAC, SYNC_RESPONSE, QUERY_RESPONSE, EXECUTE_REQUEST, EXECUTE_RESPONSE_OK, EXECUTE_RESPONSE_KO ' \
                'FROM TB_NET_DEVICE, TB_NET_DEVICE_TYPE ' \
                'WHERE TB_NET_DEVICE.NET_TYPE = TB_NET_DEVICE_TYPE.TYPE_CODE AND TB_NET_DEVICE.NET_TYPE <> \'NET\''
        if net_mac != '':
            query = query + ' AND NET_MAC = \'%s\';' % net_mac
        else:
            query = query + ';'
        net_devices = DbManager.select(query)
        devices = []
        for net_device in net_devices:
            tb_net_device = {
                'net_code': str(net_device[0]),
                'net_type': str(net_device[1]),
                'net_ip': str(net_device[2]),
                'net_mac': str(net_device[3]),
                'sync_response': loads(str(net_device[4])),
                'query_response': loads(str(net_device[5])),
                'execute_request': loads(str(net_device[6])),
                'execute_response_ok': loads(str(net_device[7])),
                'execute_response_ko': loads(str(net_device[8]))
            }
            devices.append(tb_net_device)
        return devices

    @staticmethod
    def update_tb_net_device(net_mac, net_code=None, net_type=None, net_ip=None, net_mac_info=None, net_config=None):
        query = 'UPDATE TB_NET_DEVICE SET NET_LASTUPDATE = \'%s\',' % datetime.now().strftime(XmlReader.settings['timestamp'])
        fields = {
            'net_code': 'NET_CODE = \'%s\',' % net_code,
            'net_type': 'NET_TYPE = \'%s\',' % net_type,
            'net_ip': 'NET_IP = \'%s\',' % net_ip,
            'net_mac_info': 'NET_MAC_INFO = \'%s\',' % net_mac_info,
            'net_config': 'NET_CONFIG = \'%s\',' % dumps(net_config),
        }
        device = {
            'net_code': net_code,
            'net_type': net_type,
            'net_ip': net_ip,
            'net_mac_info': net_mac_info,
            'net_config': net_config
        }
        for key, value in device.items():
            if value is not None:
                query = query + fields[key]
        query = query[:-1]
        query = query + ' WHERE NET_MAC = \'%s\';' % net_mac
        DbManager.insert_or_update(query)
        return

    @staticmethod
    def delete_tb_net_device(mac):
        query = 'DELETE FROM TB_NET_DEVICE WHERE NET_MAC = \'%s\';' % mac
        DbManager.insert_or_update(query)
        return

    @staticmethod
    def insert_tb_net_device(net_code, net_ip, net_mac, net_mac_info):
        query = 'INSERT INTO TB_NET_DEVICE (NET_CODE,NET_TYPE,NET_LASTUPDATE,NET_IP,NET_MAC,NET_MAC_INFO,NET_CONFIG) ' \
                'VALUES (\'%s\',\'NET\',\'%s\',\'%s\',\'%s\',\'%s\',\'{}\');' % (net_code, datetime.now().strftime(XmlReader.settings['timestamp']), net_ip, net_mac, net_mac_info)
        DbManager.insert_or_update(query)

    @staticmethod
    def select_tb_user(username=''):
        query = 'SELECT * ' \
                'FROM TB_USER'
        if username != "":
            query = query + ' WHERE USERNAME = \'%s\';' % username
        else:
            query = query + ';'
        users = DbManager.select(query)
        ret_users = []
        for user in users:
            tb_user = {
                'username': str(user[0]),
                'password': str(user[1]),
                'role': str(user[2]),
            }
            ret_users.append(tb_user)
        return ret_users

    @staticmethod
    def update_tb_user(username, password=None, role=None):
        query = 'UPDATE TB_USER SET '
        fields = {
            'password': 'PASSWORD = \'%s\',' % password,
            'role': 'ROLE = \'%s\',' % role,
        }
        device = {
            'password': password,
            'role': role
        }
        for key, value in device.items():
            if value is not None:
                query = query + fields[key]
        query = query[:-1]
        query = query + ' WHERE USERNAME = \'%s\';' % username
        DbManager.insert_or_update(query)
        return

    @staticmethod
    def delete_tb_user(username):
        query = 'DELETE FROM TB_USER WHERE USERNAME = \'%s\';' % username
        DbManager.insert_or_update(query)
        return

    @staticmethod
    def insert_tb_user(username, password, role):
        query = 'INSERT INTO TB_USER (USERNAME,PASSWORD,ROLE) ' \
                'VALUES (\'%s\',\'%s\',\'%s\');' % (username, password, role)
        DbManager.insert_or_update(query)

    @staticmethod
    def select_tb_wifi():
        query = "SELECT * FROM TB_WIFI;"
        wifis = DbManager.select(query)
        ret_wifi = []
        for wifi in wifis:
            tb_wifi = {
                'ssid': str(wifi[0]),
                'psw': str(wifi[1])
            }
            ret_wifi.append(tb_wifi)
        return ret_wifi

    @staticmethod
    def insert_tb_wifi(ssid, password):
        query = 'INSERT INTO TB_WIFI (SSID,PASSWORD) ' \
                'VALUES (\'%s\',\'%s\');' % (ssid, password)
        DbManager.insert_or_update(query)
        return

    @staticmethod
    def delete_tb_wifi():
        query = 'DELETE FROM TB_WIFI;'
        DbManager.insert_or_update(query)
        return

    @staticmethod
    def select_tb_string_from_lang_value(language, value):
        query = 'SELECT TB_STRING.RESULT ' \
                'FROM TB_STRING ' \
                'WHERE LANGUAGE = \'%s\' ' \
                'AND VALUE = \'%s\';' % (language, value)
        stringhe = DbManager.select(query)
        list_stringhe = []
        for stringa in stringhe:
            list_stringhe.append(str(stringa[0]))
        return list_stringhe[0]
