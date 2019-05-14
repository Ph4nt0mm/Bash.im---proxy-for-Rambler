from flask import Flask, render_template
from flask import request
import os
from sys import argv
app = Flask(__name__)

# Начальная страница
@app.route('/')
def index():
    os.system('./templ_downl.sh https://bash.im/index')
    os.system('python3 shuffle.py')
    return render_template("/templateNew.html")

# Функции для завершения сервера
def shutdown():
    func = request.environ.get('werkzeug.server.shutdown')
    if func is None:
        raise RuntimeError('Not running with the Werkzeug Server')
    func()
    return 'Server shutting down...'

# Любая не начальная страница
@app.route('/<path:path>')
def indexA(path):
    if (path == "shutdown"):
        return shutdown()
    if (path == "byrating"):
        os.system('./templ_downl.sh https://bash.im/%s' % path)
        return render_template("/template.html")
    if (path[-1:] == '/'):
        path = path[:-1]
    if (path[-5:] == '.html'):
        path = path[:-5]
    os.system('./templ_downl.sh https://bash.im/%s' % path)
    os.system('python3 shuffle.py')
    return render_template("/templateNew.html")

if __name__ == '__main__':
    if len (argv) > 1:
        app.run(port=int(argv[1]), debug=True)
    else:
        app.run(port=5000, debug=True)