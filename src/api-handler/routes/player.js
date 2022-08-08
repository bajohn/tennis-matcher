const AWS = require('aws-sdk');

const getPlayer = async (body) => {
    const userName = body.params.userName;
    return await getter(userName);
}



const putPlayer = async (body) => {
    const keys = ['userName',
        'firstName',
        'lastName',
        'city',
        'state'
    ];

    const itemToPush = keys.reduce((lv, cv) => {
        if (cv in body.params) {
            lv[cv] = body.params[cv]
        }
        return lv;
    }, {});

    return await putter(itemToPush)

}

const getter = async (userName) => {
    const docClient = new AWS.DynamoDB.DocumentClient();
    var params = {
        TableName: 'tennismatcher-user-profile',
        Key: {
            userName,
        }
    };
    return new Promise((res, rej) => {
        docClient.get(params, (err, data) => {
            if (err) {
                rej(error)
            }
            else {
                res(data)
            }
        });
    });

};

const putter = async (itemToPush) => {
    const docClient = new AWS.DynamoDB.DocumentClient();
    const params = {
        TableName: 'tennismatcher-user-profile',
        Item: itemToPush
    };

    return new Promise((res, rej) => {
        docClient.put(params, (err, data) => {
            if (err) {
                console.log('Error', err)
                res({
                    statusCode: 500
                });
            }
            else {
                res({
                    statusCode: 200,
                    data
                });
            }
        });
    });
}

module.exports = { getPlayer, putPlayer }