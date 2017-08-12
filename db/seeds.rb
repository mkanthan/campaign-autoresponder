# This seed file is intended to seed a test version of the Campaign Autoresponder graph

# A very simple version of the campaign and email graph is displayed below and modeled
# by this seed.rb file. Whenever an email leads to another email, it is because
# of a delay. This condition is assumed when the user waits the delay period.
# Whenever an email leads to a campaign it is because of a branch which is
# assumed to happen when a user opens an email and clicks on the link and enters
# a new campaign.
#
#        C1
#        |
#        E1----------C2
#        |            |
#        E2----C3    E1
#        |      |     |
#        E3    E1    E2---C5
#        |      |     |    |
#        ---C4---    E3   E1
#            |        |    |
#           E1       C6    |
#            |        |    |
#           E2       E1---C7
#                          |
#                         E1


c7e1 = Email.create(subject_content: "C7E1", body_content: "C7E1", hours_delay: 16)
c7 = Campaign.create(title: "C7", initial_email: c7e1)

c6e1 = Email.create(subject_content: "C6E1", body_content: "C6E1", next_campaign: c7, hours_delay: 8)
c6 = Campaign.create(title: "C6", initial_email: c6e1)

c5e1 = Email.create(subject_content: "C5E1", body_content: "C5E1", next_campaign: c7, hours_delay: 12)
c5 = Campaign.create(title: "C5", initial_email: c5e1)

c4e2 = Email.create(subject_content: "C4E2", body_content: "C4E2", hours_delay: 24)
c4e1 = Email.create(subject_content: "C4E2", body_content: "C4E2", next_email: c4e2, hours_delay: 10)
c4 = Campaign.create(title: "C4", initial_email: c4e1)

c3e1 = Email.create(subject_content: "C4E1", body_content: "C4E1", hours_delay: 13)
c3 = Campaign.create(title: "C3", initial_email: c3e1)

c2e3 = Email.create(subject_content: "C2E3", body_content: "C2E3", next_campaign: c6, hours_delay: 9)
c2e2 = Email.create(subject_content: "C2E2", body_content: "C2E2", next_campaign: c5, next_email: c2e3, hours_delay: 10)
c2e1 = Email.create(subject_content: "C2E1", body_content: "C2E1", next_email: c2e2, hours_delay: 20)
c2 = Campaign.create(title: "C2", initial_email: c2e1)

c1e3 = Email.create(subject_content: "C1E3", body_content: "C1E3", next_campaign: c4, hours_delay: 21)
c1e2 = Email.create(subject_content: "C1E2", body_content: "C1E2", next_campaign: c3, next_email: c1e3, hours_delay: 15)
c1e1 = Email.create(subject_content: "C1E1", body_content: "C1E1", next_campaign: c2, next_email: c1e2, hours_delay: 13)
c1 = Campaign.create(title: "C1", initial_email: c1e1, root: true)

user = User.create(first_name: "Manu", last_name: "Kanthan", email: "mkanthan@example.com")