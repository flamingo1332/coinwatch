FROM amazon/aws-lambda-python:3.8

COPY lambda_function.py ./

RUN pip install boto3 pycoingecko

CMD ["lambda_function.lambda_handler"]