FactoryBot.create_list(:department,5)
FactoryBot.create_list(:employee,4, department: Department.all.sample)
FactoryBot.create_list(:employee,7, department: Department.all.sample)