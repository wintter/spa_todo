namespace :db_populate do

  task :projects => :environment do
    3.times do
      name = Faker::Name.title
      Project.create!(name: name)
    end
  end

  task :task_lists => :environment do
    10.times do
      deadline = Faker::Date.forward(rand(1..10))
      status = [true, false].sample
      comments = Faker::Lorem.sentence(3)
      filename = ''
      project_id = rand(1..3)
      TaskList.create!(deadline: deadline, status: status,
                       comments: comments, filename: filename, project_id: project_id)
    end
  end

end

task :db_populate do
  Rake::Task['db_populate:projects'].invoke
  Rake::Task['db_populate:task_lists'].invoke
end