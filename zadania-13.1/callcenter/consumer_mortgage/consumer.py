import pika
import time
import json

def callback(ch, method, properties, body):
    data = json.loads(body)
    print(f"[MORTGAGE] Received message: {data}")

def main():
    while True:
        try:
            connection = pika.BlockingConnection(pika.ConnectionParameters(host="rabbitmq"))
            channel = connection.channel()
            channel.queue_declare(queue="mortgage")
            channel.basic_consume(queue="mortgage", on_message_callback=callback, auto_ack=True)
            print("[MORTGAGE] Waiting for messages...")
            channel.start_consuming()
        except pika.exceptions.AMQPConnectionError:
            print("Waiting for RabbitMQ...")
            time.sleep(5)

if __name__ == "__main__":
    main()
