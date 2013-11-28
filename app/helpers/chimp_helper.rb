module ChimpHelper
  def form_error model, field 
    if model.errors[field].any?
      error = model.errors[field].first
      "<span class='error'><strong>Error:</strong> <span class='mensaje'>#{error}</span></span>".html_safe
    end
  end
end
