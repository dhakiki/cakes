request = require 'axios'
co = require 'co'
_ = require 'lodash'

receiveStoreData = (storeId, responseJSON) ->
  type: 'updateInfo', data: responseJSON, params: {storeId}

receivePopularCategories = (storeId, responseJSON) ->
  type: 'updatePopularCategories', data: responseJSON, params: {storeId}

receiveCategoryOptions = (storeId, categoryId, responseJSON) ->
  type: 'updateCategoryOptions', data: responseJSON, params: {storeId, categoryId}

receiveError = (error) ->
  type: 'addError', data: errMsg: error

setLoadingState = -> type: 'loading'
setLoadedState = -> type: 'loaded'
setCategoryLoadingState = (storeId, categoryId, status) -> type: 'categoryLoadingUpdate', data: {status}, params: {storeId, categoryId}

fetchCategoryOptions = (storeId, categoryId) ->
  co.wrap (dispatch) =>
    try
      results = yield request.get "/api/#{storeId}/category_options/#{categoryId}", { headers: {'Accept': 'application/json'}}
      dispatch receiveCategoryOptions storeId, categoryId, results.data
    catch err
      dispatch receiveError err.response.text

fetchPopularCategories = (storeId) ->
  co.wrap (dispatch) =>
    try
      results = yield request.get "/api/#{storeId}/popular_categories", { headers: {'Accept': 'application/json'}}
      dispatch receivePopularCategories storeId, results.data
    catch err
      dispatch receiveError err.response.text

fetchStoreData = (storeId) ->
  co.wrap (dispatch) =>
    try
      results = yield request.get "/api/#{storeId}/baker_info", { headers: {'Accept': 'application/json'}}
      dispatch receiveStoreData storeId, results.data
    catch err
      dispatch receiveError err.response.text

module.exports =

  addItemToCart: (item) ->
    type: 'addToCart', data: item

  #TODO: figure out how to allow components to make these requests instead of combining them here like so
  fetchPopularCakesData: (storeId) ->
    (dispatch) ->
      dispatch setLoadingState()
      dispatch fetchStoreData(storeId)
      dispatch fetchPopularCategories(storeId)
      .then =>
        dispatch setLoadedState()

  fetchBakerLandingData: (storeId) ->
    (dispatch) ->
      dispatch setLoadingState()
      dispatch fetchStoreData(storeId)
      .then =>
        dispatch setLoadedState()

  fetchCategoryContent: (storeId, categoryId) ->
    (dispatch) ->
      dispatch setCategoryLoadingState storeId, categoryId, 'loading'
      dispatch fetchCategoryOptions(storeId, categoryId)
        .then =>
          dispatch setCategoryLoadingState storeId, categoryId, 'loaded'

