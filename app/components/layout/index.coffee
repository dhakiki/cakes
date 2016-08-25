require '../../styles'
react = require 'react'
classnames = require 'classnames'
{div, ul, li, select, span, option} = react.DOM

class Layout extends react.Component

  render: ->
    div {},
      div className: 'nav',
        div className: 'nav-contents',
          div className: 'nav-title', 'Doreen\'s Bakery'
          div className: 'nav-controls',
            ul {},
              li className: 'link', onClick: (=> console.log 'clicked'), 'Welcome, User!'
              li className: 'link', onClick: (=> console.log 'clicked'), 'Create an Account'
              li className: 'link', onClick: (=> console.log 'clicked'), 'Cart (0)'

      this.props.children

module.exports = Layout
