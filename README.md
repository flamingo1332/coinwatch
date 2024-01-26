
# Coinwatch

Automated Crypto price monitor

Utilizing AWS Lambda and CloudWatch, this application regularly fetches and analyzes cryptocurrency prices, calculating price changes and updating subscribers via SNS notifications.



## Motivation

It provided a good opportunity to develop skills in tools like terraform, github actions, and explore serverless architecture using AWS Lambda and DynamoDB. 

This project not only served as a technical exercise in advanced cloud and software practices but also aimed to create a practical tool for real-time cryptocurrency market monitoring.


## Architecture
![Untitled Diagram drawio](https://github.com/flamingo1332/coinwatch/assets/100294322/5d789b2f-7d8d-497a-a2f6-e75c0f895eb2)


1. Invoke lambda with cloudwatch alarm every 15m
2. get crypto price data from CoingeckoAPI
3. Calculate price change rate and save to dynamodb
4. Fetch highest price change rate up to 5 and create custom message
5. publish to sns topic


## Repo Structure

```
│   .gitignore
│   main.tf
│   README.md
│   variables.tf
│
├───.github
│   └───workflows
│           main.yml
│
├───modules
│   ├───backend
│   │       main.tf
│   │       outputs.tf
│   │       variables.tf
│   │
│   ├───dynamodb
│   │       main.tf
│   │       outputs.tf
│   │       variables.tf
│   │
│   ├───eventbridge
│   │       main.tf
│   │       outputs.tf
│   │       variables.tf
│   │
│   ├───iam
│   │       main.tf
│   │       outputs.tf
│   │       variables.tf
│   │
│   ├───lambda
│   │       main.tf
│   │       outputs.tf
│   │       variables.tf
│   │
│   └───sns_topic
│           main.tf
│           outputs.tf
│           variables.tf
│
└───scripts
        Dockerfile
        lambda_function_data.py
        lambda_function_publish.py
        requirements.txt
```

## Output
![Capture](https://github.com/flamingo1332/coinwatch/assets/100294322/9aa52bc8-373e-4135-ba0f-d8ff62002c91)

