react = require 'react'
reactDom = require 'react-dom'
appReducer = require './reducers'
reduxMulti = require 'redux-multi'
createLogger = require 'redux-logger'
{batchedSubscribe} = require 'redux-batched-subscribe'
{createStore, applyMiddleware, combineReducers} = require 'redux'
thunkMiddleware = require 'redux-thunk'
Provider = react.createFactory require('react-redux').Provider

logger = createLogger()

Root = require './components/root'
#console.log reduxMulti.default

#store = createStore(
#  reducer,
#  applyMiddleware(
#    thunkMiddleware.default,
#    reduxMulti.default
#  )
#)

########
# Add middleware to allow our action creators to return functions and arrays
createStoreWithMiddleware = applyMiddleware(
  thunkMiddleware.default,
  reduxMulti.default,
  logger
)(createStore)

# Ensure our listeners are only called once, even when one of the above
# middleware call the underlying store's `dispatch` multiple times
createStoreWithBatching = batchedSubscribe(
  (fn) => fn()
)(createStoreWithMiddleware)

# Create a store with our application reducer
store = createStoreWithBatching(appReducer)

########

render = =>
  reactDom.render(
      Provider {store},
        react.createElement Root
      document.querySelector 'main'
  );

render()
store.subscribe render
