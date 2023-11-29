module Api
    class WalletsController < ApplicationController
        skip_before_action :verify_authenticity_token
        before_action :set_user, only: [:deposit, :withdraw, :transfer]
        
        # Example for deposit from out-side (ex: the bank account) to the USER ENTITY wallet
        def deposit
            amount = params[:amount].to_f
          
            if amount <= 0
                render json: { errors: 'Invalid deposit amount. Amount must be greater than 0.' }, status: :unprocessable_entity
                return
            end
          
            begin
                ActiveRecord::Base.transaction do
                    Transaction.create!(
                        source_wallet_id: nil,
                        target_wallet_id: @user.wallet_id,
                        amount: amount,
                        description: params[:description]
                    )
            
                    render json: { message: 'Deposit successful', user: @user }, status: :created
                end
            rescue ActiveRecord::RecordInvalid => e
                render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
            rescue StandardError => e
                render json: { errors: "An error occurred during the deposit. #{e.message}" }, status: :internal_server_error
            end
        end

        # Example for withdraw from the USER ENTITY wallet to out-side (ex: ATM)
        def withdraw
            amount = params[:amount].to_f
          
            if amount <= 0
                render json: { errors: 'Invalid withdrawal amount. Amount must be greater than 0.' }, status: :unprocessable_entity
                return
            end
          
            if @user.wallet.balance < amount
                render json: { errors: 'Insufficient funds for withdrawal' }, status: :unprocessable_entity
                return
            end
          
            begin
                ActiveRecord::Base.transaction do
                    Transaction.create!(
                        source_wallet_id: @user.wallet_id,
                        target_wallet_id: nil,
                        amount: amount,
                        description: params[:description]
                    )
            
                    render json: { message: 'Withdrawal successful', user: @user }, status: :created
                end
            rescue ActiveRecord::RecordInvalid => e
                render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
            rescue StandardError => e
                render json: { errors: "An error occurred during the withdrawal. #{e.message}" }, status: :internal_server_error
            end
        end

        # Example for transfer from the USER ENTITY wallet to another USER ENTITY wallet
        def transfer
            amount = params[:amount].to_f
            target_wallet_id = params[:target_wallet_id].to_i
          
            if amount <= 0
                render json: { errors: 'Invalid transfer amount. Amount must be greater than 0.' }, status: :unprocessable_entity
                return
            end
          
            begin
                @user.wallet.transaction do
                    if @user.wallet.balance >= amount
                        # Create a debit transaction for the source wallet
                        @user.wallet.debit_transactions.create!(
                            amount: amount,
                            source_wallet_id: @user.wallet.id,
                            description: "Transfer to wallet #{target_wallet_id}",
                            message: params[:message]
                        )
                
                        # Create a credit transaction for the target wallet
                        target_wallet = Wallet.find(target_wallet_id)
                        target_wallet.credit_transactions.create!(
                            amount: amount,
                            target_wallet_id: target_wallet_id,
                            description: "Transfer from wallet #{@user.wallet.id}",
                            message: params[:message]
                        )
                
                        render json: { message: 'Transfer successful', user: @user, balance: @user.wallet.balance }, status: :ok
                    else
                        render json: { errors: 'Insufficient balance for transfer' }, status: :unprocessable_entity
                    end
                end
            rescue ActiveRecord::RecordNotFound => e
                render json: { errors: "Target wallet with ID #{target_wallet_id} not found" }, status: :not_found
            rescue ActiveRecord::RecordInvalid => e
                render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
            rescue StandardError => e
                render json: { errors: "An error occurred during the transfer. #{e.message}" }, status: :internal_server_error
            end
        end
    
        private
    
        def set_user
            # Just demo for User Entity in this time, about the other Entity, we can do the same
            @user = User.find(params[:user_id])
        rescue ActiveRecord::RecordNotFound => e
            Rails.logger.error("User not found: #{e.message}")
            render json: { errors: 'User not found' }, status: :not_found
        end

    end
end
  