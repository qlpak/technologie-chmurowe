import pika
import time
import json

def callback(ch, method, properties, body):
    data = json.loads(body)
    print(f"[CASH] Received message: {data}")

def main():
    while True:
        try:
            connection = pika.BlockingConnection(pika.ConnectionParameters(host="rabbitmq"))
            channel = connection.channel()
            channel.queue_declare(queue="cash")
            channel.basic_consume(queue="cash", on_message_callback=callback, auto_ack=True)
            print("[CASH] Waiting for messages...")
            channel.start_consuming()
        except pika.exceptions.AMQPConnectionError:
            print("Waiting for RabbitMQ...")
            time.sleep(5)

if __name__ == "__main__":
    main()
