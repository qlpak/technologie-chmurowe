from flask import Flask, request, jsonify
import pika
import os
import json

app = Flask(__name__)

RABBITMQ_HOST = os.getenv("RABBITMQ_HOST", "rabbitmq")

@app.route('/contact', methods=['POST'])
def contact():
    data = request.get_json()
    client_id = data.get("clientID")
    department = data.get("department")  # mortgage, cash, business

    if not client_id or department not in ["mortgage", "cash", "business"]:
        return jsonify({"error": "Invalid clientID or department"}), 400

    connection = pika.BlockingConnection(pika.ConnectionParameters(host=RABBITMQ_HOST))
    channel = connection.channel()

    channel.queue_declare(queue=department)
    channel.basic_publish(exchange='', routing_key=department, body=json.dumps({"clientID": client_id}))

    connection.close()
    return jsonify({"status": "queued"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
