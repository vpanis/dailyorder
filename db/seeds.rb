puts 'Cleaning DB...'

User.destroy_all
Profile.destroy_all
Restaurant.destroy_all
Supplier.destroy_all
Relation.destroy_all
Product.destroy_all
PricingCondition.destroy_all
Favorite.destroy_all
DeliveryCondition.destroy_all
Order.destroy_all
OrderLine.destroy_all

puts 'Creating Restaurants...'

qg = Restaurant.create!(email: "panis.vincent@gmail.com", name: "La Quincaillerie Générale", address: "4 Place Emile Cresp", zip: "92120", locality: "Montrouge", phone_number: "01.46.12.08.93", siret: "798 578 555 000 20")

puts 'Creating Users...'

vincent = User.create!(admin: true, email: "vpanis@hotmail.fr", password: "12345678", first_name: "Vincent", last_name: "Panis", phone_number: "06.84.73.96.18")

puts 'Creating Profiles...'

vincent_profile = Profile.create!(user: vincent, restaurant: qg, role: "Administrateur")

puts 'Creating Suppliers...'

tribolet = Supplier.create!(email: 'alain@laposte.net', name: "Ets Tribolet", address: "30 Rue Montorgueil", zip: "75001", locality: "Paris", phone_number: "01.46.12.08.91", sector: "Boucherie", siret: "798 578 444 000 20")
tafanel = Supplier.create!(email: 'christian@laposte.net', name: "Ets Tafanel", address: "31 Rue Montorgueil", zip: "75001", locality: "Paris", phone_number: "01.46.12.08.92", sector: "Boissons", siret: "798 578 333 000 20")
richard = Supplier.create!(email: 'arnaud@laposte.net', name: "Cafés Richard", address: "32 Rue Montorgueil", zip: "75001", locality: "Paris", phone_number: "01.46.12.08.93", sector: "Cafés", siret: "798 578 222 000 20")
joceane = Supplier.create!(email: 'dalila@laposte.net', name: "J'océane", address: "33 Rue Montorgueil", zip: "75001", locality: "Paris", phone_number: "01.46.12.08.94", sector: "Poissonnerie", siret: "798 578 111 000 20")
brument = Supplier.create!(email: 'benoit@laposte.net', name: "Benoit Brument Vins", address: "34 Rue Montorgueil", zip: "75001", locality: "Paris", phone_number: "01.46.12.08.95", sector: "Vins et spiritueux", siret: "798 578 666 000 20")
vergers = Supplier.create!(email: 'eric@laposte.net', name: "Les Vergers de Boulogne", address: "35 Rue Montorgueil", zip: "75001", locality: "Paris", phone_number: "01.46.12.08.96", sector: "Fruits et légumes", siret: "798 578 777 000 20")

puts 'Creating Relations...'

viande = Relation.create!(restaurant: qg, supplier: tribolet)
boisson = Relation.create!(restaurant: qg, supplier: tafanel)
cafe = Relation.create!(restaurant: qg, supplier: richard)
poisson = Relation.create!(restaurant: qg, supplier: joceane)
vin = Relation.create!(restaurant: qg, supplier: brument)
legume = Relation.create!(restaurant: qg, supplier: vergers)

puts 'Creating Products...'

entrecote = Product.create!(name: "Entrecôte boeuf 300g", measuring_unit: "kgs", supplier: tribolet)
onglet = Product.create!(name: "Onglet veau mi-par.", measuring_unit: "kgs", supplier: tribolet)
semelle = Product.create!(name: "Semelle de boeuf", measuring_unit: "kgs", supplier: tribolet)

coca = Product.create!(name: "Coca 33cl bt v", measuring_unit: "caisses(24bts)", supplier: tafanel)
perrier = Product.create!(name: "Perrier 33cl bt v", measuring_unit: "caisses(24bts)", supplier: tafanel)
orangina = Product.create!(name: "Orangina 33cl bt v", measuring_unit: "caisses(24bts)", supplier: tafanel)

noir = Product.create!(name: "Perle Noire grain 1kg", measuring_unit: "paquets", supplier: richard)
deca = Product.create!(name: "Déca moulu 500gr", measuring_unit: "paquets", supplier: richard)
chocolat = Product.create!(name: "Chocolat poudre 500g", measuring_unit: "boites", supplier: richard)

saumon = Product.create!(name: "Filet de saumon", measuring_unit: "kgs", supplier: joceane)
lieu = Product.create!(name: "Pavé de lieu noir", measuring_unit: "kgs", supplier: joceane)
eglefin = Product.create!(name: "Filet d'eglefin", measuring_unit: "kgs", supplier: joceane)

rhone = Product.create!(name: "Côte Rhone Vill.", measuring_unit: "cartons(6bts)", supplier: brument)
rioja = Product.create!(name: "Rioja AOC", measuring_unit: "cartons(6bts)", supplier: brument)
brouilly = Product.create!(name: "Brouilly AOC", measuring_unit: "cartons(6bts)", supplier: brument)

tomate = Product.create!(name: "Tomates", measuring_unit: "colis", supplier: vergers)
batavia = Product.create!(name: "Batavia", measuring_unit: "colis", supplier: vergers)
chene = Product.create!(name: "Feuille de chêne", measuring_unit: "colis", supplier: vergers)

puts 'Creating Favorites...'

Favorite.create!(relation: viande, product: entrecote)
Favorite.create!(relation: boisson, product: coca)
Favorite.create!(relation: cafe, product: noir)
Favorite.create!(relation: poisson, product: saumon)
Favorite.create!(relation: vin, product: rhone)
Favorite.create!(relation: legume, product: tomate)

puts 'Creating Orders...'

order_1 = Order.create!(relation: viande, user: vincent, status: "En cours")
order_2 = Order.create!(relation: boisson, delivery_date: DateTime.new(2017, 7, 20, 0, 0, 0, 0), user: vincent, status: "Validée")
order_3 = Order.create!(relation: cafe, delivery_date: DateTime.new(2017, 7, 1, 0, 0, 0, 0), user: vincent, status: "Envoyée")
order_4 = Order.create!(relation: poisson, delivery_date: DateTime.new(2017, 7, 1, 0, 0, 0, 0), user: vincent, status: "Envoyée")
order_5 = Order.create!(relation: vin, delivery_date: DateTime.new(2017, 7, 1, 0, 0, 0, 0), user: vincent, status: "Envoyée")
order_6 = Order.create!(relation: legume, delivery_date: DateTime.new(2017, 7, 1, 0, 0, 0, 0), user: vincent, status: "Envoyée")


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

puts 'Creating Documents...'

Document.create(
        title: "Commande Ets Tribolet",
        document_type: "Bon de commande",
        order: order_1)
Document.create(
        title: "Commande Ets Tafanel",
        document_type: "Bon de commande",
        order: order_2)
Document.create(
        title: "Commande Cafés Richard",
        document_type: "Bon de commande",
        order: order_3)
Document.create(
        title: "Commande J'océane",
        document_type: "Bon de commande",
        order: order_4)
Document.create(
        title: "Commande Benoit Brument Vins",
        document_type: "Bon de commande",
        order: order_5)
Document.create(
        title: "Commande Les Vergers de Boulogne",
        document_type: "Bon de commande",
        order: order_6)

puts 'Finished !'
