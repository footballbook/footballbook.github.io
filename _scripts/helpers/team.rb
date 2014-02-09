# encoding: utf-8

def team_title( team )   # team title plus synonyms if present
  buf = ''
  buf << team.title
  if team.synonyms.present?
    buf << ' • '
    buf << team.synonyms.gsub('|', ' • ')
  end
  buf
end
