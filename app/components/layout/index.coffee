react = require 'react'
reactRedux = require 'react-redux'
classnames = require 'classnames'
{div, ul, li, select, span, option} = react.DOM
Immutable = require 'immutable'

require '../../styles'
require './layout.styl'

class Layout extends react.Component

  componentWillMount: ->
    @_fetchCartFromLocal()

  render: ->
    div className: 'app-container',
      div className: 'nav',
        div className: 'nav-contents',
          div className: 'nav-title',
            @props.info.name if @props.status is 'loaded'
          div className: 'nav-controls',
            ul {},
              li className: 'link', 'Welcome, User!'
              li className: 'link', onClick: (=> console.log 'clicked'), 'Create an Account'
              li className: 'link', onClick: (=> console.log 'clicked'), "Cart (#{@props.cart.size})"

      div className: 'app-contents',
        this.props.children

  _fetchCartFromLocal: ->
    cart = Immutable.fromJS []
    cart = Immutable.fromJS JSON.parse localStorage.cakesCart if localStorage.cakesCart
    @props.dispatch type: 'setCart', data: {cart}

mapStateToProps = (state) =>
  cart: state.cart
  info: state.info
  status: state.status
  storeId: state.storeId

module.exports = reactRedux.connect(
  mapStateToProps
)(Layout)
