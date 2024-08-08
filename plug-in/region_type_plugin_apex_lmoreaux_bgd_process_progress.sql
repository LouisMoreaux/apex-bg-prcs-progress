prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2024.05.31'
,p_release=>'24.1.2'
,p_default_workspace_id=>22914957980901228278
,p_default_application_id=>153221
,p_default_id_offset=>0
,p_default_owner=>'L'
);
end;
/
 
prompt APPLICATION 153221 - Plug-ins
--
-- Application Export:
--   Application:     153221
--   Name:            Plug-ins
--   Date and Time:   13:49 Thursday August 8, 2024
--   Exported By:     MOREAUX.LOUIS@GMAIL.COM
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 20024237253925305900
--   Manifest End
--   Version:         24.1.2
--   Instance ID:     63113759365424
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/region_type/apex_lmoreaux_bgd_process_progress
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(20024237253925305900)
,p_plugin_type=>'REGION TYPE'
,p_name=>'APEX.LMOREAUX.BGD_PROCESS_PROGRESS'
,p_display_name=>'Background Process Progress '
,p_javascript_file_urls=>'#PLUGIN_FILES#js/bg-process-progress#MIN#.js'
,p_css_file_urls=>'#PLUGIN_FILES#css/bg-process-progress#MIN#.css'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'procedure render (',
'    p_region  in            apex_plugin.t_region',
'  , p_plugin  in            apex_plugin.t_plugin',
'  , p_param   in            apex_plugin.t_region_render_param',
'  ,  p_result in out nocopy apex_plugin.t_region_render_result',
')',
'is',
'    l_return apex_plugin.t_region_render_result;',
'begin',
'',
'    apex_plugin_util.debug_region',
'    (',
'      p_plugin => p_plugin',
'    , p_region => p_region',
'    );',
'    sys.htp.prn( ',
'        ''<apex-bg-prcs-progress region-id="'' || p_region.static_id ',
'        || ''" ajax-identifier="'' || apex_plugin.get_ajax_identifier ',
'        ||''" data-execution-id="''|| apex_util.get_session_state(p_region.attributes.get_varchar2( ''execution_id'')) ',
'        ||''" data-hash="''|| apex_util.get_hash(apex_t_varchar2 ( p_region.attribute_01 )) ',
'        ||''" data-progress-type="'' || p_region.attributes.get_varchar2( ''progress_type'')',
'        ||''" data-color-variable="'' ||  p_region.attributes.get_varchar2( ''color_variable'')',
'        ||''" data-display-percentage="'' || p_region.attributes.get_varchar2( ''display_percentage'')',
'        ||''" data-display-status="'' || p_region.attributes.get_varchar2( ''display_status'')',
'        ||''" data-bar-width="'' || p_region.attributes.get_varchar2( ''bar_width'') ',
'        ||''" data-bar-height="'' || p_region.attributes.get_varchar2( ''bar_height'') ',
'        ||''" data-circle-size="'' || p_region.attributes.get_varchar2( ''circle_size'')',
'        ||''" data-redirect-on-completion="'' || p_region.attributes.get_varchar2( ''redirect_on_completion'')  ',
'        ||''" data-redirect-link="'' || apex_util.prepare_url(apex_plugin_util.replace_substitutions(p_region.attributes.get_varchar2( ''redirect_link'')))   ',
'        ||''" data-max-iteration="'' || p_plugin.attributes.get_varchar2( ''max_iteration'') ',
'        ||''" data-sleep-time="'' || p_plugin.attributes.get_varchar2( ''sleep_time'') ',
'        ||''" role="progressbar"',
'             aria-valuenow="0"',
'             aria-valuemin="0"',
'             aria-valuetext=""',
'             aria-valuemax="100" >'');',
'    sys.htp.prn(''</apex-bg-prcs-progress>'' );',
'  end render;',
'',
'  procedure ajax (',
'    p_plugin in            apex_plugin.t_plugin,',
'    p_region in            apex_plugin.t_region,',
'    p_param  in            apex_plugin.t_region_ajax_param,',
'    p_result in out nocopy apex_plugin.t_region_ajax_result',
'  )',
'  is',
'    l_context    apex_exec.t_context;',
'    l_parameters apex_exec.t_parameters;',
'  begin',
'    apex_plugin_util.debug_region',
'    (',
'      p_plugin => p_plugin',
'    , p_region => p_region',
'    );',
'',
'    apex_exec.add_parameter( l_parameters, ''EXECUTION_ID'',  apex_util.get_session_state(p_region.attributes.get_varchar2( ''execution_id'')) );',
'',
'    l_context := apex_exec.open_query_context(',
'        p_location          => apex_exec.c_location_local_db,',
'        p_sql_query         => ''select status, status_code, status_message, sofar, totalwork from apex_appl_page_bg_proc_status where execution_id = :EXECUTION_ID'',',
'        p_sql_parameters    => l_parameters,',
'        p_total_row_count   => true ',
'    );',
'',
'    apex_json.open_object;',
'',
'    if apex_exec.get_total_row_count( p_context => l_context ) > 0 then',
'        while apex_exec.next_row( l_context ) loop',
'            apex_json.write',
'            (',
'              p_name  => ''success''',
'            , p_value => true',
'            );',
'',
'            apex_json.write(',
'                p_name => ''status'',',
'                p_value => apex_exec.get_varchar2( p_context => l_context, p_column_name => ''STATUS'' )',
'            );',
'',
'            apex_json.write(',
'                p_name => ''status_code'',',
'                p_value => apex_exec.get_varchar2( p_context => l_context, p_column_name => ''STATUS_CODE'' )',
'            );',
'',
'            apex_json.write(',
'                p_name => ''status_message'',',
'                p_value => apex_exec.get_varchar2( p_context => l_context, p_column_name => ''STATUS_MESSAGE'' )',
'            );',
'',
'            apex_json.write(',
'                p_name => ''sofar'',',
'                p_value => apex_exec.get_number( p_context => l_context, p_column_name => ''SOFAR'' )',
'            );',
'',
'            apex_json.write(',
'                p_name => ''totalwork'',',
'                p_value => apex_exec.get_number( p_context => l_context, p_column_name => ''TOTALWORK'' )',
'            );',
'        end loop;',
'    else',
'      apex_json.write',
'      (',
'        p_name  => ''success''',
'      , p_value => false',
'      );',
'',
'    end if;',
'',
'    apex_json.close_object;',
'',
'    apex_exec.close( l_context );',
'',
'    exception',
'    when others then',
'        apex_exec.close( l_context );',
'        raise;    ',
'  end ajax;'))
,p_api_version=>3
,p_render_function=>'render'
,p_ajax_function=>'ajax'
,p_standard_attributes=>'AJAX_ITEMS_TO_SUBMIT:NO_DATA_FOUND_MESSAGE'
,p_substitute_attributes=>true
,p_version_scn=>15551964116342
,p_subscribe_plugin_settings=>true
,p_help_text=>'Region plug-in that monitor background processes execution'
,p_version_identifier=>'1.0'
,p_about_url=>'https://lmoreaux.hashnode.dev/'
,p_files_version=>239
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(22835991496245879789)
,p_plugin_id=>wwv_flow_imp.id(20024237253925305900)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_static_id=>'max_iteration'
,p_prompt=>'Max Iteration'
,p_attribute_type=>'INTEGER'
,p_is_required=>true
,p_default_value=>'100'
,p_is_translatable=>false
,p_help_text=>'Maximum number of iteration'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(22847381722758975097)
,p_plugin_id=>wwv_flow_imp.id(20024237253925305900)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_static_id=>'sleep_time'
,p_prompt=>'Sleep Time (ms)'
,p_attribute_type=>'INTEGER'
,p_is_required=>false
,p_default_value=>'1000'
,p_unit=>'milliseconds'
,p_is_translatable=>false
,p_help_text=>'Waiting time between two AJAX call to get the execution status'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(20033187713618482272)
,p_plugin_id=>wwv_flow_imp.id(20024237253925305900)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_static_id=>'execution_id'
,p_prompt=>'Execution Id'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>true
,p_is_translatable=>false
,p_help_text=>'Page item containing the Execution ID you wish to monitor'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(20494409154090942532)
,p_plugin_id=>wwv_flow_imp.id(20024237253925305900)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_static_id=>'progress_type'
,p_prompt=>'Progress Type'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'bar'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Type of progress (Bar or Circular)'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(20494266883690201167)
,p_plugin_attribute_id=>wwv_flow_imp.id(20494409154090942532)
,p_display_sequence=>10
,p_display_value=>'Bar'
,p_return_value=>'bar'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(20494285176929210885)
,p_plugin_attribute_id=>wwv_flow_imp.id(20494409154090942532)
,p_display_sequence=>20
,p_display_value=>'Circular'
,p_return_value=>'circular'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(20498648337431989822)
,p_plugin_id=>wwv_flow_imp.id(20024237253925305900)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_static_id=>'display_percentage'
,p_prompt=>'Display Percentage?'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'Display the completion percentage (Y/N)'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(20498667715231993764)
,p_plugin_id=>wwv_flow_imp.id(20024237253925305900)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_static_id=>'display_status'
,p_prompt=>'Display Status?'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'Display the execution status (Y/N)'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(20592673907152544659)
,p_plugin_id=>wwv_flow_imp.id(20024237253925305900)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_static_id=>'color_variable'
,p_prompt=>'Color Variable'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'--u-color-1'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Choose the color.<br>Based on the Universal Theme colors, more info <a href="https://apex.oracle.com/pls/apex/r/apex_pm/ut/color-and-status-modifiers">here</a>.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(20593493115141292524)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>10
,p_display_value=>'u-color-1'
,p_return_value=>'--u-color-1'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(20593510086365293675)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>20
,p_display_value=>'u-color-2'
,p_return_value=>'--u-color-2'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(20594621803704294786)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>30
,p_display_value=>'u-color-3'
,p_return_value=>'--u-color-3'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(20594395380370552506)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>40
,p_display_value=>'u-color-4'
,p_return_value=>'--u-color-4'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(20594940503956568299)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>50
,p_display_value=>'u-color-5'
,p_return_value=>'--u-color-5'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795442497750856160)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>60
,p_display_value=>'u-color-6'
,p_return_value=>'--u-color-6'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795443557284857378)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>70
,p_display_value=>'u-color-7'
,p_return_value=>'--u-color-7'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795445589611858408)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>80
,p_display_value=>'u-color-8'
,p_return_value=>'--u-color-8'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795447586633859311)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>90
,p_display_value=>'u-color-9'
,p_return_value=>'--u-color-9'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795668865239117080)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>100
,p_display_value=>'u-color-10'
,p_return_value=>'--u-color-10'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795456662883861473)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>110
,p_display_value=>'u-color-11'
,p_return_value=>'--u-color-11'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795461938496862675)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>120
,p_display_value=>'u-color-12'
,p_return_value=>'--u-color-12'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795463323960863633)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>130
,p_display_value=>'u-color-13'
,p_return_value=>'--u-color-13'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795699978573121182)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>140
,p_display_value=>'u-color-14'
,p_return_value=>'--u-color-14'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795465777711865559)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>150
,p_display_value=>'u-color-15'
,p_return_value=>'--u-color-15'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795468565034866504)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>160
,p_display_value=>'u-color-16'
,p_return_value=>'--u-color-16'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795470857076867388)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>170
,p_display_value=>'u-color-17'
,p_return_value=>'--u-color-17'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795471687512868281)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>180
,p_display_value=>'u-color-18'
,p_return_value=>'--u-color-18'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795475436476869120)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>190
,p_display_value=>'u-color-19'
,p_return_value=>'--u-color-19'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795476648859870035)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>200
,p_display_value=>'u-color-20'
,p_return_value=>'--u-color-20'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795481780653870787)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>210
,p_display_value=>'u-color-21'
,p_return_value=>'--u-color-21'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795482956036871696)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>220
,p_display_value=>'u-color-22'
,p_return_value=>'--u-color-22'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795485956736872719)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>230
,p_display_value=>'u-color-23'
,p_return_value=>'--u-color-23'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795492687780873791)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>240
,p_display_value=>'u-color-24'
,p_return_value=>'--u-color-24'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795740848630131783)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>250
,p_display_value=>'u-color-25'
,p_return_value=>'--u-color-25'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795495497466876440)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>260
,p_display_value=>'u-color-26'
,p_return_value=>'--u-color-26'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795749631744133894)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>270
,p_display_value=>'u-color-27'
,p_return_value=>'--u-color-27'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795497954383878298)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>280
,p_display_value=>'u-color-28'
,p_return_value=>'--u-color-28'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795759905786135668)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>290
,p_display_value=>'u-color-29'
,p_return_value=>'--u-color-29'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795763064226136429)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>300
,p_display_value=>'u-color-30'
,p_return_value=>'--u-color-30'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795500317596880677)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>310
,p_display_value=>'u-color-31'
,p_return_value=>'--u-color-31'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795770609122137904)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>320
,p_display_value=>'u-color-32'
,p_return_value=>'--u-color-32'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795772791724138641)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>330
,p_display_value=>'u-color-33'
,p_return_value=>'--u-color-33'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795777126213139441)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>340
,p_display_value=>'u-color-34'
,p_return_value=>'--u-color-34'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795780954159140291)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>350
,p_display_value=>'u-color-35'
,p_return_value=>'--u-color-35'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795785504160141020)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>360
,p_display_value=>'u-color-36'
,p_return_value=>'--u-color-36'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795792630678141804)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>370
,p_display_value=>'u-color-37'
,p_return_value=>'--u-color-37'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795800472440142654)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>380
,p_display_value=>'u-color-38'
,p_return_value=>'--u-color-38'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795515011062887149)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>390
,p_display_value=>'u-color-39'
,p_return_value=>'--u-color-39'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795517207041888133)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>400
,p_display_value=>'u-color-40'
,p_return_value=>'--u-color-40'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795524003499889090)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>410
,p_display_value=>'u-color-41'
,p_return_value=>'--u-color-41'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795819796077146611)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>420
,p_display_value=>'u-color-42'
,p_return_value=>'--u-color-42'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795528474877890987)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>430
,p_display_value=>'u-color-43'
,p_return_value=>'--u-color-43'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795529751545891804)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>440
,p_display_value=>'u-color-44'
,p_return_value=>'--u-color-44'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(22795844995183153410)
,p_plugin_attribute_id=>wwv_flow_imp.id(20592673907152544659)
,p_display_sequence=>450
,p_display_value=>'u-color-45'
,p_return_value=>'--u-color-45'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(22798787998341951420)
,p_plugin_id=>wwv_flow_imp.id(20024237253925305900)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_static_id=>'bar_width'
,p_prompt=>'Width'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'500px'
,p_unit=>'CSS unit'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(20494409154090942532)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'bar'
,p_help_text=>'Width of the Progress Bar'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(22799204926708956825)
,p_plugin_id=>wwv_flow_imp.id(20024237253925305900)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_static_id=>'bar_height'
,p_prompt=>'Height'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'30px'
,p_unit=>'CSS unit'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(20494409154090942532)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'bar'
,p_help_text=>'Height or the Progress Bar'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(22799198374399220830)
,p_plugin_id=>wwv_flow_imp.id(20024237253925305900)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>100
,p_static_id=>'circle_size'
,p_prompt=>'Size'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'150px'
,p_unit=>'CSS unit'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(20494409154090942532)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'circular'
,p_help_text=>'Size of the circular progress'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(22800856875885303916)
,p_plugin_id=>wwv_flow_imp.id(20024237253925305900)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>110
,p_static_id=>'redirect_on_completion'
,p_prompt=>'Redirect On Completion?'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
,p_help_text=>'Redirect on execution completion (Y/N)'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(22800861624031306573)
,p_plugin_id=>wwv_flow_imp.id(20024237253925305900)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>120
,p_static_id=>'redirect_link'
,p_prompt=>'Redirect Link'
,p_attribute_type=>'LINK'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(22800856875885303916)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_help_text=>'Link to redirect the user upon completion'
);
wwv_flow_imp_shared.create_plugin_event(
 p_id=>wwv_flow_imp.id(22802517408699440384)
,p_plugin_id=>wwv_flow_imp.id(20024237253925305900)
,p_name=>'apex-bg-prcs-progress-exec-completed'
,p_display_name=>'Execution Completed'
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '28202820242C2064656275672C20726567696F6E2C207574696C2C207769646765745574696C2029203D3E207B0A202020202275736520737472696374223B0A0A20202020636F6E73742062617254656D706C617465203D20646F63756D656E742E6372';
wwv_flow_imp.g_varchar2_table(2) := '65617465456C656D656E74282774656D706C61746527293B0A2020202062617254656D706C6174652E6964203D202762672D70726F67726573732D6261722D74656D706C617465273B0A2020202062617254656D706C6174652E696E6E657248544D4C20';
wwv_flow_imp.g_varchar2_table(3) := '3D20600A202020203C7374796C653E0A20202020202020203A686F7374207B0A2020202020202020202020202D2D6261722D77696474683A2035303070783B0A2020202020202020202020202D2D6261722D6865696768743A20333070783B0A20202020';
wwv_flow_imp.g_varchar2_table(4) := '20202020202020202D2D70726F67726573732D626F726465722D7261646975733A203172656D3B0A2020202020202020202020202D2D736F6661723A20303B0A2020202020202020202020202D2D746F74616C776F726B3A3130303B0A20202020202020';
wwv_flow_imp.g_varchar2_table(5) := '20202020202D2D666F726567726F756E642D77696474683A2063616C632863616C6328766172282D2D736F66617229202A20766172282D2D6261722D77696474682929202F20766172282D2D746F74616C776F726B29293B0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(6) := '202D2D666F726567726F756E642D626F726465722D746F702D72696768742D7261646975733A203070783B0A2020202020202020202020202D2D666F726567726F756E642D626F726465722D626F74746F6D2D72696768742D7261646975733A20307078';
wwv_flow_imp.g_varchar2_table(7) := '3B0A202020202020202020202020646973706C61793A20666C65783B0A202020202020202020202020616C69676E2D6974656D733A2063656E7465723B0A2020202020202020202020206A7573746966792D636F6E74656E743A2063656E7465723B0A20';
wwv_flow_imp.g_varchar2_table(8) := '20202020202020202020206865696768743A206D696E2D636F6E74656E743B0A20202020202020207D0A0A20202020202020202E70726F67726573732D636F6E7461696E6572207B0A202020202020202020202020646973706C61793A20666C65783B0A';
wwv_flow_imp.g_varchar2_table(9) := '202020202020202020202020666C65782D646972656374696F6E3A20636F6C756D6E3B0A20202020202020207D0A0A20202020202020202E6261636B67726F756E642D70726F67726573732C202E666F726567726F756E642D70726F6772657373207B0A';
wwv_flow_imp.g_varchar2_table(10) := '20202020202020202020202077696474683A20766172282D2D6261722D7769647468293B0A2020202020202020202020206865696768743A20766172282D2D6261722D686569676874293B0A2020202020202020202020206261636B67726F756E642D63';
wwv_flow_imp.g_varchar2_table(11) := '6F6C6F723A20766172282D2D6261636B67726F756E642D636F6C6F72293B0A202020202020202020202020626F726465722D7261646975733A20766172282D2D70726F67726573732D626F726465722D726164697573293B0A20202020202020207D0A0A';
wwv_flow_imp.g_varchar2_table(12) := '20202020202020202E666F726567726F756E642D70726F6772657373207B0A20202020202020202020202077696474683A20766172282D2D666F726567726F756E642D7769647468293B0A2020202020202020202020206261636B67726F756E642D636F';
wwv_flow_imp.g_varchar2_table(13) := '6C6F723A20766172282D2D666F726567726F756E642D636F6C6F72293B0A202020202020202020202020626F726465722D746F702D72696768742D7261646975733A20766172282D2D666F726567726F756E642D626F726465722D746F702D7269676874';
wwv_flow_imp.g_varchar2_table(14) := '2D726164697573293B0A202020202020202020202020626F726465722D626F74746F6D2D72696768742D7261646975733A20766172282D2D666F726567726F756E642D626F726465722D626F74746F6D2D72696768742D726164697573293B0A20202020';
wwv_flow_imp.g_varchar2_table(15) := '20202020202020207472616E736974696F6E3A20776964746820317320656173653B0A202020202020202020202020616C69676E2D636F6E74656E743A2063656E7465723B0A20202020202020207D0A0A20202020202020202E70726F67726573732D73';
wwv_flow_imp.g_varchar2_table(16) := '7461747573207B0A202020202020202020202020646973706C61793A20766172282D2D70726F67726573732D7374617475732D646973706C6179293B0A202020202020202020202020746578742D616C69676E3A2063656E7465723B0A20202020202020';
wwv_flow_imp.g_varchar2_table(17) := '20202020206D617267696E3A202E31323572656D3B0A20202020202020207D0A0A20202020202020202E70726F67726573732D70657263656E74616765207B0A202020202020202020202020636F6C6F723A20766172282D2D70726F67726573732D7065';
wwv_flow_imp.g_varchar2_table(18) := '7263656E746167652D636F6C6F72293B0A202020202020202020202020666F6E742D7765696768743A20766172282D2D70726F67726573732D70657263656E746167652D666F6E742D7765696768742C20353030293B0A20202020202020202020202064';
wwv_flow_imp.g_varchar2_table(19) := '6973706C61793A20766172282D2D70726F67726573732D70657263656E746167652D646973706C6179293B0A2020202020202020202020206D617267696E2D6C6566743A20302E3572656D3B0A20202020202020207D0A202020203C2F7374796C653E0A';
wwv_flow_imp.g_varchar2_table(20) := '202020203C64697620636C6173733D2270726F67726573732D636F6E7461696E6572223E0A20202020202020203C64697620636C6173733D2270726F67726573732D737461747573223E3C2F6469763E0A20202020202020203C64697620636C6173733D';
wwv_flow_imp.g_varchar2_table(21) := '226261636B67726F756E642D70726F6772657373223E0A2020202020202020202020203C64697620636C6173733D22666F726567726F756E642D70726F6772657373223E0A202020202020202020202020202020203C7370616E20636C6173733D227072';
wwv_flow_imp.g_varchar2_table(22) := '6F67726573732D70657263656E74616765223E30253C2F7370616E3E0A2020202020202020202020203C2F6469763E0A20202020202020203C2F6469763E0A202020203C2F6469763E0A20202020603B0A0A20202020636F6E73742063697263756C6172';
wwv_flow_imp.g_varchar2_table(23) := '54656D706C617465203D20646F63756D656E742E637265617465456C656D656E74282774656D706C61746527293B0A2020202063697263756C617254656D706C6174652E6964203D202762672D70726F67726573732D63697263756C61722D74656D706C';
wwv_flow_imp.g_varchar2_table(24) := '617465273B0A2020202063697263756C617254656D706C6174652E696E6E657248544D4C203D20600A202020203C7374796C653E0A0A20202020202020203A686F7374207B0A2020202020202020202020202D2D6D61782D77696474683A203530307078';
wwv_flow_imp.g_varchar2_table(25) := '3B0A2020202020202020202020202D2D636972636C652D73697A653A2031353070783B0A2020202020202020202020202D2D736F6661723A20303B0A2020202020202020202020202D2D746F74616C776F726B3A3130303B0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(26) := '202D2D70657263656E746167653A20303B0A202020202020202020202020646973706C61793A20666C65783B0A202020202020202020202020616C69676E2D6974656D733A2063656E7465723B0A2020202020202020202020206A7573746966792D636F';
wwv_flow_imp.g_varchar2_table(27) := '6E74656E743A2063656E7465723B0A2020202020202020202020206865696768743A206D696E2D636F6E74656E743B0A20202020202020207D0A0A20202020202020202E70726F67726573732D636F6E7461696E6572207B0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(28) := '20646973706C61793A20666C65783B0A202020202020202020202020666C65782D646972656374696F6E3A20636F6C756D6E3B0A202020202020202020202020616C69676E2D6974656D733A2063656E7465723B0A20202020202020207D0A0A20202020';
wwv_flow_imp.g_varchar2_table(29) := '202020202E70726F67726573732D737461747573207B0A202020202020202020202020646973706C61793A20766172282D2D70726F67726573732D7374617475732D646973706C6179293B0A202020202020202020202020746578742D616C69676E3A20';
wwv_flow_imp.g_varchar2_table(30) := '63656E7465723B0A2020202020202020202020206D617267696E3A202E31323572656D3B0A202020202020202020202020636F6C6F723A20766172282D2D75742D636F6D706F6E656E742D746578742D64656661756C742D636F6C6F72293B0A20202020';
wwv_flow_imp.g_varchar2_table(31) := '202020207D0A0A20202020202020202E70726F67726573732D636972636C65207B0A202020202020202020202020706F736974696F6E3A2072656C61746976653B0A20202020202020202020202077696474683A20766172282D2D636972636C652D7369';
wwv_flow_imp.g_varchar2_table(32) := '7A65293B0A2020202020202020202020206865696768743A20766172282D2D636972636C652D73697A65293B0A2020202020202020202020207472616E736974696F6E3A202D2D70657263656E7461676520317320656173652D696E2D6F75743B0A2020';
wwv_flow_imp.g_varchar2_table(33) := '2020202020207D0A0A20202020202020202E70726F67726573732D636972636C653A3A6265666F7265207B0A202020202020202020202020636F6E74656E743A2027273B0A202020202020202020202020706F736974696F6E3A206162736F6C7574653B';
wwv_flow_imp.g_varchar2_table(34) := '0A202020202020202020202020746F703A20303B0A2020202020202020202020206C6566743A20303B0A20202020202020202020202077696474683A20313030253B0A2020202020202020202020206865696768743A20313030253B0A20202020202020';
wwv_flow_imp.g_varchar2_table(35) := '2020202020626F726465722D7261646975733A203530253B0A2020202020202020202020206261636B67726F756E643A20636F6E69632D6772616469656E7428766172282D2D666F726567726F756E642D636F6C6F72292063616C6328766172282D2D70';
wwv_flow_imp.g_varchar2_table(36) := '657263656E7461676529202A203125292C20766172282D2D6261636B67726F756E642D636F6C6F7229203025293B0A2020202020202020202020207A2D696E6465783A20313B0A20202020202020207D0A0A20202020202020202E70726F67726573732D';
wwv_flow_imp.g_varchar2_table(37) := '636972636C653A3A6166746572207B0A202020202020202020202020636F6E74656E743A2027273B0A202020202020202020202020706F736974696F6E3A206162736F6C7574653B0A202020202020202020202020746F703A2031322E35253B0A202020';
wwv_flow_imp.g_varchar2_table(38) := '2020202020202020206C6566743A2031322E35253B0A20202020202020202020202077696474683A203735253B0A2020202020202020202020206865696768743A203735253B0A2020202020202020202020206261636B67726F756E643A20766172282D';
wwv_flow_imp.g_varchar2_table(39) := '2D75742D636F6D706F6E656E742D6261636B67726F756E642D636F6C6F72293B0A202020202020202020202020626F726465722D7261646975733A203530253B0A2020202020202020202020207A2D696E6465783A20323B0A20202020202020207D0A0A';
wwv_flow_imp.g_varchar2_table(40) := '20202020202020202E70726F67726573732D70657263656E74616765207B0A202020202020202020202020706F736974696F6E3A206162736F6C7574653B0A202020202020202020202020746F703A203530253B0A2020202020202020202020206C6566';
wwv_flow_imp.g_varchar2_table(41) := '743A203530253B0A2020202020202020202020207472616E73666F726D3A207472616E736C617465282D3530252C202D353025293B0A202020202020202020202020666F6E742D73697A653A20323470783B0A202020202020202020202020666F6E742D';
wwv_flow_imp.g_varchar2_table(42) := '7765696768743A20626F6C643B0A2020202020202020202020207A2D696E6465783A20333B0A202020202020202020202020636F6C6F723A20766172282D2D75742D636F6D706F6E656E742D746578742D64656661756C742D636F6C6F72293B0A202020';
wwv_flow_imp.g_varchar2_table(43) := '202020202020202020646973706C61793A20766172282D2D70726F67726573732D70657263656E746167652D646973706C6179293B0A20202020202020207D0A20202020202020200A202020203C2F7374796C653E0A202020203C64697620636C617373';
wwv_flow_imp.g_varchar2_table(44) := '3D2270726F67726573732D636F6E7461696E6572223E0A20202020202020203C64697620636C6173733D2270726F67726573732D636972636C65223E0A2020202020202020202020203C64697620636C6173733D2270726F67726573732D70657263656E';
wwv_flow_imp.g_varchar2_table(45) := '74616765223E30253C2F6469763E0A20202020202020203C2F6469763E0A20202020202020203C64697620636C6173733D2270726F67726573732D737461747573223E3C2F6469763E0A202020203C2F6469763E0A20202020603B0A0A0A20202020636C';
wwv_flow_imp.g_varchar2_table(46) := '617373204261636B67726F756E6450726F6365737350726F677265737320657874656E64732048544D4C456C656D656E74207B0A2020202020202020636F6E7374727563746F722829207B0A202020202020202020202020737570657228293B0A0A2020';
wwv_flow_imp.g_varchar2_table(47) := '20202020202020202020746869732E736861646F77203D20746869732E617474616368536861646F77287B206D6F64653A20226F70656E22207D293B0A202020202020202020202020746869732E70726F677265737354797065203D20746869732E6461';
wwv_flow_imp.g_varchar2_table(48) := '74617365742E70726F6772657373547970653B0A0A2020202020202020202020206C65742074656D706C617465436C6F6E653B0A20202020202020202020202069662028746869732E70726F677265737354797065203D3D3D20226261722229207B0A20';
wwv_flow_imp.g_varchar2_table(49) := '20202020202020202020202020202074656D706C617465436C6F6E65203D2062617254656D706C6174652E636F6E74656E742E636C6F6E654E6F64652874727565293B0A20202020202020202020202020202020746869732E7374796C652E7365745072';
wwv_flow_imp.g_varchar2_table(50) := '6F706572747928222D2D6261722D7769647468222C20746869732E646174617365742E6261725769647468293B0A20202020202020202020202020202020746869732E7374796C652E73657450726F706572747928222D2D6261722D686569676874222C';
wwv_flow_imp.g_varchar2_table(51) := '20746869732E646174617365742E626172486569676874293B0A2020202020202020202020207D0A202020202020202020202020656C7365207B0A2020202020202020202020202020202074656D706C617465436C6F6E65203D2063697263756C617254';
wwv_flow_imp.g_varchar2_table(52) := '656D706C6174652E636F6E74656E742E636C6F6E654E6F64652874727565293B0A20202020202020202020202020202020746869732E7374796C652E73657450726F706572747928222D2D636972636C652D73697A65222C20746869732E646174617365';
wwv_flow_imp.g_varchar2_table(53) := '742E636972636C6553697A65293B0A2020202020202020202020207D0A0A2020202020202020202020202F2F20617070656E642074656D706C61746520746F2074686520736861646F7720444F4D20696E7374656164206F66202274686973220A202020';
wwv_flow_imp.g_varchar2_table(54) := '202020202020202020746869732E736861646F772E617070656E644368696C642874656D706C617465436C6F6E65293B0A0A202020202020202020202020746869732E666F726567726F756E6450726F6772657373203D20746869732E736861646F7752';
wwv_flow_imp.g_varchar2_table(55) := '6F6F742E717565727953656C6563746F7228272E666F726567726F756E642D70726F677265737327293B0A202020202020202020202020746869732E70726F6772657373537461747573203D20746869732E736861646F77526F6F742E71756572795365';
wwv_flow_imp.g_varchar2_table(56) := '6C6563746F7228272E70726F67726573732D73746174757327293B0A202020202020202020202020746869732E70726F677265737350657263656E74616765203D20746869732E736861646F77526F6F742E717565727953656C6563746F7228272E7072';
wwv_flow_imp.g_varchar2_table(57) := '6F67726573732D70657263656E7461676527293B0A202020202020202020202020746869732E70726F67657373436972636C65203D20746869732E736861646F77526F6F742E717565727953656C6563746F7228222E70726F67726573732D636972636C';
wwv_flow_imp.g_varchar2_table(58) := '6522293B0A202020202020202020202020746869732E616A61784964656E746966696572203D20746869732E676574417474726962757465282022616A61782D6964656E7469666965722220293B0A202020202020202020202020746869732E72656469';
wwv_flow_imp.g_varchar2_table(59) := '726563744F6E436F6D706C6574696F6E203D20746869732E646174617365742E72656469726563744F6E436F6D706C6574696F6E3B0A202020202020202020202020746869732E72656469726563744C696E6B203D20746869732E646174617365742E72';
wwv_flow_imp.g_varchar2_table(60) := '656469726563744C696E6B3B0A202020202020202020202020746869732E6D6178497465726174696F6E203D20746869732E646174617365742E6D6178497465726174696F6E3B0A202020202020202020202020746869732E736C65657054696D65203D';
wwv_flow_imp.g_varchar2_table(61) := '20746869732E646174617365742E736C65657054696D653B0A0A20202020202020202020202069662028746869732E646174617365742E646973706C6179537461747573203D3D3D20224E2229207B0A2020202020202020202020202020202074686973';
wwv_flow_imp.g_varchar2_table(62) := '2E7374796C652E73657450726F706572747928222D2D70726F67726573732D7374617475732D646973706C6179222C20226E6F6E6522293B0A2020202020202020202020207D0A0A20202020202020202020202069662028746869732E64617461736574';
wwv_flow_imp.g_varchar2_table(63) := '2E646973706C617950657263656E74616765203D3D3D20224E2229207B0A20202020202020202020202020202020746869732E7374796C652E73657450726F706572747928222D2D70726F67726573732D70657263656E746167652D646973706C617922';
wwv_flow_imp.g_varchar2_table(64) := '2C20226E6F6E6522293B0A2020202020202020202020207D0A0A202020202020202020202020746869732E7374796C652E73657450726F706572747928222D2D6261636B67726F756E642D636F6C6F72222C20272364346434643427293B0A2020202020';
wwv_flow_imp.g_varchar2_table(65) := '20202020202020746869732E7374796C652E73657450726F706572747928222D2D666F726567726F756E642D636F6C6F72222C20277661722827202B20746869732E646174617365742E636F6C6F725661726961626C65202B20272927293B0A20202020';
wwv_flow_imp.g_varchar2_table(66) := '2020202020202020746869732E7374796C652E73657450726F706572747928222D2D70726F67726573732D70657263656E746167652D636F6C6F72222C20277661722827202B20746869732E646174617365742E636F6C6F725661726961626C65202B20';
wwv_flow_imp.g_varchar2_table(67) := '272D636F6E74726173742927293B0A0A202020202020202020202020726567696F6E2E6372656174652820746869732E676574417474726962757465282022726567696F6E2D69642220292C207B0A20202020202020202020202020202020747970653A';
wwv_flow_imp.g_varchar2_table(68) := '202244796E616D6963436F6E74656E74220A2020202020202020202020207D20293B0A20202020202020207D0A0A2020202020202020636F6E6E656374656443616C6C6261636B2829207B0A0A2020202020202020202020206C657420656C656D656E74';
wwv_flow_imp.g_varchar2_table(69) := '203D20746869732C0A2020202020202020202020202020202070726F677265737354797065203D20746869732E70726F6772657373547970652C0A20202020202020202020202020202020616A61784964656E746966696572203D20746869732E616A61';
wwv_flow_imp.g_varchar2_table(70) := '784964656E7469666965722C0A2020202020202020202020202020202070726F6772657373537461747573203D20746869732E70726F67726573735374617475732C0A2020202020202020202020202020202070726F677265737350657263656E746167';
wwv_flow_imp.g_varchar2_table(71) := '65203D20746869732E70726F677265737350657263656E746167652C0A2020202020202020202020202020202070726F67657373436972636C65203D20746869732E70726F67657373436972636C652C0A20202020202020202020202020202020726564';
wwv_flow_imp.g_varchar2_table(72) := '69726563744F6E436F6D706C6574696F6E203D20746869732E72656469726563744F6E436F6D706C6574696F6E2C0A2020202020202020202020202020202072656469726563744C696E6B203D20746869732E72656469726563744C696E6B2C0A202020';
wwv_flow_imp.g_varchar2_table(73) := '202020202020202020202020206D6178497465726174696F6E203D20746869732E6D6178497465726174696F6E2C0A20202020202020202020202020202020736C65657054696D65203D20746869732E736C65657054696D653B0A202020202020202020';
wwv_flow_imp.g_varchar2_table(74) := '2020200A20202020202020202020202066756E6374696F6E20736C656570286D7329207B0A2020202020202020202020202020202072657475726E206E65772050726F6D697365287265736F6C7665203D3E2073657454696D656F7574287265736F6C76';
wwv_flow_imp.g_varchar2_table(75) := '652C206D7329290A2020202020202020202020207D0A0A2020202020202020202020206173796E632066756E6374696F6E20757064617465436F6D706F6E656E7428297B0A202020202020202020202020202020206C65742062436F6E74696E7565203D';
wwv_flow_imp.g_varchar2_table(76) := '20747275652C0A2020202020202020202020202020202069203D20313B0A202020202020202020202020202020207768696C65202862436F6E74696E75652026262069203C3D206D6178497465726174696F6E29207B0A20202020202020202020202020';
wwv_flow_imp.g_varchar2_table(77) := '20202020202020617761697420617065782E7365727665722E706C7567696E28616A61784964656E746966696572292E7468656E282066756E6374696F6E2820646174612029207B0A202020202020202020202020202020202020202020202020696620';
wwv_flow_imp.g_varchar2_table(78) := '28646174612E736F66617220213D3D20756E646566696E6564297B0A20202020202020202020202020202020202020202020202020202020656C656D656E742E7365744174747269627574652822617269612D76616C75656E6F77222C20646174612E73';
wwv_flow_imp.g_varchar2_table(79) := '6F666172293B0A20202020202020202020202020202020202020202020202020202020656C656D656E742E7365744174747269627574652822617269612D76616C75656D6178222C20646174612E746F74616C776F726B293B0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(80) := '202020202020202020202020202020202020656C656D656E742E7365744174747269627574652822617269612D76616C756574657874222C20646174612E7374617475735F6D65737361676520213D3D20756E646566696E6564203F20646174612E7374';
wwv_flow_imp.g_varchar2_table(81) := '617475735F6D657373616765203A20646174612E737461747573293B0A20202020202020202020202020202020202020202020202020202020656C656D656E742E7374796C652E73657450726F706572747928272D2D746F74616C776F726B272C206461';
wwv_flow_imp.g_varchar2_table(82) := '74612E746F74616C776F726B293B0A20202020202020202020202020202020202020202020202020202020656C656D656E742E7374796C652E73657450726F706572747928272D2D736F666172272C20646174612E736F666172293B0A20202020202020';
wwv_flow_imp.g_varchar2_table(83) := '2020202020202020202020202020202020202020206966202820646174612E736F666172203D3D3D20646174612E746F74616C776F726B29207B0A2020202020202020202020202020202020202020202020202020202020202020656C656D656E742E73';
wwv_flow_imp.g_varchar2_table(84) := '74796C652E73657450726F706572747928272D2D666F726567726F756E642D626F726465722D746F702D72696768742D726164697573272C2027766172282D2D70726F67726573732D626F726465722D7261646975732927293B0A202020202020202020';
wwv_flow_imp.g_varchar2_table(85) := '2020202020202020202020202020202020202020202020656C656D656E742E7374796C652E73657450726F706572747928272D2D666F726567726F756E642D626F726465722D626F74746F6D2D72696768742D726164697573272C2027766172282D2D70';
wwv_flow_imp.g_varchar2_table(86) := '726F67726573732D626F726465722D7261646975732927293B0A202020202020202020202020202020202020202020202020202020207D20656C7365207B0A2020202020202020202020202020202020202020202020202020202020202020656C656D65';
wwv_flow_imp.g_varchar2_table(87) := '6E742E7374796C652E73657450726F706572747928272D2D666F726567726F756E642D626F726465722D746F702D72696768742D726164697573272C202730707827293B0A20202020202020202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(88) := '20656C656D656E742E7374796C652E73657450726F706572747928272D2D666F726567726F756E642D626F726465722D626F74746F6D2D72696768742D726164697573272C202730707827293B0A20202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(89) := '2020202020207D0A0A202020202020202020202020202020202020202020202020202020206C65742070657263656E74616765203D204D6174682E726F756E642828646174612E736F666172202F20646174612E746F74616C776F726B292A313030293B';
wwv_flow_imp.g_varchar2_table(90) := '0A2020202020202020202020202020202020202020202020202020202070726F677265737350657263656E746167652E696E6E657248544D4C203D2069734E614E2870657263656E7461676529203F2022302522203A2070657263656E74616765202B20';
wwv_flow_imp.g_varchar2_table(91) := '2225223B0A0A202020202020202020202020202020202020202020202020202020206966202870726F677265737354797065203D3D3D202263697263756C61722229207B0A20202020202020202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(92) := '2070726F67657373436972636C652E7374796C652E73657450726F706572747928222D2D70657263656E74616765222C2069734E614E2870657263656E7461676529203F2030203A2070657263656E7461676520293B0A20202020202020202020202020';
wwv_flow_imp.g_varchar2_table(93) := '2020202020202020202020202020207D0A0A2020202020202020202020202020202020202020202020202020202070726F67726573735374617475732E696E6E657248544D4C203D20646174612E7374617475735F6D65737361676520213D3D20756E64';
wwv_flow_imp.g_varchar2_table(94) := '6566696E6564203F20646174612E7374617475735F6D657373616765203A20646174612E7374617475733B0A202020202020202020202020202020202020202020202020202020200A202020202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(95) := '2062436F6E74696E7565203D205B22455845435554494E47222C20225343484544554C4544222C22454E515545554544225D2E696E636C7564657328646174612E7374617475735F636F6465293B0A202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(96) := '2020202020202069662028202162436F6E74696E75652029207B0A2020202020202020202020202020202020202020202020202020202020202020617065782E6576656E742E7472696767657228656C656D656E742C2022617065782D62672D70726373';
wwv_flow_imp.g_varchar2_table(97) := '2D70726F67726573732D657865632D636F6D706C65746564222C2064617461293B0A2020202020202020202020202020202020202020202020202020202020202020696620282072656469726563744F6E436F6D706C6574696F6E203D3D3D2022592220';
wwv_flow_imp.g_varchar2_table(98) := '29207B0A202020202020202020202020202020202020202020202020202020202020202020202020617065782E6E617669676174696F6E2E72656469726563742872656469726563744C696E6B293B0A2020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(99) := '2020202020202020202020207D0A202020202020202020202020202020202020202020202020202020207D0A2020202020202020202020202020202020202020202020207D0A20202020202020202020202020202020202020207D20293B0A2020202020';
wwv_flow_imp.g_varchar2_table(100) := '202020202020202020202020202020692B2B3B0A2020202020202020202020202020202020202020617761697420736C65657028736C65657054696D65293B0A202020202020202020202020202020207D0A2020202020202020202020207D0A0A202020';
wwv_flow_imp.g_varchar2_table(101) := '202020202020202020757064617465436F6D706F6E656E7428293B0A20202020202020207D200A202020207D0A0A202020202428202829203D3E207B0A202020202020202077696E646F772E637573746F6D456C656D656E74732E646566696E65282022';
wwv_flow_imp.g_varchar2_table(102) := '617065782D62672D707263732D70726F6772657373222C204261636B67726F756E6450726F6365737350726F677265737320293B0A202020207D20293B0A0A7D20292820617065782E6A51756572792C20617065782E64656275672C20617065782E7265';
wwv_flow_imp.g_varchar2_table(103) := '67696F6E2C20617065782E7574696C2C20617065782E7769646765742E7574696C20293B0A';
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(20047000840941034826)
,p_plugin_id=>wwv_flow_imp.id(20024237253925305900)
,p_file_name=>'js/bg-process-progress.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '4070726F7065727479202D2D70657263656E74616765207B0A2020202073796E7461783A20273C6E756D6265723E273B0A20202020696E6865726974733A20747275653B0A20202020696E697469616C2D76616C75653A20303B0A7D0A0A';
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(20051298806722144423)
,p_plugin_id=>wwv_flow_imp.id(20024237253925305900)
,p_file_name=>'css/bg-process-progress.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '4070726F7065727479202D2D70657263656E746167657B73796E7461783A223C6E756D6265723E223B696E6865726974733A747275653B696E697469616C2D76616C75653A307D';
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(21202145146853428136)
,p_plugin_id=>wwv_flow_imp.id(20024237253925305900)
,p_file_name=>'css/bg-process-progress.min.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2828652C722C742C732C6E293D3E7B2275736520737472696374223B636F6E7374206F3D646F63756D656E742E637265617465456C656D656E74282274656D706C61746522293B6F2E69643D2262672D70726F67726573732D6261722D74656D706C6174';
wwv_flow_imp.g_varchar2_table(2) := '65222C6F2E696E6E657248544D4C3D275C6E202020203C7374796C653E5C6E20202020202020203A686F7374207B5C6E2020202020202020202020202D2D6261722D77696474683A2035303070783B5C6E2020202020202020202020202D2D6261722D68';
wwv_flow_imp.g_varchar2_table(3) := '65696768743A20333070783B5C6E2020202020202020202020202D2D70726F67726573732D626F726465722D7261646975733A203172656D3B5C6E2020202020202020202020202D2D736F6661723A20303B5C6E2020202020202020202020202D2D746F';
wwv_flow_imp.g_varchar2_table(4) := '74616C776F726B3A3130303B5C6E2020202020202020202020202D2D666F726567726F756E642D77696474683A2063616C632863616C6328766172282D2D736F66617229202A20766172282D2D6261722D77696474682929202F20766172282D2D746F74';
wwv_flow_imp.g_varchar2_table(5) := '616C776F726B29293B5C6E2020202020202020202020202D2D666F726567726F756E642D626F726465722D746F702D72696768742D7261646975733A203070783B5C6E2020202020202020202020202D2D666F726567726F756E642D626F726465722D62';
wwv_flow_imp.g_varchar2_table(6) := '6F74746F6D2D72696768742D7261646975733A203070783B5C6E202020202020202020202020646973706C61793A20666C65783B5C6E202020202020202020202020616C69676E2D6974656D733A2063656E7465723B5C6E202020202020202020202020';
wwv_flow_imp.g_varchar2_table(7) := '6A7573746966792D636F6E74656E743A2063656E7465723B5C6E2020202020202020202020206865696768743A206D696E2D636F6E74656E743B5C6E20202020202020207D5C6E5C6E20202020202020202E70726F67726573732D636F6E7461696E6572';
wwv_flow_imp.g_varchar2_table(8) := '207B5C6E202020202020202020202020646973706C61793A20666C65783B5C6E202020202020202020202020666C65782D646972656374696F6E3A20636F6C756D6E3B5C6E20202020202020207D5C6E5C6E20202020202020202E6261636B67726F756E';
wwv_flow_imp.g_varchar2_table(9) := '642D70726F67726573732C202E666F726567726F756E642D70726F6772657373207B5C6E20202020202020202020202077696474683A20766172282D2D6261722D7769647468293B5C6E2020202020202020202020206865696768743A20766172282D2D';
wwv_flow_imp.g_varchar2_table(10) := '6261722D686569676874293B5C6E2020202020202020202020206261636B67726F756E642D636F6C6F723A20766172282D2D6261636B67726F756E642D636F6C6F72293B5C6E202020202020202020202020626F726465722D7261646975733A20766172';
wwv_flow_imp.g_varchar2_table(11) := '282D2D70726F67726573732D626F726465722D726164697573293B5C6E20202020202020207D5C6E5C6E20202020202020202E666F726567726F756E642D70726F6772657373207B5C6E20202020202020202020202077696474683A20766172282D2D66';
wwv_flow_imp.g_varchar2_table(12) := '6F726567726F756E642D7769647468293B5C6E2020202020202020202020206261636B67726F756E642D636F6C6F723A20766172282D2D666F726567726F756E642D636F6C6F72293B5C6E202020202020202020202020626F726465722D746F702D7269';
wwv_flow_imp.g_varchar2_table(13) := '6768742D7261646975733A20766172282D2D666F726567726F756E642D626F726465722D746F702D72696768742D726164697573293B5C6E202020202020202020202020626F726465722D626F74746F6D2D72696768742D7261646975733A2076617228';
wwv_flow_imp.g_varchar2_table(14) := '2D2D666F726567726F756E642D626F726465722D626F74746F6D2D72696768742D726164697573293B5C6E2020202020202020202020207472616E736974696F6E3A20776964746820317320656173653B5C6E202020202020202020202020616C69676E';
wwv_flow_imp.g_varchar2_table(15) := '2D636F6E74656E743A2063656E7465723B5C6E20202020202020207D5C6E5C6E20202020202020202E70726F67726573732D737461747573207B5C6E202020202020202020202020646973706C61793A20766172282D2D70726F67726573732D73746174';
wwv_flow_imp.g_varchar2_table(16) := '75732D646973706C6179293B5C6E202020202020202020202020746578742D616C69676E3A2063656E7465723B5C6E2020202020202020202020206D617267696E3A202E31323572656D3B5C6E20202020202020207D5C6E5C6E20202020202020202E70';
wwv_flow_imp.g_varchar2_table(17) := '726F67726573732D70657263656E74616765207B5C6E202020202020202020202020636F6C6F723A20766172282D2D70726F67726573732D70657263656E746167652D636F6C6F72293B5C6E202020202020202020202020666F6E742D7765696768743A';
wwv_flow_imp.g_varchar2_table(18) := '20766172282D2D70726F67726573732D70657263656E746167652D666F6E742D7765696768742C20353030293B5C6E202020202020202020202020646973706C61793A20766172282D2D70726F67726573732D70657263656E746167652D646973706C61';
wwv_flow_imp.g_varchar2_table(19) := '79293B5C6E2020202020202020202020206D617267696E2D6C6566743A20302E3572656D3B5C6E20202020202020207D5C6E202020203C2F7374796C653E5C6E202020203C64697620636C6173733D2270726F67726573732D636F6E7461696E6572223E';
wwv_flow_imp.g_varchar2_table(20) := '5C6E20202020202020203C64697620636C6173733D2270726F67726573732D737461747573223E3C2F6469763E5C6E20202020202020203C64697620636C6173733D226261636B67726F756E642D70726F6772657373223E5C6E20202020202020202020';
wwv_flow_imp.g_varchar2_table(21) := '20203C64697620636C6173733D22666F726567726F756E642D70726F6772657373223E5C6E202020202020202020202020202020203C7370616E20636C6173733D2270726F67726573732D70657263656E74616765223E30253C2F7370616E3E5C6E2020';
wwv_flow_imp.g_varchar2_table(22) := '202020202020202020203C2F6469763E5C6E20202020202020203C2F6469763E5C6E202020203C2F6469763E5C6E20202020273B636F6E737420613D646F63756D656E742E637265617465456C656D656E74282274656D706C61746522293B612E69643D';
wwv_flow_imp.g_varchar2_table(23) := '2262672D70726F67726573732D63697263756C61722D74656D706C617465222C612E696E6E657248544D4C3D275C6E202020203C7374796C653E5C6E5C6E20202020202020203A686F7374207B5C6E2020202020202020202020202D2D6D61782D776964';
wwv_flow_imp.g_varchar2_table(24) := '74683A2035303070783B5C6E2020202020202020202020202D2D636972636C652D73697A653A2031353070783B5C6E2020202020202020202020202D2D736F6661723A20303B5C6E2020202020202020202020202D2D746F74616C776F726B3A3130303B';
wwv_flow_imp.g_varchar2_table(25) := '5C6E2020202020202020202020202D2D70657263656E746167653A20303B5C6E202020202020202020202020646973706C61793A20666C65783B5C6E202020202020202020202020616C69676E2D6974656D733A2063656E7465723B5C6E202020202020';
wwv_flow_imp.g_varchar2_table(26) := '2020202020206A7573746966792D636F6E74656E743A2063656E7465723B5C6E2020202020202020202020206865696768743A206D696E2D636F6E74656E743B5C6E20202020202020207D5C6E5C6E20202020202020202E70726F67726573732D636F6E';
wwv_flow_imp.g_varchar2_table(27) := '7461696E6572207B5C6E202020202020202020202020646973706C61793A20666C65783B5C6E202020202020202020202020666C65782D646972656374696F6E3A20636F6C756D6E3B5C6E202020202020202020202020616C69676E2D6974656D733A20';
wwv_flow_imp.g_varchar2_table(28) := '63656E7465723B5C6E20202020202020207D5C6E5C6E20202020202020202E70726F67726573732D737461747573207B5C6E202020202020202020202020646973706C61793A20766172282D2D70726F67726573732D7374617475732D646973706C6179';
wwv_flow_imp.g_varchar2_table(29) := '293B5C6E202020202020202020202020746578742D616C69676E3A2063656E7465723B5C6E2020202020202020202020206D617267696E3A202E31323572656D3B5C6E202020202020202020202020636F6C6F723A20766172282D2D75742D636F6D706F';
wwv_flow_imp.g_varchar2_table(30) := '6E656E742D746578742D64656661756C742D636F6C6F72293B5C6E20202020202020207D5C6E5C6E20202020202020202E70726F67726573732D636972636C65207B5C6E202020202020202020202020706F736974696F6E3A2072656C61746976653B5C';
wwv_flow_imp.g_varchar2_table(31) := '6E20202020202020202020202077696474683A20766172282D2D636972636C652D73697A65293B5C6E2020202020202020202020206865696768743A20766172282D2D636972636C652D73697A65293B5C6E2020202020202020202020207472616E7369';
wwv_flow_imp.g_varchar2_table(32) := '74696F6E3A202D2D70657263656E7461676520317320656173652D696E2D6F75743B5C6E20202020202020207D5C6E5C6E20202020202020202E70726F67726573732D636972636C653A3A6265666F7265207B5C6E202020202020202020202020636F6E';
wwv_flow_imp.g_varchar2_table(33) := '74656E743A205C275C273B5C6E202020202020202020202020706F736974696F6E3A206162736F6C7574653B5C6E202020202020202020202020746F703A20303B5C6E2020202020202020202020206C6566743A20303B5C6E2020202020202020202020';
wwv_flow_imp.g_varchar2_table(34) := '2077696474683A20313030253B5C6E2020202020202020202020206865696768743A20313030253B5C6E202020202020202020202020626F726465722D7261646975733A203530253B5C6E2020202020202020202020206261636B67726F756E643A2063';
wwv_flow_imp.g_varchar2_table(35) := '6F6E69632D6772616469656E7428766172282D2D666F726567726F756E642D636F6C6F72292063616C6328766172282D2D70657263656E7461676529202A203125292C20766172282D2D6261636B67726F756E642D636F6C6F7229203025293B5C6E2020';
wwv_flow_imp.g_varchar2_table(36) := '202020202020202020207A2D696E6465783A20313B5C6E20202020202020207D5C6E5C6E20202020202020202E70726F67726573732D636972636C653A3A6166746572207B5C6E202020202020202020202020636F6E74656E743A205C275C273B5C6E20';
wwv_flow_imp.g_varchar2_table(37) := '2020202020202020202020706F736974696F6E3A206162736F6C7574653B5C6E202020202020202020202020746F703A2031322E35253B5C6E2020202020202020202020206C6566743A2031322E35253B5C6E2020202020202020202020207769647468';
wwv_flow_imp.g_varchar2_table(38) := '3A203735253B5C6E2020202020202020202020206865696768743A203735253B5C6E2020202020202020202020206261636B67726F756E643A20766172282D2D75742D636F6D706F6E656E742D6261636B67726F756E642D636F6C6F72293B5C6E202020';
wwv_flow_imp.g_varchar2_table(39) := '202020202020202020626F726465722D7261646975733A203530253B5C6E2020202020202020202020207A2D696E6465783A20323B5C6E20202020202020207D5C6E5C6E20202020202020202E70726F67726573732D70657263656E74616765207B5C6E';
wwv_flow_imp.g_varchar2_table(40) := '202020202020202020202020706F736974696F6E3A206162736F6C7574653B5C6E202020202020202020202020746F703A203530253B5C6E2020202020202020202020206C6566743A203530253B5C6E2020202020202020202020207472616E73666F72';
wwv_flow_imp.g_varchar2_table(41) := '6D3A207472616E736C617465282D3530252C202D353025293B5C6E202020202020202020202020666F6E742D73697A653A20323470783B5C6E202020202020202020202020666F6E742D7765696768743A20626F6C643B5C6E2020202020202020202020';
wwv_flow_imp.g_varchar2_table(42) := '207A2D696E6465783A20333B5C6E202020202020202020202020636F6C6F723A20766172282D2D75742D636F6D706F6E656E742D746578742D64656661756C742D636F6C6F72293B5C6E202020202020202020202020646973706C61793A20766172282D';
wwv_flow_imp.g_varchar2_table(43) := '2D70726F67726573732D70657263656E746167652D646973706C6179293B5C6E20202020202020207D5C6E20202020202020205C6E202020203C2F7374796C653E5C6E202020203C64697620636C6173733D2270726F67726573732D636F6E7461696E65';
wwv_flow_imp.g_varchar2_table(44) := '72223E5C6E20202020202020203C64697620636C6173733D2270726F67726573732D636972636C65223E5C6E2020202020202020202020203C64697620636C6173733D2270726F67726573732D70657263656E74616765223E30253C2F6469763E5C6E20';
wwv_flow_imp.g_varchar2_table(45) := '202020202020203C2F6469763E5C6E20202020202020203C64697620636C6173733D2270726F67726573732D737461747573223E3C2F6469763E5C6E202020203C2F6469763E5C6E20202020273B636C617373206920657874656E64732048544D4C456C';
wwv_flow_imp.g_varchar2_table(46) := '656D656E747B636F6E7374727563746F7228297B6C657420653B737570657228292C746869732E736861646F773D746869732E617474616368536861646F77287B6D6F64653A226F70656E227D292C746869732E70726F6772657373547970653D746869';
wwv_flow_imp.g_varchar2_table(47) := '732E646174617365742E70726F6772657373547970652C22626172223D3D3D746869732E70726F6772657373547970653F28653D6F2E636F6E74656E742E636C6F6E654E6F6465282130292C746869732E7374796C652E73657450726F70657274792822';
wwv_flow_imp.g_varchar2_table(48) := '2D2D6261722D7769647468222C746869732E646174617365742E6261725769647468292C746869732E7374796C652E73657450726F706572747928222D2D6261722D686569676874222C746869732E646174617365742E62617248656967687429293A28';
wwv_flow_imp.g_varchar2_table(49) := '653D612E636F6E74656E742E636C6F6E654E6F6465282130292C746869732E7374796C652E73657450726F706572747928222D2D636972636C652D73697A65222C746869732E646174617365742E636972636C6553697A6529292C746869732E73686164';
wwv_flow_imp.g_varchar2_table(50) := '6F772E617070656E644368696C642865292C746869732E666F726567726F756E6450726F67726573733D746869732E736861646F77526F6F742E717565727953656C6563746F7228222E666F726567726F756E642D70726F677265737322292C74686973';
wwv_flow_imp.g_varchar2_table(51) := '2E70726F67726573735374617475733D746869732E736861646F77526F6F742E717565727953656C6563746F7228222E70726F67726573732D73746174757322292C746869732E70726F677265737350657263656E746167653D746869732E736861646F';
wwv_flow_imp.g_varchar2_table(52) := '77526F6F742E717565727953656C6563746F7228222E70726F67726573732D70657263656E7461676522292C746869732E70726F67657373436972636C653D746869732E736861646F77526F6F742E717565727953656C6563746F7228222E70726F6772';
wwv_flow_imp.g_varchar2_table(53) := '6573732D636972636C6522292C746869732E616A61784964656E7469666965723D746869732E6765744174747269627574652822616A61782D6964656E74696669657222292C746869732E72656469726563744F6E436F6D706C6574696F6E3D74686973';
wwv_flow_imp.g_varchar2_table(54) := '2E646174617365742E72656469726563744F6E436F6D706C6574696F6E2C746869732E72656469726563744C696E6B3D746869732E646174617365742E72656469726563744C696E6B2C746869732E6D6178497465726174696F6E3D746869732E646174';
wwv_flow_imp.g_varchar2_table(55) := '617365742E6D6178497465726174696F6E2C746869732E736C65657054696D653D746869732E646174617365742E736C65657054696D652C224E223D3D3D746869732E646174617365742E646973706C61795374617475732626746869732E7374796C65';
wwv_flow_imp.g_varchar2_table(56) := '2E73657450726F706572747928222D2D70726F67726573732D7374617475732D646973706C6179222C226E6F6E6522292C224E223D3D3D746869732E646174617365742E646973706C617950657263656E746167652626746869732E7374796C652E7365';
wwv_flow_imp.g_varchar2_table(57) := '7450726F706572747928222D2D70726F67726573732D70657263656E746167652D646973706C6179222C226E6F6E6522292C746869732E7374796C652E73657450726F706572747928222D2D6261636B67726F756E642D636F6C6F72222C222364346434';
wwv_flow_imp.g_varchar2_table(58) := '643422292C746869732E7374796C652E73657450726F706572747928222D2D666F726567726F756E642D636F6C6F72222C2276617228222B746869732E646174617365742E636F6C6F725661726961626C652B222922292C746869732E7374796C652E73';
wwv_flow_imp.g_varchar2_table(59) := '657450726F706572747928222D2D70726F67726573732D70657263656E746167652D636F6C6F72222C2276617228222B746869732E646174617365742E636F6C6F725661726961626C652B222D636F6E74726173742922292C742E637265617465287468';
wwv_flow_imp.g_varchar2_table(60) := '69732E6765744174747269627574652822726567696F6E2D696422292C7B747970653A2244796E616D6963436F6E74656E74227D297D636F6E6E656374656443616C6C6261636B28297B6C657420653D746869732C723D746869732E70726F6772657373';
wwv_flow_imp.g_varchar2_table(61) := '547970652C743D746869732E616A61784964656E7469666965722C733D746869732E70726F67726573735374617475732C6E3D746869732E70726F677265737350657263656E746167652C6F3D746869732E70726F67657373436972636C652C613D7468';
wwv_flow_imp.g_varchar2_table(62) := '69732E72656469726563744F6E436F6D706C6574696F6E2C693D746869732E72656469726563744C696E6B2C643D746869732E6D6178497465726174696F6E2C633D746869732E736C65657054696D653B66756E6374696F6E20702865297B7265747572';
wwv_flow_imp.g_varchar2_table(63) := '6E206E65772050726F6D6973652828723D3E73657454696D656F757428722C652929297D216173796E632066756E6374696F6E28297B6C6574206C3D21302C673D313B666F72283B6C2626673C3D643B29617761697420617065782E7365727665722E70';
wwv_flow_imp.g_varchar2_table(64) := '6C7567696E2874292E7468656E282866756E6374696F6E2874297B696628766F69642030213D3D742E736F666172297B652E7365744174747269627574652822617269612D76616C75656E6F77222C742E736F666172292C652E73657441747472696275';
wwv_flow_imp.g_varchar2_table(65) := '74652822617269612D76616C75656D6178222C742E746F74616C776F726B292C652E7365744174747269627574652822617269612D76616C756574657874222C766F69642030213D3D742E7374617475735F6D6573736167653F742E7374617475735F6D';
wwv_flow_imp.g_varchar2_table(66) := '6573736167653A742E737461747573292C652E7374796C652E73657450726F706572747928222D2D746F74616C776F726B222C742E746F74616C776F726B292C652E7374796C652E73657450726F706572747928222D2D736F666172222C742E736F6661';
wwv_flow_imp.g_varchar2_table(67) := '72292C742E736F6661723D3D3D742E746F74616C776F726B3F28652E7374796C652E73657450726F706572747928222D2D666F726567726F756E642D626F726465722D746F702D72696768742D726164697573222C22766172282D2D70726F6772657373';
wwv_flow_imp.g_varchar2_table(68) := '2D626F726465722D7261646975732922292C652E7374796C652E73657450726F706572747928222D2D666F726567726F756E642D626F726465722D626F74746F6D2D72696768742D726164697573222C22766172282D2D70726F67726573732D626F7264';
wwv_flow_imp.g_varchar2_table(69) := '65722D726164697573292229293A28652E7374796C652E73657450726F706572747928222D2D666F726567726F756E642D626F726465722D746F702D72696768742D726164697573222C2230707822292C652E7374796C652E73657450726F7065727479';
wwv_flow_imp.g_varchar2_table(70) := '28222D2D666F726567726F756E642D626F726465722D626F74746F6D2D72696768742D726164697573222C223070782229293B6C657420643D4D6174682E726F756E6428742E736F6661722F742E746F74616C776F726B2A313030293B6E2E696E6E6572';
wwv_flow_imp.g_varchar2_table(71) := '48544D4C3D69734E614E2864293F223025223A642B2225222C2263697263756C6172223D3D3D7226266F2E7374796C652E73657450726F706572747928222D2D70657263656E74616765222C69734E614E2864293F303A64292C732E696E6E657248544D';
wwv_flow_imp.g_varchar2_table(72) := '4C3D766F69642030213D3D742E7374617475735F6D6573736167653F742E7374617475735F6D6573736167653A742E7374617475732C6C3D5B22455845435554494E47222C225343484544554C4544222C22454E515545554544225D2E696E636C756465';
wwv_flow_imp.g_varchar2_table(73) := '7328742E7374617475735F636F6465292C6C7C7C28617065782E6576656E742E7472696767657228652C22617065782D62672D707263732D70726F67726573732D657865632D636F6D706C65746564222C74292C2259223D3D3D612626617065782E6E61';
wwv_flow_imp.g_varchar2_table(74) := '7669676174696F6E2E7265646972656374286929297D7D29292C672B2B2C617761697420702863297D28297D7D65282828293D3E7B77696E646F772E637573746F6D456C656D656E74732E646566696E652822617065782D62672D707263732D70726F67';
wwv_flow_imp.g_varchar2_table(75) := '72657373222C69297D29297D2928617065782E6A51756572792C617065782E64656275672C617065782E726567696F6E2C617065782E7574696C2C617065782E7769646765742E7574696C293B';
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(23530033483475365925)
,p_plugin_id=>wwv_flow_imp.id(20024237253925305900)
,p_file_name=>'js/bg-process-progress.min.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
