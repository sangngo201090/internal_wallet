# Using the Defined APIs in this Examination

To interact with the APIs defined in this examination, follow the steps below:

1. **Call the Login API to Get the Token:**
    - Make a POST request to the following endpoint to obtain a token:
        - Endpoint: `http://localhost:3000/api/login`
        - Parameters: `user_name=sang&password=password`
        - Parameters:
        ```json
            {
                "user_name": "sang",
                "password": "password"            
            }
        ```

2. **Attach Token to Authorization Header:**
    - Retrieve the token obtained from the login API.
    - Attach the token to the Authorization header in your subsequent requests.

3. **Testing Available APIs:**

    3.1. **Create a New User Entity:**
    - Make a POST request to create a new user entity:
        - Endpoint: `http://localhost:3000/api/users`
        - Parameters:
        ```json
            {
                "user": {
                "name": "Sang mr",
                "birth_date": "1990-01-01"
                }
            }
        ```

    3.2. **Deposit API:**
    - Make a POST request to deposit funds:
        - Endpoint: `http://localhost:3000/api/deposit`
        - Parameters:
        ```json
            {
                "user_id": "7",
                "amount": "1990-01-01",
                "description": "Transfer from Bank account"
            }
        ```

    3.3. **Withdraw API:**
    - Make a POST request to withdraw funds:
        - Endpoint: `http://localhost:3000/api/withdraw`
        - Parameters:
        ```json
            {
                "user_id": "7",
                "amount": "100",
                "description": "Withdraw in ATM"
            }
        ```

    3.4. **Transfer from Wallet A to Wallet B:**
    - Make a POST request to transfer funds between wallets:
        - Endpoint: `http://localhost:3000/api/transfer`
        - Parameters:
        ```json
            {
                "user_id": "7",
                "target_wallet_id": "4",
                "amount": "100",
                "message": "Happy birthday"
            }
        ```

    3.5. **Get User Wallet Balance:**
    - Make a GET request to get the balance of a user's wallet:
        - Endpoint: `http://localhost:3000/api/user/balance?user_id=7`
        - Parameters:
        ```json
            {
                "user_id": "7"
            }
        ```


