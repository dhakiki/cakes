react = require 'react'
reactDom = require 'react-dom'
reducer = require './reducers'
{createStore} = require 'redux'
Provider = react.createFactory require('react-redux').Provider

Root = require './components/root'

store = createStore reducer

render = =>
  reactDom.render(
      Provider {store},
        react.createElement Root
      document.querySelector 'main'
  );

render()
store.subscribe render
