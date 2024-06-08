initial_application = Application.create({ status: :applied, candidate_name: Faker::Name.name })

interview_application = Application.create({ status: :interview, candidate_name: Faker::Name.name })
interview = Interview.create({ interview_date: Time.new(2024, 4, 30, 23, 59, 59), application: interview_application })
Application::Events::Interview.create(initiable: interview)


hire_application = Application.create({ status: :hired, candidate_name: Faker::Name.name })
hire = Hire.create({ hire_date: Time.new(2024, 4, 30, 23, 59, 59), application: hire_application })
Application::Events::Hired.create(initiable: hire)
Application::Events::Rejected.create(initiable: application)

rejected_application = Application.create({ status: :rejected, candidate_name: Faker::Name.name })
Application::Events::Rejected.create(initiable: rejected_application)


title = Faker::Job.title
field = Faker::Job.field
key_skill = Faker::Job.key_skill
responsibilities = Faker::Lorem.sentences(number: 3).join(' ')
requirements = Faker::Lorem.sentences(number: 3).join(' ')

description = "
  Job Title: #{title}
  Field: #{field}
  Responsibilities: #{responsibilities}
  Requirements: Must have experience with #{key_skill}. #{requirements}
"

activated_job = Job.create({ status: :activated, title: Faker::Job.title, description: description })
Job::Events::Activated.create(initiable: activated_job)

deactivated_job = Job.create({ status: :deactivated, title: Faker::Job.title, description: description })
Job::Events::Deactivated.create(initiable: deactivated_job)
