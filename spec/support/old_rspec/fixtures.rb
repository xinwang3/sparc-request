# Copyright © 2011 MUSC Foundation for Research Development
# All rights reserved.

# Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

# 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

# 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following
# disclaimer in the documentation and/or other materials provided with the distribution.

# 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products
# derived from this software without specific prior written permission.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,
# BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
# SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
# TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

def let_there_be_lane
  let!(:jug2) { create(:identity,
      last_name:             'Glenn',
      first_name:            'Julia',
      ldap_uid:              'jug2',
      institution:           'medical_university_of_south_carolina',
      college:               'college_of_medecine',
      department:            'other',
      email:                 'glennj@musc.edu',
      credentials:           'BS,    MRA',
      catalog_overlord:      true,
      password:              'p4ssword',
      password_confirmation: 'p4ssword',
      approved:              true
    )}
end

def let_there_be_j
  let!(:jpl6) { create(:identity,
      last_name:             'Leonard',
      first_name:            'Jason',
      ldap_uid:              'jpl6@musc.edu',
      institution:           'medical_university_of_south_carolina',
      college:               'college_of_medecine',
      department:            'other',
      email:                 'leonarjp@musc.edu',
      credentials:           'BS,    MRA',
      catalog_overlord:      true,
      password:              'p4ssword',
      password_confirmation: 'p4ssword',
      approved:              true
    )}
end

def build_study_type_questions
  let!(:stq_higher_level_of_privacy) { StudyTypeQuestion.create("order"=>1, "question"=>"1a. Does your study require a higher level of privacy for the participants?", "friendly_id"=>"higher_level_of_privacy") }
  let!(:stq_certificate_of_conf)     { StudyTypeQuestion.create("order"=>2, "question"=>"1b. Does your study have a Certificate of Confidentiality?", "friendly_id"=>"certificate_of_conf") }
  let!(:stq_access_study_info)       { StudyTypeQuestion.create("order"=>3, "question"=>"1c. Do participants enrolled in your study require a second DEIDENTIFIED Medical Record that is not connected to their primary record in Epic?", "friendly_id"=>"access_study_info") }
  let!(:stq_epic_inbasket)           { StudyTypeQuestion.create("order"=>4, "question"=>"2. Do you wish to receive a notification via Epic InBasket when your research participants are admitted to the hospital or ED?", "friendly_id"=>"epic_inbasket") }
  let!(:stq_research_active)         { StudyTypeQuestion.create("order"=>5, "question"=>"3. Do you wish to remove the 'Research: Active' indicator in the Patient Header for your study participants?", "friendly_id"=>"research_active") }
  let!(:stq_restrict_sending)        { StudyTypeQuestion.create("order"=>6, "question"=>"4. Do you need to restrict the sending of study related results, such as laboratory and radiology results, to a participants MyChart?", "friendly_id"=>"restrict_sending") }
end

def build_study_type_answers
  let!(:answer1)  { StudyTypeAnswer.create(protocol_id: study.id, study_type_question_id: 1, answer: false)}
  let!(:answer2)  { StudyTypeAnswer.create(protocol_id: study.id, study_type_question_id: 2, answer: true)}
  let!(:answer3)  { StudyTypeAnswer.create(protocol_id: study.id, study_type_question_id: 3, answer: false)}
  let!(:answer4)  { StudyTypeAnswer.create(protocol_id: study.id, study_type_question_id: 4, answer: false)}
  let!(:answer5)  { StudyTypeAnswer.create(protocol_id: study.id, study_type_question_id: 5, answer: false)}
  let!(:answer6)  { StudyTypeAnswer.create(protocol_id: study.id, study_type_question_id: 6, answer: false)}
end

def build_service_request_with_project
  build_service_request()
  build_project()
  build_arms()
  build_one_time_fee_services()
  build_per_patient_per_visit_services()
end

def build_service_request_with_project_and_one_time_fees_only
  build_service_request()
  build_project()
  build_one_time_fee_services()
end

def build_service_request_with_project_and_per_patient_per_visit_only
  build_service_request()
  build_project()
  build_arms()
  build_per_patient_per_visit_services()
end

def build_service_request_with_study
  build_service_request()
  build_study()
  build_arms()
  build_one_time_fee_services()
  build_per_patient_per_visit_services()
end

def build_one_time_fee_services
  # One time fee service
  let!(:service)             { create(:service, organization_id: program.id, name: 'One Time Fee', one_time_fee: true) }
  let!(:line_item)           { create(:line_item, service_request_id: service_request.id, service_id: service.id, sub_service_request_id: sub_service_request.id, quantity: 5, units_per_quantity: 1) }
  let!(:pricing_setup)       { create(:pricing_setup, organization_id: program.id, display_date: Time.now - 1.day, federal: 50, corporate: 50, other: 50, member: 50, college_rate_type: 'federal', federal_rate_type: 'federal', industry_rate_type: 'federal', investigator_rate_type: 'federal', internal_rate_type: 'federal', foundation_rate_type: 'federal')}
  let!(:pricing_map)         { create(:pricing_map, unit_minimum: 1, unit_factor: 1, service_id: service.id, quantity_type: "Each", quantity_minimum: 5, otf_unit_type: "Week", display_date: Time.now - 1.day, full_rate: 2000, units_per_qty_max: 20) }
end

def build_per_patient_per_visit_services
  # Per patient per visit service
  let!(:service2)            { create(:service, organization_id: program.id, name: 'Per Patient') }
  let!(:pricing_setup)       { create(:pricing_setup, organization_id: program.id, display_date: Time.now - 1.day, federal: 50, corporate: 50, other: 50, member: 50, college_rate_type: 'federal', federal_rate_type: 'federal', industry_rate_type: 'federal', investigator_rate_type: 'federal', internal_rate_type: 'federal', foundation_rate_type: 'federal')}
  let!(:pricing_map2)        { create(:pricing_map, unit_minimum: 1, unit_factor: 1, service_id: service2.id, display_date: Time.now - 1.day, full_rate: 2000, federal_rate: 3000, units_per_qty_max: 20) }
  let!(:line_item2)          { create(:line_item, service_request_id: service_request.id, service_id: service2.id, sub_service_request_id: sub_service_request.id, quantity: 0) }
  let!(:service_provider)    { create(:service_provider, organization_id: program.id, identity_id: jug2.id)}
  let!(:super_user)          { create(:super_user, organization_id: program.id, identity_id: jpl6.id)}
  let!(:catalog_manager)     { create(:catalog_manager, organization_id: program.id, identity_id: jpl6.id) }
  let!(:clinical_provider)   { create(:clinical_provider, organization_id: program.id, identity_id: jug2.id) }
  let!(:available_status)    { create(:available_status, organization_id: program.id, status: 'submitted')}
  let!(:available_status2)   { create(:available_status, organization_id: program.id, status: 'draft')}
  let!(:subsidy)             { Subsidy.auditing_enabled = false; create(:subsidy, pi_contribution: 2500, sub_service_request_id: sub_service_request.id)}
  let!(:subsidy_map)         { create(:subsidy_map, organization_id: program.id) }
end

def build_service_request
  let!(:service_request)     { FactoryGirl.create(:service_request_without_validations, status: "draft") }
  let!(:institution)         { create(:institution,name: 'Medical University of South Carolina', order: 1, abbreviation: 'MUSC', is_available: 1)}
  let!(:provider)            { create(:provider,parent_id:institution.id,name: 'South Carolina Clinical and Translational Institute (SCTR)',order: 1,css_class: 'blue-provider', abbreviation: 'SCTR1',process_ssrs: 0,is_available: 1)}
  let!(:program)             { create(:program,type:'Program',parent_id:provider.id,name:'Office of Biomedical Informatics',order:1, abbreviation:'Informatics', process_ssrs:  0, is_available: 1, show_in_cwf: true)}
  let!(:core)                { create(:core, parent_id: program.id)}
  let!(:core_17)             { create(:core, parent_id: program.id, abbreviation: "Nutrition", show_in_cwf: true) }
  let!(:core_13)             { create(:core, parent_id: program.id, abbreviation: "Nursing", show_in_cwf: true) }
  let!(:core_16)             { create(:core, parent_id: program.id, abbreviation: "Lab and Biorepository", show_in_cwf: true) }
  let!(:core_15)             { create(:core, parent_id: program.id, abbreviation: "Imaging", show_in_cwf: true) }
  let!(:core_62)             { create(:core, parent_id: program.id, abbreviation: "PWF Services", show_in_cwf: true) }
  let!(:sub_service_request) { create(:sub_service_request, ssr_id: "0001", service_request_id: service_request.id, organization_id: program.id,status: "draft")}


  before :each do
    program.tag_list.add("ctrc")
    program.save
    service_request.update_attribute(:service_requester_id, Identity.find_by_ldap_uid("jug2").id)
    service_request.update_attribute(:status, 'draft')
  end
end

def add_visits
  create_visits
  update_visits
  update_visit_groups
end

def create_visits
  service_request.reload
  visit_names = ["I'm", "a", 'little', 'teapot', 'short', 'and', 'stout', 'visit', 'me', 'please']
  service_request.arms.each do |arm|
    service_request.per_patient_per_visit_line_items.each do |line_item|
      arm.create_line_items_visit(line_item)
    end
  end
  arm1.reload
  arm2.reload
end

def update_visits
  service_request.arms.each do |arm|
    arm.visits.each do |visit|
      visit.update_attributes(quantity: 15, research_billing_qty: 5, insurance_billing_qty: 5, effort_billing_qty: 5, billing: Faker::Lorem.word)
    end
  end
end

def update_visit_groups
  service_request.arms.each do |arm|
    arm.populate_subjects
    arm.visit_groups.each do |vg|
      vg.update_attributes(day: vg.position)
    end
  end
end

def build_arms
  let!(:protocol_for_service_request_id) {project.id rescue study.id}
  let!(:arm1)                { create(:arm, name: "Arm", protocol_id: protocol_for_service_request_id, visit_count: 10, subject_count: 2)}
  let!(:arm2)                { create(:arm, name: "Arm2", protocol_id: protocol_for_service_request_id, visit_count: 5, subject_count: 4)}
  let!(:visit_group1)         { create(:visit_group, arm_id: arm1.id, position: 1, day: 1)}
  let!(:visit_group2)         { create(:visit_group, arm_id: arm2.id, position: 1, day: 1)}
  # let!(:visit_group)         { create(:visit_group, arm_id: arm1.id, position: 1, day: 1)}
end

def build_project
  let!(:project) {
    protocol = Project.create(attributes_for(:protocol))
    protocol.update_attributes(funding_status: "funded", funding_source: "federal", indirect_cost_rate: 50.0, start_date: Time.now, end_date: Time.now + 2.month)
    protocol.save validate: false
    identity = Identity.find_by_ldap_uid('jug2')
    create(
        :project_role,
        protocol_id:     protocol.id,
        identity_id:     identity.id,
        project_rights:  "approve",
        role:            "primary-pi")
    identity2 = Identity.find_by_ldap_uid('jpl6@musc.edu')
    create(
        :project_role,
        protocol_id:     protocol.id,
        identity_id:     identity2.id,
        project_rights:  "approve",
        role:            "business-grants-manager")
    service_request.update_attribute(:protocol_id, protocol.id)
    protocol.reload
    service_request.reload
    protocol
  }
end

def build_study
  build_study_type_questions()
  let!(:study) {

    protocol = build(:study)
    protocol.update_attributes(funding_status: "funded", funding_source: "federal", indirect_cost_rate: 50.0, start_date: Time.now, end_date: Time.now + 2.month)
    protocol.save validate: false
    identity = Identity.find_by_ldap_uid('jug2')
    create(
        :project_role,
        protocol_id:     protocol.id,
        identity_id:     identity.id,
        project_rights:  "approve",
        role:            "primary-pi")
    identity2 = Identity.find_by_ldap_uid('jpl6@musc.edu')
    create(
        :project_role,
        protocol_id:     protocol.id,
        identity_id:     identity2.id,
        project_rights:  "approve",
        role:            "business-grants-manager")
    service_request.update_attribute(:protocol_id, protocol.id)
    protocol.reload
    protocol
  }
  build_study_type_answers()
end

def build_clinical_data all_subjects = nil
  service_request.arms.each do |arm|
    arm.subjects.each do |subject|
      subject.calendar.populate(arm.visit_groups)
    end
  end
end

def build_fake_notification
  let!(:sender) {create(:identity, last_name:'Glenn2', first_name:'Julia2', ldap_uid:'jug3', institution:'medical_university_of_south_carolina', college:'college_of_medecine', department:'other', email:'glennj2@musc.edu', credentials:'BS,    MRA', catalog_overlord: true, password:'p4ssword', password_confirmation:'p4ssword', approved: true)}
  let!(:notification) {create(:notification, sub_service_request_id: sub_service_request.id, originator_id: sender.id)}
  let!(:message) {create(:message, notification_id: notification.id, to: jug2.id, from: sender.id, email: "test@test.org", subject: "test message", body: "This is a test, and only a test")}
  let!(:user_notification) {create(:user_notification, identity_id: jug2.id, notification_id: notification.id, read: false)}
end
