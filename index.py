from flask import *
import requests
import json
import markdown

app = Flask(__name__)
@app.route('/')
def index():
    res = json.loads(requests.get('http://api.github.com/repos/lemonorangeapple/edgeless-hub/releases', verify = False).text)
    return render_template('index.html', res = res, markdown = markdown.markdown)