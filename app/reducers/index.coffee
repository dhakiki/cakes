request = require 'superagent'
_ = require 'lodash'
{Map, List} = require 'immutable'
initialState =
  bakerInfo: Map()
  categoryContent: Map()
  cart: List()
  errMsg: undefined
  status: 'init'

module.exports =

  (state = initialState, action) ->
    switch action.type
      when 'addError'
        return _.merge {}, action.data, status: 'error'
      when 'addToCart'
        storeCart = state.cart.get(action.data.storeId) or List()
        storeCart = storeCart.push action.data.item
        cart = state.cart.set action.data.storeId, storeCart
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
        bakerInfo = state.bakerInfo.set action.params.storeId, action.data.info
        return _.merge {}, state, {bakerInfo}
      when 'updatePopularCategories'
        return _.merge {}, state, action.data
      when 'setCart'
        return _.merge {}, state, action.data
      else return state
