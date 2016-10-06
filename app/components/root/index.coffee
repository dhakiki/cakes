react = require 'react'
Layout = require '../layout'
Redirect = react.createFactory require 'react-router/lib/Redirect'
Route = react.createFactory require 'react-router/lib/Route'
Router = react.createFactory require 'react-router/lib/Router'
#main layout component
Layout = require '../layout'

#subcomponents
BakerLanding = require '../baker_landing'
CakeBuilder = require '../cake_builder'
Cart = require '../cart'
CustomForm = require '../custom_form'
PopularCakes = require '../popular_cakes'
SplashPage = require '../splash_page'

browserHistory = require 'react-router/lib/browserHistory'

{div} = react.DOM

class Root extends react.Component

  routes =
    div {},
      Redirect from: '/', to: '/welcome'
      Route path: '/', component: Layout,
        Route path: '/welcome', component: SplashPage
        Route path: '/cart', component: Cart
        Route path: '/:store_id/welcome', component: BakerLanding
        Route path: '/:store_id/popular-cakes', component: PopularCakes
        Route path: '/:store_id/cake-builder', component: CakeBuilder
        Route path: '/:store_id/custom-form', component: CustomForm

  render: ->
    div className: 'root',
      Router history: browserHistory,
        routes

module.exports = Root
