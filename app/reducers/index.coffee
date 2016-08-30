request = require 'superagent'
_ = require 'lodash'
initialState =
  counter: 0
  status: 'init'
  errMsg: undefined

module.exports =

  (state = initialState, action) ->
    switch action.type
      when 'INCREMENT' then return _.merge {}, state, counter: state.counter + 1
      when 'DECREMENT' then return _.merge {}, state, counter: state.counter - 1
      when 'updateInfo'
        return _.merge {}, state, status: 'loaded', action.data
      when 'addError'
        return _.merge {}, action.data, status: 'error'
      else return state
