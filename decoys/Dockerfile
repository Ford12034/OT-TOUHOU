FROM python:3.13-slim
WORKDIR /app
COPY decoys.py .
ENV DECOY_MODE=banner DECOY_PORT=502
CMD ["python", "-u", "decoys.py"]
