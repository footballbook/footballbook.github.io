# encoding: utf-8

# world book build script
#
#  run from book folder e.g. issue:
#   $ ruby _scripts/build.rb


# -- ruby std libs

require 'erb'

# -- 3rd party gems

require 'worlddb'   ### NB: for local testing use rake -I ./lib dev:test e.g. do NOT forget to add -I ./lib
require 'sportdb'
require 'logutils/db'


# -- custom code

require_relative 'helpers/link'
require_relative 'helpers/markdown'
require_relative 'helpers/navbar'
require_relative 'helpers/part'
require_relative 'helpers/misc'
require_relative 'helpers/city'
require_relative 'helpers/team'
require_relative 'helpers/page'


require_relative 'filters'
require_relative 'utils'



puts 'Welcome'



puts "Dir.pwd: #{Dir.pwd}"

# --  db config
FOOTBALL_DB_PATH = "../build/build/football.db"


LogUtils::Logger.root.level = :info

DB_CONFIG = {
  adapter:    'sqlite3',
  database:   FOOTBALL_DB_PATH
}

pp DB_CONFIG
ActiveRecord::Base.establish_connection( DB_CONFIG )


WorldDb.tables
SportDb.tables


### model shortcuts

Continent = WorldDb::Model::Continent
Country   = WorldDb::Model::Country
Region    = WorldDb::Model::Region
City      = WorldDb::Model::City

Team      = SportDb::Model::Team
League    = SportDb::Model::League
Event     = SportDb::Model::Event
Game      = SportDb::Model::Game


#####
# todo/fix: use constant to set  ./_pages   - output (root) folder for generated pages
# todo/fix: use constant to set layout  e.g. book


####################################
# 1) generate multi-page version




def build_book

### generate events index

File.open( '_pages/events.md', 'w+') do |file|
  file.write render_events( frontmatter: <<EOS )
---
layout: book
title: Contents
permalink: /events.html
---

EOS
end


### generate event pages

Event.all.each do |event|
  puts " build event page #{event.key} #{event.title}..."

  key = event.key.gsub( '/', '_' )

  File.open( "_pages/events/#{key}.md", 'w+') do |file|
    file.write render_event( event, frontmatter: <<EOS )
---
layout: book
title: #{event.title}
permalink: /#{key}.html
---

EOS
  end
end


### generate teams a-z index

File.open( '_pages/teams.md', 'w+') do |file|
  file.write render_teams_idx( frontmatter: <<EOS )
---
layout: book
title: Contents
permalink: /teams.html
---

EOS
end


### generate table of contents (toc)

File.open( '_pages/index.md', 'w+') do |file|
  file.write render_toc( frontmatter: <<EOS )
---
layout: book
title: Contents
permalink: /index.html
---

EOS
end


### generate pages for countries

# Country.where( "key in ('at','mx','hr', 'de', 'be', 'nl', 'cz')" ).each do |country|
Country.all.each do |country|
  next if country.teams.count == 0   # skip country w/o teams

  puts "build country page #{country.key}..."

  path = country_to_md_path( country )
  puts "path=#{path}"
  File.open( "_pages/teams/#{path}", 'w+') do |file|
    file.write render_country( country, frontmatter: <<EOS )
---
layout:    book
title:     #{country.title} (#{country.code})
permalink: /#{country.key}.html
---

EOS
  end

end

end # method build_book



##########################################
# 2) generate all-in-one-page version

def build_book_all_in_one

book_text = <<EOS
---
layout: book
title: Contents
permalink: /book.html
---

EOS

book_text += render_toc( inline: true )

### generate event pages
# note: use same order as table of contents

League.all.each do |league|
  next if league.events.count == 0

  book_text += <<EOS

---------------------------------------

EOS

  league.events.each_with_index do |event,i|
    puts " build event page #{event.key} #{event.title}..."
    book_text += render_event( event )
  end
end


### generate pages for countries
# note: use same order as table of contents

Continent.all.each do |continent|
  continent.countries.order(:title).each do |country|
    next if country.teams.count == 0   # skip country w/o teams

    puts "build country page #{country.key}..."

    book_text += <<EOS

---------------------------------------

EOS

    book_text += render_country( country )
  end
end


#### add team a-z index

book_text += render_teams_idx()



File.open( '_pages/book.md', 'w+') do |file|
  file.write book_text
end

end # method build_book_all_in_one


build_book()
build_book_all_in_one()


puts 'Done. Bye.'