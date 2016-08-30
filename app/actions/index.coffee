request = require 'superagent'
_ = require 'lodash'

receiveStoreData = (storeId, responseJSON) ->
  type: 'updateInfo', data: _.merge responseJSON, id: storeId

receiveError = (error) ->
  type: 'addError', data: errMsg: error

module.exports =

  fetchStoreData: (storeId) ->
    (dispatch) =>
      request
        .get('/api/baker_info')
        .set(id: storeId)
        .set('Accept', 'application/json')
        .end (err, res) =>
          return dispatch receiveError err.response.text if err?
          dispatch receiveStoreData storeId, res.body
