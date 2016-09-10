react = require 'react'
{div} = react.DOM

class CakeBuilder extends react.Component
  render: ->
    div {}, 'Cake Builder'

module.exports = CakeBuilder

