local Translations = {
    cfg = {
        targetLabel = 'Make an Interview'
    },

    menu = {
        header = 'Illegal Smuggling',

        orderHeader = 'Order',
        orderTxt = 'You can have something by creating an order..',

        finalHeader = 'View Orders',
        finalTxt = 'Check how long it takes for your orders to reach you',

        notify = 'Are you trying to catch us, get lost!'
    },

    shop = {
        header = 'Item List',
        txt = 'There are so many products, choose the one that suits you',
        price = 'Buy in return'
    },

    shipment = {
        header = 'Ordered Items',
        txt = 'Time may vary depending on the product..',

        timeTxt = 'seconds left.',
        takeTxt = 'Check your order, it may have arrived'
    },

    server = {
        order = 'you received your order.',
        war = 'Shipment burned, lost!',
        pay = 'You paid and ordered',
        noMoney = 'Did you think to buy something from me with a penny in your pocket, miserable!'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})