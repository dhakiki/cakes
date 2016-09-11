react = require 'react'
reactRedux = require 'react-redux'
{div} = react.DOM
{fetchPopularCakesData} = require '../../actions'

class PopularCakes extends react.Component
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
          div {},
            @props.categories.map (category) ->
              div key: category.id, category.name

mapStateToProps = (state) =>
  status: state.status
  info: state.info
  categories: state.categories

module.exports = reactRedux.connect(
  mapStateToProps
)(PopularCakes)

