class ApplicationController < ActionController::Base
    before_action :authenticate_user_from_token!

    private

    def authenticate_user_from_token!
        token = request.headers['Authorization']
        # Check the token is expired or not
        if Time.now.to_i > decode_token(token)['exp']
            render json: { error: 'Token expired' }, status: :unauthorized
            return
        end

        if token && (decoded_token = decode_token(token)) && (user = SystemUser.find_by(id: decoded_token['user_id']))
            true
        else
            render json: { error: 'Unauthorized' }, status: :unauthorized
        end
    end

    def decode_token(token)
        # Simple decryption for the test (We can use a more secure method in real)
        JSON.parse(Base64.decode64(token))
    end

end
