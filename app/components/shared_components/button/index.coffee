require './button.styl'
react = require 'react'
{div} = react.DOM

module.exports = (props) ->
  div className: 'button', onClick: props.onClick,
    props.children
