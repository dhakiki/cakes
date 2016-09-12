react = require 'react'
_ = require 'lodash'
reactRedux = require 'react-redux'
{div, i, h3, h2, h4, h5, ul, li, a, img, span} = react.DOM
{fetchPopularCakesData, fetchCategoryContent} = require '../../actions'

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
            div className: 'baker-header',
              div className: 'baker-info',
                img src: 'https://scontent.xx.fbcdn.net/v/t1.0-1/c1.0.50.50/p50x50/282553_232862060087690_4214243_n.jpg?oh=cba6f9958c46b7f70377114a4057e7a7&oe=584327FC'
                h3 className: 'baker-name',
                  @props.info.name
                @_renderSocialMediaNav()
                h4 {}, 'Popular Cakes'
                h5 {}, 'Select a Category'
            div className: 'accordion',
              @props.categories.map (category, index) =>
                div className: 'item', key: category.id,
                  span className: 'title link', onClick: (=> @_requestCategoryDetails category.id, index),
                    if @state.expandedIndeces.indexOf(index) isnt -1
                      i className: 'fa fa-caret-down'
                    else
                      i className: 'fa fa-caret-right'
                    span className: 'category', category.name
                  div className: 'content', ''
                    if @state.expandedIndeces.indexOf(index) isnt -1
                      switch @props.categoryContent?.getIn [@props.params.store_id, category.id, 'status']
                        when 'loading'
                          div {}, 'fetching content'
                        when 'error'
                          div {}, 'error loading content'
                        when undefined then ''
                        else
                          div className: 'category-items',
                            @props.categoryContent.getIn([@props.params.store_id, category.id, 'items']).map (item) ->
                              div className: 'category-item', key: item.id, onClick:(=> @_showDetailsModal item, category.id),
                                img src: item.img

  _renderSocialMediaNav: ->
    ul className: 'social-media-nav',
      li {},
        a className: 'link', href: "http://www.facebook.com/#{@props.info.facebook}", target: '_blank',
          i className: 'fa fa-facebook-official'
      li {},
        a className: 'link', href: "http://www.instagram.com/#{@props.info.instagram}", target: '_blank',
          i className: 'fa fa-instagram'
      li {},
        a className: 'link', href: "http://www.twitter.com/#{@props.info.twitter}", target: '_blank',
          i className: 'fa fa-twitter'

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
    @setState itemViewing: _.merge item, {categoryId}

mapStateToProps = (state) =>
  status: state.status
  info: state.info
  categories: state.categories
  categoryContent: state.categoryContent

module.exports = reactRedux.connect(
  mapStateToProps
)(PopularCakes)

