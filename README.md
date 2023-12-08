
# Cointwatch

Automated Crypto price monitor

Utilizing AWS Lambda and CloudWatch, this application regularly fetches and analyzes cryptocurrency prices, calculating price changes and updating subscribers via SNS notifications.



## Motivation

It provided a good opportunity to develop skills in tools like terraform, github actions, and explore serverless architecture using AWS Lambda and DynamoDB. 

This project not only served as a technical exercise in advanced cloud and software practices but also aimed to create a practical tool for real-time cryptocurrency market monitoring.


## Architecture

1. Invoke lambda with cloudwatch alarm every 15m
2. get crypto price data from CoingeckoAPI
3. Calculate price change rate and save to dynamodb
4. Fetch highest price change rate up to 5 and create custom message
5. publish to sns topic


## Output

