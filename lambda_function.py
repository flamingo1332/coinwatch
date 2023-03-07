import boto3
import os
from pycoingecko import CoinGeckoAPI
from datetime import datetime, timedelta


def lambda_handler(event:any, context:any):
    # sns client
    sns = boto3.client('sns')
    topic_arn = os.environ["TOPIC_ARN"]
    message = "Top 5 coins with highest price increase rate\n"

    # db client
    dynamodb = boto3.resource("dynamodb")
    table_name = os.environ["TABLE_NAME"]
    table = dynamodb.Table(table_name)
    date_format = '%Y-%m-%d %H:%M:%S'

    
    now = datetime.now()
    now_str = now.strftime(date_format)
    now_minus_fifteen = now - timedelta(minutes=15)

    cg = CoinGeckoAPI()
    markets = cg.get_coins_markets(vs_currency="usd", per_page=100, page=1, 
                  order="market_cap_desc", price_change_percentage="1h", sparkline=False)
    
    coins = []
    for market in markets:
        coins.append(market["id"])

    prices = cg.get_price(vs_currencies="usd", ids = coins)
    
    result = {}
    for key, value in prices.items():
        # print(key, value['usd'])
        item = table.get_item(
            Key={
            'coin': key
            }
        )['item']
                
        if datetime.strptime(item['datetime'], date_format) > now_minus_fifteen: 
            result[key][0] = float(value['usd']) / float(item['price'])  # increase rate
            result[key][1] = value['usd']   # price_now 
            result[key][2] = item['price']  # price_before

        table.put_item(Item={
        'coin': key,
        'datetime': now_str,
        'price': value['usd']
    })

    sorted_result = dict(sorted(result.items(), key=lambda x: x[1][0]), reversed=True)
    top_5_result = {k: sorted_result[k] for k in list(sorted_result)[:5]}

    for i, (coin, values) in enumerate(top_5_result.items()):
        position = i + 1
        if position == 1:
            suffix = "st"
        elif position == 2:
            suffix = "nd"
        elif position == 3:
            suffix = "rd"
        else:  
            suffix = "th"
        message += f"{position}{suffix} : {coin}\n increase rate:{values[0]}\n price:{values[1]}\n price 15 min ago:{values[2]}\n"

    if len(top_5_result) == 0:
        message = "Not enough data"

    response = sns.publish(
        TopicArn=topic_arn,
        Message=message
    )

    print(response)

    return {
        'statusCode': 200,
        'body': 'Message sent successfully!'
    }



if __name__ == "__main__":
    os.environ["TABLE_NAME"] = "coinwatch_db"
    event = { "user" : "snk_local"}
    print(lambda_handler(event, None))