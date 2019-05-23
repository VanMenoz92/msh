from webapp3 import RequestHandler
from logging import info, exception


class Index(RequestHandler):
    def get(self):
        info("%s %s", self.request.method, self.request.url)
        self.redirect('/static/page/index.html')
        info("RESPONSE CODE: %s to %s", self.response.status, self.response.headers['Location'])


class Static(RequestHandler):
    def get(self, filename):
        path_ui = 'webui/'
        info("%s %s", self.request.method, self.request.url)
        f = open(path_ui + filename, 'r')
        self.response.write(f.read())
        f.close()
        info("RESPONSE CODE: %s", self.response.status)
        info("RESPONSE PAYLOAD: %s%s", path_ui, filename)


def handle_error(request, response, excep):
    path_error = 'webui/page/error/'
    error_code = '500'
    class_error = {
        '404': '<class \'webob.exc.HTTPNotFound\'>',
        '405': '<class \'webob.exc.HTTPMethodNotAllowed\'>'
    }
    for code, value in class_error.items():
        if str(value) == str(type(excep)):
            error_code = code
    if error_code != '500':
        info("%s %s", request.method, request.url)
    exception(excep)
    f = open(path_error + error_code + '.html', 'r')
    response.write(f.read())
    response.set_status(int(error_code))
    f.close()
    info("RESPONSE CODE: %s", response.status)
    info("RESPONSE PAYLOAD: %s%s.html", path_error, error_code)
