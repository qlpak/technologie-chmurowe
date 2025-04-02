ARG PYTHON_VERSION=3.12

FROM python:${PYTHON_VERSION}-slim

WORKDIR /app

COPY myapp/ .

RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "main.py"]
