react = require 'react'
classnames = require 'classnames'
{div, select, span, option} = react.DOM

class LandingPage extends react.Component

  render: ->
    div {},
      div {}, 'i was wondering if after all these years youd like to meet'
      div {}, 'to go over.. everything..'
      div {}, 'they say that time'

module.exports = LandingPage
