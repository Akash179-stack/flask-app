FROM python:3.14-slim AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt --target /app/libraries

COPY . .

FROM gcr.io/distroless/python3-debian12 AS production

WORKDIR /app

COPY --from=builder /app/libraries /app/libraries

COPY --from=builder /app .

ENV PYTHONPATH="/app/libraries"

EXPOSE 80

CMD ["run.py"]


 

