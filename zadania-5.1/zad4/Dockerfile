ARG PYTHON_VERSION=3.12
ARG APP_PORT=8000

FROM python:${PYTHON_VERSION}-alpine

ENV PYTHON_VERSION=${PYTHON_VERSION}
ENV APP_PORT=${APP_PORT}

WORKDIR /app

COPY app/ .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE ${APP_PORT}

VOLUME ["/app/data"]

CMD ["python", "main.py"]
