class ApplicationController < ActionController::API

  def secret_key
    ENV['SECRET_KEY']
  end

  def authorization_token
    token = request.headers["Authorization"]
  end

  def decoded_token
    begin
      return JWT.decode authorization_token(), secret_key(), true
    rescue JWT::VerificationError, JWT::DecodeError
      return nil
    end
  end

  def valid_token?
    !!authenticate
  end

  def requires_login
    if !valid_token?
      render json: {
        message: "Nah, not it"
      }, status: :unauthorized
    end
  end

  def payload(user, id)
    { user: UserSerializer, id: id }
  end

  def get_token(payload)
    JWT.encode payload, secret_key(), 'HS256'
  end

  def authenticate
    begin
      decoded = JWT.decode(authorization_token(), secret_key(), true, { algorithm: 'HS256' })
    rescue JWT::VerificationError, JWT::DecodeError
      return nil
    end
    decoded
  end

  # def is_admin
  #  #write this out
  # end

end
