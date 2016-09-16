react = require 'react'
{div, i} = react.DOM
require './modal.styl'

#TODO: figure out how to prevent modal clicks from closing the modal
module.exports = (props) ->
  div className: 'modal-background',
    div className: 'modal',
      div className: 'modal-header',
        props.title
        i className: 'fa fa-times close', onClick: props.onClose
      div className: 'modal-content',
        props.children
