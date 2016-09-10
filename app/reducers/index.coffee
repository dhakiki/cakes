request = require 'superagent'
_ = require 'lodash'
initialState =
  status: 'init'
  errMsg: undefined

module.exports =

  (state = initialState, action) ->
    switch action.type
      when 'loading' then return _.merge {}, state, status: 'loading'
      when 'loaded' then return _.merge {}, state, status: 'loaded'
      when 'updateInfo'
        return _.merge {}, state, action.data
      when 'updatePopularCategories'
        return _.merge {}, state, action.data
      when 'addError'
        return Object.assign {}, action.data, status: 'error'
      else return state
