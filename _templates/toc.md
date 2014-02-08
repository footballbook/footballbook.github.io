# The Free World Football Almanac


## Table of Contents

[World Tour](#tour) • [A-Z Teams, Leagues & Tournaments](#az)



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
[Leagues & Tournaments A-Z Index](events.html) _({{Event.count}})_{: .count} <br>
