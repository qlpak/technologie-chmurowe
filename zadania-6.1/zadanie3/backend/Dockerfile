FROM node:18

WORKDIR /app
COPY app.js .
RUN npm init -y && npm install express mysql2

EXPOSE 3000
CMD ["node", "app.js"]
