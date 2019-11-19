# Copyright © 2011-2019 MUSC Foundation for Research Development~
# All rights reserved.~

# Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:~

# 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.~

# 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following~
# disclaimer in the documentation and/or other materials provided with the distribution.~

# 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products~
# derived from this software without specific prior written permission.~

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,~
# BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT~
# SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL~
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS~
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR~
# TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.~

module API
  module V1
    module Entities
      module Full
        class Protocol < API::V1::Entities::Shallow::Protocol
          root 'protocols', 'protocol'

          expose  :type,
                  :next_ssr_id,
                  :short_title,
                  :title,
                  :sponsor_name,
                  :brief_description,
                  :indirect_cost_rate,
                  :udak_project_number,
                  :funding_rfa,
                  :funding_status,
                  :potential_funding_source,
                  :funding_source,
                  :federal_grant_serial_number,
                  :federal_grant_title,
                  :federal_grant_code_id,
                  :federal_non_phs_sponsor,
                  :federal_phs_sponsor,
                  :potential_funding_source_other,
                  :funding_source_other,
                  :last_epic_push_time,
                  :last_epic_push_status,
                  :billing_business_manager_static_email,
                  :selected_for_epic,
                  :study_type_question_group_id,
                  :archived

          with_options(format_with: :iso_timestamp) do
            expose :start_date
            expose :end_date
            expose :potential_funding_start_date
            expose :funding_start_date
            expose :recruitment_start_date
            expose :recruitment_end_date
          end
        end
      end
    end
  end
end
