# Copyright © 2011-2016 MUSC Foundation for Research Development
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

require 'rails_helper'

RSpec.describe 'User edits epic answers', js: true do
  let_there_be_lane
  fake_login_for_each_test
  build_study_type_question_groups
  build_study_type_questions

  context 'User is an admin' do
    before :each do
      @protocol       = create(:protocol_without_validations,
                                type: "Study",
                                primary_pi: jug2,
                                funding_status: "funded",
                                funding_source: "foundation")
      organization    = create(:organization)
      service_request = create(:service_request_without_validations,
                               protocol: @protocol)
                        create(:sub_service_request_without_validations,
                               organization: organization,
                               service_request: service_request,
                               status: 'draft')
                        create(:super_user, identity: jug2,
                               organization: organization)
      visit edit_dashboard_protocol_path(@protocol)
      wait_for_javascript_to_finish
    end

    it 'and sees edit button next to Publish Study in Epic' do
      expect(page).to have_css(
        'a.btn.btn-warning.edit-answers',
        text: 'Edit'
      )
    end

    it 'should have a cancel edit button' do
      find('.edit-answers').click

      expect(page).to have_css(
        'a.btn.btn-danger.cancel-edit',
        text: 'Cancel Edit'
      )
    end

    scenario 'when edit button is clicked, change answers that give study type 1' do
      find('a.btn.btn-warning.edit-answers').click
      wait_for_javascript_to_finish

      find('#study_selected_for_epic_true_button').click
      wait_for_javascript_to_finish

      bootstrap_select '#study_type_answer_certificate_of_conf_answer', 'Yes'
      wait_for_javascript_to_finish

      expect(page).to have_content('De-identified  Research  Participant')
    end

    scenario 'study type 11' do
      find('a.btn.btn-warning.edit-answers').click
      wait_for_javascript_to_finish

      find('#study_selected_for_epic_true_button').click
      wait_for_javascript_to_finish

      bootstrap_select '#study_type_answer_certificate_of_conf_answer', 'No'
      bootstrap_select '#study_type_answer_higher_level_of_privacy_answer', 'No'
      bootstrap_select '#study_type_answer_epic_inbasket_answer', 'No'
      bootstrap_select '#study_type_answer_research_active_answer', 'No'
      bootstrap_select '#study_type_answer_restrict_sending_answer', 'No'
      wait_for_javascript_to_finish

      expect(page).to have_content('Full Epic  Functionality: no  notification, no  pink  header, no  MyChart access.')
    end
  end
end

