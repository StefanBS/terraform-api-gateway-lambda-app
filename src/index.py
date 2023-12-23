import json

def handler(event, context):
    print('test')
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({
            "hello": "world"
        })
    }
