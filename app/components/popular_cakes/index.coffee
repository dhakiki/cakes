react = require 'react'
_ = require 'lodash'
reactRedux = require 'react-redux'
{div, i, h3, h2, h4, h5, ul, li, a, img, span} = react.DOM
{addItemToCart, fetchPopularCakesData, fetchCategoryContent} = require '../../actions'

Immutable = require 'immutable'

require './popular_cakes.styl'

Modal = react.createFactory require '../shared_components/modal'
Button = react.createFactory require '../shared_components/button'

PopularCakes = react.createClass
  getInitialState: ->
    expandedIndeces: []
    itemViewing: undefined

  componentWillMount: ->
    @props.dispatch fetchPopularCakesData @props.params.store_id

  render: ->
    div className: 'popular-cakes',
      switch @props.status
        when 'error'
          div className: 'error-status',
            h2 {}, "Error: #{@props.errMsg}"
        when 'init', 'loading'
          div {}, 'loading data'
        else
          div className: 'baker-contents',
            @_renderBakerHeader()
            @_renderCategories()

  _renderCategories: ->
    div className: 'categories-container',
      h4 {}, 'Popular Cakes'
      h5 {}, 'Select a Category'
      div className: 'accordion',
        @props.categories.map (category, index) =>
          div className: 'item', key: category.id,
            span className: 'title link', onClick: (=> @_requestCategoryDetails category.id, index),
              if @_isExpanded index
                i className: 'fa fa-caret-down'
              else
                i className: 'fa fa-caret-right'
              span className: 'category', category.name
            div className: 'content', ''
              if @_isExpanded index
                switch @_getCategoryData category.id, 'status'
                  when 'loading'
                    div {}, 'fetching content'
                  when 'error'
                    div {}, 'error loading content'
                  else
                    div className: 'category-items',
                      @_getCategoryData(category.id, 'items').map (item) =>
                        div className: 'category-item link', key: item.id, onClick:(=> @_showDetailsModal item, category.id),
                          img src: item.image_url
      @_renderDetailsModal() if @state.itemViewing

  _renderDetailsModal: ->
    {image_url, price, name, id, feedCount, ingredients} = @state.itemViewing.toJS()
    Modal title: 'Item Details', onClose: @_clearItemViewing,
      img src: image_url
      div className: 'item-details',
        h3 {}, name
        div {},
          span className: 'label', 'Cost: '
          span {}, price
        div {},
          span className: 'label', 'Ingredients: '
          span {}, ingredients
        div {},
          span className: 'label', 'Feeds: '
          span {}, feedCount
        Button onClick: @_addViewingItemToCart, 'Add to Cart'

  _addViewingItemToCart: ->
    itemExistsInCart = @props.cart.get(@props.params.store_id)?.filter (item) =>
      Immutable.is item, @state.itemViewing
    @props.dispatch addItemToCart @props.params.store_id, @state.itemViewing unless itemExistsInCart?.size
    @setState itemViewing: undefined

  _clearItemViewing: ->
    @setState itemViewing: undefined

  _isExpanded: (index) ->
    @state.expandedIndeces.indexOf(index) isnt -1

  _getCategoryData: (id, item) ->
    @props.categoryContent?.getIn [@props.params.store_id, id, item]

  _renderBakerHeader: ->
    {name, website} = @props.info.get @props.params.store_id
    div className: 'baker-header',
      div className: 'logo', style: background: 'url(http://www.womensmafia.com/wp-content/uploads/2011/12/Lady-M-Logo-JPEG.jpg)', ''
      div className: 'baker-info',
        h3 className: 'baker-name', name
        @_renderSocialMediaNav()
        @_renderAddress()
        a className: 'link', href: "http://#{website}", target: '_blank', 'Visit Website'

  _renderSocialMediaNav: ->
    {facebook, instagram, twitter} = @props.info.get @props.params.store_id
    ul className: 'social-media-nav',
      li {},
        a className: 'link', href: "http://www.facebook.com/#{facebook}", target: '_blank',
          i className: 'fa fa-facebook-official'
      li {},
        a className: 'link', href: "http://www.instagram.com/#{instagram}", target: '_blank',
          i className: 'fa fa-instagram'
      li {},
        a className: 'link', href: "http://www.twitter.com/#{twitter}", target: '_blank',
          i className: 'fa fa-twitter'

  _renderAddress: ->
    {address1, address2, city, state, zip, hours, telephone} = @props.info.get @props.params.store_id
    div className: 'address',
      div {}, "#{address1} #{address2}"
      div {}, "#{city}, #{state} #{zip}"
      div {}, "Hours: #{hours}"
      div {}, "Tel: #{telephone}"

  _requestCategoryDetails: (id, index) ->
    updatedIndeces = @state.expandedIndeces
    existentIndex = updatedIndeces.indexOf index
    if existentIndex isnt -1
      updatedIndeces.splice existentIndex, 1
    else
      unless @props.categoryContent?.getIn [@props.params.store_id, id]
        @props.dispatch fetchCategoryContent @props.params.store_id, id
      updatedIndeces.push index
    @setState expandedIndeces: updatedIndeces

  _showDetailsModal: (item, categoryId) ->
    @setState itemViewing: Immutable.fromJS _.merge item, {categoryId}

mapStateToProps = (state) =>
  info: state.bakerInfo
  cart: state.cart
  categories: state.categories
  categoryContent: state.categoryContent
  status: state.status

module.exports = reactRedux.connect(
  mapStateToProps
)(PopularCakes)

