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
              div className: 'logo', style: background: 'url(http://www.womensmafia.com/wp-content/uploads/2011/12/Lady-M-Logo-JPEG.jpg)', ''
              div className: 'baker-info',
                h3 className: 'baker-name', name
                @_renderSocialMediaNav()
                @_renderAddress()
                a className: 'link', href: "http://#{website}", target: '_blank', 'Visit Website'
            div className: 'baker-actions',
              div className: 'actions',
                a className: classnames('action-item', 'link'), href: "/1/popular-cakes",
                  div className: 'action-icon',
                    i className: 'fa fa-birthday-cake'
                  div className: 'label', 'View Popular Cakes'
                a className: classnames('action-item', 'link'), href: "/1/cake-builder/1",
                  div className: 'action-icon',
                    i className: 'fa fa-heart-o'
                  div className: 'label', 'Cake Builder'
                a className: classnames('action-item', 'link'), href: "/1/custom-form",
                  div className: 'action-icon',
                    i className: 'fa fa-camera'
                  div className: 'label', 'Send Custom Form'
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
