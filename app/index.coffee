react = require 'react'
reactDom = require 'react-dom'
reducer = require './reducers'
{createStore, applyMiddleware} = require 'redux'
thunkMiddleware = require 'redux-thunk'
Provider = react.createFactory require('react-redux').Provider

Root = require './components/root'

store = createStore(
  reducer,
  applyMiddleware(
    thunkMiddleware.default
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
