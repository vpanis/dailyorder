puts 'Cleaning DB...'

User.destroy_all
Restaurant.destroy_all
Group.destroy_all
Provider.destroy_all
Relation.destroy_all
Product.destroy_all
PricingCondition.destroy_all
Favorite.destroy_all
DeliveryCondition.destroy_all
Order.destroy_all
OrderLine.destroy_all

puts 'Creating Users...'

vincent = User.create!(admin: true, email: "vpanis@hotmail.fr", password: "123456", first_name: "Vincent", last_name: "Panis", phone_number: "06.84.73.96.18")

puts 'Creating Restaurants...'

qg = Restaurant.create!(email: "panis.vincent@gmail.com", name: "La Quincaillerie Générale", address: "4 Place Emile Cresp 92120 Montrouge", phone_number: "01.46.12.08.93", siret: "798 578 555 000 20")

puts 'Creating Providers...'

tribolet = Provider.create!(email: 'vpanis@laposte.net', name: "Ets Tribolet", address: "30 Rue Montorgueil 75001 Paris", phone_number: "01.46.12.08.91", siret: "798 578 444 000 20")
tafanel = Provider.create!(email: 'vpanis@laposte.net', name: "Ets Tafanel", address: "31 Rue Montorgueil 75001 Paris", phone_number: "01.46.12.08.92", siret: "798 578 333 000 20")
richard = Provider.create!(email: 'vpanis@laposte.net', name: "Cafés Richard", address: "32 Rue Montorgueil 75001 Paris", phone_number: "01.46.12.08.93", siret: "798 578 222 000 20")
joceane = Provider.create!(email: 'vpanis@laposte.net', name: "J'océane", address: "33 Rue Montorgueil 75001 Paris", phone_number: "01.46.12.08.94", siret: "798 578 111 000 20")
brument = Provider.create!(email: 'vpanis@laposte.net', name: "Benoit Brument Vins", address: "34 Rue Montorgueil 75001 Paris", phone_number: "01.46.12.08.95", siret: "798 578 666 000 20")
vergers = Provider.create!(email: 'vpanis@laposte.net', name: "Les Vergers de Boulogne", address: "35 Rue Montorgueil 75001 Paris", phone_number: "01.46.12.08.96", siret: "798 578 777 000 20")

puts 'Creating Relations...'

viande = Relation.create!(restaurant: qg, provider: tribolet)
boisson = Relation.create!(restaurant: qg, provider: tafanel)
cafe = Relation.create!(restaurant: qg, provider: richard)
poisson = Relation.create!(restaurant: qg, provider: joceane)
vin = Relation.create!(restaurant: qg, provider: brument)
legume = Relation.create!(restaurant: qg, provider: vergers)

puts 'Creating Products...'

entrecote = Product.create!(name: "Entrecôte de boeuf piècée 300grs", measuring_unit: "kgs", provider: tribolet)
onglet = Product.create!(name: "Onglet de veau semi-paré", measuring_unit: "kgs", provider: tribolet)
semelle = Product.create!(name: "Semelle de boeuf", measuring_unit: "kgs", provider: tribolet)

coca = Product.create!(name: "Coca 33cl bouteille verre", measuring_unit: "caisses de 24", provider: tafanel)
perrier = Product.create!(name: "Perrier 33cl bouteille verre", measuring_unit: "caisses de 24", provider: tafanel)
orangina = Product.create!(name: "Orangina 33cl bouteille verre", measuring_unit: "caisses de 24", provider: tafanel)

noir = Product.create!(name: "Café Perle Noire en grains 1kg", measuring_unit: "paquets", provider: richard)
deca = Product.create!(name: "Décaféiné moulu 500gr", measuring_unit: "paquets", provider: richard)
chocolat = Product.create!(name: "Chocolat en poudre 500gr", measuring_unit: "boites", provider: richard)

saumon = Product.create!(name: "Filet de saumon", measuring_unit: "kgs", provider: joceane)
lieu = Product.create!(name: "Pavé de lieu noir", measuring_unit: "kgs", provider: joceane)
eglefin = Product.create!(name: "Filet d'eglefin", measuring_unit: "kgs", provider: joceane)

rhone = Product.create!(name: "Côte du Rhone Village", measuring_unit: "cartons de 6", provider: brument)
rioja = Product.create!(name: "Rioja AOC", measuring_unit: "cartons de 6", provider: brument)
brouilly = Product.create!(name: "Brouilly AOC", measuring_unit: "cartons de 6", provider: brument)

tomate = Product.create!(name: "Tomates", measuring_unit: "colis", provider: vergers)
batavia = Product.create!(name: "Batavia", measuring_unit: "colis", provider: vergers)
chene = Product.create!(name: "Feuille de chêne", measuring_unit: "colis", provider: vergers)

puts 'Creating Favorites...'

Favorite.create!(relation: viande, product: entrecote)
Favorite.create!(relation: boisson, product: coca)
Favorite.create!(relation: cafe, product: noir)
Favorite.create!(relation: poisson, product: saumon)
Favorite.create!(relation: vin, product: rhone)
Favorite.create!(relation: legume, product: tomate)

puts 'Creating Orders...'

order_1 = Order.create!(relation: viande, delivery_date: DateTime.new(2017, 7, 1, 0, 0, 0, 0))
order_2 = Order.create!(relation: boisson, delivery_date: DateTime.new(2017, 7, 1, 0, 0, 0, 0))
order_3 = Order.create!(relation: cafe, delivery_date: DateTime.new(2017, 7, 1, 0, 0, 0, 0))
order_4 = Order.create!(relation: poisson, delivery_date: DateTime.new(2017, 7, 1, 0, 0, 0, 0))
order_5 = Order.create!(relation: vin, delivery_date: DateTime.new(2017, 7, 1, 0, 0, 0, 0))
order_6 = Order.create!(relation: legume, delivery_date: DateTime.new(2017, 7, 1, 0, 0, 0, 0))


puts 'Creating OrderLines...'

OrderLine.create!(order: order_1, product: entrecote, quantity: 3)
OrderLine.create!(order: order_1, product: onglet, quantity: 6)
OrderLine.create!(order: order_1, product: semelle, quantity: 9)

OrderLine.create!(order: order_2, product: coca, quantity: 2)
OrderLine.create!(order: order_2, product: perrier, quantity: 4)
OrderLine.create!(order: order_2, product: orangina, quantity: 3)

OrderLine.create!(order: order_3, product: noir, quantity: 4)
OrderLine.create!(order: order_3, product: deca, quantity: 2)
OrderLine.create!(order: order_3, product: chocolat, quantity: 2)

OrderLine.create!(order: order_4, product: saumon, quantity: 3)
OrderLine.create!(order: order_4, product: lieu, quantity: 2)
OrderLine.create!(order: order_4, product: eglefin, quantity: 4)

OrderLine.create!(order: order_5, product: rhone, quantity: 10)
OrderLine.create!(order: order_5, product: rioja, quantity: 15)
OrderLine.create!(order: order_5, product: brouilly, quantity: 10)

OrderLine.create!(order: order_6, product: tomate, quantity: 2)
OrderLine.create!(order: order_6, product: batavia, quantity: 3)
OrderLine.create!(order: order_6, product: chene, quantity: 1)

puts 'Finished !'
