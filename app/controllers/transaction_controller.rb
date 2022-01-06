class TransactionController < ApplicationController


    # json will look like the following
    # {
    #   transaction: {
    #       buyer: "foo",
    #       seller: "bar",
    #       image: "baz"
    #   }
    # }
    def sell
        transaction = JSON.parse(request.body.read).deep_symbolize_keys![:transaction]
        if !transaction then
            return render json: {error: "missing json body"}, :status => 400
        end
        if !%i[buyer seller image].all? {|s| transaction.key? s} then
            return render json: {error: "incomplete request"}, :status => 400
        end
        buyer = User.find_by(user_id: transaction[:buyer])
        seller = User.find_by(user_id: transaction[:seller])
        image = Image.find_by(image_id: transaction[:image])

        if !image then
            return render json: {error: "image with id: #{image[:image_id]} does not exist"}, :status => 400
        end

        if !buyer then
            return render json: {error: "buyer with id: #{transaction[:buyer]} does not exist"}, :status => 400
        end

        if !seller then
            return render json: {error: "seller with id: #{transaction[:seller]} does not exist"}, :status => 400
        end

        if image[:owner] != seller[:user_id] then
            return render json: {error: "seller with id: #{transaction[:seller]} does not own image with id #{image[:image_id]}"}, :status => 400
        end

        if !(buyer[:balance] - image[:price] > 0) then
            return render json: {error: "buyer with id: #{buyer[:user_id]} does not have sufficient funds"}, :status => 400
        end

        buyer.update(balance: buyer[:balance] - image[:price])
        seller.update(balance: seller[:balance] + image[:price])
        image.update(owner: buyer[:user_id])

        json_response({response: "Transaction successful. Buyers new balance: #{buyer[:balance]}. Sellers new balance: #{seller[:balance]}. Images current owner: #{image[:owner]}."})
    end
end