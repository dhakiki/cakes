react = require 'react'
redux = require 'redux'
reactRedux = require 'react-redux'
classnames = require 'classnames'
{button, div, select, span, option} = react.DOM
{increment, decrement} = require '../../actions'

class LandingPage extends react.Component

  componentWillMount: ->
    @props.dispatch type: 'fetchStoreData', data: @props.params.store_id

  render: ->
    div {},
      console.log 'STATUS', @props.status
      console.log 'COUNTER', @props.counter
      console.log 'INFO', @props.info
      switch @props.status
        when 'error'
          div {},
            div {}, 'ERROR'
            div {}, @props.errMsg
        else
          div {},
            div {}, @props.counter
            button onClick: @_increment, '+'
            button onClick: @_decrement, '-'
            div {}, @props.info

  _increment: =>
    @props.dispatch increment

  _decrement: =>
    @props.dispatch increment

mapStateToProps = (state) =>
  console.log 'STATE', state
  counter: state.counter
  status: state.status
  errMsg: state.errMsg
  info: state.info
  storeId: state.storeId

module.exports = reactRedux.connect(
  mapStateToProps
)(LandingPage)
