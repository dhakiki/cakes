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


# TODO: remove this once you get middleware
# middleware that is specific to this router
apiRouter.use (req, res, next) ->
  console.log 'Time: ', Date.now()
  next()

apiRouter.get '/:id/baker_info', (req, res) ->
  #TODO: remove ID hax
  if req.params.id isnt "1"
    res.status(500).send 'Baker not found'
  else
    obj =
      info:
        name: 'Lady M Cake Boutique'
        address1: '400 S Woodbury Rd'
        address2: '#101'
        city: 'Los Angeles'
        state: 'CA'
        zip: '90024'
        hours: 'M-Sat 9AM - 6PM, Sun 11AM - 5PM'
        website: 'www.ladym.com'
        instagram: 'ladymcakes'
        facebook: 'ladymcakeboutique'
        twitter: 'ladymcakes'
        telephone: '(800) 867-5309'
    res.json obj

apiRouter.get '/:id/popular_categories', (req, res) ->
  console.log 'params', req.params
  #TODO: remove ID hax
  if req.params.id isnt "1"
    res.status(500).send 'Baker not found'
  else
    obj =
      categories:
        [
            name: 'Birthday (Kids - Boy)'
            id: '1'
          ,
            name: 'Birthday (Kids - Girl)'
            id: '2'
          ,
            name: 'Bat Mitzvah'
            id: '3'
        ]
    res.json obj

app.use '/api', apiRouter
app.use '/', pageRouter
app.listen 3000
console.log 'Server listening on 3000'

