module JobBase
  def infer_postfix
    return '_dev' if %w[development test].include? Rails.env
    return '' if Rails.env == 'production'
    '_' + Rails.env
  end

  def infer_queue_name
    queue_name = name.gsub('::', '').demodulize.underscore.gsub('_job', '')
    queue_name + infer_postfix
  end
end
