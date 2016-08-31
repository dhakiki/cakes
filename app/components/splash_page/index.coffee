react = require 'react'
redux = require 'redux'
reactRedux = require 'react-redux'
classnames = require 'classnames'
{button, div, h1, h3, h4, select, span, option, ul, li, i, a} = react.DOM

class SplashPage extends react.Component

  render: ->
    div className: 'splash-page',
      div className: 'splash-page-content',
        h1 {}, 'Welcome to Cakes!'
        h4 {}, 'Where bakers offer cakes.'
        h3 {}, 'Select a participating baker to get started.'

mapStateToProps = (state) =>
  status: state.status
  errMsg: state.errMsg
  info: state.info
  storeId: state.storeId

module.exports = reactRedux.connect(
  mapStateToProps
)(SplashPage)
