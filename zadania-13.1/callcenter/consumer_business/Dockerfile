FROM python:3.9-slim
WORKDIR /app
RUN pip install pika
COPY consumer.py .
CMD ["python", "consumer.py"]
