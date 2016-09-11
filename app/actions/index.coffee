request = require 'axios'
co = require 'co'
_ = require 'lodash'

receiveStoreData = (storeId, responseJSON) ->
  type: 'updateInfo', data: _.merge responseJSON, id: storeId

receivePopularCategories = (storeId, responseJSON) ->
  type: 'updatePopularCategories', data: _.merge responseJSON, id: storeId

receiveError = (error) ->
  type: 'addError', data: errMsg: error

setLoadingState = -> type: 'loading'
setLoadedState = -> type: 'loaded'


fetchStoreData = (storeId) ->
  co.wrap (dispatch) =>
    try
      results = yield request.get "/api/#{storeId}/baker_info", { headers: {'Accept': 'application/json'}}
      dispatch receiveStoreData storeId, results.data
    catch err
      dispatch receiveError err.response.text

fetchPopularCategories = (storeId) ->
  co.wrap (dispatch) =>
    try
      results = yield request.get "/api/#{storeId}/popular_categories", { headers: {'Accept': 'application/json'}}
      dispatch receivePopularCategories storeId, results.data
    catch err
      dispatch receiveError err.response.text

module.exports =

  testEverything: (storeId) ->
    co.wrap (dispatch) ->
      dispatch setLoadingState()
      dispatch fetchStoreData(storeId)
      dispatch fetchPopularCategories(storeId)
      .then =>
        dispatch setLoadedState()



