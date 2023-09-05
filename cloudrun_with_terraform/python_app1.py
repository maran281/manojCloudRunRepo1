import os
from flask import Flask,jsonify

app=Flask(__name__)

@app.route("/", methods=["GET"])
def hello_world():
    return jsonify(message="Hello World"),200

if __name__=='__main__':
    app.run(debug=True,host='0.0.0.0',port=8080)