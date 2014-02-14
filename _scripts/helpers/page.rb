# encoding: utf-8

##########################
# page helpers


def render_cover( opts={} )
  tmpl       = File.read_utf8( '_templates/cover.md' )
  text = ''
  text << render_frontmatter( opts[:frontmatter] )   if opts[:frontmatter]
  text << render_erb_template( tmpl, binding )
  text
end

def render_about( opts={} )
  tmpl       = File.read_utf8( '_templates/about.md' )
  text = ''
  text << render_frontmatter( opts[:frontmatter] )   if opts[:frontmatter]
  text << render_erb_template( tmpl, binding )
  text
end


def render_events( opts={} )
  tmpl       = File.read_utf8( '_templates/events.md' )
  text = ''
  text << render_frontmatter( opts[:frontmatter] )   if opts[:frontmatter]
  text << render_erb_template( tmpl, binding )
  text
end


def render_event( event, opts={} )
  tmpl       = File.read_utf8( '_templates/event.md' )
  text = ''
  text << render_frontmatter( opts[:frontmatter] )  if opts[:frontmatter]
  text << render_erb_template( tmpl, binding )
  text
end


def render_country( country, opts={} )
  tmpl       = File.read_utf8( '_templates/country.md' )
  text = ''
  text << render_frontmatter( opts[:frontmatter] )  if opts[:frontmatter]
  text << render_erb_template( tmpl, binding )
  text
end

def render_toc( opts={} )
  tmpl = File.read_utf8( '_templates/toc.md' )
  text = ''
  text << render_frontmatter( opts[:frontmatter] )  if opts[:frontmatter]
  text << render_erb_template( tmpl, binding )
  text
end


def render_teams_idx( opts={} )
  tmpl = File.read_utf8( '_templates/teams-idx.md' )
  text = ''
  text << render_frontmatter( opts[:frontmatter] )  if opts[:frontmatter]
  text << render_erb_template( tmpl, binding )
  text
end
