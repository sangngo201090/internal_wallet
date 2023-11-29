module Api
    class TeamsController < ApplicationController
        skip_before_action :verify_authenticity_token
        
        def create
            team = Team.new(team_params)
            wallet = Wallet.new(name: "Wallet of #{user.name}")

            ActiveRecord::Base.transaction do
                if wallet.save
                    team.wallet_id = wallet.id
                    team.system_user_id = decode_token(request.headers['Authorization'])['user_id']

                    if team.save
                        render json: { message: 'User and Wallet created successfully', team: team, wallet: wallet }, status: :created
                    else
                        # Rollback the transaction if saving the user fails
                        render json: { errors: team.errors.full_messages }, status: :unprocessable_entity
                        raise ActiveRecord::Rollback
                    end
                else
                    render json: { errors: wallet.errors.full_messages }, status: :unprocessable_entity
                end
            end
        end
  
        private
  
        def team_params
            params.require(:team).permit(:name, :description)
        end
    end
  end