class ErrorSerializer
  def self.bad_request
    {errors: "Bad request, please check your location information and try again"}
  end
end