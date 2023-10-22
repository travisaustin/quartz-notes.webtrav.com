FROM node:20-slim as builder
WORKDIR /usr/src/app
COPY .quartz/package.json .
COPY .quartz/package-lock.json* .
RUN npm ci

FROM node:20-slim
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/ /usr/src/app/
COPY .quartz .
COPY ../ content/
CMD ["npx", "quartz", "build", "--serve"]
