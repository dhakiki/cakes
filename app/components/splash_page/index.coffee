react = require 'react'
redux = require 'redux'
reactRedux = require 'react-redux'
classnames = require 'classnames'
{button, div, select, span, option, ul, li, i, a} = react.DOM

class SplashPage extends react.Component

  render: ->
    div className: 'splash-page',
      div {}, 'hello!'

mapStateToProps = (state) =>
  status: state.status
  errMsg: state.errMsg
  info: state.info
  storeId: state.storeId

module.exports = reactRedux.connect(
  mapStateToProps
)(SplashPage)
