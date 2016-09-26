react = require 'react'
reactRedux = require 'react-redux'
{div, h2, h3, span} = react.DOM

require './cart.styl'

class Cart extends react.Component

  render: ->
    div className: 'cart',
      h3 {}, 'Cart'
      div {},
        span {}, @_generateSubtotalItems()
        span className: 'label', @_generateSubtotalValue()

  _generateSubtotalItems: ->
    numItems = @_fetchCartTotal()
    items = 'items'
    items = 'item' if numItems is 1
    "Subtotal (#{numItems} #{items}): "

  _generateSubtotalValue: ->
    total = 0
    @props.cart.forEach (item) ->
    @props.cart.toArray().forEach (cart) ->
      cart.forEach (item) ->
        total += parseInt item.get('price').slice 1
    "$#{total}"

  _fetchCartTotal: ->
    total = 0
    @props.cart.toArray().forEach (cart) -> total += cart.size
    total

mapStateToProps = (state) =>
  info: state.bakerInfo
  cart: state.cart

module.exports = reactRedux.connect(
  mapStateToProps
)(Cart)
