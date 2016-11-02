react = require 'react'
{a, div, h1, h3, svg, ellipse, rect, i, span} = react.DOM
classNames = require 'classnames'

require './cake_viewer.styl'

CakeViewer = react.createClass

  render: ->
    div {}, 'hi'

module.exports = CakeViewer
