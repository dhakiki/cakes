react = require 'react'
classnames = require 'classnames'
{div, select, span, option} = react.DOM

class Layout extends react.Component

  render: ->
    div {},
      div {}, 'hello.. its me'
      this.props.children

module.exports = Layout
