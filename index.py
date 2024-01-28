from flask import *
import requests
import json
import markdown

app = Flask(__name__)
@app.route('/')
def index():
    res = json.loads(requests.get('http://api.github.com/repos/lemonorangeapple/edgeless-hub/releases', verify = False).text)
    for release in res:
        if release['prerelease'] == False:
            res.remove(release)
            res = [release] + res
            break
    return render_template('index.html', res = res, markdown = markdown.markdown)