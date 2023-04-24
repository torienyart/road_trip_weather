class ErrorSerializer
  include JSONAPI::Serializer

  attribute :errors do |object|
    errors = object.errors.map do |error|
      error.full_message
    end
  end

  def self.bad_request
    {errors: "Bad request, please check your location information and try again"}
  end
end