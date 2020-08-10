module ApplicationHelper

  def in_namespace?(request, namespace)
    fullpath = remove_http_prefix(request.fullpath)
    first_path_from(fullpath) == namespace
  end

private

  def remove_http_prefix(request_fullpath)
    request_fullpath.sub(/^(http|https):\/\/[^\/]+\//, '')
  end

  def first_path_from(fullpath)
    fullpath.split(/\//).reject(&:empty?).first
  end

end
