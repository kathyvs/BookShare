module GetOrUse

  def get_or_use(obj, method)
    obj.respond_to?(method) ? obj.send(method) : obj
  end

end
