request = require 'superagent'
_ = require 'lodash'
initialState =
  counter: 0
  status: 'init'
  errMsg: undefined

module.exports =

  (state = initialState, action) ->
    switch action.type
      when 'INCREMENT' then return counter: state.counter + 1
      when 'DECREMENT' then return counter: state.counter - 1
      when 'fetchStoreData'
        console.log action.data
        request
          .get('/api/baker_info')
          .set(id: action.data)
          .set('Accept', 'application/json')
          .end (err, res) ->
            if err?
              console.log err.response.text
              obj = _.merge initialState, status: 'error', errMsg: err.response.text
              console.log {obj}
              return obj
            else
              console.log res.body
              return state
      else return state
