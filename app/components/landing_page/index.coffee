react = require 'react'
classnames = require 'classnames'
{div, select, span, option} = react.DOM

class LandingPage extends react.Component

  render: ->
    div {}, 'i was wondering if after all these years youd like to meet'

module.exports = LandingPage
