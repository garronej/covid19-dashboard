# build environment
FROM node:16-alpine as build
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn prepare-data
RUN yarn build

# production environment
FROM node:16-alpine
WORKDIR /app
COPY --from=build /app /app
CMD npx next start