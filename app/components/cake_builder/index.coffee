react = require 'react'
{div, h1} = react.DOM
classNames = require 'classnames'
require './cake_builder.styl'

class CakeBuilder extends react.Component
  render: ->
    div className: 'cake-builder main-content',
      @_renderStepViewer()
      @_renderStepContents()

  _renderStepViewer: ->
    console.log @props.params.step_num
    div className: 'step-viewer',
      div className: 'steps-visual',
        div className: classNames('step', filled: @_isStepComplete(1)), 1
        div className: classNames('step', filled: @_isStepComplete(2)), 2
        div className: classNames('step', filled: @_isStepComplete(3)), 3
      div className: 'steps-text',
        div className: 'step-text label', 'Select Shape'
        div className: 'step-text label', 'Build Cake'
        div className: 'step-text label', 'Review'

  _renderStepContents: ->
    console.log 'hi'

  _isStepComplete: (step) ->
    parseInt(@props.params.step_num) >= step

module.exports = CakeBuilder

