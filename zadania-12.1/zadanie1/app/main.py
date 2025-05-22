from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    return jsonify({"message": "REST API is working correctly"})

@app.route('/health')
def health():
    return jsonify({"status": "healthy"})

@app.route('/hello')
def hello():
    return jsonify({"message": "Hello cloud"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)