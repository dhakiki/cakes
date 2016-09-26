react = require 'react'
redux = require 'redux'
reactRedux = require 'react-redux'
classnames = require 'classnames'
{button, div, select, h3, h2, span, option, ul, li, i, a, img} = react.DOM
{fetchBakerLandingData} = require '../../actions'

require './baker_landing.styl'

class LandingPage extends react.Component

  componentWillMount: ->
    @props.dispatch fetchBakerLandingData @props.params.store_id

  render: ->
    div className: 'baker-landing',
      switch @props.status
        when 'error'
          div className: 'error-status',
            h2 {}, "Error: #{@props.errMsg}"
        when 'init', 'loading'
          div {}, 'loading data'
        else
          {name, website} = @props.info.get @props.params.store_id
          div className: 'baker-contents',
            div className: 'baker-header',
              div className: 'baker-info',
                img src: 'https://scontent.xx.fbcdn.net/v/t1.0-1/c1.0.50.50/p50x50/282553_232862060087690_4214243_n.jpg?oh=cba6f9958c46b7f70377114a4057e7a7&oe=584327FC'
                h3 className: 'baker-name', name
                @_renderSocialMediaNav()
                @_renderAddress()
                a className: 'link', href: "http://#{website}", target: '_blank', 'Visit Website'
              div className: 'baker-actions',
                div className: 'actions',
                  div className: 'options',
                    #TODO: fix url to point to root without hax
                    a className: classnames('action-item', 'link'), href: "http://localhost:3000/1/popular-cakes",
                      i className: 'fa fa-birthday-cake'
                    a className: classnames('action-item', 'link'), href: "http://localhost:3000/1/cake-builder",
                      i className: 'fa fa-heart-o'
                    a className: classnames('action-item', 'link'), href: "http://localhost:3000/1/custom-form",
                      i className: 'fa fa-camera'
            @_renderRecentWork()

  _renderSocialMediaNav: ->
    {facebook, instagram, twitter} = @props.info.get @props.params.store_id
    ul className: 'social-media-nav',
      li {},
        a className: 'link', href: "http://www.facebook.com/#{facebook}", target: '_blank',
          i className: 'fa fa-facebook-official'
      li {},
        a className: 'link', href: "http://www.instagram.com/#{instagram}", target: '_blank',
          i className: 'fa fa-instagram'
      li {},
        a className: 'link', href: "http://www.twitter.com/#{twitter}", target: '_blank',
          i className: 'fa fa-twitter'

  _renderAddress: ->
    {address1, address2, city, state, zip, hours, telephone} = @props.info.get @props.params.store_id
    div className: 'address',
      div {}, "#{address1} #{address2}"
      div {}, "#{city}, #{state} #{zip}"
      div {}, "Hours: #{hours}"
      div {}, "Tel: #{telephone}"

  _renderRecentWork: ->
    div className: 'recent-work',
      h3 {}, 'Recent Work'
      div className: 'baker-work',
        div className: 'recent-imgs',
          div className: 'image-sub'
          div className: 'image-sub'
          div className: 'image-sub'
          div className: 'image-sub'
          div className: 'image-sub'
          div className: 'image-sub'
          div className: 'image-sub'
          div className: 'image-sub'
          div className: 'image-sub'

mapStateToProps = (state) =>
  status: state.status
  errMsg: state.errMsg
  info: state.bakerInfo
  storeId: state.storeId

module.exports = reactRedux.connect(
  mapStateToProps
)(LandingPage)
