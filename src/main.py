from pywebio.platform.flask import start_server
from pywebio.output import *
from pywebio.session import *

from dataclasses import dataclass

from contents.hello import HelloPython

@dataclass
class App:

    '''
    Initialize application
    '''
    def __init__(self):
        self.hello = HelloPython()

    def index(self):
        set_env(title='Hello Python', output_animation=False)

        with use_scope(name='hello'):
            self.hello.helloWorld()
            self.hello.version()

if __name__ == '__main__':
    app = App()
    start_server(app.index, debug=True, port=3000)