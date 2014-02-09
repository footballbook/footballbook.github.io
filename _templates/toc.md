# The Free World Football Almanac


## Table of Contents

[Leagues & Tournaments](#events) •
[World Tour](#tour) •
[A-Z Teams, Leagues & Tournaments](#az)


.. <!-- (re)use partial for events ??? -->

### Events _({{ Event.count }})_{: .count}
{: #events}

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
          {{ event.season.title }}  ++   <!-- fix: use link_to_event( event ) -->
   {% end %}  ++
| ++
    {% if league.country.present? %} ++
      {{ league.country.title }}  ++  <!-- fix: use link_to_country( league.country ) -->
      ({{ league.country.code }}) ++
    {% end %} ++
|
{% end %}
{% end %}




### World Tour
{: #tour}

{{ continents_navbar }}


{% Continent.all.each do |continent| %}


#### {{ continent.title }}
{: #{{ urlify( continent.title ) }} }

  {{ columns_begin( columns: 3 ) }}
  {{ render_toc_countries( continent.countries.order(:title), opts ) }}
  {{ columns_end() }}

{% end %}<!-- each continent -->


### A-Z Countries, Regions, Cities
{: #az}

<!-- fix: for all-in-one page version use/check opts :inline -->
[Teams A-Z Index](teams.html) _({{Country.count}})_{: .count} <br>

<!-- [Leagues & Tournaments A-Z Index](events.html) _({{Event.count}})_{: .count} <br> -->
