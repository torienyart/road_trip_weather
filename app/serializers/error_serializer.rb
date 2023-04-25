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

  def self.incorrect_password
    {errors: "Username and password are incorrect"}
  end

  def self.user_not_found
    {errors: "User does not exist, please register"}
  end

  def self.unauthorized
    {errors: "Invalid API Key"}
  end
end