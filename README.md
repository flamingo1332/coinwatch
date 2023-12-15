
# Coinwatch

Automated Crypto price monitor

Utilizing AWS Lambda and CloudWatch, this application regularly fetches and analyzes cryptocurrency prices, calculating price changes and updating subscribers via SNS notifications.



## Motivation

It provided a good opportunity to develop skills in tools like terraform, github actions, and explore serverless architecture using AWS Lambda and DynamoDB. 

This project not only served as a technical exercise in advanced cloud and software practices but also aimed to create a practical tool for real-time cryptocurrency market monitoring.


## Architecture
![Untitled Diagram drawio](https://github.com/flamingo1332/coinwatch/assets/100294322/9b0304f5-7db9-4f93-8b33-3b6e8ef19297)

1. Invoke lambda with cloudwatch alarm every 15m
2. get crypto price data from CoingeckoAPI
3. Calculate price change rate and save to dynamodb
4. Fetch highest price change rate up to 5 and create custom message
5. publish to sns topic


## Output
![Capture](https://github.com/flamingo1332/coinwatch/assets/100294322/9aa52bc8-373e-4135-ba0f-d8ff62002c91)
