react = require 'react'
reactRedux = require 'react-redux'
classnames = require 'classnames'
{a, div, ul, li, select, span, option} = react.DOM
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
            @props.info.get(@props.params.store_id)?.name or 'Cakes' if @props.status is 'loaded'
          div className: 'nav-controls',
            ul {},
              li className: 'link', 'Welcome, User!'
              li className: 'link', onClick: (=> console.log 'clicked'), 'Create an Account'
              a className: 'link', href: "http://localhost:3000/cart",
                li {}, "Cart (#{@_fetchCartTotal()})"

      div className: 'app-contents',
        this.props.children

  _fetchCartTotal: ->
    total = 0
    @props.cart.toArray().forEach (cart) -> total += cart.size
    total

  _fetchCartFromLocal: ->
    cart = Immutable.fromJS {}
    cart = Immutable.fromJS JSON.parse localStorage.cakesCart if localStorage.cakesCart
    @props.dispatch type: 'setCart', data: {cart}

mapStateToProps = (state) =>
  cart: state.cart
  info: state.bakerInfo
  status: state.status

module.exports = reactRedux.connect(
  mapStateToProps
)(Layout)
