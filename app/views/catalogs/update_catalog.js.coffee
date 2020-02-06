# Copyright © 2011-2019 MUSC Foundation for Research Development
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

$('#serviceCatalog').replaceWith("<%= j render 'catalogs/service_accordion', service_request: @service_request, locked_org_ids: @locked_org_ids %>")
$('#catalogCenter').replaceWith("<%= j render 'catalogs/catalog_center', organization: nil, service_request: @service_request, locked_org_ids: @locked_org_ids %>")

# Add include_external to the URL
url = new URL(window.location.href)
url.searchParams.set('include_external', "<%= params[:include_external] %>")
window.history.pushState({}, null, url.href)
$('#loginLink').attr('href', "<%= new_identity_session_path(srid: @service_request.id, include_external: params[:include_external]) %>")
$('#serviceCatalogForm').attr('action', "<%= navigate_service_request_path(srid: @service_request.id, include_external: params[:include_external]) %>")

initializeServiceCatalogSearch()

$(document).trigger('ajax:complete') # rails-ujs element replacement bug fix