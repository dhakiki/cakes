react = require 'react'
redux = require 'redux'
reactRedux = require 'react-redux'
classnames = require 'classnames'
{button, img, div, h1, h3, h4, select, span, option, ul, li, i, a} = react.DOM

require './splash_page.styl'

class SplashPage extends react.Component

  render: ->
    div className: 'splash-page',
      div className: 'splash-page-content',
        h1 {}, 'Welcome to Cakes!'
        h4 {}, 'Where bakers offer cakes.'
        h3 {}, 'Select a participating baker to get started.'
        div className: 'bakers',
          div className: 'baker',
            a href: '/1/welcome',
              img src: 'https://scontent.xx.fbcdn.net/v/t1.0-1/c1.0.50.50/p50x50/282553_232862060087690_4214243_n.jpg?oh=cba6f9958c46b7f70377114a4057e7a7&oe=584327FC'

mapStateToProps = (state) =>
  status: state.status
  errMsg: state.errMsg
  info: state.info
  storeId: state.storeId

module.exports = reactRedux.connect(
  mapStateToProps
)(SplashPage)
