FROM python:3.12-slim
WORKDIR /app
COPY *.py /app/
CMD ["python3", "f3.py"]
