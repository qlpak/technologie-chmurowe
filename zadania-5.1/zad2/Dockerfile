FROM node:18-alpine

WORKDIR /usr/src/app

COPY app/ .

RUN npm install

ENV NODE_ENV=production

CMD ["node", "index.js"]
