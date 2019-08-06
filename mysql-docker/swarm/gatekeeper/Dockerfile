FROM node:boron

WORKDIR /usr/src/app

COPY package.json .
COPY server.js .

RUN npm install

EXPOSE 8180

CMD ["npm", "start"]