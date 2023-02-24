FROM python:3.10-alpine
WORKDIR /app
COPY src/ .
RUN  pip install --upgrade pip && \
    pip install -r requirements.txt
EXPOSE 5000
CMD ["python", "/app/app.py"]