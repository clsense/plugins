{#

Copyright (C) 2017 Frank Wall
OPNsense® is Copyright © 2014-2015 by Deciso B.V.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1.  Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.

2.  Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES,
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

#}

<script>

    $( document ).ready(function() {

        /***********************************************************************
         * link grid actions
         **********************************************************************/

        $("#grid-actions").UIBootgrid(
            {   search:'/api/acmeclient/actions/search',
                get:'/api/acmeclient/actions/get/',
                set:'/api/acmeclient/actions/set/',
                add:'/api/acmeclient/actions/add/',
                del:'/api/acmeclient/actions/del/',
                toggle:'/api/acmeclient/actions/toggle/',
                options: {
                    rowCount:[10,25,50,100,500,1000]
                }
            }
        );

        // hook into on-show event for dialog to extend layout.
        $('#DialogAction').on('shown.bs.modal', function (e) {
            $("#action\\.type").change(function(){
                var service_id = 'table_optional_' + $(this).val();
                $(".table_optional").hide();
                $("."+service_id).show();
            });
            $("#action\\.type").change(function(){
                $(".method_table").hide();
                $(".method_table_"+$(this).val()).show();
            });
            $("#action\\.type").change();
        })
    });

</script>

<ul class="nav nav-tabs" data-tabs="tabs" id="maintabs">
    <li class="active"><a data-toggle="tab" href="#actions">{{ lang._('Restart Actions') }}</a></li>
</ul>

<div class="tab-content content-box tab-content">
    <div id="actions" class="tab-pane fade in active">
        <table id="grid-actions" class="table table-condensed table-hover table-striped table-responsive" data-editDialog="DialogAction">
            <thead>
            <tr>
                <th data-column-id="enabled" data-width="6em" data-type="string" data-formatter="rowtoggle">{{ lang._('Enabled') }}</th>
                <th data-column-id="name" data-type="string">{{ lang._('Name') }}</th>
                <th data-column-id="description" data-type="string">{{ lang._('Description') }}</th>
                <th data-column-id="commands" data-width="7em" data-formatter="commands" data-sortable="false">{{ lang._('Commands') }}</th>
                <th data-column-id="uuid" data-type="string" data-identifier="true"  data-visible="false">{{ lang._('ID') }}</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
            <tfoot>
            <tr>
                <td></td>
                <td>
                    <button data-action="add" type="button" class="btn btn-xs btn-default"><span class="fa fa-plus"></span></button>
                    <button data-action="deleteSelected" type="button" class="btn btn-xs btn-default"><span class="fa fa-trash-o"></span></button>
                </td>
            </tr>
            </tfoot>
        </table>
    </div>
</div>

{# include dialogs #}
{{ partial("layout_partials/base_dialog",['fields':formDialogAction,'id':'DialogAction','label':lang._('Edit Restart Action')])}}
