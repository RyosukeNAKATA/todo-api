FROM rust:1.78-slim-bookworm AS builder
WORKDIR /app
COPY . .
RUN cargo build --release

FROM debian:bookworm-slim
WORKDIR /app

# 後のためのユーザーを作成
RUN adduser book && chown -R book /app
USER BOOK
COPY --from=builder ./app/target/release/app ./target/release/app

ENV PORT 8080
EXPOSE $PORT
ENTRYPOINT ["./target/release/app"]