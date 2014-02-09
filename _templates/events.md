## Events _({{ Event.count }})_{: .count}


{% League.all.each do |league|
   if league.events.count > 0 %}
| ++
  _{{ league.key }}_{: .key} ++
| ++
   {{ league.title }} ++
| ++
   _({{ league.events.count }})_{: .count}  ++
| ++
   {% league.events.each_with_index do |event,index| %} ++
          {{ '•' if index > 0 }} ++
          {{ event.title }}  ++   <!-- fix: use link_to_event( event ) -->
   {% end %}  ++
| ++
    {% if league.country.present? %} ++
      {{ league.country.title }}  ++  <!-- fix: use link_to_country( league.country ) -->
      ({{ league.country.code }}) ++
    {% end %} ++
|
{% end %}
{% end %}
