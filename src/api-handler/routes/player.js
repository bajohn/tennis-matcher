

export const getPlayer = (event) => {
    const userName = event.body.params.userName;
    return await getter(userName);
}



export const putPlayer = async (event) => {
    // "userName": "bjohn454@gmail.com",
    // "city": "Seattle",
    // "firstName": "Brendan",
    // "lastName": "John",
    // "state": "Washington"

    const keys = ['userName',
        'firstName',
        'lastName',
        'city',
        'state'
    ];

    const itemToPush = keys.reduce((lv, cv) => {
        if (cv in event.body.params) {
            lv[cv] = event.body.params[cv]
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

    docClient.put(params, (err, data) => {
        if (err) {
            console.log("Error", err);
        } else {
            console.log("Success", data);
        }
    });
}