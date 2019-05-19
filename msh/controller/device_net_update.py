from webapp3 import RequestHandler
from logging import info, exception
from module.dbmanager import DbManager
from module.xml_reader import XmlReader
from json import dumps
from datetime import datetime


class DeviceNetUpdate(RequestHandler):
    def get(self):
        info("%s %s", self.request.method, self.request.url)
        response = {}
        try:
            codice = self.request.get('c')
            tipo = self.request.get('t')
            mac = self.request.get('m')
            DbManager(XmlReader.settings['path']['db'])
            rows = DbManager.select(XmlReader.settings['query']['select_tb_net_device_from_mac'] % mac)
            device = DbManager.tb_net_device(rows)[0]
            DbManager.insert_or_update(XmlReader.settings['query']['update_tb_net_device'] % (codice, tipo, device['net_status'], device['net_ip'], device['net_mac_info'], device['net_mac']))
            DbManager.close_db()
            response['output'] = 'OK'
        except Exception as e:
            exception("Exception")
            response['output'] = XmlReader.settings['string_failure']['generic'] % (XmlReader.settings['command']['net'], e)
        finally:
            response['timestamp'] = datetime.now().strftime(XmlReader.settings['timestamp'])
            self.response.headers.add('Access-Control-Allow-Origin', '*')
            self.response.headers.add('Content-Type', 'application/json')
            self.response.write(dumps(response, indent=4, sort_keys=True))
            info("RESPONSE CODE: %s", self.response.status)
            info("RESPONSE PAYLOAD: %s", response)
