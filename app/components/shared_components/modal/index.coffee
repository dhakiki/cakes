react = require 'react'
{div, i} = react.DOM
require './modal.styl'

module.exports = (props) ->
  div className: 'modal-container',
    div className: 'modal-mask', onClick: props.onClose
    div className: 'modal',
      div className: 'modal-header',
        props.title
        i className: 'fa fa-times close', onClick: props.onClose
      div className: 'modal-content',
        props.children
