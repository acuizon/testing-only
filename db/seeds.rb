# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

su = ShortUrl.create(original_url: "http://google.com")

dv1 = DailyView.create(short_url_id: su.id, view_date: 2.days.ago, view_hour: 5)
dv2 = DailyView.create(short_url_id: su.id, view_date: 2.days.ago, view_hour: 6)
dv3 = DailyView.create(short_url_id: su.id, view_date: 2.days.ago, view_hour: 7)

dv4 = DailyView.create(short_url_id: su.id, view_date: 1.days.ago, view_hour: 2)
dv5 = DailyView.create(short_url_id: su.id, view_date: 1.days.ago, view_hour: 4)
dv6 = DailyView.create(short_url_id: su.id, view_date: 1.days.ago, view_hour: 6)

dv7 = DailyView.create(short_url_id: su.id, view_date: Date.current, view_hour: 5)
dv8 = DailyView.create(short_url_id: su.id, view_date: Date.current, view_hour: 10)
dv9 = DailyView.create(short_url_id: su.id, view_date: Date.current, view_hour: 15)

Visitor.create(daily_view_id: dv1.id, ip_address: "0.0.0.1")
Visitor.create(daily_view_id: dv1.id, ip_address: "0.0.0.2")
Visitor.create(daily_view_id: dv2.id, ip_address: "0.0.0.1")
Visitor.create(daily_view_id: dv2.id, ip_address: "0.0.0.2")
Visitor.create(daily_view_id: dv2.id, ip_address: "0.0.0.3")
Visitor.create(daily_view_id: dv3.id, ip_address: "0.0.0.1")
Visitor.create(daily_view_id: dv3.id, ip_address: "0.0.0.2")
Visitor.create(daily_view_id: dv3.id, ip_address: "0.0.0.3")
Visitor.create(daily_view_id: dv3.id, ip_address: "0.0.0.4")
Visitor.create(daily_view_id: dv4.id, ip_address: "0.0.0.1")
Visitor.create(daily_view_id: dv4.id, ip_address: "0.0.0.2")
Visitor.create(daily_view_id: dv4.id, ip_address: "0.0.0.3")
Visitor.create(daily_view_id: dv4.id, ip_address: "0.0.0.4")
Visitor.create(daily_view_id: dv4.id, ip_address: "0.0.0.5")
Visitor.create(daily_view_id: dv5.id, ip_address: "0.0.0.1")
Visitor.create(daily_view_id: dv5.id, ip_address: "0.0.0.2")
Visitor.create(daily_view_id: dv5.id, ip_address: "0.0.0.3")
Visitor.create(daily_view_id: dv5.id, ip_address: "0.0.0.4")
Visitor.create(daily_view_id: dv6.id, ip_address: "0.0.0.1")
Visitor.create(daily_view_id: dv6.id, ip_address: "0.0.0.2")
Visitor.create(daily_view_id: dv6.id, ip_address: "0.0.0.3")
Visitor.create(daily_view_id: dv7.id, ip_address: "0.0.0.1")
Visitor.create(daily_view_id: dv7.id, ip_address: "0.0.0.2")
Visitor.create(daily_view_id: dv8.id, ip_address: "0.0.0.1")
Visitor.create(daily_view_id: dv9.id, ip_address: "0.0.0.1")
Visitor.create(daily_view_id: dv9.id, ip_address: "0.0.0.2")