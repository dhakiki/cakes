express = require 'express'
path = require 'path'

app = express()

app.set 'view engine', 'ejs'
app.set 'views', path.join(__dirname, '../')
app.get '*', (req, res) ->
  res.render 'index',
    publicPath: process.env.PUBLIC_PATH ? 'http://localhost:8080/assets/'

app.listen 3000
console.log 'Server listening on 3000'

