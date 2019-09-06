FROM node:10.15.3 as builder

RUN mkdir -p /root/src/app
WORKDIR /root/src/app
ENV PATH /root/src/app/node_modules/.bin:$PATH

COPY . .

RUN npm install
RUN npm run build

FROM node:10.15.3-alpine

WORKDIR /root/src/app

COPY --from=builder /root/src/app/dist /root/src/app/dist

EXPOSE 3000

ENTRYPOINT ["node","./dist/server/server.js"]
