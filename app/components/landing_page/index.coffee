react = require 'react'
redux = require 'redux'
reactRedux = require 'react-redux'
classnames = require 'classnames'
{button, div, select, h3, h2, span, option, ul, li, i, a, img} = react.DOM
{fetchStoreData} = require '../../actions'

class LandingPage extends react.Component

  componentWillMount: ->
    @props.dispatch fetchStoreData @props.params.store_id


  render: ->
    div className: 'baker-landing',
      switch @props.status
        when 'error'
          div {},
            div {}, 'ERROR'
            div {}, @props.errMsg
        when 'init'
          div {}, 'loading data'
        else
          div className: 'baker-contents',
            div className: 'baker-header',
              div className: 'baker-info',
                img src: 'https://scontent.xx.fbcdn.net/v/t1.0-1/c1.0.50.50/p50x50/282553_232862060087690_4214243_n.jpg?oh=cba6f9958c46b7f70377114a4057e7a7&oe=584327FC'
                h3 {}, @props.info.name
                @_renderSocialMediaNav()
                @_renderAddress()
                a href: "http://#{@props.info.website}", target: '_blank', 'Visit Website'
              div className: 'baker-actions',
                div className: 'actions',
                  div className: 'options',
                    div className: 'action-item'
                    div className: 'action-item'
                    div className: 'action-item'
            @_renderRecentWork()

  _renderSocialMediaNav: ->
    ul className: 'social-media-nav',
      li {},
        a href: "http://www.facebook.com/#{@props.info.facebook}", target: '_blank',
          i className: 'fa fa-facebook-official'
      li {},
        a href: "http://www.instagram.com/#{@props.info.instagram}", target: '_blank',
          i className: 'fa fa-instagram'
      li {},
        a href: "http://www.twitter.com/#{@props.info.twitter}", target: '_blank',
          i className: 'fa fa-twitter'

  _renderAddress: ->
    div className: 'address',
      div {}, "#{@props.info.address1} #{@props.info.address2}"
      div {}, "#{@props.info.city}, #{@props.info.state} #{@props.info.zip}"
      div {}, "Hours: #{@props.info.hours}"

  _renderRecentWork: ->
    div className: 'recent-work',
      h3 {}, 'Recent Work'
      div className: 'baker-work',
        div className: 'recent-imgs',
          div className: 'image-sub'
          div className: 'image-sub'
          div className: 'image-sub'
          div className: 'image-sub'

mapStateToProps = (state) =>
  status: state.status
  errMsg: state.errMsg
  info: state.info
  storeId: state.storeId

module.exports = reactRedux.connect(
  mapStateToProps
)(LandingPage)
