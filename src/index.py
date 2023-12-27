import json


def handler(event, context):
    greeter = "world"
    if event["body"]:
        body = json.loads(event["body"])
        if body["greeter"] and body["greeter"] != "":
            greeter = body["greeter"]
    response = {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps({"message": f"hello {greeter}"}),
    }
    return response
