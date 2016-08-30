request = require 'superagent'

receiveStoreData = (storeId, responseJSON) ->
  console.log {responseJSON}
  type: 'updateInfo', data: id: storeId, json: responseJSON

receiveError = (error) ->
  console.log error
  type: 'addError', data: error

module.exports =

  fetchStoreData: (storeId) ->
    console.log @receiveStoreData
    (dispatch) =>
      request
        .get('/api/baker_info')
        .set(id: storeId)
        .set('Accept', 'application/json')
        .end (err, res) =>
          if err?
            console.log err.response.text
            dispatch receiveError err.response.text
          else
            console.log res.body, receiveStoreData, dispatch
            dispatch receiveStoreData storeId, res.body
      #type: 'fetchStoreData', data: storeId

  increment:
    type: 'INCREMENT'

  decrement:
    type: 'DECREMENT'
