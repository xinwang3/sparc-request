if @type == 'Form'
  accessible_surveys = Form.for(current_user)
else
  accessible_surveys = SystemSurvey.for(current_user)
end

json.(@responses) do |response|
  srid = response.try(:respondable).try(:display_id) || response.try(:respondable).try(:protocol_id) || 'N/A'

  json.srid             srid == 'N/A' ? 'N/A' : link_to(srid, dashboard_protocol_path(srid.to_s.split('-').first), target: :_blank)
  json.short_title      response.try(:respondable).try(:protocol).try(:short_title) || 'N/A'
  json.primary_pi       response.try(:respondable).try(:protocol).try(:primary_principal_investigator).try(:full_name) || 'N/A'
  json.title            response.survey.full_title
  json.by               response.identity.try(:full_name) || 'N/A'
  json.complete         complete_display(response)
  json.completion_date  response.completed? ? format_date(response.created_at, html: true) : ""
  json.survey_sent_date format_date(response.updated_at, html: true)
  json.actions          response_options(response, accessible_surveys)
end
