request = require 'superagent'
_ = require 'lodash'
{Map} = require 'immutable'
initialState =
  status: 'init'
  errMsg: undefined
  categoryContent: Map()

module.exports =

  (state = initialState, action) ->
    switch action.type
      when 'loading' then return _.merge {}, state, status: 'loading'
      when 'loaded' then return _.merge {}, state, status: 'loaded'
      when 'categoryLoadingUpdate'
        categoryContent = state.categoryContent.setIn [action.params.storeId, action.params.categoryId, 'status'], action.data.status
        return _.merge {}, state, {categoryContent}
      when 'updateCategoryOptions'
        categoryContent = state.categoryContent.setIn [action.params.storeId, action.params.categoryId, 'items'], action.data
        return _.merge {}, state, {categoryContent}
      when 'updateInfo'
        return _.merge {}, state, action.data
      when 'updatePopularCategories'
        return _.merge {}, state, action.data
      when 'addError'
        return Object.assign {}, action.data, status: 'error'
      else return state
