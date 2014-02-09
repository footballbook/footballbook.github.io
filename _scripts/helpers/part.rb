# encoding: utf-8

##########################
# part helpers


#####
# todo: find a better name for ender_toc_countries ??


def render_toc_countries( countries, opts={} )
  buf = ''
  countries.each do |country|
    #<!-- fix: add to models -> countries_w_breweries_or_beers ?? -->
    # <!-- todo: use helper e.g. has_beers_or_breweries? or similar  ?? -->
    teams_count   = country.teams.count
    leagues_count = country.leagues.count
    ## events_count  = country.events.count  <!-- fix: add to sportdb gem -->
    
    # skip country w/o teams
    next if teams_count == 0 && leagues_count == 0
    
    buf << link_to_country( country, opts )
    buf << " -- "
    buf << "_#{teams_count} Teams_{:.count}"
    buf << ", _#{leagues_count} Leagues_{:.count} "   if leagues_count > 0
    buf << "  <br>"
    buf << "\n"
  end
  buf
end


def render_teams( teams, opts={} )
  buf = ''
  teams.each do |team|
    buf << render_team( team, opts )
  end
  buf
end


def render_team( team, opts={} )
  tmpl       = File.read_utf8( '_templates/shared/_team.md' )
  render_erb_template( tmpl, binding )
end

def render_team_idx( team, opts={} )
  tmpl       = File.read_utf8( '_templates/shared/_team-idx.md' )
  render_erb_template( tmpl, binding )
end
