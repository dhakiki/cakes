request = require 'superagent'
_ = require 'lodash'
{Map, List} = require 'immutable'
initialState =
  status: 'init'
  errMsg: undefined
  categoryContent: Map()
  cart: List()

module.exports =

  (state = initialState, action) ->
    switch action.type
      when 'addError'
        return _.merge {}, action.data, status: 'error'
      when 'addToCart'
        cart = state.cart.push action.data
        localStorage.setItem 'cakesCart', JSON.stringify cart.toJS()
        return _.merge {}, state, {cart}
      when 'categoryLoadingUpdate'
        categoryContent = state.categoryContent.setIn [action.params.storeId, action.params.categoryId, 'status'], action.data.status
        return _.merge {}, state, {categoryContent}
      when 'loading' then return _.merge {}, state, status: 'loading'
      when 'loaded' then return _.merge {}, state, status: 'loaded'
      when 'updateCategoryOptions'
        categoryContent = state.categoryContent.setIn [action.params.storeId, action.params.categoryId, 'items'], action.data
        return _.merge {}, state, {categoryContent}
      when 'updateInfo'
        return _.merge {}, state, action.data
      when 'updatePopularCategories'
        return _.merge {}, state, action.data
      when 'setCart'
        return _.merge {}, state, action.data
      else return state
