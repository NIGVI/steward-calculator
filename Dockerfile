FROM node:20-alpine
WORKDIR /build

COPY ./package* ./
RUN npm i
COPY ./ ./

VOLUME [ "/build/dist" ]

CMD [ "npm", "run", "build" ]