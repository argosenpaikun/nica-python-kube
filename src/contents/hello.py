from pywebio.output import *

class HelloPython:

    def __init__(self):
        pass

    def helloWorld(self):
        put_image(open('src/assets/docker-logo.png', 'rb').read())        
        put_markdown('## Hello World from Docker and Kubernetes!')
        
    def version(self):
        put_markdown('#### Version 1.0.1')