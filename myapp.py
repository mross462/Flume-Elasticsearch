import os
import datetime
from flask import Flask, request, redirect, url_for
from werkzeug import secure_filename
import httplib
from random import choice

app = Flask(__name__)

@app.route("/", methods=['GET'])
def feedback_attachment():

    #Return Random HTTP Status Code
    status = choice(httplib.responses.keys())
    return (httplib.responses.get(status), status)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5001, debug=True)
