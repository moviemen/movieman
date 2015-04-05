class Movieman.Favorite extends Batman.Model
  @resourceName: 'favorite'
  @storageKey:   'favorites'

  @persist Batman.RailsStorage

  # fields
  @encode 'name', 'url', 'photo', 'last_season', 'last_episode', 'updated_at'

  # validations
  @validate "name",         presence: true
  @validate "url",          presence: true
  @validate "photo",        presence: true
  @validate "last_season",  presence: true
  @validate "last_episode", presence: true
  @validate "updated_at",   presence: true
