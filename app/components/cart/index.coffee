react = require 'react'
reactRedux = require 'react-redux'
{a, div, h2, h3, h4, i, img, input, span} = react.DOM
{fetchBakerLandingData, removeItemFromCart} = require '../../actions'

require './cart.styl'

Cart = react.createClass

  componentWillMount: ->
    storeIds = Object.keys @props.cart.toJS()
    #TODO: make this less hackey after MVP by allowing multiple store requests
    storeIds.map (storeId) =>
      @props.dispatch fetchBakerLandingData storeId unless @props.info.get storeId

  render: ->
    div className: 'cart',
      switch @props.status
        when 'error'
          div className: 'error-status',
            h2 {}, "Error: #{@props.errMsg}"
        when 'init', 'loading'
          div {}, 'loading data'
        else
          h3 {}, 'Cart'
          div {},
            span {}, @_generateSubtotalItems()
            span className: 'label', @_generateSubtotalValue()
            div className: 'cart-content', @_renderCartContent()

  _renderCartContent: ->
    storeIds = Object.keys @props.cart.toJS()
    storeIds.map (storeId, index) =>
      div className: 'baker-cart', key: index,
        a href: '/1/welcome',
          h3 {}, @props.info.get(storeId).name
        div className: 'baker-cart-items',
          @props.cart.get(storeId).map (item, index) =>
            @_renderCartItem item, storeId, index

  _renderCartItem: (item, storeId, index) ->
    div className: 'cart-item', key: index,
      div className: 'item-category image',
        img src: item.get 'image_url'
      @_renderDescription item
      @_renderConfiguration item
      @_renderAction storeId, item

  _renderDescription: (item) ->
    div className: 'item-category description',
      div {}, item.get 'name'
      div {},
        span className: 'label', 'Cost: '
        span {}, item.get 'price'
      div {},
        span className: 'label', 'Feeds: '
        span {}, item.get 'feedCount'

  _renderConfiguration: (item) ->
    div className: 'item-category configuration',
      div {},
        div className: 'label', 'Personalize Message'
        span {},
          input type: 'text'
        div className: 'label', 'Location'
        div {},
          span className: 'loc-option',
            input type: 'radio', value: 'base'
            span {}, 'Base'
          span className: 'loc-option',
            input type: 'radio', value: 'cake'
            span {}, 'Cake'

  _renderAction: (storeId, item) ->
    div className: 'item-category action link', onClick: (=> @_deleteFromCart item, storeId),
      i className: 'fa fa-trash'
      div className: 'label', 'Delete'

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

  _deleteFromCart: (item, storeId) ->
    @props.dispatch removeItemFromCart storeId, item

mapStateToProps = (state) =>
  info: state.bakerInfo
  cart: state.cart
  status: state.status

module.exports = reactRedux.connect(
  mapStateToProps
)(Cart)
