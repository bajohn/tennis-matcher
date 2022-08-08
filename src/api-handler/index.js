const AWS = require('aws-sdk');

exports.handler = async (event, context) => {
    // Documentation:
    // https://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/dynamodb-example-document-client.html
    const docClient = new AWS.DynamoDB.DocumentClient();
    // const params = {
    //     TableName: 'tennismatcher-user-profile',
    //     Item: {
    //         'userName': 'bjohn454@gmail.com',
    //         'firstName': 'Brendan',
    //         'lastName': 'John',
    //         'city': 'Seattle',
    //         'state': 'Washington'
    //     }
    // };

    // docClient.put(params, (err, data) => {
    //     if (err) {
    //         console.log("Error", err);
    //     } else {
    //         console.log("Success", data);
    //     }
    // });


    const retData = await getter(docClient);

    return {
        "isBase64Encoded": false,
        "statusCode": 200,
        "headers": {},
        "body": JSON.stringify(retData)
    };
}

const getter = (docClient) => {
    return new Promise((res, rej) => {
        var params = {
            TableName: 'tennismatcher-user-profile',
            Key: {
                userName: 'bjohn454@gmail.com',
            }
        };

        docClient.get(params, (err, data) => {
            if (err) {
                rej(error)
            }
            else {
                res(data)
            }
        });
    })
}