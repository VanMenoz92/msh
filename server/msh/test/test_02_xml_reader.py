from module import XmlReader
from os import remove
from test import read_xml


def test_xml_reader_log_file():
    f = open("settings_log_file.xml", "w")
    f.write("<settings>"
            "   <lingua>IT</lingua>"
            "   <timestamp>%Y-%m-%d %H:%M:%S</timestamp>"
            "   <project_id_google_actions>fake_project</project_id_google_actions>"
            "   <subdomain_oauth>fake_oauth</subdomain_oauth>"
            "   <subdomain_webapp>fake_webapp</subdomain_webapp>"
            "   <log>"
            "       <!-- Se valorizzato con None logga in console -->"
            "       <filename>msh.log</filename>"
            "       <format>%(asctime)s|%(levelname)s|%(filename)s:%(lineno)s|%(message)s</format>"
            "       <!-- debug, info, warning, error, critical -->"
            "       <level>info</level>"
            "   </log>"
            "</settings>")
    f.close()
    XmlReader("settings_log_file.xml")
    remove("settings_log_file.xml")
    assert XmlReader.settings['log']['filename'] == "msh.log"


def test_xml_reader_log_console():
    read_xml()
    assert XmlReader.settings['log']['filename'] is None
