import boto3
import os
from pycoingecko import CoinGeckoAPI
from datetime import datetime, timedelta
from decimal import Decimal, ROUND_HALF_UP
import decimal

def lambda_handler(event:any, context:any):
    decimal.getcontext().prec = 10

    # db 
    dynamodb = boto3.resource("dynamodb")
    table = dynamodb.Table(os.environ["TABLE_NAME"])
    table_change_rate = dynamodb.Table(os.environ["TABLE_NAME_CHANGERATE"])

    # datetime
    date_format = '%Y-%m-%d %H:%M'
    now = datetime.now()
    now_str = now.strftime(date_format)
    now_minus_35 = now - timedelta(minutes=35)

    # coin price data
    cg = CoinGeckoAPI()
    markets = cg.get_coins_markets(vs_currency="usd", per_page=100, page=1, 
                  order="market_cap_desc", price_change_percentage="1h", sparkline=False)
    coins = []
    for market in markets:
        coins.append(market["id"])
    prices = cg.get_price(vs_currencies="usd", ids = coins)
    

    # process data and 
    results = {}
    with table.batch_writer() as batch:
        for key, value in prices.items():
            # print(key, value['usd'])
            db_response = table.get_item(Key={'coin': key})
            
            if 'Item' in db_response:
                item = db_response['Item']
                if datetime.strptime(item['details']['datetime'], date_format) > now_minus_35: 
                    results[key] = (Decimal(value['usd']) / Decimal(item['details']['price']) - 1,   # increase rate
                                   value['usd'],                                                # price_now 
                                   item['details']['price'])                                    # price_before
        
            batch.put_item(Item={
                'coin': key,
                'details' : {
                    'datetime': now_str,
                    'price': str(value['usd'])
                }
            })

    if len(results) != 0:
        with table_change_rate.batch_writer() as batch:
            for key, (change_rate, price_now, price_before) in results.items():
                batch.put_item(Item={
                    'coin': key,
                    'datetime' : now_str,
                    'change_rate': change_rate
                    })


    return {
        'statusCode': 200,
        'body': 'change rate data saved'
    }

