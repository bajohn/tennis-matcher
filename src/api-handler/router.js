const { getPlayer } = require("./routes/player");


export const routeRequest = (event) => {
    const action = event.body.action;
    const routes = {
        getPlayer,
        putPlayer
    };
    if (action in routes) {
        return routes[action](event)
    } else {
        return {
            status: 'Not found'
        }
        // TODO: not found error
    }
}
