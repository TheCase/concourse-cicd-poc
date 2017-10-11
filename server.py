#!/usr/bin/env python
import sys
from flask import Flask
from flask import render_template

app = Flask(__name__)  # pylint: disable=invalid-name

@app.route('/')
def index():
    return "hello world" 

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=int(3000))
