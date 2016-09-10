react = require 'react'
reactRedux = require 'react-redux'
{div} = react.DOM
{testEverything} = require '../../actions'

class PopularCakes extends react.Component
  componentWillMount: ->
    @props.dispatch testEverything @props.params.store_id

  componentWillReceiveProps: (nextProps) ->
    console.log {nextProps}

  render: ->
    div className: 'popular-cakes',
      #console.log @props.status, 'heywill'
      switch @props.status
        when 'error'
          div className: 'error-status',
            h2 {}, "Error: #{@props.errMsg}"
        when 'init', 'loading'
          div {}, 'loading data'
        else
          #console.log 'rendering', @props
          div {}, @props.categories[0].name

mapStateToProps = (state) =>
  console.log 'updating', state
  Object.assign {}, state,
    status: state.status
    info: state.info
    categories: state.categories

# TODO: figure out how to subscribe to diff component's store
module.exports = reactRedux.connect(
  mapStateToProps
)(PopularCakes)

