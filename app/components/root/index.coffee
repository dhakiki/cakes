react = require 'react'
Layout = require '../layout'
Redirect = react.createFactory require 'react-router/lib/Redirect'
Route = react.createFactory require 'react-router/lib/Route'
Router = react.createFactory require 'react-router/lib/Router'
LandingPage = require '../landing_page'
Layout = require '../layout'
browserHistory = require 'react-router/lib/browserHistory'
{div} = react.DOM


class Root extends react.Component

  routes =
    div {},
      Redirect from: '/', to: '/welcome'
      Route path: '/', component: Layout,
        Route path: '/welcome', component: LandingPage

  render: ->
    Router history: browserHistory,
      routes

module.exports = Root
