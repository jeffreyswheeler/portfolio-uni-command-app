FROM node:16.15.1-buster as build

WORKDIR /app

COPY package*.json .

RUN npm ci --production

COPY . .

RUN npm run build

FROM nginx:1.23.1-alpine

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]