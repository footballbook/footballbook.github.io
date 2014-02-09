..
..
{{ team_title( team ) }}  ++
{{ " (#{team.code})" if team.code.present? }} ++
_#{{ team.key }}_{: .key} <br>
{: .team #{{team.key}} }
