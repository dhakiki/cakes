module.exports =
  entry: './app/index.coffee'

  output:
    path: 'output/',
    filename: 'bundle.js'
    publicPath: '/assets/'
  
  resolve:
    extensions: [''
                 '.coffee'
                 '.js'
                ]

  module:
    loaders: [
      {test: /\.coffee$/,     loader: 'coffee'}
      {test: /\.json$/,       loader: 'json'  }
      {test: /\.styl$/,       loader: 'style!css!stylus'}
      {test: /\.css$/,        loader: 'style!css'}
      {test: /\.font\.yml/,   loader: 'style!css!fontgen!yaml'}
    ]
