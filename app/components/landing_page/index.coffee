react = require 'react'
redux = require 'redux'
reactRedux = require 'react-redux'
classnames = require 'classnames'
{button, div, select, span, option} = react.DOM

class LandingPage extends react.Component

  render: ->
    div {},
      console.log this.props
      div {}, this.props.counter
      button onClick: @_increment, '+'
      button onClick: @_decrement, '-'
      div {}, 'i was wondering if after all these years youd like to meet'
      div {}, 'to go over.. everything..'
      div {}, 'they say that time'

  _increment: =>
    @props.dispatch type: 'INCREMENT'

  _decrement: =>
    @props.dispatch type: 'DECREMENT'

mapStateToProps = (state) =>
  counter: state

module.exports = reactRedux.connect(
  mapStateToProps
)(LandingPage)
