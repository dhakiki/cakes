react = require 'react'
redux = require 'redux'
reactRedux = require 'react-redux'
classnames = require 'classnames'
{button, div, select, span, option, ul, li} = react.DOM
{increment, decrement} = require '../../actions'

class LandingPage extends react.Component

  componentWillMount: ->
    @props.dispatch type: 'fetchStoreData', data: @props.params.store_id

  render: ->
    div {},
      switch @props.status
        when 'error'
          div {},
            div {}, 'ERROR'
            div {}, @props.errMsg
        when 'init'
          div {}, 'loading data'
        else
          div {},
            div {}, @props.counter
            button onClick: @_increment, '+'
            button onClick: @_decrement, '-'
            div {}, @props.info.name
            ul {},
              li {}, @props.info.facebook
              li {}, @props.info.instagram
              li {}, @props.info.twitter
            div {}, "#{@props.info.address1} #{@props.info.address2}"
            div {}, "#{@props.info.city}, #{@props.info.state} #{@props.info.zip}"
            div {}, "Hours: #{@props.info.hours}"
            div {}, @props.info.website

  _increment: =>
    @props.dispatch increment

  _decrement: =>
    @props.dispatch increment

mapStateToProps = (state) =>
  counter: state.counter
  status: state.status
  errMsg: state.errMsg
  info: state.info
  storeId: state.storeId

module.exports = reactRedux.connect(
  mapStateToProps
)(LandingPage)
