FROM node:18-alpine as build
WORKDIR /app/src
COPY package*.json ./
RUN npm ci
COPY . ./
RUN npx -p @angular/cli@16 ng build
# RUN npx -p @angular/cli@16 ng serve

FROM nginx:1.17.1-alpine
COPY /nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/src/dist/technica-app /usr/share/nginx/html

EXPOSE 80