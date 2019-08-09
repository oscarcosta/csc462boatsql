FROM node

WORKDIR /usr/src/app/web_app

COPY ./web/ .

RUN npm install -y

EXPOSE 3000

CMD [ "npm", "start" ]
