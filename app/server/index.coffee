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

apiRouter.get '/:id/category_options/:cat_id', (req, res) ->
  obj =
    [
        name: 'Birthday Gal'
        id: '1'
        ingredients: 'Vanilla-Flavored Cake, Vanila-Flavored Buttercream'
        image_url: 'http://www.dgreetings.com/birthday/images/creative-birthday-cake-image.jpg'
        price: '$40'
        feedCount: '15-20'
      ,
        name: 'Chocolate Garden'
        id: '2'
        ingredients: 'Vanilla-Flavored Cake, Chocolate-Flavored Fondent'
        image_url: 'http://namebirthdaycakes.com/images/styles/new-arrival-happy-birthday-chocolate-cake-with-name-07f0.png'
        price: '$55'
        feedCount: '20-25'
      ,
        name: 'Rose Buttercream Classic'
        id: '3'
        ingredients: 'Vanilla-Flavored Cake, Vanilla-Flavored Buttercream'
        image_url: 'http://www.shopcreativegifts.com/cake-pink.gif'
        price: '$30'
        feedCount: '20-25'
      ,
        name: 'Chocolate Drip'
        id: '4'
        ingredients: 'Vanilla-Flavored Cake, Chocolate/Buttercream Exterior'
        image_url: 'http://mynamepix.com/images/styles/chocolate-birthday-cake-with-rose_name_pix_84a2.png'
        price: '$35'
        feedCount: '20-25'
    ]
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
          ,
            name: 'Baby Shower'
            id: '4'
          ,
            name: 'Bridal Shower'
            id: '5'
          ,
            name: 'Wedding'
            id: '6'
        ]
    res.json obj

app.use '/api', apiRouter
app.use '/', pageRouter
app.listen 3000
console.log 'Server listening on 3000'

