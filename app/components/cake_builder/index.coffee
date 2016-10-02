react = require 'react'
{div, h1, svg, ellipse, rect} = react.DOM
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
    svg className: 'test-svg',
      rect x: '9', y: '54', width: '102', height: '50', fill: 'green'
      ellipse cx:"60", cy:"60", rx:"50", ry:"25", stroke: 'green', strokeWidth: '4', fill: 'red'


  _isStepComplete: (step) ->
    parseInt(@props.params.step_num) >= step

module.exports = CakeBuilder

