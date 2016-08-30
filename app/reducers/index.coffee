request = require 'superagent'
_ = require 'lodash'
initialState =
  counter: 0
  status: ''
  errMsg: undefined

module.exports =

  (state = initialState, action) ->
    switch action.type
      when 'INCREMENT' then return counter: state.counter + 1
      when 'DECREMENT' then return counter: state.counter - 1
      when 'updateInfo'
        console.log 'thingz', action.data
        return info: action.data.json.info, storeId: action.data.id, counter: state.counter
      when 'addError'
        console.log 'thingz', action.data
        return errMsg: action.data, status: 'error'
      else return state
