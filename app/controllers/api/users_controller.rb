module Api
    class UsersController < ApplicationController
        skip_before_action :verify_authenticity_token
        
        # Create new User Entity, Team & Stock Entity are the same
        # Create new wallet for User Entity, Team & Stock Entity are the same
        def create
            user = User.new(user_params)
            wallet = Wallet.new(name: "Wallet of #{user.name}")
            
            ActiveRecord::Base.transaction do
                if wallet.save
                    user.wallet_id = wallet.id
                    user.system_user_id = decode_token(request.headers['Authorization'])['user_id']

                    if user.save
                        render json: { message: 'User and Wallet created successfully', user: user, wallet: wallet }, status: :created
                    else
                        # Rollback the transaction if saving the user fails
                        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
                        raise ActiveRecord::Rollback
                    end
                else
                    render json: { errors: wallet.errors.full_messages }, status: :unprocessable_entity
                end
            end
        end

        # Get balance of User Entity, Team & Stock Entity are the same
        def balance
            user = User.find_by(id: params[:user_id])
            if user
                render json: { message: 'Success', balance: user.wallet.balance }, status: :ok
            else
                render json: { errors: 'User not found' }, status: :not_found
            end
        end
  
        private
  
        def user_params
            params.require(:user).permit(:name, :birth_date)
        end
    end
  end