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

store = createStore(
  appReducer,
  applyMiddleware(
    thunkMiddleware.default,
    reduxMulti.default,
    logger
  )
)

render = =>
  reactDom.render(
      Provider {store},
        react.createElement Root
      document.querySelector 'main'
  );

render()
store.subscribe render
