react = require 'react'
reactRedux = require 'react-redux'
classnames = require 'classnames'
{div, ul, li, select, span, option} = react.DOM

require './layout.styl'

class Layout extends react.Component

  componentWillMount: ->
    @_resetCartOnLocal()

  render: ->
    div className: 'app-container',
      div className: 'nav',
        div className: 'nav-contents',
          div className: 'nav-title',
            @props.info.name if @props.status is 'loaded'
          div className: 'nav-controls',
            ul {},
              li className: 'link', 'Welcome, User!'
              li className: 'link', onClick: (=> console.log 'clicked'), 'Create an Account'
              li className: 'link', onClick: (=> console.log 'clicked'), "Cart (#{@_gatherCartCount()})"

      div className: 'app-contents',
        this.props.children

  _gatherCartCount: ->
    JSON.parse(localStorage.cakesCart).length

  _resetCartOnLocal: ->
    localStorage.setItem 'cakesCart', JSON.stringify []

mapStateToProps = (state) =>
  status: state.status
  info: state.info
  storeId: state.storeId

module.exports = reactRedux.connect(
  mapStateToProps
)(Layout)
