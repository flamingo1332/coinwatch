import boto3
import os
from decimal import Decimal
from datetime import datetime, timedelta


def lambda_handler(event:any, context:any):
    # datetime
    date_format = '%Y-%m-%d %H:%M'
    now = datetime.now()
    now_str = now.strftime(date_format)
    now_minus_15 = now - timedelta(minutes=15)
    now_minus_15_str = now_minus_15.strftime(date_format)
    
    # sns client
    sns = boto3.client('sns')
    topic_arn = os.environ["TOPIC_ARN"]
    message = f"coins with highest price change% (15min, Limit5, {now}):\n "

    # db
    dynamodb = boto3.resource("dynamodb")
    table_change_rate = dynamodb.Table(os.environ["TABLE_NAME_CHANGERATE"])
    

    response = table_change_rate.scan(
        FilterExpression='#dt BETWEEN :start_dt AND :end_dt',
        ExpressionAttributeNames={
            '#dt': 'datetime'
        },
        ExpressionAttributeValues={
            ':start_dt': now_minus_15_str,
            ':end_dt': now_str
        }
    )


    top_coins = sorted(response['Items'], key=lambda x: Decimal(x['change_rate']), reverse=True)[:5]

    if len(top_coins) != 0:
        for coin in top_coins:
            message += f"{coin['coin']} : {coin['change_rate']:.4f}\n " 

    else:
        message += "Not enough data"

    response = sns.publish(
        TopicArn=topic_arn,
        Message=message
    )


    return {
        'statusCode': 200,
        'body': 'Message sent successfully!',
        'message': message
    }

