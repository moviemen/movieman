class Movieman.EpisodesController extends Movieman.ApplicationController
  routingKey: 'episodes'

  index: (params) ->
    @set('episodes', Movieman.Episode.get('all'))
