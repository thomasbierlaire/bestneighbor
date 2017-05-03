# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.bestneighbor.fr"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add new_user_session_path
  add user_session_path

  add choix_path

  add listes_path
  add new_liste_path

  Liste.find_each do |liste|
    add liste_path(liste), :lastmod => liste.updated_at
  end

  add trajets_path
  add new_trajet_path

  Trajet.find_each do |trajet|
    add trajet_path(trajet), :lastmod => trajet.updated_at
  end

  add aide_path
  add cgu_path

end
