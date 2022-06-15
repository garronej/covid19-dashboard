# build environment
FROM node:14-alpine as build
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .
RUN echo $AWS_S3_ENDPOINT
RUN yarn prepare-data

# production environment
FROM node:14-alpine
WORKDIR /app
COPY --from=build /app /app
CMD yarn dev