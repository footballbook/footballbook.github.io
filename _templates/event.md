
### {{ event.full_title }}


#### {{ event.teams.count }} Teams


{% event.teams.each_with_index do |team,i| %}
     {{ ' • ' if i > 0 }}  ++
     {{ team.title }}  ++ 
     {{ "(#{team.code})" if team.code.present? }}  ++
     {{ team.title2  if team.title2.present? }}  ++
      {# render_team_world_tree( team ) #}
{% end %}



{% if event.groups.count > 0 %}

#### {{ event.groups.count }} Groups

{% event.groups.each_with_index do |group,i| %}
     {{ ' • ' if i > 0 }}  ++
     {{ group.title }}
{% end %}


{% event.groups.each do |group| %}
| ++
  {{ group.title }} --   ++
| ++ 
  {% group.teams.each do |team| %} ++ 
    | ++
    {{ team.title }} ++ 
  {% end %} ++
|
{% end %}

{% end %} <!-- if event.groups.count > 0 -->



#### {{ event.games.count }} Games

{% event.rounds.each_with_index do |round,i| %}
  {{ ' • ' if i > 0 }}  ++
  .. <!-- fix: escape round starting w/ 1. -> gets turned into a list -->
  {{ round.title }}
{% end %}



{% event.rounds.each do |round| %}
| ++ 
   **{{ round.title }}** ++
   {{ "/ #{round.title2}" if round.title2.present? }} ++
|
.. <!-- new row -->
..
  {% round.games.each do |game| %}
  | ++
     {{ game.play_at.strftime('(%a) %-d/%b %Y %H:%M' ) }}  ++
  | ++
     {{ game.team1.title }}  ++
  | ++
     {{ game.score_str }}  ++
  | ++
     {{ game.team2.title }}   ++
  | ++
  {{ "(#{game.group.title})" if game.group.present? }}   ++
|
.. <!-- new row -->
..
  {% end %} <!-- games -->
{% end %} <!-- rounds -->
