from pywebio.platform.flask import webio_view
from pywebio.output import *
from pywebio.session import *

from dataclasses import dataclass

from contents.hello import HelloPython
from flask import Flask

app = Flask(__name__)

def task_func():
    set_env(title='Hello Python', output_animation=False)
    hello = HelloPython()

    with use_scope(name='hello'):
        hello.helloWorld()
        hello.version()


if __name__ == '__main__':
    app.add_url_rule('/', 'webio_view', webio_view(task_func), methods=['GET', 'POST', 'OPTIONS'])
    app.run(host='0.0.0.0', debug=False, port=3000)