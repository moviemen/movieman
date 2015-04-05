class Movieman.FavoritesController extends Movieman.ApplicationController
  routingKey: 'favorites'

  index: (params) ->
    @set('favorites', Movieman.Favorite.get('all'))
