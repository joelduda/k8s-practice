# build production react code
FROM node:14.14.0-alpine as builder

USER node

RUN mkdir -p /home/node/app

WORKDIR '/home/node/app'

COPY --chown=node:node . .

RUN npm install
RUN npm run build

# build production nginx container and copy production react code
FROM nginx

COPY --from=builder /home/node/app/build /usr/share/nginx/html
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

# nginx image default command is fine, dont need to override
EXPOSE 3000