#
# A module to add a utility function to cover inputs that may refer
# to an object or a property on that object, when it is the property
# that is actually wanted.
#
module GetOrUse

  def get_or_use(obj, method)
    obj.respond_to?(method) ? obj.send(method) : obj
  end

end
