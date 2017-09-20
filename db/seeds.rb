require 'active_support'

puts 'Cleaning DB...'

Profile.destroy_all
User.destroy_all
Restaurant.destroy_all
Supplier.destroy_all
Relation.destroy_all
Product.destroy_all
PricingCondition.destroy_all
Favorite.destroy_all
DeliveryCondition.destroy_all
Order.destroy_all
OrderLine.destroy_all
Document.destroy_all

puts 'Creating Restaurants...'

pv1 = Restaurant.create!(email: "panis.vincent@gmail.com", name: "Point de Vente 1", address: "4 Place Emile Cresp", zip: "92120", locality: "Montrouge", phone_number: "01.46.12.08.93", siret: "798 578 555 000 20")
pv2 = Restaurant.create!(email: "panis.vincent@gmail.com", name: "Point de Vente 2", address: "1 Avenue du Trône", zip: "75012", locality: "Paris", phone_number: "01.46.12.08.94", siret: "798 578 555 000 21")
pv3 = Restaurant.create!(email: "panis.vincent@gmail.com", name: "Point de Vente 3", address: "3 Avenue des Gobelins", zip: "75005", locality: "Paris", phone_number: "01.46.12.08.95", siret: "798 578 555 000 22")

puts 'Creating Users...'

u1 = User.create!(admin: true, email: "vincent@dailyorder.co", password: "12345678", first_name: "Utilisateur", last_name: "Test", phone_number: "06.84.73.96.18")

puts 'Creating Suppliers...'

s1 = Supplier.create!(email: 'vincent@dailyorder.co', name: "Fournisseur 1", address: "30 Rue Montorgueil", zip: "75001", locality: "Paris", phone_number: "01.46.12.08.91", sector: "Boucherie", siret: "798 578 444 000 20")
s2 = Supplier.create!(email: 'vincent@dailyorder.co', name: "Fournisseur 2", address: "31 Rue Montorgueil", zip: "75001", locality: "Paris", phone_number: "01.46.12.08.92", sector: "Boissons", siret: "798 578 333 000 20")
s3 = Supplier.create!(email: 'vincent@dailyorder.co', name: "Fournisseur 3", address: "32 Rue Montorgueil", zip: "75001", locality: "Paris", phone_number: "01.46.12.08.93", sector: "Cafés", siret: "798 578 222 000 20")
s4 = Supplier.create!(email: 'vincent@dailyorder.co', name: "Fournisseur 4", address: "33 Rue Montorgueil", zip: "75001", locality: "Paris", phone_number: "01.46.12.08.94", sector: "Poissonnerie", siret: "798 578 111 000 20")
s5 = Supplier.create!(email: 'vincent@dailyorder.co', name: "Fournisseur 5", address: "34 Rue Montorgueil", zip: "75001", locality: "Paris", phone_number: "01.46.12.08.95", sector: "Vins et spiritueux", siret: "798 578 666 000 20")
s6 = Supplier.create!(email: 'vincent@dailyorder.co', name: "Fournisseur 6", address: "35 Rue Montorgueil", zip: "75001", locality: "Paris", phone_number: "01.46.12.08.96", sector: "Fruits et légumes", siret: "798 578 777 000 20")
s7 = Supplier.create!(email: 'vincent@dailyorder.co', name: "Fournisseur 7", address: "40 Rue Montorgueil", zip: "75001", locality: "Paris", phone_number: "01.46.12.10.80", sector: "Boucherie", siret: "798 578 444 000 10")

puts 'Creating Profiles...'

p1 = Profile.create!(user: u1, restaurant: pv1, role: "Profil admin")
p2 = Profile.create!(user: u1, restaurant: pv2, role: "Profil admin")
p3 = Profile.create!(user: u1, restaurant: pv3, role: "Profil admin")
p4 = Profile.create!(user: u1, supplier: s1, role: "Profil admin")
p5 = Profile.create!(user: u1, supplier: s2, role: "Profil admin")
p6 = Profile.create!(user: u1, supplier: s3, role: "Profil admin")
p7 = Profile.create!(user: u1, supplier: s4, role: "Profil admin")
p8 = Profile.create!(user: u1, supplier: s5, role: "Profil admin")
p9 = Profile.create!(user: u1, supplier: s6, role: "Profil admin")
p10 = Profile.create!(user: u1, supplier: s7, role: "Profil admin")

puts 'Creating Relations...'

r1 = Relation.create!(restaurant: pv1, supplier: s1)
r2 = Relation.create!(restaurant: pv1, supplier: s2)
r3 = Relation.create!(restaurant: pv1, supplier: s3)
r4 = Relation.create!(restaurant: pv1, supplier: s4)
r5 = Relation.create!(restaurant: pv1, supplier: s5)
r6 = Relation.create!(restaurant: pv1, supplier: s6)

puts 'Creating Delivery Conditions...'

dc1 = DeliveryCondition.create!(order_deadlines: [nil, 0, 0, 0, 0, 0, 0], undelivery_days: [0], holidays: [], relation: r1)
dc2 = DeliveryCondition.create!(order_deadlines: [nil, 2, nil, nil, 1, nil, nil], undelivery_days: [0, 2, 3, 5, 6] ,holidays: [], relation: r2)
dc3 = DeliveryCondition.create!(order_deadlines: [nil, nil, 3, nil, nil, 1, nil], undelivery_days: [0, 1, 3, 4, 6], holidays: [], relation: r3)
dc4 = DeliveryCondition.create!(order_deadlines: [nil, nil, nil, nil, nil, 1.5, nil], undelivery_days: [0, 1, 2, 3, 4, 6], holidays: [], relation: r4)

puts 'Creating Products...'

pdt1 = Product.create!(name: "Produit 1", measuring_unit: "kgs", supplier: s1, is_discount: true)
pdt2 = Product.create!(name: "Produit 2", measuring_unit: "kgs", supplier: s1, is_discount: true)
pdt3 = Product.create!(name: "Produit 3", measuring_unit: "kgs", supplier: s1, is_discount: true)
pdt4 = Product.create!(name: "Produit 4", measuring_unit: "kgs", supplier: s1)
pdt5 = Product.create!(name: "Produit 5", measuring_unit: "kgs", supplier: s1)
pdt6 = Product.create!(name: "Produit 6", measuring_unit: "kgs", supplier: s1)
pdt7 = Product.create!(name: "Produit 7", measuring_unit: "kgs", supplier: s1)
pdt8 = Product.create!(name: "Produit 8", measuring_unit: "kgs", supplier: s1)
pdt9 = Product.create!(name: "Produit 9", measuring_unit: "kgs", supplier: s1)
pdt10 = Product.create!(name: "Produit 10", measuring_unit: "kgs", supplier: s1)

pdt1 = Product.create!(name: "Produit 1", measuring_unit: "c(24)", supplier: s2, is_discount: true)
pdt1 = Product.create!(name: "Produit 2", measuring_unit: "c(24)", supplier: s2, is_discount: true)
pdt1 = Product.create!(name: "Produit 3", measuring_unit: "c(24)", supplier: s2, is_discount: true)
pdt4 = Product.create!(name: "Produit 4", measuring_unit: "c(24)", supplier: s2)
pdt5 = Product.create!(name: "Produit 5", measuring_unit: "c(24)", supplier: s2)
pdt6 = Product.create!(name: "Produit 6", measuring_unit: "c(24)", supplier: s2)
pdt7 = Product.create!(name: "Produit 7", measuring_unit: "c(24)", supplier: s2)
pdt8 = Product.create!(name: "Produit 8", measuring_unit: "c(24)", supplier: s2)
pdt9 = Product.create!(name: "Produit 9", measuring_unit: "c(24)", supplier: s2)
pdt10 = Product.create!(name: "Produit 10", measuring_unit: "c(24)", supplier: s2)

pdt1 = Product.create!(name: "Produit 1", measuring_unit: "paq.", supplier: s3, is_discount: true)
pdt1 = Product.create!(name: "Produit 2", measuring_unit: "paq.", supplier: s3, is_discount: true)
pdt1 = Product.create!(name: "Produit 3", measuring_unit: "boit.", supplier: s3, is_discount: true)
pdt4 = Product.create!(name: "Produit 4", measuring_unit: "boit.", supplier: s3)
pdt5 = Product.create!(name: "Produit 5", measuring_unit: "boit.", supplier: s3)
pdt6 = Product.create!(name: "Produit 6", measuring_unit: "boit.", supplier: s3)
pdt7 = Product.create!(name: "Produit 7", measuring_unit: "boit.", supplier: s3)
pdt8 = Product.create!(name: "Produit 8", measuring_unit: "paq.", supplier: s3)
pdt9 = Product.create!(name: "Produit 9", measuring_unit: "paq.", supplier: s3)
pdt10 = Product.create!(name: "Produit 10", measuring_unit: "paq.", supplier: s3)

pdt1 = Product.create!(name: "Produit 1", measuring_unit: "kgs", supplier: s4, is_discount: true)
pdt1 = Product.create!(name: "Produit 2", measuring_unit: "kgs", supplier: s4, is_discount: true)
pdt1 = Product.create!(name: "Produit 3", measuring_unit: "kgs", supplier: s4, is_discount: true)
pdt4 = Product.create!(name: "Produit 4", measuring_unit: "kgs", supplier: s4)
pdt5 = Product.create!(name: "Produit 5", measuring_unit: "kgs", supplier: s4)
pdt6 = Product.create!(name: "Produit 6", measuring_unit: "kgs", supplier: s4)
pdt7 = Product.create!(name: "Produit 7", measuring_unit: "kgs", supplier: s4)
pdt8 = Product.create!(name: "Produit 8", measuring_unit: "kgs", supplier: s4)
pdt9 = Product.create!(name: "Produit 9", measuring_unit: "kgs", supplier: s4)
pdt10 = Product.create!(name: "Produit 10", measuring_unit: "kgs", supplier: s4)

pdt1 = Product.create!(name: "Produit 1", measuring_unit: "c(6)", supplier: s5, is_discount: true)
pdt1 = Product.create!(name: "Produit 2", measuring_unit: "c(6)", supplier: s5, is_discount: true)
pdt1 = Product.create!(name: "Produit 3", measuring_unit: "c(6)", supplier: s5, is_discount: true)
pdt4 = Product.create!(name: "Produit 4", measuring_unit: "c(6)", supplier: s5)
pdt5 = Product.create!(name: "Produit 5", measuring_unit: "c(6)", supplier: s5)
pdt6 = Product.create!(name: "Produit 6", measuring_unit: "c(6)", supplier: s5)
pdt7 = Product.create!(name: "Produit 7", measuring_unit: "c(6)", supplier: s5)
pdt8 = Product.create!(name: "Produit 8", measuring_unit: "c(6)", supplier: s5)
pdt9 = Product.create!(name: "Produit 9", measuring_unit: "c(6)", supplier: s5)
pdt10 = Product.create!(name: "Produit 10", measuring_unit: "c(6)", supplier: s5)

pdt1 = Product.create!(name: "Produit 1", measuring_unit: "col.", supplier: s6, is_discount: true)
pdt1 = Product.create!(name: "Produit 2", measuring_unit: "col.", supplier: s6, is_discount: true)
pdt1 = Product.create!(name: "Produit 3", measuring_unit: "col.", supplier: s6, is_discount: true)
pdt4 = Product.create!(name: "Produit 4", measuring_unit: "col.", supplier: s6)
pdt5 = Product.create!(name: "Produit 5", measuring_unit: "col.", supplier: s6)
pdt6 = Product.create!(name: "Produit 6", measuring_unit: "col.", supplier: s6)
pdt7 = Product.create!(name: "Produit 7", measuring_unit: "col.", supplier: s6)
pdt8 = Product.create!(name: "Produit 8", measuring_unit: "col.", supplier: s6)
pdt9 = Product.create!(name: "Produit 9", measuring_unit: "col.", supplier: s6)
pdt10 = Product.create!(name: "Produit 10", measuring_unit: "col.", supplier: s6)

puts 'Creating Favorites...'

Favorite.create!(relation: r1, product: pdt3)
Favorite.create!(relation: r1, product: pdt4)
Favorite.create!(relation: r1, product: pdt5)

Favorite.create!(relation: r2, product: pdt3)
Favorite.create!(relation: r2, product: pdt4)
Favorite.create!(relation: r2, product: pdt5)

Favorite.create!(relation: r3, product: pdt3)
Favorite.create!(relation: r3, product: pdt4)
Favorite.create!(relation: r3, product: pdt5)

Favorite.create!(relation: r4, product: pdt3)
Favorite.create!(relation: r4, product: pdt4)
Favorite.create!(relation: r4, product: pdt5)

Favorite.create!(relation: r5, product: pdt3)
Favorite.create!(relation: r5, product: pdt4)
Favorite.create!(relation: r5, product: pdt5)

Favorite.create!(relation: r6, product: pdt3)
Favorite.create!(relation: r6, product: pdt4)
Favorite.create!(relation: r6, product: pdt5)

puts 'Creating Orders...'

order_1 = Order.create!(relation: r1, user: u1, status: "En cours")
order_2 = Order.create!(relation: r2, delivery_date: DateTime.new(2017, 7, 20, 0, 0, 0, 0), user: u1, status: "Validée")
order_3 = Order.create!(relation: r3, delivery_date: DateTime.new(2017, 7, 1, 0, 0, 0, 0), user: u1, status: "Envoyée")
order_4 = Order.create!(relation: r4, delivery_date: DateTime.new(2017, 7, 1, 0, 0, 0, 0), user: u1, status: "Envoyée")
order_5 = Order.create!(relation: r5, delivery_date: DateTime.new(2017, 7, 1, 0, 0, 0, 0), user: u1, status: "Envoyée")
order_6 = Order.create!(relation: r6, delivery_date: DateTime.new(2017, 7, 1, 0, 0, 0, 0), user: u1, status: "Envoyée")


puts 'Creating OrderLines...'

OrderLine.create!(order: order_1, product: pdt5, quantity: 3)
OrderLine.create!(order: order_1, product: pdt1, quantity: 6)
OrderLine.create!(order: order_1, product: pdt8, quantity: 9)

OrderLine.create!(order: order_2, product: pdt3, quantity: 2)
OrderLine.create!(order: order_2, product: pdt4, quantity: 4)
OrderLine.create!(order: order_2, product: pdt10, quantity: 3)

OrderLine.create!(order: order_3, product: pdt1, quantity: 4)
OrderLine.create!(order: order_3, product: pdt5, quantity: 2)
OrderLine.create!(order: order_3, product: pdt4, quantity: 2)

OrderLine.create!(order: order_4, product: pdt1, quantity: 3)
OrderLine.create!(order: order_4, product: pdt9, quantity: 2)
OrderLine.create!(order: order_4, product: pdt8, quantity: 4)

OrderLine.create!(order: order_5, product: pdt8, quantity: 10)
OrderLine.create!(order: order_5, product: pdt4, quantity: 15)
OrderLine.create!(order: order_5, product: pdt7, quantity: 10)

OrderLine.create!(order: order_6, product: pdt6, quantity: 2)
OrderLine.create!(order: order_6, product: pdt10, quantity: 3)
OrderLine.create!(order: order_6, product: pdt2, quantity: 1)

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
