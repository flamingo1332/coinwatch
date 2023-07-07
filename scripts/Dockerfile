FROM python:3.10

WORKDIR /app

COPY lambda_function_data.py .

COPY requirements1.txt .

RUN pip install -r requirements1.txt

CMD ["python", "lambda_function_data.py"]

# docker build -t docker.io/ksw29555/lambda-function-publish:latest -f scripts/Dockerfile2 ./scripts
# docker push docker.io/ksw29555/lambda-function-publish:latest
# docker tag ksw29555/lambda-function-publish:latest 164634153529.dkr.ecr.ap-northeast-1.amazonaws.com/demo:latest