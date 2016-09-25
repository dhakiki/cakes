react = require 'react'
reactRedux = require 'react-redux'
{div, h2, h3, span} = react.DOM

require './cart.styl'

class Cart extends react.Component

  render: ->
    console.log @props.cart
    div className: 'cart',
      h3 {}, 'Cart'
      div {},
        span {}, @_generateSubtotalItems()
        span className: 'label', @_generateSubtotalValue()

  _generateSubtotalItems: ->
    items = 'items'
    items = 'item' if @props.cart.size is 1
    "Subtotal (#{@props.cart.size} items): "

  _generateSubtotalValue: ->
    total = 0
    @props.cart.forEach (item) ->
      total += parseInt item.get('price').slice 1
    "#{total}"

mapStateToProps = (state) =>
  cart: state.cart

module.exports = reactRedux.connect(
  mapStateToProps
)(Cart)
