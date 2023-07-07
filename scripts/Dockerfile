FROM public.ecr.aws/lambda/python:3.10

COPY requirements.txt ${LAMBDA_TASK_ROOT}

COPY lambda_function_data.py ${LAMBDA_TASK_ROOT}

RUN pip install -r requirements.txt

CMD [ "lambda_function_data.lambda_handler" ]

# docker build -t docker.io/ksw29555/lambda-function-publish:latest -f scripts/Dockerfile2 ./scripts
# docker push docker.io/ksw29555/lambda-function-publish:latest
# docker tag ksw29555/lambda-function-publish:latest 164634153529.dkr.ecr.ap-northeast-1.amazonaws.com/demo:latest

