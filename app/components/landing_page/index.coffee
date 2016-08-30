react = require 'react'
redux = require 'redux'
reactRedux = require 'react-redux'
classnames = require 'classnames'
{button, div, select, span, option, ul, li, i, a} = react.DOM

class LandingPage extends react.Component

  componentWillMount: ->
    @props.dispatch type: 'fetchStoreData', data: @props.params.store_id

  render: ->
    div {},
      switch @props.status
        when 'error'
          div {},
            div {}, 'ERROR'
            div {}, @props.errMsg
        when 'init'
          div {}, 'loading data'
        else
          div {},
            div {}, @props.info.name
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
            div {}, "#{@props.info.address1} #{@props.info.address2}"
            div {}, "#{@props.info.city}, #{@props.info.state} #{@props.info.zip}"
            div {}, "Hours: #{@props.info.hours}"
            a href: "http://#{@props.info.website}", target: '_blank', 'Visit Website'

mapStateToProps = (state) =>
  status: state.status
  errMsg: state.errMsg
  info: state.info
  storeId: state.storeId

module.exports = reactRedux.connect(
  mapStateToProps
)(LandingPage)
