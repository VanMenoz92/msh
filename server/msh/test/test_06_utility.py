from unittest import TestCase
from test import read_xml_prod
from module import execute_os_cmd, execute_ssh_cmd


class TestUtility(TestCase):

    def test_execute_os_cmd_run(self):
        read_xml_prod()
        response = execute_os_cmd("pwd")
        self.assertEqual(response['return_code'], 0)
        self.assertNotEqual(response['cmd_out'], "")

    def test_execute_os_cmd_check_output(self):
        read_xml_prod()
        response = execute_os_cmd("pwd", check_out=True)
        self.assertNotEqual(response['cmd_out'], "")

    def test_execute_os_cmd_system(self):
        read_xml_prod()
        response = execute_os_cmd("pwd", sys=True)
        self.assertEqual(response, {})

    def test_execute_ssh_cmd_ko_login(self):
        read_xml_prod()
        response = execute_ssh_cmd('127.0.0.1', 'test_user', 'test1234', 'pwd')
        self.assertEqual(response['output'], 'Credenzilai non valide')

    def test_execute_ssh_cmd_ko_other(self):
        read_xml_prod()
        response = execute_ssh_cmd('127.0.0.2', 'test_user', 'test1234', 'pwd')
        self.assertNotEqual(response['output'], "OK")

    def test_execute_ssh_cmd_ok(self):
        read_xml_prod()
        response = execute_ssh_cmd('127.0.0.1', 'test_user', 'test_password', 'pwd')
        self.assertEqual(response['output'], "OK")
