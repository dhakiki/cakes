module.exports =

  (state = 0, action) ->
    switch action.type
      when 'INCREMENT' then return state + 1
      when 'DECREMENT' then return state - 1
      else return state
