express = require 'express'
apiRouter = express.Router()
pageRouter = express.Router()
path = require 'path'

app = express()

app.set 'view engine', 'ejs'
app.set 'views', path.join(__dirname, '../')

pageRouter.get '*', (req, res, next) ->
  res.render 'index',
    publicPath: process.env.PUBLIC_PATH ? 'http://localhost:8080/assets/'


# middleware that is specific to this router
apiRouter.use (req, res, next) ->
  console.log 'Time: ', Date.now()
  next()

# define the home page route
apiRouter.get '/', (req, res) ->
  console.log 'load'
  res.send 'root thingz'

# define the about route
apiRouter.get '/popular', (req, res) ->
  console.log 'welcome'
  res.send 'popular cake thingz'

# define the about route
apiRouter.get '/baker_info', (req, res) ->
  console.log 'baker info', req
  console.log req.headers.id
  #TODO: remove ID hax
  if req.headers.id isnt "1"
    res.status(500).send 'Baker not found'
  else
    res.json info: 'cake info thingz'

app.use '/api', apiRouter
app.use '/', pageRouter
app.listen 3000
console.log 'Server listening on 3000'

