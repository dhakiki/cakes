react = require 'react'
reactRedux = require 'react-redux'
{div, i, span} = react.DOM
{fetchPopularCakesData, fetchCategoryContent} = require '../../actions'

PopularCakes = react.createClass
  getInitialState: ->
    expandedIndeces: []

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
                        @props.categoryContent.getIn [@props.params.store_id, category.id, 'items'].map (item) ->
                          div {}, 'stuff'

  _requestCategoryDetails: (id, index) ->
    updatedIndeces = @state.expandedIndeces
    existentIndex = updatedIndeces.indexOf index
    if existentIndex isnt -1
      updatedIndeces.splice existentIndex, 1
    else
      unless @props.categoryContent?.getIn [@props.params.store_id,id]
        @props.dispatch fetchCategoryContent @props.params.store_id, id
      updatedIndeces.push index
    @setState expandedIndeces: updatedIndeces

mapStateToProps = (state) =>
  status: state.status
  info: state.info
  categories: state.categories
  categoryContent: state.categoryContent

module.exports = reactRedux.connect(
  mapStateToProps
)(PopularCakes)

