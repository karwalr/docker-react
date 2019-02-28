#BUILD PHASE
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
#no need for volume system as this is a 'real' build
RUN npm run build
#CMD ["npm", "run", "start"]

#RUN PHASE. Copies everything over from the builder phase.
FROM nginx
COPY default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html

#by default, the Nginix will start automatically so no need for a run command.
