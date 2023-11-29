module Api
    class AuthenticationsController < ApplicationController
        skip_before_action :verify_authenticity_token
        skip_before_action :authenticate_user_from_token!, only: [:login]
        def login
            user = SystemUser.find_by(user_name: params[:user_name])
    
            if user && user.authenticate(params[:user_name], params[:password])
                token = generate_token(user)
                render json: { token: token, message: 'Sign-in successful' }
            else
                render json: { error: 'Invalid username or password' }, status: :unauthorized
            end
        end
    
    
        private

        def generate_token(user)
                token_payload = {
                user_id: user.id,
                exp: 1.hours.from_now.to_i
            }

            # Simple encryption (We use a more secure method in production)
            Base64.encode64(JSON.dump(token_payload))
        end

    end
end