unless Rails.env.production?
  # Set to something to trigger mobile
  ENV['IS_MOBILE'] = ""
  ENV['ANALYTICS_KEY'] = ""
end
