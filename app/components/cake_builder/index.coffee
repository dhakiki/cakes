react = require 'react'
{a, div, h1, h3, svg, ellipse, rect, i, span} = react.DOM
classNames = require 'classnames'
require './cake_builder.styl'

Button = react.createFactory require '../shared_components/button'
CakeViewer = react.createFactory require './cake_viewer/'
CakeBuilder = react.createClass
  getInitialState: ->
    step: 1

  render: ->
    div className: 'cake-builder main-content',
      @_renderStepViewer()
      @_renderStepContents()

  _renderStepViewer: ->
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
    switch @state.step
      when 1 then @_renderShapeSelector()
      when 2 then @_renderEditor()
      when 3 then @_renderReviewer()
    #svg className: 'test-svg',
    #  rect x: '9', y: '54', width: '102', height: '50', fill: 'green'
    #  ellipse cx:"60", cy:"60", rx:"50", ry:"25", stroke: 'green', strokeWidth: '4', fill: 'red'

  _renderEditor: ->
    console.log 'yo', @state.selectedShape
    div className: 'editor',
      div className: 'cake-editor',
        div className: 'cake-viewer'
        div className: 'cake-controls'
      div className: 'cake-customization',
        div className: 'customization-actions',
          div className: 'label', 'Actions'
          div className: 'actions',
            div {},
              Button {}, 'Add Garnish'
            div {},
              Button {}, 'Add Arrangement'
        div className: 'customization-selection',
          div className: 'label', 'Selected Garnishes'

  _renderShapeSelector: ->
    div className: 'shape-selector',
      h3 className: 'center', 'Please Select a Shape to Get Started'
      div className: 'shape link', onClick: (=> @_openEditor tier: 1, shape: 'circle'),
        i className: 'temp-cake fa fa-birthday-cake'
        div className: 'shape-label', 'One Tier (Circle)'
      div className: 'shape link', onClick: (=> @_openEditor tier: 1, shape: 'square'),
        i className: 'temp-cake fa fa-birthday-cake'
        div className: 'shape-label', 'One Tier (Square)'
      div className: 'shape link', onClick: (=> @_openEditor tier: 2, shape: 'circle'),
        i className: 'temp-cake fa fa-birthday-cake'
        div className: 'shape-label', 'Two Tier (Circle)'
      div className: 'shape link', onClick: (=> @_openEditor tier: 2, shape: 'square'),
        i className: 'temp-cake fa fa-birthday-cake'
        div className: 'shape-label', 'Two Tier (Square)'
      div className: 'shape link', onClick: (=> @_openEditor tier: 3, shape: 'circle'),
        i className: 'temp-cake fa fa-birthday-cake'
        div className: 'shape-label', 'Three Tier (Circle)'
      div className: 'shape link', onClick: (=> @_openEditor tier: 3, shape: 'square'),
        i className: 'temp-cake fa fa-birthday-cake'
        div className: 'shape-label', 'Three Tier (Square)'

  _openEditor: (selectedShape) ->
    @setState step: 2, selectedShape: selectedShape

  _renderReviewer: ->
    console.log 'go'

  _isStepComplete: (step) ->
    @state.step >= step

module.exports = CakeBuilder

