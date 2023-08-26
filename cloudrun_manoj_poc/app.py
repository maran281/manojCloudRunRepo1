import os
from flask import Flask, jsonify

app=Flask(__name__)

@app.route("/", method=["GET"])
def hello_world():
    return jsonify(message="hello world!!!"),200

if __name__=='__main__':
    app.run(debug=True,host='0.0.0',port=int(os.environ.get("port",8080))) 