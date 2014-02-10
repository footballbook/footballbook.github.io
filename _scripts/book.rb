# encoding: utf-8


#####
# todo/fix: use constant to set  ./_pages   - output (root) folder for generated pages
# todo/fix: use constant to set layout  e.g. book


def build_book( opts={} )


  if opts[:inline].present?
    ## generate inline (all-in-one-page) version

    File.open( '_pages/book.md', 'w+' ) do |file|
      file.write  <<EOS
---
layout: book
title: Contents
permalink: /book.html
---

EOS
    end
  end


  build_page_toc( opts )
  
  
  # note: use same order as table of contents
  League.all.each do |league|
    next if league.events.count == 0

    league.events.each_with_index do |event,i|
       puts "  build event page [#{i+1}] #{event.key} #{event.title}..."
       build_page_for_event( event, opts )
    end
  end

  ## build_page_events( opts )


  # note: use same order as table of contents
  Continent.all.each do |continent|
    continent.countries.order(:title).each do |country|
      next if country.teams.count == 0   # skip country w/o teams

      puts "  build country page #{country.key}..."
      build_page_for_country( country, opts )
    end
  end

  build_page_teams_idx( opts )


end # method build_book

